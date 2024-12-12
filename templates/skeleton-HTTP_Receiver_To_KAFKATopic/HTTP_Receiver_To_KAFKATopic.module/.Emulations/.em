<?xml version="1.0" encoding="ASCII"?>
<emulation:EmulationData xmlns:emulation="http:///emulation.ecore" isBW="true" location="HTTP_Receiver_To_KAFKATopic.module">
  <ProcessNode Id="http_receiver_to_kafkatopic.module.Activator" Name="http_receiver_to_kafkatopic.module.Activator" ModelType="BW" moduleName="HTTP_Receiver_To_KAFKATopic.module">
    <Operation Name="onStartup" serviceName="ModuleActivator">
      <Inputs Id="a462ae3c-7f90-4ad3-83a8-f3cfa0ecc94cHTTP_Receiver_To_KAFKATopic.module_http_receiver_to_kafkatopic.module.Activator_onStartup_Request" Name="Request" isDefault="true"/>
    </Operation>
    <Operation Name="onShutdown" serviceName="ModuleActivator">
      <Inputs Id="15e0e766-dd10-489d-a333-c68294a8f8cbHTTP_Receiver_To_KAFKATopic.module_http_receiver_to_kafkatopic.module.Activator_onShutdown_Request" Name="Request" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="http_receiver_to_kafkatopic.module.CP_KafkaSender" Name="http_receiver_to_kafkatopic.module.CP_KafkaSender" ModelType="BW" moduleName="HTTP_Receiver_To_KAFKATopic.module">
    <Operation Name="callProcess" serviceName="http_receiver_to_kafkatopic.module.CP_KafkaSender">
      <Inputs Id="6cbca764-d46b-4005-9ccf-5b6a4f4c3fadHTTP_Receiver_To_KAFKATopic.module_http_receiver_to_kafkatopic.module.CP_KafkaSender_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS">
        <informations Name="input" tnsName="tns:" nameSpace="xmlns:tns">
          <nameSpaces prefix="tns" nameSapce="http://www.example.org/adidasIntegrationMessage"/>
          <Parameter Name="tns:JSON" Value="&#xA;&#x9;">
            <parameters Name="All" Value="You may enter the following 2 items in any order" type="All"/>
            <parameters Name="tns:metadata">
              <parameters Name="All" Value="You may enter the following 6 items in any order" type="All"/>
              <parameters Name="tns:eventVersion" Value="1.0" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventSource" Value="''" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventName" Value="ObjectName_&lt;Create/Update/Delete" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true"/>
              <parameters Name="tns:eventTime" Value="''" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventID" Value="1234" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventKey" Value="1234" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true"/>
            </parameters>
            <parameters Name="tns:payload">
              <parameters Name="tns:ObjectNameElement">
                <parameters Name="tns:hostIndicator" Value="''" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:containerNumber" Value="''" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:created" Value="''" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:inboundDeliveryNumber" Value="12" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:transactionNumber" Value="432" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:internalReference" Value="''" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:warehouse" Value="''" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:inboundDeliveryLines">
                  <parameters Name="tns:articleNumber" Value="''" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parameters Name="tns:lineNumber" Value="23" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parameters Name="tns:srcSizeCd3" Value="''" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parameters Name="tns:unitsReceived" Value="''" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
              </parameters>
            </parameters>
          </Parameter>
        </informations>
      </Inputs>
      <Inputs Id="827b8101-c393-47e1-aa87-9fb9f5d4bf3aHTTP_Receiver_To_KAFKATopic.module_http_receiver_to_kafkatopic.module.CP_KafkaSender_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS">
        <informations Name="input" nameSpace="http://www.example.org/adidasIntegrationMessage">
          <nameSpaces prefix="tns" nameSapce="http://www.example.org/adidasIntegrationMessage"/>
          <Parameter Name="tns:JSON">
            <parameters Name="All" Value="You may enter the following 2 items in any order" type="All"/>
            <parameters Name="tns:metadata">
              <parameters Name="All" Value="You may enter the following 6 items in any order" type="All"/>
              <parameters Name="tns:eventVersion" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventSource" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventName" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true"/>
              <parameters Name="tns:eventTime" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventID" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventKey" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true"/>
            </parameters>
            <parameters Name="tns:payload">
              <parameters Name="tns:ObjectNameElement">
                <parameters Name="tns:hostIndicator" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:containerNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:created" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:inboundDeliveryNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:transactionNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:internalReference" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:warehouse" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:inboundDeliveryLines">
                  <parameters Name="tns:articleNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parameters Name="tns:lineNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parameters Name="tns:srcSizeCd3" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parameters Name="tns:unitsReceived" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
              </parameters>
            </parameters>
          </Parameter>
        </informations>
      </Inputs>
      <Inputs Id="8d4516bf-3265-4f2d-91d0-fe4189a7c9adHTTP_Receiver_To_KAFKATopic.module_http_receiver_to_kafkatopic.module.CP_KafkaSender_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS">
        <informations Name="input" nameSpace="http://www.example.org/adidasIntegrationMessage">
          <nameSpaces prefix="tns" nameSapce="http://www.example.org/adidasIntegrationMessage"/>
          <Parameter Name="tns:JSON">
            <parameters Name="All" Value="You may enter the following 2 items in any order" type="All"/>
            <parameters Name="tns:metadata">
              <parameters Name="All" Value="You may enter the following 6 items in any order" type="All"/>
              <parameters Name="tns:eventVersion" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventSource" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventName" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true"/>
              <parameters Name="tns:eventTime" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventID" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventKey" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true"/>
            </parameters>
            <parameters Name="tns:payload">
              <parameters Name="tns:ObjectNameElement">
                <parameters Name="tns:hostIndicator" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:containerNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:created" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:inboundDeliveryNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:transactionNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:internalReference" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:warehouse" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:inboundDeliveryLines">
                  <parameters Name="tns:articleNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parameters Name="tns:lineNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parameters Name="tns:srcSizeCd3" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parameters Name="tns:unitsReceived" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
              </parameters>
            </parameters>
          </Parameter>
        </informations>
      </Inputs>
      <Inputs Id="bcb70631-9db3-46b5-9268-cd5153ef6127HTTP_Receiver_To_KAFKATopic.module_http_receiver_to_kafkatopic.module.CP_KafkaSender_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS">
        <informations Name="input" nameSpace="http://www.example.org/adidasIntegrationMessage">
          <nameSpaces prefix="tns" nameSapce="http://www.example.org/adidasIntegrationMessage"/>
          <Parameter Name="tns:JSON">
            <parameters Name="All" Value="You may enter the following 2 items in any order" type="All"/>
            <parameters Name="tns:metadata">
              <parameters Name="All" Value="You may enter the following 6 items in any order" type="All"/>
              <parameters Name="tns:eventVersion" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventSource" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventName" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true"/>
              <parameters Name="tns:eventTime" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventID" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventKey" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true"/>
            </parameters>
            <parameters Name="tns:payload">
              <parameters Name="tns:ObjectNameElement">
                <parameters Name="tns:hostIndicator" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:containerNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:created" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:inboundDeliveryNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:transactionNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:internalReference" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:warehouse" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:inboundDeliveryLines">
                  <parameters Name="tns:articleNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parameters Name="tns:lineNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parameters Name="tns:srcSizeCd3" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parameters Name="tns:unitsReceived" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
              </parameters>
            </parameters>
          </Parameter>
        </informations>
      </Inputs>
      <Inputs Id="92cc44b9-4596-4d1f-8268-11e249cccd44HTTP_Receiver_To_KAFKATopic.module_http_receiver_to_kafkatopic.module.CP_KafkaSender_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS">
        <informations Name="input" nameSpace="http://www.example.org/adidasIntegrationMessage">
          <nameSpaces prefix="tns" nameSapce="http://www.example.org/adidasIntegrationMessage"/>
          <Parameter Name="tns:JSON">
            <parameters Name="All" Value="You may enter the following 2 items in any order" type="All"/>
            <parameters Name="tns:metadata">
              <parameters Name="All" Value="You may enter the following 6 items in any order" type="All"/>
              <parameters Name="tns:eventVersion" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventSource" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventName" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true"/>
              <parameters Name="tns:eventTime" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventID" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventKey" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true"/>
            </parameters>
            <parameters Name="tns:payload">
              <parameters Name="tns:ObjectNameElement">
                <parameters Name="tns:hostIndicator" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:containerNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:created" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:inboundDeliveryNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:transactionNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:internalReference" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:warehouse" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:inboundDeliveryLines">
                  <parameters Name="tns:articleNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parameters Name="tns:lineNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parameters Name="tns:srcSizeCd3" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parameters Name="tns:unitsReceived" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
              </parameters>
            </parameters>
          </Parameter>
        </informations>
      </Inputs>
      <Inputs Id="fe3ab0a6-e6a2-41e1-b89f-929a5c204d14HTTP_Receiver_To_KAFKATopic.module_http_receiver_to_kafkatopic.module.CP_KafkaSender_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS">
        <informations Name="input" nameSpace="http://www.example.org/adidasIntegrationMessage">
          <nameSpaces prefix="tns" nameSapce="http://www.example.org/adidasIntegrationMessage"/>
          <Parameter Name="tns:JSON">
            <parameters Name="All" Value="You may enter the following 2 items in any order" type="All"/>
            <parameters Name="tns:metadata">
              <parameters Name="All" Value="You may enter the following 6 items in any order" type="All"/>
              <parameters Name="tns:eventVersion" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventSource" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventName" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true"/>
              <parameters Name="tns:eventTime" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventID" type="string" nameSpace="http://www.w3.org/2001/XMLSchema"/>
              <parameters Name="tns:eventKey" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true"/>
            </parameters>
            <parameters Name="tns:payload">
              <parameters Name="tns:ObjectNameElement">
                <parameters Name="tns:hostIndicator" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:containerNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:created" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:inboundDeliveryNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:transactionNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:internalReference" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:warehouse" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
                <parameters Name="tns:inboundDeliveryLines">
                  <parameters Name="tns:articleNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parameters Name="tns:lineNumber" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parameters Name="tns:srcSizeCd3" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parameters Name="tns:unitsReceived" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true">
                    <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                  </parameters>
                  <parent Name="ObjectNameElementType" nameSpace="http://www.example.org/adidasIntegrationMessage"/>
                </parameters>
              </parameters>
            </parameters>
          </Parameter>
        </informations>
      </Inputs>
    </Operation>
  </ProcessNode>
</emulation:EmulationData>
