namespace: Integrations.demo.aos.tools
flow:
  name: delete_file
  inputs:
    - host
    - username
    - password
    - filename
  workflow:
    - delete_file:
        do:
          io.cloudslang.base.ssh.ssh_command:
            - host: '${host}'
            - command: "${'cd '+get_sp('script_location')+' && rm -f '+filename}"
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      delete_file:
        x: 115
        y: 58
        navigate:
          8d204cda-4410-e2a9-87cb-f47cd1fd7d87:
            targetId: 9734afd6-7579-4d88-ea35-cd3d3c68bade
            port: SUCCESS
    results:
      SUCCESS:
        9734afd6-7579-4d88-ea35-cd3d3c68bade:
          x: 304
          y: 57
