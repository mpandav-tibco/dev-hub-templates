# FileSchema {#Xsd .concept}

Section contains description of XSD Schema FileSchema.xsd“[FileSchema.xsd](FileSchema.xsd)”

Section contains description of XSD Schema “FileSchema.xsd”

**Parent topic:**[XSD Schemas](../../../projects/com.odido-rfp-demo.application_1.0.0_ear/common/xsd.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
| |No description|

## Diagram: {#Diagram}

![Diagram
              FileSchema.xsd](FileSchema.xsd.png)

## Attributes {#Attributes}

-   *elementFormDefault :**qualified*
-   *targetNamespace :**http://www.example.com/namespaces/tns/1699990752353*

## Overview {#Overview}

### Elements {#Elements}

-   [FileContents](#element_FileContents)
-   [GetFileParameters](#element_GetFileParameters)

## Detail {#Detail}

### element FileContents {#element_FileContents}

-   element metadata*maxOccurs**1* , *minOccurs**1* , *type**xsd:string*

-   element binaryData*maxOccurs**1* , *minOccurs**1* , *type**xsd:base64Binary*

### element GetFileParameters {#element_GetFileParameters}

-   element FileName*maxOccurs**1* , *minOccurs**1* , *type**xsd:string*

