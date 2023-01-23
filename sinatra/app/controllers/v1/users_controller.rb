module Api
  module V1
    class UsersController < ApplicationController
      namespace '/api/v1' do  
        get '/user' do
          env['warden'].authenticate!(:access_token)

          @user = get_user_by_token
          
          JSONAPI::Serializer.serialize(@user, namespace: Api::V1).to_json
        end

        patch '/user' do
          env['warden'].authenticate!(:access_token)

          params = Helpers::JsonHelper.json_params(request.body.read)

          @user = get_user_by_token
          
          if @user.update(params)
            JSONAPI::Serializer.serialize(@user, namespace: Api::V1).to_json
          else
            status 422, { message: @user.errors.full_messages }.to_json
          end
        end

        delete '/user' do
          env['warden'].authenticate!(:access_token)

          @user = get_user_by_token
          
          if @user.destroy
            JSONAPI::Serializer.serialize(@user, namespace: Api::V1).to_json
          else
            status 204, { message: 'User was not deleted' }.to_json
          end
        end
      end

      private

      def get_user_by_token
        access_token = request.env['HTTP_AUTHORIZATION'].split(' ').last
        @user = User.find_by(username: Helpers::TokenHelper.decode_token(access_token))
        @user
      end
    end
  end
end