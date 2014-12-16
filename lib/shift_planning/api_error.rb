class ShiftPlanning::ApiError < Exception
  attr_reader :code

  CODES = {
    -3 => 'Flagged API Key - Pemanently Banned',
    -2 => 'Flagged API Key - Too Many invalid access attempts - contact us',
    -1 => 'Flagged API Key - Temporarily Disabled - contact us',
    1 => 'Success',
    2 => 'Invalid API key - App must be granted a valid key by ShiftPlanning',
    3 => 'Invalid token key - Please re-authenticate',
    4 => 'Invalid Method - No Method with that name exists in our API',
    5 => 'Invalid Module - No Module with that name exists in our API',
    6 => 'Invalid Action - No Action with that name exists in our API',
    7 => 'Authentication Failed - You do not have permissions to access the service',
    8 => 'Missing parameters - Your request is missing a required parameter',
    9 => 'Invalid parameters - Your request has an invalid parameter type',
    10 => 'Extra parameters - Your request has an extra/unallowed parameter type',
    12 => 'Create Failed - Your CREATE request failed',
    13 => 'Update Failed - Your UPDATE request failed',
    14 => 'Delete Failed - Your DELETE request failed',
    15 => 'Get Failed - Your GET request failed',
    20 => 'Incorrect Permissions - You don\'t have the proper permissions to access this',
    90 => 'Suspended API key - Access for your account has been suspended, please contact ShiftPlanning',
    91 => 'Throttle exceeded - You have exceeded the max allowed requests. Try again later.',
    98 => 'Bad API Paramaters - Invalid POST request. See Manual.',
    99 => 'Service Offline - This service is temporarily offline. Try again later.',
    100 => 'Can not connect to LDAP - host or port are incorect',
    101 => 'Can not connect to LDAP - username or password are incorrect'
  }

  def initialize(code, message)
    @code = code
    super message
  end

  def self.parse(code)
    raise new(code, CODES[code]) if code != 1
  end
end
