<?xml version="1.0" encoding="ASCII"?>
<emulation:EmulationData xmlns:emulation="http:///emulation.ecore" isBW="true" location="KAFKATopic_To_REST_SERVICE.module">
  <ProcessNode Id="kafkatopic_to_rest_service.module.Activator" Name="kafkatopic_to_rest_service.module.Activator" ModelType="BW" moduleName="KAFKATopic_To_REST_SERVICE.module">
    <Operation Name="onStartup" serviceName="ModuleActivator">
      <Inputs Id="fa112d98-c1f4-495f-ac01-7f5fa339abe6KAFKATopic_To_REST_SERVICE.module_kafkatopic_to_rest_service.module.Activator_onStartup_Request" Name="Request" isDefault="true"/>
    </Operation>
    <Operation Name="onShutdown" serviceName="ModuleActivator">
      <Inputs Id="84c60331-d288-4471-a609-34d83afed7e5KAFKATopic_To_REST_SERVICE.module_kafkatopic_to_rest_service.module.Activator_onShutdown_Request" Name="Request" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="kafkatopic_to_rest_service.module.CP_RestAPIInvoke" Name="kafkatopic_to_rest_service.module.CP_RestAPIInvoke" ModelType="BW" moduleName="KAFKATopic_To_REST_SERVICE.module">
    <Operation Name="callProcess" serviceName="kafkatopic_to_rest_service.module.CP_RestAPIInvoke">
      <Inputs Id="e62a73cb-d38b-4c8a-971c-5dba716c79b5KAFKATopic_To_REST_SERVICE.module_kafkatopic_to_rest_service.module.CP_RestAPIInvoke_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS">
        <informations Name="input">
          <Parameter Name="ObjectNameElement" Value="&#xA;         ">
            <parameters Name="ObjectNameElement" type="string"/>
          </Parameter>
        </informations>
      </Inputs>
    </Operation>
  </ProcessNode>
</emulation:EmulationData>
