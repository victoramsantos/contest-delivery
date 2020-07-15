

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
- usecase/order/database
- usecase/order/list
- usecase/order/calculate
- usecase/order/update
- usecase/carrier/notification
- site

# Run procedures
- database setup
    - connect to ec2
    - install mariadb
    - connect to rds db using credentials
    - run usecase/order/database/assets/entrypoint.sql

- setup site
    - edit site/content/site/index.html with:
        - styles.css's url references (line 4)
        - api gateway url references (line 29)

