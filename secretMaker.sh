#!/bin/bash
# MAIN VARIABLES
OUTPUT_GCP_FILE="create_gcp_secrets.sh"

echo "Secret Maker ver 0.1"
read -p 'Google Project ID: ' PROJECT_ID
read -p 'Archivo csv con secretos: ' INPUT_FILE

[ ! -f $INPUT_FILE ] && { echo "$INPUT_FILE file not found"; exit 99; }
rm -f $OUTPUT_GCP_FILE
while IFS="," read -r rec_column1 rec_column2 rec_column3
do
  echo "gcloud secrets create $rec_column1 --project_id=$PROJECT_ID --replication-policy=\"automatic\"" >> $OUTPUT_GCP_FILE
  echo "Secret Manager Name: $rec_column1"
  echo "K8S Name: $rec_column2"
  echo "Contenido: $rec_column3"
  echo ""
done < <(tail $INPUT_FILE)

