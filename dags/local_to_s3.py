from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
import os
from os import path
from minio import Minio
from minio.error import S3Error
import logging
from config import minio

def upload_to_minio(bucket_name, destination_file, source_file):
    try:
        # Initialize Minio client
        client = Minio(
            endpoint="host.docker.internal:9000",
            access_key=minio['minio_username'],
            secret_key=minio['minio_password'],
            secure=False
        )

        # Check if bucket exists; if not, create it
        if not client.bucket_exists(bucket_name):
            client.make_bucket(bucket_name)
            logging.info(f"Bucket '{bucket_name}' created successfully.")
        else:
            logging.info(f"Bucket '{bucket_name}' already exists.")

        # Upload file
        client.fput_object(bucket_name, destination_file, source_file)
        logging.info(f"{source_file} successfully uploaded as object {destination_file} to bucket {bucket_name}.")

    except S3Error as e:
        logging.error(f"S3Error occurred: {e}")
        raise
    except Exception as e:
        logging.error(f"An unexpected error occurred: {e}")
        raise


# Define Airflow DAG
default_args = {
    'owner': 'airflow',
    'retries': 1,
}

with DAG(
    dag_id='upload_to_minio_dag',
    default_args=default_args,
    description='Upload files from a local directory to Minio bucket',
    schedule_interval=None,
    start_date=datetime(2024, 1, 1),
    catchup=False,
) as dag:

    data_path = '/opt/airflow/data_csv'
    bucket_name = 'salesdata'

    # Check if the data directory exists
    if not path.exists(data_path):
        raise FileNotFoundError(f"The directory '{data_path}' does not exist.")

    # List all files in the data directory
    files_list = [file for file in os.listdir(data_path) if path.isfile(path.join(data_path, file))]

    if not files_list:
        raise ValueError(f"No files found in the directory '{data_path}'.")

    # Create a task for each file
    for file in files_list:
        # Ensure task IDs are unique and Airflow-compliant
        sanitized_file_name = file.replace(".", "_").replace(" ", "_")
        destination_file = f'/bronze/{file.split(".")[0]}/{file}'
        source_file = path.join(data_path, file)

        PythonOperator(
            task_id=f'upload_{sanitized_file_name}',
            python_callable=upload_to_minio,
            op_args=[bucket_name, destination_file, source_file],
        )
