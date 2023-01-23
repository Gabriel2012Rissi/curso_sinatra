module Api
  module V1
    class CarsController < ApplicationController
      namespace '/api/v1' do
        get '/cars' do
          @cars = Car.all
          # Get cars by brand
          @cars = @cars.where(brand: params[:brand]) if params[:brand]
          # Get cars by model
          @cars = @cars.where(model: params[:model]) if params[:model]
          # Get cars by year
          @cars = @cars.where(year: params[:year]) if params[:year]
          
          JSONAPI::Serializer.serialize(@cars, is_collection: true, namespace: Api::V1).to_json
        end

        get '/cars/:id' do
          @car = Car.find(params[:id])

          JSONAPI::Serializer.serialize(@car, namespace: Api::V1).to_json
        end

        post '/cars' do
          env['warden'].authenticate!(:access_token)

          params = Helpers::JsonHelper.json_params(request.body.read)

          @car = Car.new(params)
          
          if @car.save
            JSONAPI::Serializer.serialize(@car, namespace: Api::V1).to_json
          else
            status 422, { message: @car.errors.full_messages }.to_json
          end
        end

        patch '/cars/:id' do
          env['warden'].authenticate!(:access_token)

          @car = Car.find(params[:id])

          params = Helpers::JsonHelper.json_params(request.body.read)
          
          if @car.update(params)
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