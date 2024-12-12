<?xml version="1.0" encoding="ASCII"?>
<emulation:EmulationData xmlns:emulation="http:///emulation.ecore" isBW="true" location="DB_To_KafkaTopic.module">
  <ProcessNode Id="db_to_kafkatopic.module.Activator" Name="db_to_kafkatopic.module.Activator" ModelType="BW" moduleName="DB_To_KafkaTopic.module">
    <Operation Name="onStartup" serviceName="ModuleActivator">
      <Inputs Id="3bbd30f7-b00f-4539-94b8-7918c75a9dadDB_To_KafkaTopic.module_db_to_kafkatopic.module.Activator_onStartup_Request" Name="Request" isDefault="true"/>
    </Operation>
    <Operation Name="onShutdown" serviceName="ModuleActivator">
      <Inputs Id="0e9f5264-237d-4f70-b423-d54ee470d532DB_To_KafkaTopic.module_db_to_kafkatopic.module.Activator_onShutdown_Request" Name="Request" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="db_to_kafkatopic.module.InterfaceLogicSubProcess" Name="db_to_kafkatopic.module.InterfaceLogicSubProcess" ModelType="BW" moduleName="DB_To_KafkaTopic.module">
    <Operation Name="callProcess" serviceName="db_to_kafkatopic.module.InterfaceLogicSubProcess">
      <Inputs Id="1bfdb7be-4a8a-4506-96c8-77fa2ceb8166DB_To_KafkaTopic.module_db_to_kafkatopic.module.InterfaceLogicSubProcess_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS">
        <informations Name="input" tnsName="tns:" nameSpace="xmlns:tns">
          <nameSpaces prefix="tns" nameSapce="http://www.example.org/OrderSchema"/>
          <Parameter Name="tns:OrderDetails" Value="&#xA;  ">
            <parameters Name="tns:ORDER_ID" Value="1" type="int" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true"/>
            <parameters Name="tns:ORDER_DESCRIPTION" Value="&quot;&quot;" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true"/>
            <parameters Name="tns:ORDER_PRICE" Value="1.0" type="double" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true"/>
            <parameters Name="tns:ADB_SEQUENCE" Value="&quot;&quot;" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true"/>
            <parameters Name="tns:ADB_TIMESTAMP" Value="&quot;&quot;" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true"/>
            <parameters Name="tns:ADB_REF_OBJECT" Value="&quot;&quot;" type="string" nameSpace="http://www.w3.org/2001/XMLSchema" canDelete="true"/>
          </Parameter>
        </informations>
      </Inputs>
    </Operation>
  </ProcessNode>
</emulation:EmulationData>
