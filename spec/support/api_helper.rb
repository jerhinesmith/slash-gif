module Requests
  module ApiHelpers
    def set_api_version(version)
      @version = version.to_s =~ /^v/i ? version : "v#{version}"
    end

    def set_user(user)
      @user = user
    end

    def get(uri, params = {}, session = {})
      super uri, params, default_header.merge(session)
    end

    def post(uri, params = {}, session = {})
      super uri, params, default_header.merge(session)
    end

    def put(uri, params = {}, session = {})
      super uri, params, default_header.merge(session)
    end

    def patch(uri, params = {}, session = {})
      super uri, params, default_header.merge(session)
    end

    def delete(uri, params = {}, session = {})
      super uri, params, default_header.merge(session)
    end

    def default_header
      accept = "application/vnd.#{ApiConstraints::VENDOR_PREFIX}.#{@version || 'v1'}"

      header = { 'Accept' => accept }

      header.merge!({
        Authorization: "Token token=\"#{@user.authentication_token}\""
      }) if @user

      header
    end
  end
end
