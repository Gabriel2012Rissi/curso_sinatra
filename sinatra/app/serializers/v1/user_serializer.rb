module Api
  module V1
    class UserSerializer < BaseSerializer
      attributes :name, :email, :username, :token
    end
  end
end