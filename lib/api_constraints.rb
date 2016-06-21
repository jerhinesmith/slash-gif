# http://railscasts.com/episodes/350-rest-api-versioning

class ApiConstraints
  VENDOR_PREFIX = 'slashgif'

  attr_accessor :version, :default

  def initialize(attributes = {})
    raise ArgumentError, 'No version specified or version of correct type' unless attributes[:version].to_i > 0

    self.version = attributes[:version]
    self.default = attributes.fetch(:default, false)
  end

  def matches?(req)
    self.default || req.headers['Accept'].include?("application/vnd.#{VENDOR_PREFIX}.v#{self.version}")
  end
end
