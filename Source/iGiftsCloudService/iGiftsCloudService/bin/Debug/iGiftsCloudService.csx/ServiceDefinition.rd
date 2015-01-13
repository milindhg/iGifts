<?xml version="1.0" encoding="utf-8"?>
<serviceModel xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" name="iGiftsCloudService" generation="1" functional="0" release="0" Id="37ed4113-e1d3-438f-9a85-8034a2281017" dslVersion="1.2.0.0" xmlns="http://schemas.microsoft.com/dsltools/RDSM">
  <groups>
    <group name="iGiftsCloudServiceGroup" generation="1" functional="0" release="0">
      <componentports>
        <inPort name="prototype3:HttpIn" protocol="http">
          <inToChannel>
            <lBChannelMoniker name="/iGiftsCloudService/iGiftsCloudServiceGroup/LB:prototype3:HttpIn" />
          </inToChannel>
        </inPort>
      </componentports>
      <settings>
        <aCS name="prototype3Instances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/iGiftsCloudService/iGiftsCloudServiceGroup/Mapprototype3Instances" />
          </maps>
        </aCS>
        <aCS name="prototype3:AccountName" defaultValue="">
          <maps>
            <mapMoniker name="/iGiftsCloudService/iGiftsCloudServiceGroup/Mapprototype3:AccountName" />
          </maps>
        </aCS>
        <aCS name="prototype3:AccountSharedKey" defaultValue="">
          <maps>
            <mapMoniker name="/iGiftsCloudService/iGiftsCloudServiceGroup/Mapprototype3:AccountSharedKey" />
          </maps>
        </aCS>
        <aCS name="prototype3:BlobStorageEndpoint" defaultValue="">
          <maps>
            <mapMoniker name="/iGiftsCloudService/iGiftsCloudServiceGroup/Mapprototype3:BlobStorageEndpoint" />
          </maps>
        </aCS>
        <aCS name="prototype3:QueueStorageEndpoint" defaultValue="">
          <maps>
            <mapMoniker name="/iGiftsCloudService/iGiftsCloudServiceGroup/Mapprototype3:QueueStorageEndpoint" />
          </maps>
        </aCS>
        <aCS name="prototype3:TableStorageEndpoint" defaultValue="">
          <maps>
            <mapMoniker name="/iGiftsCloudService/iGiftsCloudServiceGroup/Mapprototype3:TableStorageEndpoint" />
          </maps>
        </aCS>
        <aCS name="prototype3:ContainerName" defaultValue="">
          <maps>
            <mapMoniker name="/iGiftsCloudService/iGiftsCloudServiceGroup/Mapprototype3:ContainerName" />
          </maps>
        </aCS>
        <aCS name="prototype3:InitialListsBlobUrl" defaultValue="">
          <maps>
            <mapMoniker name="/iGiftsCloudService/iGiftsCloudServiceGroup/Mapprototype3:InitialListsBlobUrl" />
          </maps>
        </aCS>
      </settings>
      <channels>
        <lBChannel name="LB:prototype3:HttpIn">
          <toPorts>
            <inPortMoniker name="/iGiftsCloudService/iGiftsCloudServiceGroup/prototype3/HttpIn" />
          </toPorts>
        </lBChannel>
      </channels>
      <maps>
        <map name="Mapprototype3Instances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/iGiftsCloudService/iGiftsCloudServiceGroup/prototype3Instances" />
          </setting>
        </map>
        <map name="Mapprototype3:AccountName" kind="Identity">
          <setting>
            <aCSMoniker name="/iGiftsCloudService/iGiftsCloudServiceGroup/prototype3/AccountName" />
          </setting>
        </map>
        <map name="Mapprototype3:AccountSharedKey" kind="Identity">
          <setting>
            <aCSMoniker name="/iGiftsCloudService/iGiftsCloudServiceGroup/prototype3/AccountSharedKey" />
          </setting>
        </map>
        <map name="Mapprototype3:BlobStorageEndpoint" kind="Identity">
          <setting>
            <aCSMoniker name="/iGiftsCloudService/iGiftsCloudServiceGroup/prototype3/BlobStorageEndpoint" />
          </setting>
        </map>
        <map name="Mapprototype3:QueueStorageEndpoint" kind="Identity">
          <setting>
            <aCSMoniker name="/iGiftsCloudService/iGiftsCloudServiceGroup/prototype3/QueueStorageEndpoint" />
          </setting>
        </map>
        <map name="Mapprototype3:TableStorageEndpoint" kind="Identity">
          <setting>
            <aCSMoniker name="/iGiftsCloudService/iGiftsCloudServiceGroup/prototype3/TableStorageEndpoint" />
          </setting>
        </map>
        <map name="Mapprototype3:ContainerName" kind="Identity">
          <setting>
            <aCSMoniker name="/iGiftsCloudService/iGiftsCloudServiceGroup/prototype3/ContainerName" />
          </setting>
        </map>
        <map name="Mapprototype3:InitialListsBlobUrl" kind="Identity">
          <setting>
            <aCSMoniker name="/iGiftsCloudService/iGiftsCloudServiceGroup/prototype3/InitialListsBlobUrl" />
          </setting>
        </map>
      </maps>
      <components>
        <groupHascomponents>
          <role name="prototype3" generation="1" functional="0" release="0" software="F:\Users\Milind\Documents\GitHub\iGifts\source\iGiftsCloudService\iGiftsCloudService\obj\Debug\prototype3\" entryPoint="base\x64\WaWebHost.exe" parameters="" memIndex="1792" hostingEnvironment="frontend" hostingEnvironmentVersion="2">
            <componentports>
              <inPort name="HttpIn" protocol="http" />
            </componentports>
            <settings>
              <aCS name="AccountName" defaultValue="" />
              <aCS name="AccountSharedKey" defaultValue="" />
              <aCS name="BlobStorageEndpoint" defaultValue="" />
              <aCS name="QueueStorageEndpoint" defaultValue="" />
              <aCS name="TableStorageEndpoint" defaultValue="" />
              <aCS name="ContainerName" defaultValue="" />
              <aCS name="InitialListsBlobUrl" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;prototype3&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;prototype3&quot;&gt;&lt;e name=&quot;HttpIn&quot; /&gt;&lt;/r&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/iGiftsCloudService/iGiftsCloudServiceGroup/prototype3Instances" />
          </sCSPolicy>
        </groupHascomponents>
      </components>
      <sCSPolicy>
        <sCSPolicyID name="prototype3Instances" defaultPolicy="[1,1,1]" />
      </sCSPolicy>
    </group>
  </groups>
  <implements>
    <implementation Id="5ce84eee-6468-4054-9faf-a9be95f6c31e" ref="Microsoft.RedDog.Contract\ServiceContract\iGiftsCloudServiceContract@ServiceDefinition">
      <interfacereferences>
        <interfaceReference Id="76508ef9-1576-4442-9636-fce416d7adaf" ref="Microsoft.RedDog.Contract\Interface\prototype3:HttpIn@ServiceDefinition">
          <inPort>
            <inPortMoniker name="/iGiftsCloudService/iGiftsCloudServiceGroup/prototype3:HttpIn" />
          </inPort>
        </interfaceReference>
      </interfacereferences>
    </implementation>
  </implements>
</serviceModel>