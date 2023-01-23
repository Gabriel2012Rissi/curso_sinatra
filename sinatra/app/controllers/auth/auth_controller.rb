module Api
  module Auth
    class AuthController < ApplicationController
      namespace '/api/auth' do
        post '/login' do
          params = json_params
          @user = User.find_by(email: params['email'])
          if @user.authenticate(params['password'])
            status 200
            {
              data: {
                id: @user.id,
                type: 'user',
                attributes: {
                  token: @user.token
                }
              }
            }.to_json
          else
            status 401
            {
              errors: [
                {
                  status: 401,
                  title: 'Unauthorized',
                  detail: 'Invalid credentials'
                }
              ]
            }.to_json
          end
        end

        post '/signup' do
          params = json_params
          @user = User.new(params)
          if @user.save
            status 201
            {
              data: {
                id: @user.id,
                type: 'user',
                attributes: {
                  token: @user.token
                }
              }
            }.to_json
          else
            status 422
            {
              errors: [
                {
                  status: 422,
                  title: 'Unprocessable Entity',
                  detail: @user.errors.full_messages
                }
              ]
            }.to_json
          end
        end
      end
    end
  end
end