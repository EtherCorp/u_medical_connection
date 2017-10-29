Dir[File.expand_path 'centers/**/*.rb'].each { |f| require_relative(f) }

module Drivers
  # Base class of all Drivers.
  class Base
    # Dispatch message depending of request_type
    def parse(request_type, request)
      method_name = "parse_#{request_type}"
      public_send(method_name, request)
    end
  end
end
