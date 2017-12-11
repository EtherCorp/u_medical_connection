module Drivers
  # Driver for Medical Center 1
  # This parse the request to a normalized json-like hash
  class MedicalCenter1 < BaseDriver
    def professionals_key_converter(request)
      return {} if request.empty?
      { 'registration_number' => request['numero_registro'],
        'registration_date' => request['fecha_registro'],
        'rut' => request['run'][0..-2] + '-' + request['run'][-1],
        'name' => request['nombre'],
        'last_name' => request['apellido'],
        'age' => request['edad'],
        'nationality' => request['nacionalidad'],
        'phone' => request['telefono'],
        'speciality_id' => request['especialidad'] }
    end

    def parse_patients(request)
      return {} unless check_request(request, %w[nombre run edad])
      nombre = request['nombre'].split(' ', 2)
      { 'rut' => request['run'][0..-2] + '-' + request['run'][-1],
        'name' => nombre[0],
        'last_name' => nombre[1],
        'age' => request['edad'] }
    end

    def parse_professionals(request)
      return {} if request.empty?
      keys = %w[id name last_name rut age nationality registration_date email
                job_title grant_date granting_entity freelance speciality_id
                registration_number]
      request.merge(professionals_key_converter(request)).slice(keys)
    end

    def parse_consults(request)
      return {} if request.empty?
      { 'patient_id' => request['idPaciente'],
        'professional_id' => request['idProfesional'],
        'date' => request['fecha'],
        'reason' => request['razon'],
        'symptoms' => request['sintoma'],
        'observations' => request['observaciones'] }
    end

    def parse_movements(request)
      keys = %w[tipo consulta detalles]
      return {} if request.empty? || check_movement(request, keys) == 'unknown'
      { 'type' => request['tipo'],
        'consult_id' => request['consulta'],
        'details' => parse_details(request['detalles']) }
    end

    def parse_details(details)
      return { 'files' => {}, 'details' => {}} if details.nil? || details.empty?
      { 'files' => get_files(details['files']),
        'details' => get_details(details['other'])}
    end

    def get_files(files)
      return [] if files.nil? || files.empty?
      parsed_files = []
      files.each do |file|
        if file.include?('name') && file.include?('file')
          parsed_files.push('name' => file['name'], 'content' => file['file'])
        end
      end
      parsed_files
    end

    def get_details(other)
      return nil unless other.is_a?(String)
      [{ 'key' => 'demo', 'value' => other }]
    end
  end
end
