#!/bin/bash

cd bootstrap/
echo "Starting bootstrap creation"
/bin/bash execution.sh
cd ..

cd usecases/order/database
echo "Starting bootstrap creation"
/bin/bash execution.sh
cd ../../../

cd usecases/order/list
echo "Starting usecases/order/list creation"
/bin/bash execution.sh
cd ../../../

cd usecases/order/calculate
echo "Starting usecases/order/calculate creation"
/bin/bash execution.sh
cd ../../../

cd usecases/order/update
echo "Starting usecases/order/update creation"
/bin/bash execution.sh
cd ../../../

cd usecases/carrier/notification
echo "Starting usecases/carrier/notification creation"
/bin/bash execution.sh
cd ../../../

cd usecases/site
echo "Starting usecases/site creation"
/bin/bash execution.sh
cd ../../../

echo "All stack has been deployed"