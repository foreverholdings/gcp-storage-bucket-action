#!/bin/sh

#Decode Base64-key to json file
echo "$INPUT_SERVICE_KEY" | base64 --decode > "$HOME"/service_key.json

gcloud auth activate-service-account --key-file="$HOME"/service_key.json --project "$INPUT_PROJECT"

gsutil -m cp -z "css,js,html,svg,json" -r . gs://"$INPUT_BUCKET_NAME"
gsutil web set -m "$INPUT_HOME_PAGE_PATH" -e "$INPUT_ERROR_PAGE_PATH" gs://"$INPUT_BUCKET_NAME"
gsutil -m setmeta -h "Cache-Control:public, max-age=31536000" gs://"$INPUT_BUCKET_NAME"/**/*.js
gsutil -m setmeta -h "Cache-Control:public, max-age=31536000" gs://"$INPUT_BUCKET_NAME"/**/*.css
gsutil -m setmeta -h "Cache-Control:public, max-age=31536000" gs://"$INPUT_BUCKET_NAME"/**/*.svg
gsutil -m setmeta -h "Cache-Control:public, max-age=31536000" gs://"$INPUT_BUCKET_NAME"/**/*.woff
gsutil -m setmeta -h "Cache-Control:public, max-age=31536000" gs://"$INPUT_BUCKET_NAME"/**/*.woff2
