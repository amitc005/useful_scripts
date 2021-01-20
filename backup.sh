#!/bin/bash

db_backup(){
    env_path='/etc/gateway_settings/.env'
    if [ ! -f $env_path ]; then
        return 1
    fi

    source $env_path

    file_path="/tmp/$(date +'%Y%m%d').sql.gz"
    mysqldump --protocol=tcp --host=localhost --port=3306 --user=root --password=$DB_ROOT_PWD --all-databases | gzip > $file_path

    if [ $? -ne 0 ]; then
        return 1
    fi

    if [ ! -f "$file_path" ]; then
        return 1
    fi

    aws s3 cp "$file_path" s3://$BUCKET_NAME >> upload.log

    if [ $? -ne 0 ]; then
        return 1
    fi

    rm $file_path
    return 0
}

db_backup

if [ $? -ne 0 ]; then
        php api/app/cli.php server email "Backup error happened."
fi
