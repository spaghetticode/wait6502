class Search
  SEARCH_MODELS = [Hardware, Manufacturer, Cpu, CoCpu]
  
  attr_accessor :query, :results

  def initialize(query)
    @query = {:keywords => query}
    @results = {}
  end
  
  def create
    SEARCH_MODELS.each do |model|
      results[model.to_s.underscore.to_sym] = model.filter(query)
    end
  end
end
