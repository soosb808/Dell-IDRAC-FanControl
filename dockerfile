FROM alpine:latest

RUN apk --no-cache add ipmitool apk-cron && \
    rm -rf /var/cache/apk/*

COPY crontab /etc/cron.d/fan-control
COPY adaptivefancontrol.sh /opt/adaptivefancontrol.sh

RUN chmod 0644 /etc/cron.d/fan-control && \
    chmod 0755 /opt/adaptivefancontrol.sh && \
    crontab /etc/cron.d/fan-control

CMD ["/opt/adaptivefancontrol.sh", "&&", "crond"]