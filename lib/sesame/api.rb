require 'faraday'
require 'json'

module Sesame
  module Api
    ENDPOINT_URL = 'https://api.candyhouse.co/public'.freeze

    def authorized?
      !@auth_token.nil?
    end

    def client
      @client ||= Faraday.new(url: ENDPOINT_URL)
    end

    def auth_token(value)
      @auth_token = value
      self
    end

    def login(email:, password:)
      auth_response = post('accounts/login', email: email, password: password)
      auth_token(auth_response['authorization'])
    end

    def get_sesames
      get('sesames')
    end

    def get_sesame(device_id:)
      get("sesames/#{device_id}")
    end

    def control_sesame(device_id:, type:)
      post("sesames/#{device_id}/control", type: type)
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
        req.headers['X-Authorization'] = @auth_token unless @auth_token.nil?
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
