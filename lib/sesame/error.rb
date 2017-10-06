module Sesame
  class Error < StandardError
    attr_reader :status, :code

    def initialize(status, data)
      super(data['message'])
      @data = data
      @status = status
      @code = data['code'].to_i
    end

    def to_s
      %(#{@data['message']} HTTP: #{status}, API: #{@data['code']})
    end
  end
end
