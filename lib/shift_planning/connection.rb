class ShiftPlanning::Connection
  attr_reader :http

  def initialize(key)
    @key = key
    @token = nil
    @http = Faraday.new(url: "https://www.humanity.com") do |conn|
      conn.request :url_encoded

      conn.response :json
      conn.response :logger

      conn.adapter Faraday.default_adapter
    end
  end

  def call(method, command, params = {})
    request_params = {
      request: params.merge(
        method: method,
        module: command
      ),
      output: 'json'
    }

    response = http.post('/api/', data: JSON::generate(signed_params(request_params))).body
    ShiftPlanning::ApiError.parse(response['status'])

    parse_data response do |data|
      @token = data['token'] if data.has_key?('token')
    end
  end

  def authenticated?
    @token && !@token.empty?
  end

  private

  def parse_data(response_data, &block)
    data = response_data
    block.call(data) if block_given?
    data['data']
  end

  def signed_params(params)
    params.merge(key: @key, token: @token)
  end
end
