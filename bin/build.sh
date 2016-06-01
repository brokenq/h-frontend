#!/usr/bin/env bash

deploy(){
    npm install
    if [ $profile == "local" ]; then
        gulp serve:local --env local
        pm2 startOrRestart ecosystem.json --watch
    else
        gulp serve:$profile --env $profile
        pm2 startOrRestart ecosystem.json --env $profile
    fi
}

# $1 = dev | qa | prod
profile="local"

if [ -n $1 -a \( $1 == "local" -o $1 == "dev" -o $1 == "qa" -o $1 == "prod" \) ];then
    profile=$1
else
    echo "support (local | dev | qa | prod) profile only"
    exit 1
fi

echo "current environment: $profile"
deploy
exit 0