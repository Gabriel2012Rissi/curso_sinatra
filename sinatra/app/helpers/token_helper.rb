module Helpers
  class TokenHelper
    def self.decode_token(token)
      token_decoded = Libraries::JsonWebToken.decode(token)
      token_decoded[:data]
    end
  end
end