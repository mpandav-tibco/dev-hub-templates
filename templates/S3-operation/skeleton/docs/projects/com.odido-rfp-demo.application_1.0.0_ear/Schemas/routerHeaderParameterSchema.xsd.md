# routerHeaderParameterSchema {#Xsd .concept}

Section contains description of XSD Schema routerHeaderParameterSchema.xsd“[routerHeaderParameterSchema.xsd](routerHeaderParameterSchema.xsd)”

Section contains description of XSD Schema “routerHeaderParameterSchema.xsd”

**Parent topic:**[XSD Schemas](../../../projects/com.odido-rfp-demo.application_1.0.0_ear/common/xsd.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
| |No description|

## Diagram: {#Diagram}

![Diagram
              routerHeaderParameterSchema.xsd](routerHeaderParameterSchema.xsd.png)

## Attributes {#Attributes}

-   *elementFormDefault :**unqualified*
-   *targetNamespace :**http://xmlns.example.com/router/headerParameters*

## Imports {#Imports}

### Namespace: http://tns.tibco.com/bw/REST {#unknownNamespace3}

Imported from file: 

## Overview {#Overview}

### Elements {#Elements}

-   [routerPostHeader](#element_routerPostHeader)
-   [router1GetHeader](#element_router1GetHeader)

### Complex Types {#ComplexTypes}

-   [routerPostHeaderType](#type_routerPostHeaderType)
-   [router1GetHeaderType](#type_router1GetHeaderType)

## Detail {#Detail}

### complexType routerPostHeaderType {#type_routerPostHeaderType}

-   extension*base**Q1:httpTransportHeaders*
-   sequence:
    -   element backend*maxOccurs**1* , *minOccurs**0* , *type**xs:string*

### element routerPostHeader {#element_routerPostHeader}

-   *type :**tns:routerPostHeaderType*

### complexType router1GetHeaderType {#type_router1GetHeaderType}

-   extension*base**Q1:httpTransportHeaders*
-   sequence:
    -   element backend*maxOccurs**1* , *minOccurs**0* , *type**xs:string*

### element router1GetHeader {#element_router1GetHeader}

-   *type :**tns:router1GetHeaderType*

