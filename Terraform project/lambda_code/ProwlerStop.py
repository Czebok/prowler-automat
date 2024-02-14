import boto3

def lambda_handler(event, context):

   ec2 = boto3.client('ec2', region_name='eu-central-1')   
   response = ec2.stop_instances(InstanceIds=['i-04b63d16c560b6ddc'])
   print('Zatrzymano instancje: i-04b63d16c560b6ddc')
