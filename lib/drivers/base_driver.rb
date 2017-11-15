Dir[File.expand_path 'centers/**/*.rb'].each { |f| require_relative(f) }

module Drivers
  # Base class of all Drivers.
  class BaseDriver
    # Dispatch message depending of request_type
    def parse(request_type, request)
      method_name = "parse_#{request_type}"
      public_send(method_name, request)
    end
    #Método que deben tener todos los drivers. Permite reciclar JSON de consulta
    def professionals_key_converter(request) end
    def parse_patients(request) end
    def parse_professionals(request) end
    def parse_consults(request) end
    def parse_movements(request) end
    def parse_unknown(request)
      {}.to_json
    end
      
    end
  end
end
