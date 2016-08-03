# docker-splunk-forwarder
Splunk Cloud Universal Forwarder installed on a linux image

This image requires a Splunk Universal Forwarder credentials package detailed here:
http://docs.splunk.com/Documentation/Forwarder/6.4.2/Forwarder/HowtoforwarddatatoSplunkCloud

Usage:
Docker build --build-arg SPLUNK_URL=deploymentserver.splunk.mycompany.com --build-arg SPLUNK_PORT=8089
