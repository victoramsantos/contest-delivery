SITE_S3=site-deliverycontest-victor.com
ASSETS_S3=assets-deliverycontest-victor.com

SITE_PATH=usecases/site/content/site
ASSETS_PATH=usecases/site/content/assets

aws s3 cp $SITE_PATH s3://$SITE_S3 --recursive
aws s3 cp $ASSETS_PATH s3://$ASSETS_S3 --recursive
