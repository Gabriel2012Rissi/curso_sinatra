module Api
  module V1
    class CarsController < ApplicationController
      namespace '/api/v1' do
        get '/cars' do
          # env['warden'].authenticate!(:access_token)

          @cars = Car.all
          @cars = @cars.where(brand: params[:brand]) if params[:brand]
          
          JSONAPI::Serializer.serialize(@cars, is_collection: true, namespace: Api::V1).to_json
        end

        get '/cars/:id' do
          # env['warden'].authenticate!(:access_token)

          @car = Car.find(params[:id])

          JSONAPI::Serializer.serialize(@car, namespace: Api::V1).to_json
        end

        post '/cars' do
          env['warden'].authenticate!(:access_token)

          @car = Car.new(json_params)
          
          if @car.save
            JSONAPI::Serializer.serialize(@car, namespace: Api::V1).to_json
          else
            status 422, { message: @car.errors.full_messages }.to_json
          end
        end

        patch '/cars/:id' do
          env['warden'].authenticate!(:access_token)

          @car = Car.find(params[:id])
          
          if @car.update(json_params)
            JSONAPI::Serializer.serialize(@car, namespace: Api::V1).to_json
          else
            status 422, { message: @car.errors.full_messages }.to_json
          end
        end

        delete '/cars/:id' do
          env['warden'].authenticate!(:access_token)

          @car = Car.find(params[:id])
          
          if @car.destroy
            JSONAPI::Serializer.serialize(@car, namespace: Api::V1).to_json
          else
            status 204, { message: 'Car was not deleted' }.to_json
          end
        end
      end
    end
  end
end