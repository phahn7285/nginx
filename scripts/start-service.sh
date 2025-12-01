#!/bin/bash

SERVICE="$1"
LOGFILE="$HOME/logs/service-actions.log"

log_action() {
    echo "$(date): $1" >> "$LOGFILE"
}

if [ -z "$SERVICE" ]; then
    echo "ERROR: No service specified"
    log_action "ERROR: start-service.sh called with no service"
    exit 1
fi

log_action "START action requested for: $SERVICE"

case "$SERVICE" in
    "adminer")
        log_action "Starting Adminer container (dbadmin)"
        cd ../.. && docker compose up -d dbadmin
        RESULT=$?
        ;;
    "cadvisor")
        log_action "Starting cAdvisor container"
        cd ../.. && docker compose up -d cadvisor
        RESULT=$?
        ;;
    "grafana")
        log_action "Starting Grafana container"
        cd ../.. && docker compose up -d grafana
        RESULT=$?
        ;;
    "kafka")
        log_action "Starting Kafka container"
        cd ../.. && docker compose up -d kafka
        RESULT=$?
        ;;
    "loki")
        log_action "Starting Loki container"
        cd ../.. && docker compose up -d loki
        RESULT=$?
        ;;
    "mysql")
        log_action "Starting MySQL container"
        cd ../.. && docker compose up -d mysql
        RESULT=$?
        ;;
    "mysql-exporter")
        log_action "Starting MySQL Exporter container"
        cd ../.. && docker compose up -d mysql-exporter
        RESULT=$?
        ;;
    "nginx")
        log_action "Starting Nginx container"
        cd ../.. && docker compose up -d nginx
        RESULT=$?
        ;;
    "node-exporter")
        log_action "Starting Node Exporter container"
        cd ../.. && docker compose up -d node-exporter
        RESULT=$?
        ;;
    "prometheus")
        log_action "Starting Prometheus container"
        cd ../.. && docker compose up -d prometheus
        RESULT=$?
        ;;
    "promtail")
        log_action "Starting Promtail container"
        cd ../.. && docker compose up -d promtail
        RESULT=$?
        ;;
    "docker")
        log_action "Starting Docker service"
        sudo systemctl start docker
        RESULT=$?
        ;;
    "samba")
        log_action "Starting Samba service"
        sudo systemctl start smbd nmbd
        RESULT=$?
        ;;
    "butterfly")
        log_action "Starting Butterfly web terminal"
        sudo systemctl start butterfly
        RESULT=$?
        ;;
    "react-app")
        log_action "Starting React development server and IP detection server"
        # Start React dev server
        cd ../../react && npm run dev > ~/react/react-app.log 2>&1 &
        RESULT=$?
        ;;
    *)
        log_action "ERROR: Unknown service: $SERVICE"
        echo "ERROR: Unknown service: $SERVICE"
        exit 1
        ;;
esac

if [ $RESULT -eq 0 ]; then
    log_action "SUCCESS: $SERVICE started successfully"
    echo "SUCCESS: $SERVICE started"
else
    log_action "ERROR: Failed to start $SERVICE (exit code: $RESULT)"
    echo "ERROR: Failed to start $SERVICE"
    exit $RESULT
fi
