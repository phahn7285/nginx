#!/bin/bash

SERVICE="$1"
LOGFILE="$HOME/service-actions.log"

log_action() {
    echo "$(date): $1" >> "$LOGFILE"
}

if [ -z "$SERVICE" ]; then
    echo "ERROR: No service specified"
    log_action "ERROR: stop-service.sh called with no service"
    exit 1
fi

log_action "STOP action requested for: $SERVICE"

case "$SERVICE" in
    "adminer")
        log_action "Stopping Adminer container (dbadmin)"
        cd ../.. && docker compose stop dbadmin
        RESULT=$?
        ;;
    "kafka")
        log_action "Stopping Kafka container"
        cd ../.. && docker compose stop kafka
        RESULT=$?
        ;;
    "mysql")
        log_action "Stopping MySQL container"
        cd ../.. && docker compose stop mysql
        RESULT=$?
        ;;
    "nginx")
        log_action "Stopping Nginx container"
        cd ../.. && docker compose stop nginx
        RESULT=$?
        ;;
    "docker")
        log_action "Stopping Docker service"
        sudo systemctl stop docker
        RESULT=$?
        ;;
    "samba")
        log_action "Stopping Samba service"
        sudo systemctl stop smbd nmbd
        RESULT=$?
        ;;
    "butterfly")
        log_action "Stopping Butterfly web terminal"
        sudo systemctl stop butterfly
        RESULT=$?
        ;;
    "react-app")
        log_action "Stopping React development server"
        pkill -f "npm.*dev"
        RESULT=$?
        ;;
    *)
        log_action "ERROR: Unknown service: $SERVICE"
        echo "ERROR: Unknown service: $SERVICE"
        exit 1
        ;;
esac

if [ $RESULT -eq 0 ]; then
    log_action "SUCCESS: $SERVICE stopped successfully"
    echo "SUCCESS: $SERVICE stopped"
else
    log_action "ERROR: Failed to stop $SERVICE (exit code: $RESULT)"
    echo "ERROR: Failed to stop $SERVICE"
    exit $RESULT
fi
