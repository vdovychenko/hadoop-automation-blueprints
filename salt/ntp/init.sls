ntp:
  pkg.installed: []
  service.running:
    - enable: True
    - name: ntpd
