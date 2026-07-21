import boto3
from botocore.exceptions import ClientError


# Enter your CloudTrail trail name
TRAIL_NAME = "security-audit-trail"


def enable_cloudtrail_log_validation():
    cloudtrail = boto3.client("cloudtrail", region_name="eu-north-1")

    try:
        cloudtrail.update_trail(
            Name=TRAIL_NAME,
            EnableLogFileValidation=True
        )

        print(
            f"[SUCCESS] CloudTrail log file validation enabled for: {TRAIL_NAME}"
        )

    except ClientError as e:
        print(f"[ERROR] Failed to update CloudTrail trail: {e}")


if __name__ == "__main__":
    enable_cloudtrail_log_validation()