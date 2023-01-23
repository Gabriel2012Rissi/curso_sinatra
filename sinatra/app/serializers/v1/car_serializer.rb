module Api
  module V1
    class CarSerializer < BaseSerializer
      attributes :brand, :model, :year, :price
    end
  end
end