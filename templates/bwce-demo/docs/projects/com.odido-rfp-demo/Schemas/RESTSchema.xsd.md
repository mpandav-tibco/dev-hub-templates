# RESTSchema {#Xsd .concept}

Section contains description of XSD Schema RESTSchema.xsd“[RESTSchema.xsd](RESTSchema.xsd)”

Section contains description of XSD Schema “RESTSchema.xsd”

**Parent topic:**[XSD Schemas](../../../projects/com.odido-rfp-demo/common/xsd.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
| |No description|

## Diagram: {#Diagram}

![Diagram
              RESTSchema.xsd](RESTSchema.xsd.png)

## Attributes {#Attributes}

-   *targetNamespace :**http://tns.tibco.com/bw/REST*

## Overview {#Overview}

### Elements {#Elements}

-   [messageBody](#element_messageBody)
-   [httpHeaders](#element_httpHeaders)
-   [httpResponseHeaders](#element_httpResponseHeaders)
-   [httpFaultHeaders](#element_httpFaultHeaders)
-   [dynamicConfigurations](#element_dynamicConfigurations)
-   [statusLine](#element_statusLine)
-   [client4XXError](#element_client4XXError)
-   [server5XXError](#element_server5XXError)
-   [jwtClaims](#element_jwtClaims)

### Complex Types {#ComplexTypes}

-   [httpTransportHeaders](#type_httpTransportHeaders)
-   [httpTransportResponseHeaders](#type_httpTransportResponseHeaders)
-   [httpTransportFaultHeaders](#type_httpTransportFaultHeaders)
-   [dynamicHeadersTypeDetails](#type_dynamicHeadersTypeDetails)
-   [dynamicHeadersType](#type_dynamicHeadersType)
-   [dynamicConfigurationsType](#type_dynamicConfigurationsType)
-   [statusLineType](#type_statusLineType)
-   [client4XXErrorType](#type_client4XXErrorType)
-   [server5XXErrorType](#type_server5XXErrorType)
-   [jwtClaimElementType](#type_jwtClaimElementType)
-   [jwtClaimsType](#type_jwtClaimsType)

### Simple Types {#SimpleTypes}

-   [tmessageBody](#type_tmessageBody)

## Detail {#Detail}

### element messageBody {#element_messageBody}

-   *type :**tns:tmessageBody*

### simpleType tmessageBody {#type_tmessageBody}

-   restriction*base**string*

### complexType httpTransportHeaders {#type_httpTransportHeaders}

-   element Accept*form**unqualified* , *minOccurs**0* , *type**string*

-   element Accept-Charset*form**unqualified* , *minOccurs**0* , *type**string*

-   element Accept-Encoding*form**unqualified* , *minOccurs**0* , *type**string*

-   element Content-Type*form**unqualified* , *minOccurs**0* , *type**string*

-   element Content-Length*form**unqualified* , *minOccurs**0* , *type**string*

-   element Connection*form**unqualified* , *minOccurs**0* , *type**string*

-   element Cookie*form**unqualified* , *minOccurs**0* , *type**string*

-   element Pragma*form**unqualified* , *minOccurs**0* , *type**string*

-   element Authorization*form**unqualified* , *minOccurs**0* , *type**string*

-   element DynamicHeaders*maxOccurs**1* , *minOccurs**0* , *type**tns:dynamicHeadersType*

### complexType httpTransportResponseHeaders {#type_httpTransportResponseHeaders}

-   element Content-Length*form**unqualified* , *minOccurs**0* , *type**string*

-   element Connection*form**unqualified* , *minOccurs**0* , *type**string*

-   element Pragma*form**unqualified* , *minOccurs**0* , *type**string*

-   element StatusLine*form**unqualified* , *minOccurs**0* , *type**string*

-   element Location*form**unqualified* , *minOccurs**0* , *type**string*

-   element Set-Cookie*form**unqualified* , *minOccurs**0* , *type**string*

-   element Content-Type*form**unqualified* , *minOccurs**0* , *type**string*

-   element DynamicHeaders*maxOccurs**1* , *minOccurs**0* , *type**tns:dynamicHeadersType*

### complexType httpTransportFaultHeaders {#type_httpTransportFaultHeaders}

-   element Content-Length*form**unqualified* , *minOccurs**0* , *type**string*

-   element Connection*form**unqualified* , *minOccurs**0* , *type**string*

-   element Pragma*form**unqualified* , *minOccurs**0* , *type**string*

-   element StatusLine*form**unqualified* , *minOccurs**0* , *type**string*

-   element Location*form**unqualified* , *minOccurs**0* , *type**string*

-   element Set-Cookie*form**unqualified* , *minOccurs**0* , *type**string*

-   element Content-Type*form**unqualified* , *minOccurs**0* , *type**string*

-   element DynamicHeaders*maxOccurs**1* , *minOccurs**0* , *type**tns:dynamicHeadersType*

### complexType dynamicHeadersTypeDetails {#type_dynamicHeadersTypeDetails}

-   element Name*form**unqualified* , *maxOccurs**1* , *minOccurs**1* , *type**string*

-   element Value*form**unqualified* , *maxOccurs**1* , *minOccurs**1* , *type**string*

### complexType dynamicHeadersType {#type_dynamicHeadersType}

-   element Header*form**unqualified* , *maxOccurs**unbounded* , *minOccurs**0* , *type**tns:dynamicHeadersTypeDetails*

### element httpHeaders {#element_httpHeaders}

-   *type :**tns:httpTransportHeaders*

### element httpResponseHeaders {#element_httpResponseHeaders}

-   *type :**tns:httpTransportResponseHeaders*

### element httpFaultHeaders {#element_httpFaultHeaders}

-   *type :**tns:httpTransportFaultHeaders*

### element dynamicConfigurations {#element_dynamicConfigurations}

-   *type :**tns:dynamicConfigurationsType*

### complexType dynamicConfigurationsType {#type_dynamicConfigurationsType}

-   element URL*maxOccurs**1* , *minOccurs**0* , *type**string*

-   element activityTimeout*maxOccurs**1* , *minOccurs**0* , *type**integer*

### complexType statusLineType {#type_statusLineType}

-   element statusCode*form**unqualified* , *maxOccurs**1* , *minOccurs**1* , *type**integer*

### element statusLine {#element_statusLine}

-   *type :**tns:statusLineType*

### complexType client4XXErrorType {#type_client4XXErrorType}

-   element statusCode*form**unqualified* , *maxOccurs**1* , *minOccurs**1* , *type**integer*

-   element message*form**unqualified* , *maxOccurs**1* , *minOccurs**0* , *type**string*

### element client4XXError {#element_client4XXError}

-   *type :**tns:client4XXErrorType*

### complexType server5XXErrorType {#type_server5XXErrorType}

-   element statusCode*form**unqualified* , *maxOccurs**1* , *minOccurs**1* , *type**integer*

-   element message*form**unqualified* , *maxOccurs**1* , *minOccurs**0* , *type**string*

### element server5XXError {#element_server5XXError}

-   *type :**tns:server5XXErrorType*

### complexType jwtClaimElementType {#type_jwtClaimElementType}

-   element Name*form**unqualified* , *maxOccurs**1* , *minOccurs**1* , *type**string*

-   element Value*form**unqualified* , *maxOccurs**1* , *minOccurs**1* , *type**string*

### complexType jwtClaimsType {#type_jwtClaimsType}

-   element claim*maxOccurs**unbounded* , *minOccurs**0* , *type**tns:jwtClaimElementType*

-   element payload*maxOccurs**1* , *minOccurs**0* , *type**string*

### element jwtClaims {#element_jwtClaims}

-   *type :**tns:jwtClaimsType*

