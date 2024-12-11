# static-routerHeaderParameterSchema {#Xsd .concept}

Section contains description of XSD Schema static-routerHeaderParameterSchema.xsd“[static-routerHeaderParameterSchema.xsd](static-routerHeaderParameterSchema.xsd)”

Section contains description of XSD Schema “static-routerHeaderParameterSchema.xsd”

**Parent topic:**[XSD Schemas](../../../projects/com.odido-rfp-demo/common/xsd.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
| |No description|

## Diagram: {#Diagram}

![Diagram
              static-routerHeaderParameterSchema.xsd](static-routerHeaderParameterSchema.xsd.png)

## Attributes {#Attributes}

-   *elementFormDefault :**unqualified*
-   *targetNamespace :**http://xmlns.example.com/static-router/headerParameters*

## Imports {#Imports}

### Namespace: http://tns.tibco.com/bw/REST {#unknownNamespace2}

Imported from file: [../Schemas/RESTSchema.xsd.dita](RESTSchema.xsd.md)

## Overview {#Overview}

### Elements {#Elements}

-   [static-routerGetHeader](#element_static-routerGetHeader)

### Complex Types {#ComplexTypes}

-   [static-routerGetHeaderType](#type_static-routerGetHeaderType)

## Detail {#Detail}

### complexType static-routerGetHeaderType {#type_static-routerGetHeaderType}

-   extension*base**Q1:httpTransportHeaders*
-   sequence:
    -   element backend*maxOccurs**1* , *minOccurs**1* , *type**xs:string*

### element static-routerGetHeader {#element_static-routerGetHeader}

-   *type :**tns:static-routerGetHeaderType*

