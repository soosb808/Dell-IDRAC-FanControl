FROM alpine:latest

RUN apk --no-cache add ipmitool && \
    rm -rf /var/cache/apk/*

COPY adaptivefancontrol.sh /opt/adaptivefancontrol.sh

RUN chmod 0755 /opt/adaptivefancontrol.sh

CMD ["/opt/adaptivefancontrol.sh"]