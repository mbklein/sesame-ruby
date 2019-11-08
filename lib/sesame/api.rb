require 'faraday'
require 'json'

module Sesame
  module Api
    ENDPOINT_URL = 'https://api.candyhouse.co/public'.freeze

    def client
      @client ||= Faraday.new(url: ENDPOINT_URL)
    end

    def auth_token(value)
      @auth_token = value
      self
    end

    def get_sesames
      get('sesames')
    end

    def get_sesame(device_id:)
      get("sesame/#{device_id}")
    end

    def control_sesame(device_id:, command:)
      post("sesame/#{device_id}", command: command)
    end

    def get(path)
      call(:get, path)
    end

    def post(path, params)
      call(:post, path, params)
    end

    def call(method, path, params = nil)
      response = client.send(method) do |req|
        req.url path
        req.headers['Content-Type'] = 'application/json'
        req.headers['Authorization'] = @auth_token unless @auth_token.nil?
        req.body = params.to_json unless params.nil?
      end
      parse_response(response)
    end

    def parse_response(response)
      parsed_response = response.headers['Content-Length'].to_i > 0 ? JSON.parse(response.body) : ''
      raise Error.new(response.status, parsed_response) if response.status >= 400

      parsed_response
    end
  end
end
