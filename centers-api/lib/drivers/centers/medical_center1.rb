module Drivers
  # Driver for Medical Center 1
  # This parse the request to a normalized json-like hash
  class MedicalCenter1 < Base
    def parse_patients(request)
      parsed = {}
      rut_string = request[:run].to_s
      parsed[:rut] = rut_string[0..-2] << '-' << rut_string[-1]
      parsed[:name], parsed[:last_name] = request[:nombre].split(' ', 2)
      parsed[:age] = request[:edad]
      parsed
    end
  end
end