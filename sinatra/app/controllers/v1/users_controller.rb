module Api
  module V1
    class UsersController < ApplicationController
      namespace '/api/v1' do  
        get '/user' do
          env['warden'].authenticate!(:access_token)

          @user = User.find_by(token: request.env['HTTP_AUTHORIZATION'].split(' ').last)
          
          JSONAPI::Serializer.serialize(@user, namespace: Api::V1).to_json
        end

        patch '/user' do
          env['warden'].authenticate!(:access_token)

          @user = User.find_by(token: request.env['HTTP_AUTHORIZATION'].split(' ').last)
          
          if @user.update(json_params)
            JSONAPI::Serializer.serialize(@user, namespace: Api::V1).to_json
          else
            status 422, { message: @user.errors.full_messages }.to_json
          end
        end

        delete '/user' do
          env['warden'].authenticate!(:access_token)

          @user = User.find_by(token: request.env['HTTP_AUTHORIZATION'].split(' ').last)
          
          if @user.destroy
            JSONAPI::Serializer.serialize(@user, namespace: Api::V1).to_json
          else
            status 204, { message: 'User was not deleted' }.to_json
          end
        end
      end
    end
  end
end