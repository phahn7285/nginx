#!/bin/bash

SERVICE="$1"
LOGFILE="$HOME/service-actions.log"

log_action() {
    echo "$(date): $1" >> "$LOGFILE"
}

if [ -z "$SERVICE" ]; then
    echo "ERROR: No service specified"
    log_action "ERROR: restart-service.sh called with no service"
    exit 1
fi

log_action "RESTART action requested for: $SERVICE"

case "$SERVICE" in
    "adminer")
        log_action "Restarting Adminer container (dbadmin)"
        cd ../.. && docker compose stop dbadmin && docker compose up -d dbadmin
        RESULT=$?
        ;;
    "kafka")
        log_action "Restarting Kafka container"
        cd ../.. && docker compose stop kafka && docker compose up -d kafka
        RESULT=$?
        ;;
    "mysql")
        log_action "Restarting MySQL container"
        cd ../.. && docker compose stop mysql && docker compose up -d mysql
        RESULT=$?
        ;;
    "nginx")
        log_action "Restarting Nginx container"
        cd ../.. && docker compose stop nginx && docker compose up -d nginx
        RESULT=$?
        ;;
    "docker")
        log_action "Restarting Docker service"
        sudo systemctl restart docker
        RESULT=$?
        ;;
    "samba")
        log_action "Restarting Samba service"
        sudo systemctl restart smbd nmbd
        RESULT=$?
        ;;
    "butterfly")
        log_action "Restarting Butterfly web terminal"
        sudo systemctl restart butterfly
        RESULT=$?
        ;;
    "react-app")
        log_action "Restarting React development server"
        pkill -f "npm.*dev"
        sleep 3
        # Start React dev server
        cd ../../react && npm run dev > ~/logs/react-app.log 2>&1 &
        RESULT=$?
        ;;
    *)
        log_action "ERROR: Unknown service: $SERVICE"
        echo "ERROR: Unknown service: $SERVICE"
        exit 1
        ;;
esac

if [ $RESULT -eq 0 ]; then
    log_action "SUCCESS: $SERVICE restarted successfully"
    echo "SUCCESS: $SERVICE restarted"
else
    log_action "ERROR: Failed to restart $SERVICE (exit code: $RESULT)"
    echo "ERROR: Failed to restart $SERVICE"
    exit $RESULT
fi
