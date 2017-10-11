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

      movement={:token => "000",:medical_center => params[:medical_center],:status => "Pending" , :queued => nil , :body => params}
      puts movement
      conn.save_movement(movement)
    end

  end

end
