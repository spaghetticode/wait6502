module EbayFinder
  EBAY_BASE_URL = 'http://open.api.ebay.com/shopping'
  
  # custom error classes
  class EbayError < StandardError; end
  class TimeoutErorr < EbayError; end
  class RequestError < EbayError; end
  class SystemError < EbayError; end
  
  class Request
    attr_reader :app_id, :website, :callname, :params
    @@config_params = nil
    
    def initialize(params={})
      @website = params.delete(:website) || self.class.config_params[:website] || '0'
      @app_id = self.class.config_params[:app_id]
      @callname = params.delete(:callname) || 'FindItemsAdvanced' # option is GetItemStatus
      @params = params
    end
    
    def self.config_params
      return @@config_params if @@config_params
      config_params = YAML.load_file("#{RAILS_ROOT}/config/ebay_config.yml")
      @@config_params = config_params[RAILS_ENV.to_sym]
    end
    
    def response
      @response ||= "EbayFinder::#{callname.camelize}Response".constantize.new(http_get(query_url), self)
    end
    
    protected
    
    def query_url
      app_query = "appid=#{app_id}"
      website_query = "siteid=#{website}"
      callname_query = "callname=#{callname}"
      @url = "#{EBAY_BASE_URL}?#{callname_query}&responseencoding=XML&version=525&#{app_query}&#{website_query}&#{query_params}"
    end
  
    def query_params
      self.params.empty? ? '' : build_params
    end
    
    def build_params
      self.params.inject([]) do |collection, data|
        name, value = data
        collection << "#{name.to_s.camelize}=#{CGI.escape(value.to_s).gsub(' ', '%20')}"
      end.join('&')
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
  
  class Response
    attr_reader :xml_response, :request
    
    def initialize(response_body, request=nil)
      @xml_response = XmlSimple.xml_in(response_body, 'ForceArray' => false)
      @request = request
      check_for_errors
    end
    
    def items
      @items ||= (xml_items.is_a?(Array) ? xml_items : [xml_items]).collect{|i| Item.new(i)}
    end
    
    def total_items
      @total_items ||= xml_response['TotalItems'] && xml_response['TotalItems'].to_i
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
  
  class GetItemStatusResponse < Response
    def xml_items
      xml_response['Item']
    end
    
    def total_items
      items.size
    end
  end
  
  class FindItemsAdvancedResponse < Response
    def items
      return [] if total_items.zero?
      @items ||= (xml_items.is_a?(Array) ? xml_items : [xml_items]).collect{|i| Item.new(i)}
    end
    
    def xml_items
      xml_response['SearchResult']['ItemArray']['Item'] rescue nil
    end
    
    def total_pages
      @total_pages ||= xml_response['TotalPages'] && xml_response['TotalPages'].to_i
    end
    
    def page_number
      @page_number ||= xml_response['PageNumber'] && xml_response['PageNumber'].to_i
    end
  end
  
  class Item
    attr_reader :params, :title, :view_item_url_for_natural_search, :gallery_url, :item_id, :listing_status
    
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
      self['ConvertedCurrentPrice']
    end
    
    def end_time
      Time.parse self['EndTime']
    end
  end
end
