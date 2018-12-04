namespace: Integrations.demo.aos.sub_flows
flow:
  name: remote_copy
  inputs:
    - host
    - username
    - password
    - url
  workflow:
    - extract_filename:
        do:
          io.cloudslang.demo.aos.tools.extract_filename:
            - url: '${url}'
        publish:
          - filename
        navigate:
          - SUCCESS: get_file
    - get_file:
        do:
          io.cloudslang.base.http.http_client_action:
            - url: '${url}'
            - destination_file: '${filename}'
            - method: GET
        navigate:
          - SUCCESS: remote_secure_copy
          - FAILURE: on_failure
    - remote_secure_copy:
        do:
          io.cloudslang.base.remote_file_transfer.remote_secure_copy:
            - source_path: '${filename}'
            - destination_host: '${host}'
            - destination_path: "${get_sp('script_location')}"
            - destination_username: '${username}'
            - destination_password:
                value: '${password}'
                sensitive: true
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - filename: '${filename}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      extract_filename:
        x: 161
        y: 87
      get_file:
        x: 319
        y: 85
      remote_secure_copy:
        x: 463
        y: 90
        navigate:
          a051c51a-c345-3ead-fe9e-b59a41060165:
            targetId: c56ea475-10b3-a6a5-a8da-b7f396c8cdee
            port: SUCCESS
    results:
      SUCCESS:
        c56ea475-10b3-a6a5-a8da-b7f396c8cdee:
          x: 461
          y: 229
