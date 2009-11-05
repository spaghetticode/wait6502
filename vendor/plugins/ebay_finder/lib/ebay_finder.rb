require 'parametrizer'
module EbayFinder
  EBAY_BASE_URL = 'http://svcs.ebay.com/services/search/FindingService/v1?OPERATION-NAME=findItemsByKeywords&SERVICE-VERSION=1.0.0'
  
  # custom error classes
  class EbayError < StandardError; end
  class TimeoutErorr < EbayError; end
  class RequestError < EbayError; end
  class SystemError < EbayError; end
  
  class Request
    attr_reader :app_id, :website, :params
    @@config_params = nil
    
    def initialize(params={})
      @website = params.delete(:website) || self.class.config_params[:website] || 'EBAY-IT'
      @app_id = self.class.config_params[:app_id]
      @params = params
    end
    
    def self.config_params
      return @@config_params if @@config_params
      config_params = YAML.load_file("#{RAILS_ROOT}/config/ebay_config.yml")
      @@config_params = config_params[RAILS_ENV.to_sym]
    end
    
    def response
      @response ||= EbayFinder::FindItemsResponse.new(http_get(query_url), self)
    end
    
    protected
    
    def query_url
      app_query = "SECURITY-APPNAME=#{app_id}"
      website_query = "GLOBAL-ID=#{website}"
      @url = "#{EBAY_BASE_URL}&#{app_query}&#{website_query}&RESPONSE-DATA-FORMAT=XML&REST-PAYLOAD&#{query_params}"
    end
  
    def query_params
      self.params.empty? ? '' : build_params
    end
    
    def build_params
      self.params.ebay_parametrize
    end
    
    def http_get(url)
      response = nil
      uri = URI.parse(url)
      request = Net::HTTP.new(uri.host, uri.port)
      request.read_timeout = 5
      begin
        response = request.get(uri.request_uri)
        raise RequestError, 'Problems retrieving data from ebay' unless response.is_a? Net::HTTPSuccess
      rescue Timeout::Error
        raise TimeoutError, 'Time out... ebay seems to be currently unavailable.'
      end
      response.body
    end
  end
  
  class FindItemsResponse
    attr_reader :xml_response, :request
    def initialize(response_body, request=nil)
      @xml_response = XmlSimple.xml_in(response_body, 'ForceArray' => false)
      @request = request
      check_for_errors
    end
    
    def items
      return [] if total_items == 0
      @items ||= (xml_items.is_a?(Array) ? xml_items : [xml_items]).collect{|i| Item.new(i)}
    end
    
    def xml_items
      xml_response['searchResult']['item']
    end
    
    def total_items
      @total_items ||= xml_response['paginationOutput']['totalEntries'] && xml_response['paginationOutput']['totalEntries'].to_i
    end
    
    def total_pages
      @total_pages ||= xml_response['paginationOutput']['totalPages'] && xml_response['paginationOutput']['totalPages'].to_i
    end
    
    def page_number
      @page_number ||= xml_response['paginationOutput']['pageNumber'] && xml_response['paginationOutput']['pageNumber'].to_i
    end
    
    private
    
    def check_for_errors
      if self.xml_response['Ack'] == 'Failure'
        @errors = self.xml_response['Errors']
        raise TimeoutError, @errors['LongMessage'] if @errors['ErrorCode'] == '1.23'
        if @errors['ErrorClassification'] == 'SystemError'
          raise SystemError, @errors['LongMessage']
        else
          raise RequestError, @errors['LongMessage']
        end
      end
    end
  end
  
  class Item
    attr_reader :params, :title, :view_item_url, :gallery_url, :item_id
    
    def initialize(params)
      @params = params
      params.each_key do|p_name|
        if self.respond_to?(p_name.underscore)
          self.instance_variable_set("@#{p_name.underscore}", params[p_name])
        end
      end
    end
    
    def [](param_name)
      params[param_name]
    end
    
    def current_price
      currency, amount = self['sellingStatus']['currentPrice'].values
      "#{currency} %.2f" % amount.to_f
    end
  end
end
