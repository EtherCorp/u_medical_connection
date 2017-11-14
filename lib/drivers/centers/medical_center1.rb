module Drivers
  # Driver for Medical Center 1
  # This parse the request to a normalized json-like hash
  class MedicalCenter1 < BaseDriver
    def professionals_key_converter(request)
    { 'speciality' => request['especialidad'],
      'registration_number' => request['numero_registro'],
      'registration_date' => request['fecha_registro'],  
      'rut' => request['run'][0..-2] + '-' + request['run'][-1],
      'name' => request['nombre'],
      'last_name' => request['apellido'],
      'age' => request['edad'],
      'nationality' => request['nacionalidad'],
      'phone' => request['telefono']
    }
    end

    def parse_patients(request)
      nombre = request['nombre'].split(' ', 2)
      { 'rut' => request['run'][0..-2] + '-' + request['run'][-1],
        'name' => nombre[0],
        'last_name' => nombre[1], 
        'age' => request['edad']}.to_json
    end

    def parse_professionals(request)
      return {}.to_json unless request.empty?
      request.merge(key_converter(request)).slice!(
        :especialidad, :numero_registro,
        :fecha_registro, :run, :nombre,
        :apellido, :edad, :nacionalidad,
        :telefono).to_json
    end

    def parse_consults(request)
      parsed = {}
      rut_string = request['runPaciente']
      puts rut_string
      puts request.inspect
      parsed[:patient_rut] = rut_string[0..-2] + '-' + rut_string[-1]
      rut_string = request['runProfesional']
      parsed[:professional_rut] = rut_string[0..-2] + '-' + rut_string[-1]
      parsed[:date] = request['fecha']
      parsed[:reason] = request['razon']
      parsed[:symptoms] = request['sintoma']
      parsed[:observations] = request['observaciones']
      parsed
    end

    def parse_movements(request)
      parsed = {}
      parsed[:type] = request['tipo']
      rut_string = request['runPaciente']
      parsed[:patient_rut] = rut_string[0..-2] + '-' + rut_string[-1]
      rut_string = request['runProfesional']
      parsed[:professional_rut] = rut_string[0..-2] + '-' + rut_string[-1]
      parsed[:detail] = request['detalles']
      parsed
    end
    
    def parse_unknown(request)
      parsed = {}
      parsed
    end
  end
end
