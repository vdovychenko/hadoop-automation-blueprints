import boto3

def replaceIP(hostName, hostIP):
  with open('/srv/pillar/ambari.sls', 'r') as file :
    filedata = file.readlines()

  with open('/srv/pillar/ambari.sls', 'w') as file:
    for i in filedata:
      if hostName + ':' in i.replace(' ', '') :
        file.write('  ' + hostName+': '+ hostIP + '\n')
      else:
        file.write(i)



ec2 = boto3.client('ec2')

response = ec2.describe_instances()

for reservation in response["Reservations"]:
  for instance in reservation["Instances"]:
    if (instance["State"]["Name"] == "running"):
      privatIpAddr=instance["PrivateIpAddress"]
      for tag in instance["Tags"]:
        if tag["Key"] == "Name":
          hostName=tag["Value"]
          print("Replace: " + hostName + ' ' + privatIpAddr)
          replaceIP(hostName, privatIpAddr)


