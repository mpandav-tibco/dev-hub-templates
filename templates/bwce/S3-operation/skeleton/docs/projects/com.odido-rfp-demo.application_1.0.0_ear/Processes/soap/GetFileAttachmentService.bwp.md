# GetFileAttachmentService {#ProcessMain .concept}

Section contains description of Process " GetFileAttachmentService.bwp " .

**Parent topic:**[Processes](../../../../projects/com.odido-rfp-demo.application_1.0.0_ear/common/process.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
| |No description|

## Process description: {#ProcessDescription}

|No description|

## Process definition: {#ProcessDefinition}

Full process path: soap.GetFileAttachmentService

## Diagram: {#Diagram}

![](GetFileAttachmentService.bwp.png)

## Process starter activity: {#Starter}

### Name: **_OnMessageStart_** {#OnMessageStart}

-   Constructor: onMessageStart
-   xpdlId: 02b8460b-a853-464b-aed5-42965ffbf0d0

## Process end activity: {#EndActivity}

### Name: **_OnMessageEnd_** {#OnMessageEnd}

-   Constructor: onMessageEnd
-   xpdlId: 158dbe03-a6c3-4abb-9712-15178ad04a7e

## Process properties: {#ProcessProperties}

|Name|Hot Update|Private Property|Shared Resource Type|Type|Property Source|
|----|----------|----------------|--------------------|----|---------------|
|bucketName|false|true| |xsd:string|[//sharedLibrary///EnvOperations/AWS-S3/bucketName](#Prod:%20odido-bwce-demo-bucket,%20default:%20odido-bwce-demo-bucket,%20Dev:%20odido-bwce-demo-bucket,%20Test:%20odido-bwce-demo-bucket,)|

## Activities: {#Activities}

### Name: **_getFile_** {#getFile}

-   Description: *No description*
-   Input Variable: *getFile-input*
-   Output Variable: *getFile*
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns1:GetFileParameters****/tns1:FileName**|$getFileAttachment/fileName|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns1:GetFileParameters
		 tns1:FileName = **$getFileAttachment/fileName
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns1="http://www.example.com/namespaces/tns/1699990752353" version="2.0">
   <xsl:param name="getFileAttachment"/>
   <xsl:template name="getFile-input" match="/">
      <tns1:GetFileParameters>
         <tns1:FileName>
            <xsl:value-of select="$getFileAttachment/fileName"/>
         </tns1:FileName>
      </tns1:GetFileParameters>
   </xsl:template>
</xsl:stylesheet>

        ```

|

-   Spawn: *false*
-   Subprocess: [sharedLibrary/Processes/aws/s3/getFile.bwp](../../../sharedLibrary/Processes/aws/s3/getFile.bwp.md)

### Name: **_getFileAttachmentOut_** {#getFileAttachmentOut}

-   Service: GetFileAttachmentPortType / operation: getFileAttachment
-   ReplyWith: Output Message
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:getFileAttachmentSoapOut****/fileMetaData**|$getFile/tns1:metadata|
        |**/tns:getFileAttachmentSoapOut****/fileContents**|$getFile/tns1:binaryData|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:getFileAttachmentSoapOut
		 fileMetaData = **$getFile/tns1:metadata**
		 fileContents = **$getFile/tns1:binaryData
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.com/interface/attachments" xmlns:tns1="http://www.example.com/namespaces/tns/1699990752353" version="2.0">
   <xsl:param name="getFile"/>
   <xsl:template name="getFileAttachmentOut-input" match="/">
      <tns:getFileAttachmentSoapOut>
         <fileMetaData>
            <xsl:value-of select="$getFile/tns1:metadata"/>
         </fileMetaData>
         <fileContents>
            <xsl:value-of select="$getFile/tns1:binaryData"/>
         </fileContents>
      </tns:getFileAttachmentSoapOut>
   </xsl:template>
</xsl:stylesheet>

        ```

|

    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:getFileAttachmentSoapOut****/fileMetaData**|$getFile/tns1:metadata|
        |**/tns:getFileAttachmentSoapOut****/fileContents**|$getFile/tns1:binaryData|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:getFileAttachmentSoapOut
		 fileMetaData = **$getFile/tns1:metadata**
		 fileContents = **$getFile/tns1:binaryData
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.com/interface/attachments" xmlns:tns1="http://www.example.com/namespaces/tns/1699990752353" version="2.0">
   <xsl:param name="getFile"/>
   <xsl:template name="getFileAttachmentOut-input" match="/">
      <tns:getFileAttachmentSoapOut>
         <fileMetaData>
            <xsl:value-of select="$getFile/tns1:metadata"/>
         </fileMetaData>
         <fileContents>
            <xsl:value-of select="$getFile/tns1:binaryData"/>
         </fileContents>
      </tns:getFileAttachmentSoapOut>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: **_LogReply_** {#LogReply}

-   Description: *No description*
-   Type: bw.generalactivities.log
-   Logger Name:
-   Log level: *Info*
-   Suppress Job Info: *true*
-   Input Variable: *LogReply-input*
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns2:ActivityInput****/message**|concat\(" \#\#\#\# SOAP API: Successfully Downloaded file : ",$getFileAttachment/fileName, " and Sent as a SOAP Attachment..."\)|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns2:ActivityInput
		 message = **concat(&quot; #### SOAP API:  Successfully Downloaded file : &quot;,$getFileAttachment/fileName, &quot;  and Sent as a SOAP Attachment...&quot;)
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns2="http://www.tibco.com/pe/WriteToLogActivitySchema" version="2.0">
   <xsl:param name="getFileAttachment"/>
   <xsl:template name="LogReply-input" match="/">
      <tns2:ActivityInput>
         <message>
            <xsl:value-of select="concat(&quot; #### SOAP API:  Successfully Downloaded file : &quot;,$getFileAttachment/fileName, &quot;  and Sent as a SOAP Attachment...&quot;)"/>
         </message>
      </tns2:ActivityInput>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: **_LogStart_** {#LogStart}

-   Description: *No description*
-   Type: bw.generalactivities.log
-   Logger Name:
-   Log level: *Info*
-   Suppress Job Info: *true*
-   Input Variable: *LogStart-input*
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns2:ActivityInput****/message**|concat\(" \#\#\#\# SOAP API: Downloading File : ",$getFileAttachment/fileName, " from S3 Bucket : ",$bucketName \)|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns2:ActivityInput
		 message = **concat(&quot; #### SOAP API: Downloading File : &quot;,$getFileAttachment/fileName, &quot; from S3 Bucket : &quot;,$bucketName )
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns2="http://www.tibco.com/pe/WriteToLogActivitySchema" xmlns:bw="http://www.tibco.com/bw/xpath/bw-custom-functions" version="2.0">
   <xsl:param name="getFileAttachment"/>
   <xsl:param name="bucketName"/>
   <xsl:template name="LogStart-input" match="/">
      <tns2:ActivityInput>
         <message>
            <xsl:value-of select="concat(&quot; #### SOAP API: Downloading File : &quot;,$getFileAttachment/fileName, &quot; from S3 Bucket : &quot;,$bucketName )"/>
         </message>
      </tns2:ActivityInput>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: **_Reply_** {#Reply}

-   Service: GetFileAttachmentPortType / operation: getFileAttachment
-   ReplyWith: Undeclared Fault
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns3:UndeclaredFault****/tns3:message**|"Internal Server Error"|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
        tns3:UndeclaredFault
            tns3:message = **&quot;Internal Server Error&quot;
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns3="http://schemas.tibco.com/bw/plugins/basic/6.0/faults" version="2.0">
    <xsl:template name="Reply-input" match="/">
        <tns3:UndeclaredFault>
            <tns3:message>
                <xsl:value-of select="&quot;Internal Server Error&quot;"/>
            </tns3:message>
        </tns3:UndeclaredFault>
    </xsl:template>
</xsl:stylesheet>
        ```

|


## References: {#References}

## Transitions: {#Transitions}

-   From: **_LogStart_** -To: **_getFile_**
    -   Label: **
    -   Type: SUCCESS

-   From: **_getFile_** -To: **_getFileAttachmentOut_**
    -   Label: **
    -   Type: SUCCESS

-   From: **_getFileAttachmentOut_** -To: **_LogReply_**
    -   Label: **
    -   Type: SUCCESS

-   From: **_OnMessageStart_** -To: **_LogStart_**
    -   Label: **
    -   Type: SUCCESS

