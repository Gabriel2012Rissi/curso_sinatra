module Libraries
  module JsonWebToken
    def self.encode(data, expire = nil)
      expire.nil? ? expire = 1.day.from_now : expire
      payload = { data: data, exp: expire.to_i }
      JWT.encode(payload, API_KEY, 'HS256')
    end
  
    def self.decode(token)
      body = JWT.decode(token, API_KEY, true, algorithm: 'HS256')[0]
      ActiveSupport::HashWithIndifferentAccess.new body
    end
  end
end