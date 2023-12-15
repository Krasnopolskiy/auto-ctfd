#!/bin/bash

mc alias set storage https://$MINIO_HOSTNAME:9000 $MINIO_ROOT_USER $MINIO_ROOT_PASSWORD

mc mb --ignore-existing storage/$MINIO_BUCKET_NAME --region $MINIO_REGION

mc anonymous set download storage/$MINIO_BUCKET_NAME
