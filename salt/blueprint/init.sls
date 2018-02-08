{% set ambari = pillar['ambari'] %}
{% set ambarimngr = ambari.ambarinode + '.' + ambari.domain %}


{% if grains['fqdn'] == ambarimngr %}

/tmp/blueprint:
  file.recurse:
    - source: salt://blueprint

blueprint-register:
    cmd.run:
      - name: 'curl -H "X-Requested-By: ambari" -X POST -u {{ ambari.ambariuser }}:{{ ambari.ambaripwd }} http://localhost:8080/api/v1/blueprints/{{ ambari.clustername }} -d @/tmp/blueprint/{{ ambari.blueprintname }}'

blueprint-deploy:
    cmd.run:
      - name: 'curl -H "X-Requested-By: ambari" -X POST -u {{ ambari.ambariuser }}:{{ ambari.ambaripwd }} http://localhost:8080/api/v1/clusters/{{ ambari.clustername }} -d @/tmp/blueprint/{{ ambari.blueprinthosts }}'


{% endif %}



