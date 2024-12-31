FROM apache/airflow:latest-python3.11
COPY requirements.txt /
RUN pip install --no-cache-dir -r /requirements.txt &&  \
    pip install apache-airflow-providers-airbyte[http]
