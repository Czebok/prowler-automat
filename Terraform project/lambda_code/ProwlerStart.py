import boto3
import time

COMMAND = './startscan.sh'
WORKDIR = '/home/ubuntu'


def lambda_handler(event, context):

   ec2 = boto3.client('ec2', region_name='eu-central-1')
   ssm = boto3.client('ssm')

   response = ec2.start_instances(InstanceIds=['i-04b63d16c560b6ddc'])
   print('Uruchomiono instancje: i-04b63d16c560b6ddc')
   
   time.sleep(180)
   
   response = ssm.send_command(
   InstanceIds=["i-04b63d16c560b6ddc"],
   DocumentName="AWS-RunShellScript",
   Parameters={'commands': [COMMAND], 'workingDirectory': [WORKDIR]}
   )
   print('scan has been started :)')

