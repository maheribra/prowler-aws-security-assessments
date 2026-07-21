import boto3
from botocore.exceptions import ClientError

# Enter the name of the S3 bucket you want to remediate
BUCKET_NAME = "aws-cloudtrail-logs-018134828551-513d4334"


def enable_s3_public_access_block():
    s3 = boto3.client("s3")

    try:
        s3.put_public_access_block(
            Bucket=BUCKET_NAME,
            PublicAccessBlockConfiguration={
                "BlockPublicAcls": True,
                "IgnorePublicAcls": True,
                "BlockPublicPolicy": True,
                "RestrictPublicBuckets": True
            }
        )

        print(f"[SUCCESS] S3 Block Public Access enabled for: {BUCKET_NAME}")

    except ClientError as e:
        print(f"[ERROR] Failed to remediate bucket: {e}")


if __name__ == "__main__":
    enable_s3_public_access_block()