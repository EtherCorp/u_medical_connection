You can instantiate a driver like this:

`center_driver = 'MedicalCenter1' `

`driver = Object.const_get('Driver::'<<center_driver).new`


And call the parser like this:

`request_type = 'patients' `

`request_json_hash = {name: 'Don Graf', ... } `

`normalized_json = driver.parse(request_type, request_json_hash)`