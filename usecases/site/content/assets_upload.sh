
S3=assets-deliverycontest-victor.com
SITE_PATH=./assets

aws s3 cp $SITE_PATH s3://$S3 --recursive
