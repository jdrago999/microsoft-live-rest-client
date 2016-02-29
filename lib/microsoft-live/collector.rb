
module MicrosoftLive
  class Collector
    include HTTParty
    attr_accessor :simple, :path, :limit, :offset, :result, :page_size, :item_class
    base_uri 'https://login.live.com/'

    def initialize(simple:, path:, limit:, offset:, page_size: 50, item_class:)
      self.simple = simple
      self.path = path
      self.limit = limit
      self.offset = offset
      self.page_size = page_size
      self.item_class = item_class
    end

    def items
      response = simple.get_collection(url: path, limit: limit, offset: offset)
      response[:data].map do |item|
        item_class.new(data: item, simple: simple)
      end
    end

    def next_page
      self.offset += page_size
      items
    end
  end
end
