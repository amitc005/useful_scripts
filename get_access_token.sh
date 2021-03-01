#!/bin/sh
export auth_token=$(http -v POST http://127.0.0.1:8000/auth/login email="scho@texadasoftware.com" password="TEST1" clientID="test_client" companyID:=1 | grep "authToken" | cut -d":" -f 2 | tr -d "[:space:]")
echo $auth_token
