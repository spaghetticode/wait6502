module EbayFinder
  EBAY_BASE_URL = 'http://open.api.ebay.com/shopping'
  EBAY_SITES = {
    :US => 0,
    :FR => 71,
    :ES => 186,
    :GB => 3,
    :DE => 77,
    :NL => 146,
    :IT => 101,
    :AU => 15,
    :CA => 2
  }
  
  # custom error classes
  class EbayError < StandardError; end
  class TimeoutErorr < EbayError; end
  class RequestError < EbayError; end
  class SystemError < EbayError; end
  
  class Request
    attr_reader :app_id, :website, :callname, :params
    @@config_params = nil
    
    def initialize(params={})
      @website = params.delete(:website) || self.class.config_params[:website] || 'US'
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
      website_query = "siteid=#{EBAY_SITES[website.to_sym]}"
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
      @xml_response = XmlSimple.xml_in(response_body, 'ForceArray' => false, 'KeepRoot' => false)
      fix_xml_response if defined? AWS::S3
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
    
    def fix_xml_response
      # as aws-s3 gem (0.6.2) monkeypatches xmlsimple, we have to fix the 
      # xml response if the gem is loaded:
      root_tag = self.class.name.split('::').last
      @xml_response = @xml_response[root_tag] if @xml_response[root_tag]
    end
    
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
    
    def bid_count
      self['BidCount'].to_i
    end
    
    def current_price
      EbayFinder::Money.new(self['ConvertedCurrentPrice'])
    end
    
    def end_time
      Time.parse self['EndTime']
    end
  end
  
  class Money
    attr_reader :currency_id, :amount

    def initialize(currency_hash)
      @currency_id = currency_hash['currencyID']
      # aws-s3 keeps biting my hand
      @amount = (defined?(AWS::S3) ? currency_hash['__content__'] : currency_hash['content']).to_f
    end
    
    def to_s
      "#{currency_id} #{format('%0.2f', amount)}"
    end
  end
end
