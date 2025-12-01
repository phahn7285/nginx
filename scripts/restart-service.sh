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
    "cadvisor")
        log_action "Restarting cAdvisor container"
        cd ../.. && docker compose stop cadvisor && docker compose up -d cadvisor
        RESULT=$?
        ;;
    "grafana")
        log_action "Restarting Grafana container"
        cd ../.. && docker compose stop grafana && docker compose up -d grafana
        RESULT=$?
        ;;
    "kafka")
        log_action "Restarting Kafka container"
        cd ../.. && docker compose stop kafka && docker compose up -d kafka
        RESULT=$?
        ;;
    "loki")
        log_action "Restarting Loki container"
        cd ../.. && docker compose stop loki && docker compose up -d loki
        RESULT=$?
        ;;
    "mysql")
        log_action "Restarting MySQL container"
        cd ../.. && docker compose stop mysql && docker compose up -d mysql
        RESULT=$?
        ;;
    "mysql-exporter")
        log_action "Restarting MySQL Exporter container"
        cd ../.. && docker compose stop mysql-exporter && docker compose up -d mysql-exporter
        RESULT=$?
        ;;
    "nginx")
        log_action "Restarting Nginx container"
        cd ../.. && docker compose stop nginx && docker compose up -d nginx
        RESULT=$?
        ;;
    "node-exporter")
        log_action "Restarting Node Exporter container"
        cd ../.. && docker compose stop node-exporter && docker compose up -d node-exporter
        RESULT=$?
        ;;
    "prometheus")
        log_action "Restarting Prometheus container"
        cd ../.. && docker compose stop prometheus && docker compose up -d prometheus
        RESULT=$?
        ;;
    "promtail")
        log_action "Restarting Promtail container"
        cd ../.. && docker compose stop promtail && docker compose up -d promtail
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
