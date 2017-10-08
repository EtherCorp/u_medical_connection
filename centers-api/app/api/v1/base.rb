module V1
  # Base class of API v1
  class Base < Grape::API
    version 'v1', using: :path

    # endpoint example
    resource :movements do
      desc 'Sends params to queue'
      post do
        params
      end
    end

    desc 'Accepts information and passes it to the queue as default'
    post do
      params
    end

  end
end
