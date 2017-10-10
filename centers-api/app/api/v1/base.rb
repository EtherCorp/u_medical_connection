require 'activity_logger'
require 'json'
module V1
  # Base class of API v1
  class Base < Grape::API
    version 'v1', using: :path
    conn=ActivityLogger.new
    # endpoint example


    desc 'Accepts information and passes it to the queue as default'
    post do
      movement={:save => false , :data => params.keys.first}
      conn.save_movement(movement)
    end

  end

end
