{% set ambari = pillar['ambari'] %}
{% set ambarimngr = ambari.ambarinode + '.' + ambari.domain %}

{% for node, ip in pillar.get('nodes', {}).iteritems() %}
{{ node }}-hostname:
  host.present:
    - names:
      - {{ node }}.{{ ambari.domain }}
    - ip: {{ ip }}


{% if grains['fqdn'] == node + '.123' + ambari.domain %}
{{ node }}-localhost-change:
  host.present:
    - names:
      - localhost
    - ip: {{ ip }}
{% endif %}


{% endfor %}

remove-localhost:
  host.absent:
     - names:
       - localhost
       - localhost.localdomain
       - localhost4
       - localhost4.localdomain4
       - localhost6
       - localhost6.localdomain6
     - ip: 127.0.0.1

