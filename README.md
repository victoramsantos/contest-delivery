

# Apply terraform order
- vpc
- vpc endpoint
- rds
- api gateway
- lambda > list
- lambda > calculate
- lambda > update
- lambda > notify
- ec2
- cloudfront

# Build environment order
- bootstrap
- usecases/order/database
- usecases/order/list
- usecases/order/calculate
- usecases/order/update
- usecases/carrier/notification
- site

# Run procedures
- database setup
    - connect to ec2
    - install mariadb
    - connect to rds db using credentials
    - run usecase/order/database/assets/entrypoint.sql

- api gateway setup
    - you must perform a manual deploy of your api at aws console    
    
- setup site
    - edit site/content/site/index.html with:
        - styles.css's url references (line 4)
        - api gateway url references (line 29)




# setup database 
sudo yum update -y
sudo wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm 
sudo yum localinstall mysql57-community-release-el7-11.noarch.rpm -y
sudo yum install mysql-community-server -y
sudo systemctl start mysqld.service


export HOST={RDS' url}
export USER={Content of contest-database-username variable at Secret Manager}
export PASSWORD={Content of contest-database-password variable at Secret Manager}


mysql --host=$HOST --user=$USER --password=$PASSWORD 
