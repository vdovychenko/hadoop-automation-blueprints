ambari:
  # The cluster domain name
  domain: cap

  # The short host name where Ambari will be installed
  ambarinode: master-01

  # Blueprint file. There are several available blueprints:
  # - bp-hdfs.json - install only HDFS and YARN
  # - bp-hdfs-hive.json - install Hive in addition to previous configuration
  # - bp-hdfs-hive-spark.json - install Spark in addition to previous configuration
  blueprintname: bp-hdfs.json

  # Blueprint hosts file - describes. There are several hosts files:
  # - hosts-1node.json - for 1 node installation
  # - hosts-3node.json - for 3 node installation
  blueprinthosts: hosts-3node.json

  # HDP Cluster name
  # before changing make sure that blueprint file contains the same name
  clustername: hdp

  # Ambari username and password
  ambariuser: admin
  ambaripwd: admin

nodes:
  master-01: 172.31.48.9
  data-01: 172.31.62.250
  data-02: 172.31.59.235
