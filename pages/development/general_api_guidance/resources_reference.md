---
title: FHIR Profile Reference
keywords: development reference
tags: [development,fhir]
sidebar: overview_sidebar
permalink: explore_reference.html
summary: "Developer Cheat Sheet shortcuts for the technical build of NRL API."
---

The table outlines the profiled FHIR resources which are used within the NRL service.

|Profile| Description |
|-------|-------|
| [NRL-DocumentReference-1](https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1)| The DocumentReference resource is the data model used for the pointers held on the NRL. |
| [Spine-OperationOutcome-1](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1)| The OperationOutcome resource is the data model that will be used to shared error, warning or information messages that result from a NRL Service interaction.|
| [Spine-OperationOutcome-1-0](https://fhir.nhs.uk/StructureDefinition/spine-operationoutcome-1-0)| This version of the OperationOutcome resource is the default Spine OperationOutcome profiled resource that supports exceptions raised by the Spine common requesthandler and not the NRL Service. |

{% include note.html content="Major changes to the pointer model will be reflected in the NRL DocumentReference FHIR profile, using the naming convention `NRL-DocumentReference-[major_version]`. <br><br> The FHIR profile which the pointer conforms to will be indicated in the `DocumentReference.meta.profile` metadata attribute to enable Consumers to support the different versions of the pointer model. Pointers conforming to the NRLS-DocumentReference-1 profile will not have this attribute populated." %}

## NRL Data Model to FHIR DocumentReference Resource Mapping

The table below maps the [Pointer Data Items](pointer_overview.html) on the pointer overview page to NRL-DocumentReference-1 profiled resource elements. 

|Data Item|[FHIRPath](https://hl7.org/fhirpath/)|Data Type|Cardinality|Description|
|----|---------|----|-----------|-----|
| [Pointer Identifier](identifier_guidance.html) | `id` | string | 0..1 | Assigned by the NRL at creation time. Uniquely identifies this pointer within the NRL. Used by Providers to update or delete. |
| Profile | `meta.profile` | uri | 0..1 | The URI of the FHIR profile that the resource conforms to. Indicates the version of the pointer model. |
| Version | `meta.versionId` | string | 0..1 | Assigned by the NRL at creation or update time. Used to track the current version of a Pointer. |
| Pointer last updated datetime | `meta.lastUpdated` | datetime | 0..1 | Assigned by the NRL at creation and update time. The date and time that the pointer was last updated. |
| Pointer indexed datetime | `indexed` | datetime | 0..1 | Assigned by the NRL at creation time. The date and time that the pointer was created. |
| [Master Identifier](identifier_guidance.html) | `masterIdentifier` | Identifier | 0..1 | An optional identifier of the document as assigned by the Provider. It is version specific, a new master identifier is required if the pointer is updated. |
| | `masterIdentifier.system` | Uri | 1..1 | The namespace for the identifier. This element must be completed if the masterIdentifier is to be included. |
| | `masterIdentifier.value` | String | 1..1 | The unique value of the identifier. This element must be completed if the masterIdentifier is to be included. |
| Pointer Status | `status` | Code | 1..1 | The status of the pointer |
| Patient | `subject` | Reference | 1..1 | The NHS number of the patient that the information referenced by this Pointer relates to. Supports Pointer retrieval scenarios. |
| Pointer owner | `custodian` | Reference | 1..1 | ODS code for the pointer owner organization. |
| Information owner | `author` | Reference | 1..1 | ODS code for the information owner organization. |
| Information category | `class` | CodeableConcept | 1..1 | A high-level category of the information. The category will be one of a controlled set. It will not be possible to create a pointer with a category that does not exist within this controlled set. |
| | `class.coding.system` | Uri | 1..1 | Identity of the terminology system. |
| | `class.coding.code` | Code | 1..1 | Symbol in syntax defined by the system. |
| | `class.coding.display` | String | 1..1 | Representation defined by the system. |
| Information type | `type` | CodeableConcept | 1..1 | The clinical type of the information. Used to support searching to allow Consumers to make sense of large result sets of Pointers. |
| | `type.coding.system` | Uri | 1..1 | Example Value: http://snomed.info/sct |
| | `type.coding.code` | Code | 1..1 | Symbol in syntax defined by the system. Example Value: 736253002 |
| | `type.coding.display` | String | 1..1 | Representation defined by the system. |
| Clinical setting | `context.practiceSetting` | CodeableConcept | 1..1 | Describes the clinical setting in which the information was recorded. |
|| `context.practiceSetting.coding.system` | Uri | 1..1 | Identity of the terminology system. |
|| `context.practiceSetting.coding.code` | Code | 1..1 | Symbol in syntax defined by the system. |
|| `context.practiceSetting.coding.display` | String |1..1 | Representation defined by the system. |
| Period of care | `context.period` | Period | 0..1 | Details the time at which the documented care is relevant. |
|| `context.period.start` | dateTime | 1..1 | Starting time with inclusive boundary. |
|| `context.period.end` | dateTime | 0..1 |End time with inclusive boundary, if not ongoing. |
| [Retrieval Information](retrieval_overview.html) | `content` | BackboneElement | 1..* | Information retrieval information |
| Information creation datetime | `content.attachment.creation` | dateTime | 0..1 | The date and time (on the Provider’s system) that the information was created, for static records. |
| Retrieval URL | `content.attachment.url` | uri | 1..1 | Absolute URL for the location of the information on the Provider’s system and/or a service that allows you to look up information based on the provider url, e.g. web page with service contact details. |
| Retrieval format | `content.format` | Coding | 1..1 | Describes the technical structure and rules of the information such that the Consumer can pick an appropriate mechanism to handle the retrieved information. |
| | `content.format.system` | Uri | 1..1 | Identity of the terminology system. |
| | `content.format.code` | Code | 1..1 | Symbol in syntax defined by the system. |
| | `content.format.display` | String | 1..1 | Representation defined by the system. |
| Retrieval MIME type | `content.attachment.contentType` | code | 1..1 | Describes the type of data such that the Consumer can pick an appropriate mechanism to handle the information. |
|Information Stability | `content.extension:contentStability` | Extension | 1..1 | Information content extension. |
| | `content.extension:contentStability.url` | Uri | 1..1 | identifies the meaning of the extension. |
| | `content.extension:contentStability`<br/>`.valueCodeableConcept` | CodeableConcept | 1..1 | Describes whether the information content at the time of the request is dynamically generated or is static. |
| | `content.extension:contentStability`<br/>`.valueCodeableConcept.coding.system` | Uri | 1..1 | Identity of the terminology system |
| | `content.extension:contentStability`<br/>`.valueCodeableConcept.coding.code` | Code | 1..1 | Symbol in syntax defined by the system |
| | `content.extension:contentStability`<br/>`.valueCodeableConcept.coding.display` | String | 1..1 | Representation defined by the system |
| Related Pointer | `relatesTo` | BackboneElement | 0..1 | Relationship to another pointer |
| | `relatesTo.code` | Code | 1..1 | The type of relationship between the documents. This element is mandatory if the *relatesTo* element is sent and the value MUST be *replaces*. |
| | `relatesTo.target` | Reference | 1..1 | The Target of the relationship. This should contain the logical reference to the target DocumentReference held within the NRL using the identifier property of this [Reference Data Type](https://www.hl7.org/fhir/references.html#logical). |


## ValueSets

The following value sets are used within the profiled FHIR resources above.

|Valueset|Description|
|-------|-----------|
|[NRL-RecordType-1](https://fhir.nhs.uk/STU3/ValueSet/NRL-RecordType-1)| A ValueSet that identifies the NRL information type. |
|[NRL-FormatCode-1](https://fhir.nhs.uk/STU3/ValueSet/NRL-FormatCode-1)| A ValueSet that identifies the NRL information format. |
|[NRL-PracticeSetting-1](https://fhir.nhs.uk/STU3/ValueSet/NRL-PracticeSetting-1)| A ValueSet that identifies the NRL information practice setting. |
|[NRL-RecordClass-1](https://fhir.nhs.uk/STU3/ValueSet/NRL-RecordClass-1)| A ValueSet that identifies the NRL information category. |
|[NRL-ContentStability-1](https://fhir.nhs.uk/STU3/ValueSet/NRL-ContentStability-1)| A ValueSet that identifies the NRL information stability. |
|[Spine-ErrorOrWarningCode-1](https://fhir.nhs.uk/STU3/ValueSet/Spine-ErrorOrWarningCode-1)| A ValueSet that identifies the Spine error or warning code in response to a request.|
|[Spine-Response-Code-1-0](https://fhir.nhs.uk/ValueSet/spine-response-code-1-0)|  A set of codes to indicate low level error information about a Spine 2 error response to a request for patient record details. Exceptions raised by the Spine common requesthandler and not the NRL Service will be returned using the Spine default [spine-operationoutcome-1-0](https://fhir.nhs.uk/StructureDefinition/spine-operationoutcome-1-0) profile which binds to this default ValueSet. |

{% include note.html content="Display values for SNOMED CT concepts MUST be as listed in the FHIR value sets. The display value is the preferred term and one of the synonyms for the concept, not the Fully Specified Name, as described in the [FHIR guidance for usage of SNOMED CT](https://www.hl7.org/fhir/STU3/snomedct.html)." %}


## Extensions

The following extensions are used within the profiled FHIR resources above.

|Extension|Description|
|-------|-----------|
|[Extension-NRL-ContentStability-1](https://fhir.nhs.uk/STU3/StructureDefinition/Extension-NRL-ContentStability-1)| Information Content Stability. |


## CodeSystems

The following CodeSystems are used within the profiled FHIR resoruces above.

|CodeSystem|Description|
|-------|-----------|
|[Spine-ErrorOrWarningCode-1](https://fhir.nhs.uk/STU3/CodeSystem/Spine-ErrorOrWarningCode-1) | Spine error codes and descriptions.|
|[NRL-ContentStability-1](https://fhir.nhs.uk/STU3/CodeSystem/NRL-ContentStability-1) | Information stability codes and descriptions.|
|[NRL-FormatCode-1](https://fhir.nhs.uk/STU3/CodeSystem/NRL-FormatCode-1) | NRL Information format codes and descriptions.|


## Identifiers

The following URIs are supported for use in NRL, more information on identifiers is available on the [Identifier Guidance](identifier_guidance.html) page.   

| identifier | URI | Comment |
|--------------------------------------------|----------|----|
| Logical ID | `[baseurl]/DocumentReference/[id]` | Pointer identifier |
| Patient | `https://demographics.spineservices.nhs.uk/STU3/Patient/[NHS Number]` | Patient NHS Number |
| Organisation | `https://directory.spineservices.nhs.uk/STU3/Organization/[ODS Code]` | Information author or information owner ODS code |
| Master Identifier | `Identifier=[system]%7C[value]` | Pointer local/business identifier |

{% include warning.html content="The URIs on subdomain `spineservices.nhs.uk` are currently not resolvable, however this will change in the future where references relate to FHIR endpoints in our national systems." %}


## Examples

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
