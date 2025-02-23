import os
import pandas as pd
from google.cloud import storage
from google.cloud import bigquery
from pandas_gbq import to_gbq

# Configurações do GCP
PROJECT_ID = "taxi-rides-ny-00"
DATASET_ID = "zoomcamp"
LOCATION = "europe-west2"  # Região correta
BUCKET_NAME = "almb-bucket-zoomcamp-new"
CREDENTIALS_PATH = "c:/Users/thebo/.gcp/dbt.json"

# Configurar credenciais do GCP
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = CREDENTIALS_PATH

# Inicializar clientes
storage_client = storage.Client()
bigquery_client = bigquery.Client()

def list_parquet_files(prefix):
    """Lista os arquivos Parquet no bucket do GCS com um prefixo específico."""
    bucket = storage_client.bucket(BUCKET_NAME)
    return [blob.name for blob in bucket.list_blobs(prefix=prefix) if blob.name.endswith(".parquet")]

def process_and_upload(table_name, prefix):
    """Lê os arquivos Parquet do GCS e os envia individualmente para o BigQuery."""
    parquet_files = list_parquet_files(prefix)

    if not parquet_files:
        print(f"Nenhum arquivo encontrado para {table_name}. Pulando...")
        return

    print(f"Processando {len(parquet_files)} arquivos para {table_name}...")

    table_id = f"{PROJECT_ID}.{DATASET_ID}.{table_name}"
    first_file = True

    for file in parquet_files:
        file_path = f"gs://{BUCKET_NAME}/{file}"
        print(f"Lendo {file_path}...")
        df = pd.read_parquet(file_path, engine="pyarrow")

        # Definir o modo de inserção
        mode = "replace" if first_file else "append"
        first_file = False

        # Enviar para o BigQuery
        to_gbq(df, table_id, project_id=PROJECT_ID, if_exists=mode, location=LOCATION)
        print(f"Upload de {file} concluído!")

# Processar os datasets
process_and_upload("green_tripdata", "green/")
process_and_upload("yellow_tripdata", "yellow/")
process_and_upload("fhv_tripdata", "fhv/")
