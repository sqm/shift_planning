class ShiftPlanning::AuthenticationKeeper
  attr_reader :client

  def initialize(api_key, username, password)
    @client = ShiftPlanning::Client.new(api_key)
    @username = username
    @password = password
  end

  def run(&block)
    login unless @client.connection.authenticated?
    block.call @client
  rescue ShiftPlanning::ApiError => e
    raise e if e.code != 3
    login
    block.call @client
  end

  def logout
    @client.staff.get_logout if @client.connection.authenticated?
  end

  private

  def login
    @client.staff.get_login(@username, @password)
  end
end
