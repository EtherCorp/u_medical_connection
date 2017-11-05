module API
  class API < Grape::API
    format :json
    prefix :api

    version 'v1', using: :path do
      mount ::V1::Base
      mount ::V1::Consults
      mount ::V1::Movements
      mount ::V1::Patients
      mount ::V1::Professionals
    end
  end
end