module Drivers
  # Driver for Medical Center 1
  # This parse the request to a normalized json-like hash
  class MedicalCenter1 < BaseDriver

    def professionals_key_converter(request)  
      puts request
      return {} if request.empty?
    { #'speciality' => request['especialidad'],
      'registration_number' => request['numero_registro'],
      'registration_date' => request['fecha_registro'],  
      'rut' => request['run'][0..-2] + '-' + request['run'][-1],
      'name' => request['nombre'],
      'last_name' => request['apellido'],
      'age' => request['edad'],
      'nationality' => request['nacionalidad'],
      'phone' => request['telefono'],
      'speciality_id' =>request['especialidad']
      #'speciality_id' => 2, #DUMMY SPECIALITY
    }
    end

    def parse_patients(request)
      return {} unless check_request(request, %w[nombre run edad])
      nombre = request['nombre'].split(' ', 2)
      a = { 'rut' => request['run'][0..-2] + '-' + request['run'][-1],
        'name' => nombre[0],
        'last_name' => nombre[1], 
        'age' => request['edad']}
      puts a
      a
    end

    def parse_professionals(request)
      return {} if request.empty?
      a = request.merge(professionals_key_converter(request)).slice('id', 'name', 'last_name', 'rut', 'age', 
        'nationality', 'registration_date', 'freelance', 
        'job_title', 'grant_date', 'granting_entity', 'email', 'speciality_id', 'registration_number') 
      puts a
      a
    end

    def parse_consults(request)
      return {} if request.empty?
      {
      'patient_rut' => request['runPaciente'][0..-2] + '-' + request['runPaciente'][-1],
      'professional_rut' => request['runProfesional'][0..-2] + '-' + request['runProfesional'][-1],
      'date' => request['fecha'],
      'reason' => request['razon'],
      'symptoms' => request['sintoma'],
      'observations' => request['observaciones']}
    end

    def parse_movements(request)
      return {} if request.empty?
      {
      'type' => request['tipo'],
      'patient_rut' => request['runPaciente'][0..-2] + '-' + request['runPaciente'][-1],
      'professional_rut' => request['runProfesional'][0..-2] + '-' + request['runProfesional'][-1],
      'detail' =>request['detalles']}
    end

    def check_movement(request, attr_required)
      attr_required.each do |atribute|
        return 'unknown' unless request.include?(atribute)
        return 'unknown' if request[atribute].nil?
      end
      request['tipo'].downcase!
    end

    def parse_exams(request)
      {
        'type' => 'exam',
        'patient' => request['runPaciente'],
        'professional' => request['runProfesional'],
        'details' => request['detalles']
      }
    end

    def parse_diagnostics(request)
      {
        'type' => 'diagnostic',
        'patient' => request['runPaciente'],
        'professional' => request['runProfesional'],
        'details' => request['detalles']
      }
    end

    def parse_prescriptions(request)
      {
        'type' => 'prescription',
        'patient' => request['runPaciente'],
        'professional' => request['runProfesional'],
        'details' => request['detalles']
      }
    end

    def parse_licenses(request)
      {
        'type' => 'license',
        'patient' => request['runPaciente'],
        'professional' => request['runProfesional'],
        'details' => request['detalles']
      }
    end

    def parse_procedures(request)
      {
        'type' => 'procedures',
        'patient' => request['runPaciente'],
        'professional' => request['runProfesional'],
        'details' => request['detalles']
      }
    end
  end
end
