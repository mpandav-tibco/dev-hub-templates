# getFileAttachmentService {#Wsdl .concept}

Section contains description of WSDL Schema “[getFileAttachmentService.wsdl](getFileAttachmentService.wsdl)”

Section contains description of WSDL Schema “getFileAttachmentService.wsdl”

Service:

Documentation:

**Parent topic:**[WSDLs](../../../projects/com.odido-rfp-demo.application_1.0.0_ear/common/wsdl.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
| |No description|

## Diagram: {#Diagram}

Diagram [getFileAttachmentService.wsdl.svg](C_/MakeDoc/cfg/storage/default/1700828808628/dita/projects/com.odido-rfp-demo.application_1.0.0_ear/Service_Descriptors/getFileAttachmentService.wsdl.svg)

Diagram of getFileAttachmentService.wsdl.

## Namespaces: {#Namespaces}

-   xmlns: - http://schemas.xmlsoap.org/wsdl/
-   xmlns: http - http://schemas.xmlsoap.org/wsdl/http/
-   xmlns: mime - http://schemas.xmlsoap.org/wsdl/mime/
-   xmlns: ns - http://ws-i.org/profiles/basic/1.1/xsd
-   xmlns: s1 - http://www.example.com/interface/attachments
-   xmlns: s - http://www.w3.org/2001/XMLSchema
-   xmlns: soapenc - http://schemas.xmlsoap.org/soap/encoding/
-   xmlns: soap - http://schemas.xmlsoap.org/wsdl/soap/
-   xmlns: tibex - http://www.tibco.com/bs3.2/extensions
-   xmlns: xml - http://www.w3.org/XML/1998/namespace

## Types: {#Types}

## Port configuration: {#PortConfig}

*Empty*

## Operations: {#Operations}

-   **Name:**getFileAttachment
    -   **Parameters:**
        -   **Input:**[s1:getFileAttachmentSoapIn](#Messages)
        -   **Output:**[s1:getFileAttachmentSoapOut](#Messages)

## Messages: {#Messages}

-   **Name:**getFileAttachmentSoapIn
    -   **Part Element:**
    -   **Part Name:**fileName
-   **Name:**getFileAttachmentSoapOut
    -   **Part Element:**
    -   **Part Name:**fileMetaData
    -   **Part Element:**
    -   **Part Name:**fileContents

