---
title: NRL | FHIR&reg; Resources &amp; References
keywords: development Reference
tags: [development,fhir,profiles]
sidebar: overview_sidebar
permalink: explore_reference.html
summary: "Developer Cheat Sheet shortcuts for the <br/>technical build of NRL API."
---

{% include custom/search.warnbanner.html %}

## 1. Profiles: ##

Links to the NRL FHIR profiles on the NHS FHIR Reference Server. 

|Profile| Description |
|-------|-------|
| [NRL-DocumentReference-1](https://fhir.nhs.uk/STU3/StructureDefinition/NRL-DocumentReference-1)| A DocumentReference resource is used to describe a record that is made available to a healthcare system.  |
| [Spine-OperationOutcome-1](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1)| Operation Outcome resource that supports a collection of error, warning or information messages that result from a NRL Service Spine interaction.|
| [Spine-OperationOutcome-1-0](https://fhir.nhs.uk/StructureDefinition/spine-operationoutcome-1-0)| The default Spine OperationOutcome profile resource that supports exceptions raised by the Spine common requesthandler and not the NRL Service. 


## 2. NRL Data Model to FHIR Profile Mapping ##

The table maps the 'lean alpha' [Solution Data Model](overview_data_model.html) to NRL-DocumentReference-1 profile elements. 

|Data Item|FHIR Element|Data Type|Card|Description|
|----|---------|----|-----------|-----|
|Identifier|`id`|string|0..1|Assigned by the NRL at creation time. Uniquely identifies this record within the NRL. Used by Providers to update or delete.|
|Version|`versionId`|string|0..1|Assigned by the NRL at creation or update time. Used to track the current version of a Pointer.|
|Master Identifier|`masterIdentifier`|Identifier|0..1|The masterIdentifier is the identifier of the document as assigned by the source of the document. It is version specific – i.e. a new one is required if the document is updated. It is an optional field, providers do not have to supply a value.|
||`masterIdentifier.system`|Uri|1..1|The namespace for the identifier. This element must be completed if the masterIdentifier is to be included.|
||`masterIdentifier.value`|String|1..1| The unique value of the identifier. This element must be completed if the masterIdentifier is to be included.|
|Pointer Status|`status`| Code| 1..1| The status of the pointer|
|Record type|`type`|CodeableConcept|1..1|The clinical type of the record. Used to support searching to allow Consumers to make sense of large result sets of Pointers.|
||`type.system`|Uri|1..1|Example Value: http://snomed.info/sct.|
||`type.code`|Code|1..1|Symbol in syntax defined by the system. Example Value: 736253002|
||`type.display`|String|1..1|Representation defined by the system.|
|Record Class|`class`|CodeableConcept|1..1|A high-level category of the record. The category will be one of a controlled set. It will not be possible to create a pointer with a category that does not exist within this controlled set|
||`class.system`|Uri|1..1|Identity of the terminology system|
||`class.code`|Code|1..1|Symbol in syntax defined by the system|
||`class.display`|String|1..1|Representation defined by the system|
|Patient|`subject`|Reference|1..1|The Patient that the record referenced by this Pointer relates to. Supports Pointer retrieval scenarios.| 
|Record owner|`author`|Reference|1..1|ODS code for the record owner organization.|
|Pointer owner|`custodian`|Reference|1..1|ODS code for the pointer owner organization.|
|Related documents|`relatesTo`| BackboneElement| 0..*| Relationships to other documents|
||`relatesTo.code`| Code| 1..1| The type of relationship between the documents. This element is mandatory if the *relatesTo* element is sent. Possible values are *replaces, transforms, signs, appends*.|
||`relatesTo.target`| Reference| 1..1| The Target of the relationship. This should contain the logical reference to the target DocumentReference held within the NRL using the identifier property of this [Reference Data Type](https://www.hl7.org/fhir/references.html#logical).|
|Pointer referenced|`content`| BackboneElement| 1..*| Record referenced|
|Record mime type|`attachment.contentType`|code|1..1|Describes the format of the record such that the Consumer can pick an appropriate mechanism to handle the record. Without it the Consumer would be in the dark as to how to deal with the Record|
|Record URL|`attachment.url`|uri|1..1|The location of the record on the Provider’s system and/ or a service that allows you to look up information based on the provider url e.g. web page with service contact details|
|Record creation datetime|`attachment.creation`|dateTime|0..1|The date and time (on the Provider’s system) that the record was created. Note that this is an optional field and is meant to convey the concept of a static record.|
|Record format|`content.format`|Coding|1..1|Describes the technical structure and rules of the record and it’s retrieval route|
||`content.format.system`|Uri|1..1|Identity of the terminology system|
||`content.format.code`|Code|1..1|Symbol in syntax defined by the system|
||`content.format.display`|String|1..1|Representation defined by the system|
|Record Stability|`content.extension:contentStability`|Extension|1..1|Record content extension|
||`content.extension:contentStability.url`|Uri|1..1|identifies the meaning of the extension|
||`content.extension:contentStability.`<br />`valueCodeableConcept`|CodeableConcept|1..1|Describes whether the record content at the time of the request is dynamically generated or is static|
||`content.extension:contentStability.`<br />`valueCodableConcept.system`|Uri|1..1|Identity of the terminology system|
||`content.extension:contentStability.`<br />`valueCodableConcept.code`|Code|1..1|Symbol in syntax defined by the system|
||`content.extension:contentStability.`<br />`valueCodableConcept.display`|String|1..1|Representation defined by the system|
|Record creation clinical setting|`context.practiceSetting`|CodeableConcept|1..1|Describes where the content was created, in what clinical setting|
||`context.practiceSetting.system`|Uri|1..1|Identity of the terminology system|
||`context.practiceSetting.code`|Code|1..1|Symbol in syntax defined by the system|
||`context.practiceSetting.display`|String|1..1|Representation defined by the system|
|Period of care|`context.period`|Period|0..1|Details the time at which the documented care is relevant|
||`context.period.start`|dateTime|1..1|Starting time with inclusive boundary|
||`context.period.end`|dateTime|0..1|End time with inclusive boundary, if not ongoing|



## 3. ValueSets ##

Links to the NRL FHIR value sets on the NHS FHIR Reference Server. 

|Valueset|Description|
|-------|-----------|
|[ValueSet-NRL-RecordType-1](https://fhir.nhs.uk/STU3/ValueSet/NRL-RecordType-1)| A ValueSet that identifies the NRL record type. |
|[ValueSet-NRL-FormatCode-1](https://fhir.nhs.uk/STU3/ValueSet/NRL-FormatCode-1)| A ValueSet that identifies the NRL record format. |
|[ValueSet-NRL-PracticeSetting-1](https://fhir.nhs.uk/STU3/ValueSet/NRL-PracticeSetting-1)| A ValueSet that identifies the NRL record practice setting. |
|[ValueSet-NRL-RecordClass-1](https://fhir.nhs.uk/STU3/ValueSet/NRL-RecordClass-1)| A ValueSet that identifies the NRL record class. |
|[ValueSet-NRL-ContentStability-1](https://fhir.nhs.uk/STU3/ValueSet/NRL-ContentStability-1)| A ValueSet that identifies the NRL record stability. |
|[ValueSet-Spine-ErrorOrWarningCode-1](https://fhir.nhs.uk/STU3/ValueSet/Spine-ErrorOrWarningCode-1)| A ValueSet that identifies the Spine error or warning code in response to a request.|
|[ValueSet-Spine-Response-Code-1-0](https://fhir.nhs.uk/ValueSet/spine-response-code-1-0)|  A set of codes to indicate low level error information about a Spine 2 error response to a request for patient record details. Exceptions raised by the Spine common requesthandler and not the NRL Service will be returned using the Spine default [spine-operationoutcome-1-0](https://fhir.nhs.uk/StructureDefinition/spine-operationoutcome-1-0) profile which binds to this default valueSet. |


## 4. Extensions ##

Links to the NRL FHIR Extensions on the NHS FHIR Reference Server. 

|Extension|Description|
|-------|-----------|
|[Extension-NRL-ContentStability-1](https://fhir.nhs.uk/STU3/StructureDefinition/Extension-NRL-ContentStability-1)|NRL Record Content Stability.|

## 5. CodeSystems ##

Links to the NRL FHIR CodeSystems on the NHS FHIR Reference Server. 

|CodeSystem|Description|
|-------|-----------|
|[CodeSystem-Spine-ErrorOrWarningCode-1](https://fhir.nhs.uk/STU3/CodeSystem/Spine-ErrorOrWarningCode-1)|Spine error codes and descriptions.|
|[NRL-ContentStability-1](https://fhir.nhs.uk/STU3/CodeSystem/NRL-ContentStability-1)|NRL record stability codes and descriptions.|
|[NRL-FormatCode-1](https://fhir.nhs.uk/STU3/CodeSystem/NRL-FormatCode-1)|NRL record format codes and descriptions.|

## 6. Identifiers ##

NRL supported URI's:   

| identifier | URI | Comment |
|--------------------------------------------|----------|----|
| `Logical ID` | [baseurl]/DocumentReference/[id] | Pointer identifier |
| `Patient` | https://demographics.spineservices.nhs.uk/STU3/Patient/[NHS Number] | Patient |
| `Organization` | https://directory.spineservices.nhs.uk/STU3/Organization/[ODS Code] | Record author or record owner |
| `Master Identifier` | Identifier=[system]%7C[value] | Pointer local/business indentifier |

{% include warning.html content="The URI's on subdomain `spineservices.nhs.uk` are currently not resolvable, however this will change in the future where references relate to FHIR endpoints in our national systems." %}

## 7. Examples ##


### JSON Example ###

A JSON example of a DocumentReference resource is displayed below. 

<div class="github-sample-wrapper scroll-height-350">
{% highlight json %}
{% include /examples/create_documentreference_resource.json  %}
{% endhighlight %}
</div>


### XML Example ###

An XML example of a DocumentReference resource is displayed below. 

<div class="github-sample-wrapper scroll-height-350">
{% highlight xml %}
{% include /examples/create_documentreference_resource.xml  %}
{% endhighlight %}
</div>




