FROM ubuntu

ARG SPLUNK_URL
ARG SPLUNK_PORT

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y curl --no-install-recommends \
 && rm -rf /var/lib/apt/lists/*

# New versions and build numbers can be found at http://www.splunk.com/download/universal-forwarder.html
ENV SPLUNK_FORWARDER_VERSION 6.4.2
ENV SPLUNK_FORWARDER_BUILD 00f5bb3fa822
ENV SPLUNK_FORWARDER_URL https://download.splunk.com/products/splunk/releases/${SPLUNK_FORWARDER_VERSION}/universalforwarder/linux/splunkforwarder-${SPLUNK_FORWARDER_VERSION}-${SPLUNK_FORWARDER_BUILD}-Linux-x86_64.tgz

RUN curl --insecure --show-error ${SPLUNK_FORWARDER_URL} -o splunkforwarder.tgz \
 && tar xvzf splunkforwarder.tgz -C /opt

COPY splunkclouduf.spl /opt/splunkforwarder/splunkclouduf.spl

RUN /opt/splunkforwarder/bin/splunk start --accept-license \
 && /opt/splunkforwarder/bin/splunk install app /opt/splunkforwarder/splunkclouduf.spl -auth admin:changeme \
 && /opt/splunkforwarder/bin/splunk set deploy-poll ${SPLUNK_URL}:${SPLUNK_PORT} \
 && /opt/splunkforwarder/bin/splunk add udp 50333 -sourcetype syslog

EXPOSE 50333

CMD /opt/splunkforwarder/bin/splunk start --nodaemon --accept-license
