---
title: Services and Care List (Professional Contacts) - FHIR STU3
keywords: structured rest documentreference
tags: [fhir,pointers,record_retrieval]
sidebar: accessrecord_rest_sidebar
permalink: retrieval_services_and_care_fhir_stu3.html
summary: Services and Care List, FHIR STU3 format information retrieval.
---

{% include warning.html content="This retrieval format is currently in DRAFT and is included for informational purposes only. No development or technical decision making should be done against this page's content without first consulting the NRL team." %}

The `Services and Care List FHIR STU3 v1` record format contains a list of episodes of care, in which organisations had or has a responsibility for care of a patient. The episodes of care will contain information about the organisation responsible for the care but may also contain information about a care team or individual responsible for that patients care.

All pointers which allow for retrieval in the `Services and Care List FHIR STU3 v1` record format **MUST** return information conforming to the guidance and requirements specified on this page.


## Pointer Retrieval `Format` Code

The NRL pointer [`format`](pointer_fhir_resource.html#retrieval-format) code for this structure is as follows:

|System|Code|Display|
|------|----|-------|
| https://fhir.nhs.uk/STU3/CodeSystem/NRL-FormatCode-1 | urn:nhs-ic:fhir:stu3:services-and-care-list:1 | Services and Care List FHIR STU3 v1 |


## Retrieval Interaction

The `Services and Care List FHIR STU3 v1` retrieval format **MUST** support the [SSP Read](retrieval_ssp.html) retrieval interaction.

The endpoint URL included in the NRL pointer **MUST** require no additional/custom headers or parameters beyond those required by the SSP.


## Retrieval Response

When successfully responding to a request the provider **MUST** return:
- an HTTP `200` **OK** status code.
- a payload conforming to the requirements on this page.


## Retrieved Data Structure

The response payload will consist of a `collection` [FHIR Bundle](http://hl7.org/fhir/STU3/StructureDefinition/Bundle). The `Bundle` will include a [FHIR List](http://hl7.org/fhir/STU3/list.html) resource as the first entry, which is used to manage the collection of resources.

The diagram below shows the referencing between FHIR resources within the response `Bundle` resource:

<img alt="Services and Care List FHIR Bundle diagram." src="images/information_retrieval/formats/services_and_care_list_fhir_stu3.png" >


The `Bundle` **MUST** contain the following resources:

|Resource|Cardinality|Description|
|--------|-----------|-----------|
| [`List`](http://hl7.org/fhir/STU3/list.html) | 1..1 | Container for list of episodes of care for the patient. |
| [`CareConnect-EpisodeOfCare-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-EpisodeOfCare-1) | 0..* | The episodes of care related to the patient.<br /><br />The cardinality allows for zero episodes of care to be included, to allow for where pointer maintenance may not align with data management. For example, if pointers are maintained as an overnight batch process, but a episode of care data is removed during the day, this may result in a pointer pointing to an empty list.<br /><br />Providers **MUST** remove pointers containing no episode of care resources as soon as possible. |
| [`CareConnect-Patient-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Patient-1) | 1..1 | Identifies the patient which the episodes of care relate to. |
| [`CareConnect-Organization-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Organization-1) | 1..* | The `Organization` resources referenced by the `List` resource represent the organisation sharing the information and **MUST** contain contact details for use in relation to data quality issues. References between the resources will put any other included `Organization` resources in context. |

The `Bundle` **MAY** contain the following resources:

|Resource|Cardinality|Description|
|--------|-----------|-----------|
| [`CareConnect-CareTeam-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-CareTeam-1) | 0..* | May be included in relation to an episode(s) of care. |
| [`CareConnect-Practitioner-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Practitioner-1) | 0..* | May be included in relation to an episode(s) of care.<br /><br />**Note:** it is important to consider Information Governance when including practitioner personal data within information shared with other organisations. |
| [`CareConnect-PractitionerRole-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-PractitionerRole-1) | 0..* | May be included to add additional information in relation to practitioners included in the shared information. |


## Resource Population Requirements and Guidance

The following requirements and resource population guidance **MUST** be followed.

### [Bundle](http://hl7.org/fhir/STU3/StructureDefinition/Bundle)

The `Bundle` resource is the container for the record and **MUST** conform to the `Bundle` base FHIR profile and the additional population guidance as per the table below. The first entry within the `Bundle` **MUST** be the mandatory `List` resource.

| Resource Cardinality | 1..1 |

|Element|Cardinality|Additional Guidance|
|-------|-----------|-------------------|
| type | 1..1 | Fixed value: `collection` |


### [List](http://hl7.org/fhir/STU3/list.html)

The `List` resource **MUST** conform to the `List` base FHIR profile and the additional population guidance as per the table below:

| Resource Cardinality | 1..1 |

|Element|Cardinality|Additional Guidance|
|-------|-----------|-------------------|
| extension `(informationProvider).valueReference` | 1..1 | This **MUST** reference the `Organization` resource representing the organisation sharing the information, including their contact details for use in relation to data quality issues. |
| `status` | 1..1 | Fixed value: `current` |
| `mode` | 1..1 | Fixed value: `snapshot` |
| `subject` | 1..1 | A reference to the `Patient` resource representing the subject of this record. |
| `code` | 1..1 | The purpose of the list. The value SHALL match the record type code on the associated pointer (`DocumentReference.type`). |


### [CareConnect-EpisodeOfCare-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-EpisodeOfCare-1)

The `EpisodeOfCare` resources included as part of the returned information **MUST** conform to the `CareConnect-EpisodeOfCare-1` constrained FHIR profile and the additional population guidance as per the table below:

| Resource Cardinality | 0..* |

| Element | Cardinality | Additional Guidance |
| --- | --- | --- |
| identifier | 1..1 | A publisher defined unique identifier for the episode of care which will be maintained across different sharing capabilities to allow consumers to identify the information from different messages. |
| status | 1..1 | The `status` element MUST represent the current status of the organisation's responsibility for the patient. |
| type | 1..* | The `type` element MUST represent the type of care/service the organisation is providing during this episode of care.<br/><br/>The resource MUST contain a `type` from value set [CareConnect-CareSettingType-1](https://fhir.hl7.org.uk/STU3/ValueSet/CareConnect-CareSettingType-1)<br/><br/>For example "Health visiting service (1078501000000104)"  |
| managingOrganization | 1..1  | This MUST reference the organisation which is responsible for this episode of care, which contains contact details for that organisation in relation to this episode of care. |
| period.start | 0..1 | Date on which the organisation took responsibility for the patients care. |
| period.end | 0..1 | Date on which the organisation stopped being responsible for the patients care. |
| team | 0..* | The EpisodeOfCare may reference specific care teams for this episode of care. |


### [CareConnect-Patient-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Patient-1)

`Patient` resources included in the `Bundle` **MUST** conform to the `CareConnect-Patient-1` constrained FHIR profile and the additional population guidance as per the table below:

| Resource Cardinality | 1..1 |

|Element|Cardinality|Additional Guidance|
|-------|-----------|-------------------|
| `identifier` | 1..1 | Patient NHS Number identifier SHALL be included within the nhsNumber identifier slice. The NHS Number **MUST** match the NHS Number on the associated pointer (`DocumentReference.subject`). |
| `name (official)` | 1..1 | Patient's name as registered on PDS, included within the resource as the official name element slice. |
| `birthDate` | 1..1 | The patient's date of birth. |


### [CareConnect-Organization-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Organization-1)

`Organization` resources included in the `Bundle` **MUST** conform to the `CareConnect-Organization-1` constrained FHIR profile and the additional population guidance as per the table below:

| Resource Cardinality | 1..* |

|Element|Cardinality|Additional Guidance|
|-------|-----------|-------------------|
| `identifier` | 1..* | The organisation ODS code identifier **MUST** be included within the `odsOrganizationCode` identifier slice. |
| `name` | 1..1 | A human readable name for the organisation **MUST** be included. |
| `telecom` | 0..* | Where the `Organization` resource is referenced directly from the `List` (via `extension (informationProvider)`), contact details for the organisation **MUST** be included for use in relation to data quality issues. |
| `telecom.system` | 1..1 | **MUST** contain a value of phone or email matching the included contact method within the value element. |
| `telecom.value` | 1..1 | A phone number or email address. |


### [CareConnect-CareTeam-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-CareTeam-1)

The CareConnect-CareTeam-1 resource may be included as part of the bundle to give more detail on a specific team who are responsible for the patient's care.

Any CareTeam resource SHALL conform to the [CareConnect-CareTeam-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-CareTeam-1) constrained FHIR profile and the additional population guidance as per the table below:

| Resource Cardinality | 0..* |

| Element | Cardinality | Additional Guidance |
| --- | --- | --- |
| subject | 0..1 | This should reference the Patient resource representing the subject of the episode of care. |
| name | 0..1 | The care team name should be included to assist subscribers of the information to contact the organisation if required. |
| participant | 0..* | The members of the care team may be referenced and should include their role within the care team.<br /><br />**Note:** it is important to consider Information Governance when including personal data of members of the care team within information shared with other organisations. |


### [CareConnect-Practitioner-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Practitioner-1)

`Practitioner` resources included in the `Bundle` **MUST** conform to the `CareConnect-Practitioner-1` constrained FHIR profile.

| Resource Cardinality | 0..* |

**Note:** Information Governance should be considered before including practitioners' personal data within shared information.

### [CareConnect-PractitionerRole-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-PractitionerRole-1)

`PractitionerRole` resources included in the `Bundle` **MUST** conform to the `CareConnect-PractitionerRole-1` constrained FHIR profile and the additional population guidance as per the table below:

| Resource Cardinality | 0..* |

|Element|Cardinality|Additional Guidance|
|-------|-----------|-------------------|
| `organization` | 1..1 | Reference to the organization where the practitioner performs this role. |
| `practitioner` | 1..1 | Reference to the practitioner who this role relates to. |
| `code` | 1..* | A value from the [`ProfessionalType-1`](https://fhir.nhs.uk/STU3/ValueSet/ProfessionalType-1) ValueSet, including the SDS Job Role name where available. |
| `specialty` | 1..1 | A value from the [`Specialty-1`](https://fhir.nhs.uk/STU3/ValueSet/Specialty-1) ValueSet. |



## Examples

[ TO DO ]
