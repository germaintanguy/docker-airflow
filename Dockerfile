# Use an official Python runtime as a base image
FROM python:2.7


# Airflow
ARG AIRFLOW_VERSION=1.8.2rc1
ARG AIRFLOW_HOME=/usr/local/airflow

RUN apt-get update -yqq \
    && apt-get install -yqq apt-utils \
    && apt-get install -yqq netcat \
    && useradd -ms /bin/bash -d ${AIRFLOW_HOME} airflow \
    && pip install apache-airflow[crypto,celery,postgres,hive,hdfs,jdbc,gcp_api]==$AIRFLOW_VERSION \
    && pip install celery[redis]==3.1.17

RUN mkdir ${AIRFLOW_HOME}/dags/

COPY script/entrypoint.sh /entrypoint.sh
COPY conf/airflow.cfg ${AIRFLOW_HOME}/airflow.cfg
COPY examples/hello.py ${AIRFLOW_HOME}/dags/

RUN chown -R airflow: ${AIRFLOW_HOME}

EXPOSE 8080 5555 8793

USER airflow
WORKDIR ${AIRFLOW_HOME}
ENTRYPOINT ["/entrypoint.sh"]
