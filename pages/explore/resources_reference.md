---
title: NRL | FHIR&reg; Resources &amp; References
keywords: development Reference
tags: [development,fhir,profiles]
sidebar: overview_sidebar
permalink: explore_reference.html
summary: "Developer Cheat Sheet shortcuts for the technical build of NRL API."
---

{% include custom/search.warnbanner.html %}

## 1. Profiles:

{% include important.html content="The NRL DocumentReference profile has been updated and has also been renamed from <b>NRLS-DocumentReference-1</b> to <b>NRL-DocumentReference-1</b>." %}

Links to the NRL FHIR profiles on the NHS FHIR Reference Server.

|Profile| Description |
|-------|-------|
| [NRL-DocumentReference-1](https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1)| A DocumentReference resource is used to describe a record that is made available to a healthcare system.  |
| [Spine-OperationOutcome-1](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1)| Operation Outcome resource that supports a collection of error, warning or information messages that result from a NRL Service Spine interaction.|
| [Spine-OperationOutcome-1-0](https://fhir.nhs.uk/StructureDefinition/spine-operationoutcome-1-0)| The default Spine OperationOutcome profile resource that supports exceptions raised by the Spine common requesthandler and not the NRL Service. 

{% include note.html content="Major changes to the pointer model will be reflected in the NRL DocumentReference FHIR profile, using the naming convention `NRL-DocumentReference-[major_version]`. <br/> <br/> The FHIR profile which the pointer conforms to will be indicated in the `DocumentReference.meta.profile` metadata attribute to enable Consumers to support the different versions of the pointer model. Pointers conforming to the NRLS-DocumentReference-1 profile (v1.2.3-beta specification) will not have this attribute populated." %}

## 2. NRL Data Model to FHIR Profile Mapping

The table maps the 'lean alpha' [Solution Data Model](overview_data_model.html) to NRL-DocumentReference-1 profile elements. 

|Data Item|[FHIRPath](https://hl7.org/fhirpath/)|Data Type|Card|Description|
|----|---------|----|-----------|-----|
|Identifier| <code class="highlighter-rouge">id</code> |string|0..1|Assigned by the NRL at creation time. Uniquely identifies this record within the NRL. Used by Providers to update or delete.|
|Profile| <code class="highlighter-rouge">meta<wbr>.profile</code> |uri|0..1|The URI of the FHIR profile that the resource conforms to. Indicates the version of the pointer model. |
|Version| <code class="highlighter-rouge">meta<wbr>.versionId</code> |string|0..1|Assigned by the NRL at creation or update time. Used to track the current version of a Pointer.|
|Pointer last updated datetime| <code class="highlighter-rouge">meta<wbr>.lastUpdated</code> |datetime|0..1|Assigned by the NRL at creation and update time. The date and time that the pointer was last updated.|
|Pointer indexed datetime| <code class="highlighter-rouge">indexed</code> |datetime|0..1|Assigned by the NRL at creation time. The date and time that the pointer was created.|
|Master Identifier| <code class="highlighter-rouge">masterIdentifier</code> |Identifier|0..1|An optional identifier of the document as assigned by the Provider. It is version specific — a new master identifier is required if the document is updated.|
|| <code class="highlighter-rouge">masterIdentifier<wbr>.system</code> |Uri|1..1|The namespace for the identifier. This element must be completed if the masterIdentifier is to be included.|
|| <code class="highlighter-rouge">masterIdentifier<wbr>.value</code> |String|1..1| The unique value of the identifier. This element must be completed if the masterIdentifier is to be included.|
|Pointer Status| <code class="highlighter-rouge">status</code> | Code| 1..1| The status of the pointer|
|Patient| <code class="highlighter-rouge">subject</code> |Reference|1..1|The NHS number of the patient that the record referenced by this Pointer relates to. Supports Pointer retrieval scenarios.| 
|Pointer owner| <code class="highlighter-rouge">custodian</code> |Reference|1..1|ODS code for the pointer owner organization.|
|Record owner| <code class="highlighter-rouge">author</code> |Reference|1..1|ODS code for the record owner organization.|
|Record category| <code class="highlighter-rouge">class</code> |CodeableConcept|1..1|A high-level category of the record. The category will be one of a controlled set. It will not be possible to create a pointer with a category that does not exist within this controlled set|
|| <code class="highlighter-rouge">class<wbr>.coding[0]<wbr>.system</code> |Uri|1..1|Identity of the terminology system|
|| <code class="highlighter-rouge">class<wbr>.coding[0]<wbr>.code</code> |Code|1..1|Symbol in syntax defined by the system|
|| <code class="highlighter-rouge">class<wbr>.coding[0]<wbr>.display</code> |String|1..1|Representation defined by the system|
|Record type| <code class="highlighter-rouge">type</code> |CodeableConcept|1..1|The clinical type of the record. Used to support searching to allow Consumers to make sense of large result sets of Pointers.|
|| <code class="highlighter-rouge">type<wbr>.coding[0]<wbr>.system</code> |Uri|1..1|Example Value: http://snomed.info/sct.|
|| <code class="highlighter-rouge">type<wbr>.coding[0]<wbr>.code</code> |Code|1..1|Symbol in syntax defined by the system. Example Value: 736253002|
|| <code class="highlighter-rouge">type<wbr>.coding[0]<wbr>.display</code> |String|1..1|Representation defined by the system.|
|Record creation clinical setting| <code class="highlighter-rouge">context<wbr>.practiceSetting</code> |CodeableConcept|1..1|Describes where the content was created, in what clinical setting|
|| <code class="highlighter-rouge">context<wbr>.practiceSetting<wbr>.coding[0]<wbr>.system</code> |Uri|1..1|Identity of the terminology system|
|| <code class="highlighter-rouge">context<wbr>.practiceSetting<wbr>.coding[0]<wbr>.code</code> |Code|1..1|Symbol in syntax defined by the system|
|| <code class="highlighter-rouge">context<wbr>.practiceSetting<wbr>.coding[0]<wbr>.display</code> |String|1..1|Representation defined by the system|
|Period of care| <code class="highlighter-rouge">context<wbr>.period</code> |Period|0..1|Details the time at which the documented care is relevant|
|| <code class="highlighter-rouge">context<wbr>.period<wbr>.start</code> |dateTime|1..1|Starting time with inclusive boundary|
|| <code class="highlighter-rouge">context<wbr>.period<wbr>.end</code> |dateTime|0..1|End time with inclusive boundary, if not ongoing|
|Pointer referenced| <code class="highlighter-rouge">content[0]</code> | BackboneElement| 1..*| Record referenced|
|Record creation datetime| <code class="highlighter-rouge">content[0]<wbr>.attachment<wbr>.creation</code> |dateTime|0..1|The date and time (on the Provider’s system) that the record was created, for static records.|
|Record URL| <code class="highlighter-rouge">content[0]<wbr>.attachment<wbr>.url</code> |uri|1..1|Absolute URL for the location of the record on the Provider’s system and/ or a service that allows you to look up information based on the provider url e.g. web page with service contact details.|
|Record format| <code class="highlighter-rouge">content[0]<wbr>.format</code> |Coding|1..1|Describes the technical structure and rules of the record such that the Consumer can pick an appropriate mechanism to handle the record.|
|| <code class="highlighter-rouge">content[0]<wbr>.format<wbr>.system</code> |Uri|1..1|Identity of the terminology system|
|| <code class="highlighter-rouge">content[0]<wbr>.format<wbr>.code</code> |Code|1..1|Symbol in syntax defined by the system|
|| <code class="highlighter-rouge">content[0]<wbr>.format<wbr>.display</code> |String|1..1|Representation defined by the system|
|Record MIME type| <code class="highlighter-rouge">content[0]<wbr>.attachment<wbr>.contentType</code> |code|1..1|Describes the type of data such that the Consumer can pick an appropriate mechanism to handle the record.|
|Record Stability| <code class="highlighter-rouge">content[0]<wbr>.extension:contentStability</code> |Extension|1..1|Record content extension|
|| <code class="highlighter-rouge">content[0]<wbr>.extension:contentStability<wbr>.url</code> |Uri|1..1|identifies the meaning of the extension|
|| <code class="highlighter-rouge">content[0]<wbr>.extension:contentStability.<wbr>valueCodeableConcept</code> |CodeableConcept|1..1|Describes whether the record content at the time of the request is dynamically generated or is static|
|| <code class="highlighter-rouge">content[0]<wbr>.extension:contentStability.<wbr>valueCodableConcept<wbr>.coding[0]<wbr>.system</code> |Uri|1..1|Identity of the terminology system|
|| <code class="highlighter-rouge">content[0]<wbr>.extension:contentStability.<wbr>valueCodableConcept<wbr>.coding[0]<wbr>.code</code> |Code|1..1|Symbol in syntax defined by the system|
|| <code class="highlighter-rouge">content[0]<wbr>.extension:contentStability.<wbr>valueCodableConcept<wbr>.coding[0]<wbr>.display</code> |String|1..1|Representation defined by the system|
|Related documents| <code class="highlighter-rouge">relatesTo</code> | BackboneElement| 0..1| Relationship to another pointer|
|| <code class="highlighter-rouge">relatesTo<wbr>.code</code> | Code| 1..1| The type of relationship between the documents. This element is mandatory if the *relatesTo* element is sent and the value MUST be *replaces*.|
|| <code class="highlighter-rouge">relatesTo<wbr>.target</code> | Reference| 1..1| The Target of the relationship. This should contain the logical reference to the target DocumentReference held within the NRL using the identifier property of this [Reference Data Type](https://www.hl7.org/fhir/references.html#logical).|



## 3. ValueSets

{% include important.html content="The NRL RecordType valueset has been renamed from <b>NRLS-RecordType-1</b> to <b>NRL-RecordType-1</b>." %}

Links to the NRL FHIR value sets on the NHS FHIR Reference Server. 

|Valueset|Description|
|-------|-----------|
|[NRL-RecordType-1](https://fhir.nhs.uk/STU3/ValueSet/NRL-RecordType-1)| A ValueSet that identifies the NRL record type. |
|[NRL-FormatCode-1](https://fhir.nhs.uk/STU3/ValueSet/NRL-FormatCode-1)| A ValueSet that identifies the NRL record format. |
|[NRL-PracticeSetting-1](https://fhir.nhs.uk/STU3/ValueSet/NRL-PracticeSetting-1)| A ValueSet that identifies the NRL record practice setting. |
|[NRL-RecordClass-1](https://fhir.nhs.uk/STU3/ValueSet/NRL-RecordClass-1)| A ValueSet that identifies the NRL record category. |
|[NRL-ContentStability-1](https://fhir.nhs.uk/STU3/ValueSet/NRL-ContentStability-1)| A ValueSet that identifies the NRL record stability. |
|[Spine-ErrorOrWarningCode-1](https://fhir.nhs.uk/STU3/ValueSet/Spine-ErrorOrWarningCode-1)| A ValueSet that identifies the Spine error or warning code in response to a request.|
|[Spine-Response-Code-1-0](https://fhir.nhs.uk/ValueSet/spine-response-code-1-0)|  A set of codes to indicate low level error information about a Spine 2 error response to a request for patient record details. Exceptions raised by the Spine common requesthandler and not the NRL Service will be returned using the Spine default [spine-operationoutcome-1-0](https://fhir.nhs.uk/StructureDefinition/spine-operationoutcome-1-0) profile which binds to this default valueSet. |

{% include note.html content="Display values for SNOMED CT concepts MUST be as listed in the FHIR value sets. The display value is the preferred term and one of the synonyms for the concept, not the Fully Specified Name, as described in the [FHIR guidance for usage of SNOMED CT](https://www.hl7.org/fhir/STU3/snomedct.html)." %}

## 4. Extensions

Links to the NRL FHIR Extensions on the NHS FHIR Reference Server. 

|Extension|Description|
|-------|-----------|
|[Extension-NRL-ContentStability-1](https://fhir.nhs.uk/STU3/StructureDefinition/Extension-NRL-ContentStability-1)|NRL Record Content Stability.|

## 5. CodeSystems

Links to the NRL FHIR CodeSystems on the NHS FHIR Reference Server. 

|CodeSystem|Description|
|-------|-----------|
|[Spine-ErrorOrWarningCode-1](https://fhir.nhs.uk/STU3/CodeSystem/Spine-ErrorOrWarningCode-1)|Spine error codes and descriptions.|
|[NRL-ContentStability-1](https://fhir.nhs.uk/STU3/CodeSystem/NRL-ContentStability-1)|NRL record stability codes and descriptions.|
|[NRL-FormatCode-1](https://fhir.nhs.uk/STU3/CodeSystem/NRL-FormatCode-1)|NRL record format codes and descriptions.|

## 6. Identifiers

NRL supported URI's:   

| identifier | URI | Comment |
|--------------------------------------------|----------|----|
| <code class="highlighter-rouge">Logical ID</code> | `[baseurl]/DocumentReference/[id]` | Pointer identifier |
| <code class="highlighter-rouge">Patient</code> | `https://demographics.spineservices.nhs.uk/STU3/Patient/[NHS Number]` | Patient NHS Number |
| <code class="highlighter-rouge">Organisation</code> | `https://directory.spineservices.nhs.uk/STU3/Organization/[ODS Code]` | Record author or record owner ODS code |
| <code class="highlighter-rouge">Master Identifier</code> | `Identifier=[system]%7C[value]` | Pointer local/business indentifier |

{% include warning.html content="The URI's on subdomain `spineservices.nhs.uk` are currently not resolvable, however this will change in the future where references relate to FHIR endpoints in our national systems." %}

## 7. Examples


### JSON Example

A JSON example of a DocumentReference resource is displayed below. 

<div class="github-sample-wrapper scroll-height-350">
{% highlight json %}
{% include /examples/create_documentreference_resource.json  %}
{% endhighlight %}
</div>


### XML Example

An XML example of a DocumentReference resource is displayed below. 

<div class="github-sample-wrapper scroll-height-350">
{% highlight xml %}
{% include /examples/create_documentreference_resource.xml  %}
{% endhighlight %}
</div>
