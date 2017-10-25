require_relative 'medical_center_faker'

faker = MedicalCenterFaker.new

# Use default parameters
faker.run
faker.run2
faker.run3
faker.run4

# Use custom requests
requests_meta = [
  {source: 'MedicalCenter1', request_type: 'patient', request_number: 8645}
  # {source: 'MedicalCenter2', request_type: 'consult', request_number: 100}
  # {source: 'ClinicaBicentenario', request_type: 'exam', request_number: 420}
]

# faker.run(request_meta)
