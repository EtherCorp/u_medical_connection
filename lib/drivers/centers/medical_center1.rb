module Drivers
  # Driver for Medical Center 1
  # This parse the request to a normalized json-like hash
  class MedicalCenter1 < BaseDriver
    def professionals_key_converter(request)
      return {}.to_json unless request.empty?
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
      return {}.to_json unless request.empty?
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
      return {}.to_json unless request.empty?
      {
      'patient_rut' => request['runPaciente'][0..-2] + '-' + request['runPaciente'][-1],
      'professional_rut' => request['runProfesional'][0..-2] + '-' + request['runProfesional'][-1],
      'date' => request['fecha'],
      'reason' => request['razon'],
      'symptoms' => request['sintoma'],
      'observations' = request['observaciones']}.to_json
    end

    def parse_movements(request)
      return {}.to_json unless request.empty?
      {
      'type' => request['tipo'],
      'patient_rut' => request['runPaciente'][0..-2] + '-' + request['runPaciente'][-1],
      'professional_rut' => request['runProfesional'][0..-2] + '-' + request['runProfesional'][-1],
      'detail' =>request['detalles']}.to_json
    end
    
  end
end
