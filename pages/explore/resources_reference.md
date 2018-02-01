---
title: NRLS | Reference
keywords: development Reference
tags: [development,fhir,profiles]
sidebar: overview_sidebar
permalink: explore_reference.html
summary: "Developer Cheat Sheet shortcuts for the <br/>technical build of NRLS API."
---

{% include custom/search.warnbanner.html %}

## 1. Profiles: ##

Links to the NRLS FHIR profiles on the NHS FHIR Reference Server. 

|Profile| 
|-------|
| [NRLS-DocumentReference-1](https://fhir.nhs.uk/STU3/StructureDefinition/NRLS-DocumentReference-1)| 
| [Spine-OperationOutcome-1](https://fhir.nhs.uk/STU3/StructureDefinition/Spine-OperationOutcome-1)| 


## 2. NRLS Pointer FHIR Profile ##

The table maps the 'lean alpha' [Solution Data Model](overview_data_model.html) to NRLS-DocumentReference-1 profile elements. 

|Data Item|FHIR Element|Data Type|Card|Description|
|----|---------|----|-----------|-----|
|Identifier|`id`|string|0..1|Assigned by the NRLS at creation time. Uniquely identifies this record within an instance of the NRLS. Used by Providers to update or delete.|
|Version|`versionId`|string|0..1|Assigned by the NRLS at creation or update time. Used to track the current version of a Pointer.|
|Record type|`type`|CodeableConcept|1..1|The clinical type of the record. Used to support searching to allow Consumers to make sense of large result sets of Pointers.|
|Patient|`subject`|Reference|1..1|The Patient that the record referenced by this Pointer relates to. Supports Pointer retrieval scenarios.| 
|Record owner|`author`|Reference|1..1|ODS code for the record owner organization.|
|Pointer owner|`custodian`|Reference|1..1|ODS code for the pointer owner organization.|
|Record mime type|`attachment.contentType`|code|1..1|Describes the format of the record such that the Consumer can pick an appropriate mechanism to handle the record. Without it the Consumer would be in the dark as to how to deal with the Record|
|Record URL|`attachment.url`|uri|1..1|The location of the record on the Provider’s system|
|Record creation datetime|`attachment.creation`|dateTime|0..1|The date and time (on the Provider’s system) that the record was created. Note that this is an optional field and is meant to convey the concept of a static record.|
|Record retrieval mode|`content.recordRetrievalMode`|CodeableConcept|0..1|Whether or not this Pointer facilitates direct or indirect Record retrieval. Used to give the Consumer a clue as to what following the Pointer will return.|


## 3. Extensions ##

Links to the NRLS FHIR extensions on the NHS FHIR Reference Server. 

|Extension|
|---------|
| [Extension-NRLS-RecordRetrievalMode-1](https://fhir.nhs.uk/STU3/StructureDefinition/Extension-NRLS-RecordRetrievalMode-1)|

## 4. Valesets ##

Links to the NRLS FHIR valuesets on the NHS FHIR Reference Server. 

|Valueset|Description|
|-------|-----------|
|[ValueSet-NRLS-RecordRetrievalMode-1](https://fhir.nhs.uk/STU3/ValueSet/NRLS-RecordRetrievalMode-1)| National record locator pointer retrieval mode. |
|[ValueSet-CarePlanType-1](https://fhir.nhs.uk/STU3/ValueSet/CarePlanType-1)| Care plan type |
|[ValueSet-Spine-ErrorOrWarningCode-1](https://fhir.nhs.uk/STU3/ValueSet/Spine-ErrorOrWarningCode-1)| Spine error codes|

## 5. CodeSystems ##

Links to the NRLS FHIR CodeSystems on the NHS FHIR Reference Server. 

|CodeSystem|Description|
|-------|-----------|
|[CodeSystem-NRLS-RecordRetrievalMode-1](https://fhir.nhs.uk/STU3/CodeSystem/NRLS-RecordRetrievalMode-1)| identifies the national record locator pointer retrieval mode. |
|[CodeSystem-Spine-ErrorOrWarningCode-1](https://fhir.nhs.uk/STU3/CodeSystem/Spine-ErrorOrWarningCode-1)|Spine error codes and descriptions.|

<!--
## NRLS Identifiers ##

| identifier | URI | Comment |
|--------------------------------------------|----------|----|
| NHS Number | https://fhir.nhs.uk/Id/nhs-number | Patient - England and Wales |
| SDS User Id/ Practitioner Code | https://fhir.nhs.uk/Id/sds-user-id | Practitioner |
| SDS/ODS Organisation Code | https://fhir.nhs.uk/Id/ods-organization-code | Organization |
| SDS/ODS Site Code | https://fhir.nhs.uk/Id/ods-site-code | Location |
-->

## 6. Identifiers ##

NRLS supported URI's:   

| identifier | URI | Comment |
|--------------------------------------------|----------|----|
| `Logical ID` | [baseurl]/DocumentReference/[id] | Pointer identifier |
| `Patient` | https://demographics.spineservices.nhs.uk/STU3/Patient/[NHS Number] | Patient |
|`organization`| https://directory.spineservices.nhs.uk/STU3/Organization/[ODS Code] | Record author or record owner |


{% include warning.html content="The URI's on subdomain `spineservices.nhs.uk` are currently not resolvable, however this will change in the future where references relate to FHIR endpoints in our national systems." %}

## 7. Examples ##


### JSON Example ###

A JSON example of a DocumentReference resource is displayed below. 

<script src="https://gist.github.com/swk003/d7d42428b4d4516f1d64ccee2813ff84.js"></script>


### XML Example ###

An XML example of a DocumentReference resource is displayed below. 

<script src="https://gist.github.com/swk003/7dbd484c3e590e259a82abe684ebb4a5.js"></script>





