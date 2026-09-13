import json
import boto3
import pymysql


def get_database_credentials():
    client = boto3.client("secretsmanager", region_name="eu-west-1")

    response = client.get_secret_value(
        SecretId="production/rds/credentials"
    )

    return json.loads(response["SecretString"])


def get_connection():
    credentials = get_database_credentials()

    return pymysql.connect(
        host=credentials["host"],
        user=credentials["username"],
        password=credentials["password"],
        database=credentials["database"],
        port=credentials["port"],
    )
