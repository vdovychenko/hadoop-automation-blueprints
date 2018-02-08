{% set ambari = pillar['ambari'] %}
{% set ambarimngr = ambari.ambarinode + '.' + ambari.domain %}

ambari:
  pkg.installed:
    {% if grains['fqdn'] == ambarimngr %}
    - pkgs:
      - ambari-server
      - ambari-agent
    {% else %}
    - name: ambari-agent
    {% endif %}
    - require:
      - pkgrepo: ambari-repo


ambari-repo:
  pkgrepo.managed:
    - name: ambari
    - humanname: ambari-2.5.1.0 - Updates
    - baseurl: http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.5.1.0
    - gpgkey: http://public-repo-1.hortonworks.com/ambari/centos7/RPM-GPG-KEY/RPM-GPG-KEY-Jenkins
    - gpgcheck: 1
    - priority: 1


ambari-agent.ini:
    file.blockreplace:
        - name: /etc/ambari-agent/conf/ambari-agent.ini
        - marker_start: "[server]"
        - marker_end: "url_port=8440"
        - content: hostname={{ ambari.ambarinode }}.{{ ambari.domain }}
        - append_if_not_found: True
        - backup: '.bak'
        - show_changes: True


ambari-agent:
    pkg.installed:
        - name: ambari-agent
    service.running:
      - name: ambari-agent
      - enable: True
      - require:
        - pkg: ambari-agent

{% if grains['fqdn'] == ambarimngr %}
ambari-server-setup:
    cmd.run:
      - name: 'ambari-server setup -s'


ambari-server-run:
    pkg.installed:
      - name: ambari-server
    service.running:
      - name: ambari-server
      - enable: True
      - init_delay: 30
      - require:
        - pkg: ambari-server

{% endif %}

