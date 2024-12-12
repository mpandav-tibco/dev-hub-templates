# Resource {#HTTPConnectorsMain .concept}

Section contains description od HTTP Connectors " Resource.httpConnResource " .

**Parent topic:**[HTTP Connectors](../../../../projects/com.odido-rfp-demo.application_1.0.0_ear/common/httpConnector.md)

## Basic Configuration {#HTTPConnectorBasic}

-   Host: [BW.HOST.NAME](#Prod:%20localhost,%20default:%20localhost,%20Dev:%20localhost,%20Test:%20localhost,)
-   Port: [BW.CLOUD.PORT](#Prod:%208080,%20default:%208080,%20Dev:%208080,%20Test:%208080,)
-   Accept Queue Size: -1
-   Acceptor Threads: 1

## Advanced Configuration {#HTTPConnectorAdvanced}

-   Head Buffer Size \(B\): 4096
-   Request Buffer Size \(B\): 8192
-   Response Buffer Size \(B\): 24576
-   Max Idle Time \(ms\): 200000
-   Low Resource Max Idle Time \(ms\): 0
-   Linger Time \(ms\): 0
-   Session timeout \(ms\): 1800
-   Max Post Size: 2097152
-   Max Save Post Size: 4096
-   Minimum QTP Threads: 10
-   Maximum QTP Threads: 75
-   Disable HTTP methods: no disabled methods.

-   Use Non-Blocking IO Sockets: true
-   Use Direct Buffers: true
-   URI Encoding:
-   Enable DNS Lookups: false
-   Compression: false
-   Compressible Mime Types text/html,text/xml,text/plain
-   Reverse Proxy Host:
-   Reverse Proxy Port: 0
-   Enable access logs: false
-   Share accross application: false

-   No SSL server configuration chosen.

