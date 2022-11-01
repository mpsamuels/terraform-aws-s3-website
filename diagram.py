from diagrams import Diagram, Cluster
from urllib.request import urlretrieve
from diagrams.custom import Custom

from diagrams.aws.storage import S3
from diagrams.aws.network import Route53HostedZone
from diagrams.aws.network import Route53
from diagrams.aws.network import CF
from diagrams.aws.compute import LambdaFunction
from diagrams.aws.network import APIGateway

with Diagram("S3 website", show=False):
    user = Custom("User", "./images/account.png")
    gui = Custom("S3 Uploader Page", "./images/application-outline.png")
    www_bucket = S3("www S3 bucket")
    root_bucket = S3("root S3 bucket")
    www_r53 = Route53("www r53 record")
    root_r53 = Route53("root r53 record")
    www_cf = CF("www Cloudfront")
    root_cf = CF("root Cloudfront")

    user >> root_r53 >> root_cf >> root_bucket >> www_bucket >> gui
    www_r53 >> www_cf >> www_bucket
    user >> www_r53