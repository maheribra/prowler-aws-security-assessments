import boto3
from botocore.exceptions import ClientError


def enforce_iam_password_policy():
    iam = boto3.client("iam")

    try:
        iam.update_account_password_policy(
            MinimumPasswordLength=14,
            RequireUppercaseCharacters=True,
            RequireLowercaseCharacters=True,
            RequireNumbers=True,
            RequireSymbols=True,
            MaxPasswordAge=90,
            PasswordReusePrevention=24,
            AllowUsersToChangePassword=True
        )

        print("[SUCCESS] IAM password policy updated successfully.")
        print("[INFO] Minimum length: 14 characters")
        print("[INFO] Uppercase required: Yes")
        print("[INFO] Lowercase required: Yes")
        print("[INFO] Numbers required: Yes")
        print("[INFO] Symbols required: Yes")
        print("[INFO] Maximum password age: 90 days")
        print("[INFO] Password reuse prevention: 24 passwords")

    except ClientError as e:
        print(f"[ERROR] Failed to update IAM password policy: {e}")


if __name__ == "__main__":
    enforce_iam_password_policy()