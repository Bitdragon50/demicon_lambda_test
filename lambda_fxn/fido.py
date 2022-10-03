import boto3
import json
from urllib.parse import unquote_plus



def lambda_handler(event, context):
    """Read file from s3 on trigger."""
    s3 = boto3.client("s3")
    fileObj = s3.get_object(Bucket="tf-state-bucket-6542", Key="terraform.tfstate")
    file_content = fileObj["Body"].read().decode("utf-8")
    json_Content = json.loads(file_content)
    print(json_Content)  
    
    return json_Content