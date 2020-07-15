
S3=site-deliverycontest-victor.com
SITE_PATH=./site

aws s3 cp $SITE_PATH s3://$S3 --recursive
