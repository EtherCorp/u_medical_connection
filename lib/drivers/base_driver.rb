Dir[File.expand_path 'centers/**/*.rb'].each { |f| require_relative(f) }

module Drivers
  # Base class of all Drivers.
  class BaseDriver
    # Dispatch message depending of request_type
    def parse(request_type, request)
      method_name = "parse_#{request_type}"
      public_send(method_name, request)
    end

    # Método que deben tener todos los drivers. Permite reciclar JSON de consulta
    def professionals_key_converter(request) end

    def parse_patients(request) end

    def parse_professionals(request) end

    def parse_consults(request) end

    def parse_movements(request)
      keys = %w[tipo runPaciente runProfesional detalles]
      request_type = check_movement(request, keys)
      method_name = "parse_#{request_type}s"
      public_send(method_name, request)
    end

    def parse_unknown(_request)
      {}
    end

    def check_request(request, attr_list)
      return false unless check_param(request)
      return false unless check_param(attr_list)
      attr_list.each do |attribute|
        return false unless request.key?(attribute)
      end
      true
    end

    def check_param(attribute)
      return false if attribute.nil? || attribute.empty?
      attribute
    end
  end
end
