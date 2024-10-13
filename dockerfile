FROM alpine:edge

RUN apk --no-cache add ipmitool apk-cron

COPY crontab /etc/cron.d/fan-control
COPY adaptivefancontrol.sh /opt/adaptivefancontrol.sh
RUN chmod 0777 /etc/cron.d/fan-control && \
    chmod 0777 /opt/*.sh && \
    /usr/bin/crontab /etc/cron.d/fan-control

CMD [/opt/adaptivefancontrol.sh && crond]