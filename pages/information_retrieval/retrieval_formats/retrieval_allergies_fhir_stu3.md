---
title: Allergy List - FHIR STU3
keywords: structured rest documentreference
tags: [fhir,pointers,record_retrieval]
sidebar: accessrecord_rest_sidebar
permalink: retrieval_allergies_fhir_stu3.html
summary: Allergies and Adverse Reactions List, FHIR STU3 format information retrieval.
---

The `Allergy List FHIR STU3 v1` record format represents a list of allergies and adverse reactions recorded against a patient, with relevant supporting information.

All pointers which allow for retrieval in the `Allergy List FHIR STU3 v1` record format **MUST** return information conforming to the guidance and requirements specified on this page.

## Pointer Retrieval `Format` Code

The NRL pointer [`format`](fhir_resource_mapping.html#retrieval-format) code for this structure is as follows:

|System|Code|Display|
|------|----|-------|
| https://fhir.nhs.uk/STU3/CodeSystem/NRL-FormatCode-1 | urn:nhs-ic:fhir:stu3:allergy-intolerance-list:1 | Allergy List FHIR STU3 v1 |

## Retrieval Interaction

The `Allergy List FHIR STU3 v1` retrieval format **MUST** support the [SSP Read](retrieval_ssp.html) retrieval interaction.

The endpoint URL included in the NRL pointer **MUST** require no additional/custom headers or parameters beyond those required by the SSP.

## Retrieval Response

When successfully responding to a request the provider **MUST** return:
- an HTTP `200` **OK** status code.
- a payload conforming to the requirements on this page.

## Retrieved Data Structure

The response payload will consist of a `collection` [FHIR Bundle](http://hl7.org/fhir/STU3/StructureDefinition/Bundle). The `Bundle` will include a [FHIR List](http://hl7.org/fhir/STU3/list.html) resource as the first entry, which is used to manage the collection of resources.

The diagram below shows the referencing between FHIR resources within the response `Bundle` resource:

<img alt="Allergy information FHIR Bundle diagram." src="images/retrieval/formats/allergy_list_fhir_stu3.png" style="width:100%;max-width: 100%;">

The `Bundle` **MUST** contain the following resources:

|Resource|Cardinality|Description|
|--------|-----------|-----------|
| [`List`](http://hl7.org/fhir/STU3/list.html) | 1..1 | Container for list of allergies for the patient. |
| [`CareConnect-AllergyIntolerance-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-AllergyIntolerance-1) | 0..* | The set of allergies.<br /><br />The cardinality allows for zero allergies to be included to allow for where pointer maintenance may not align with data management. For example, if pointers are maintained as an overnight batch process, but an allergy is removed during the day, this may result in a pointer pointing to an empty list.<br /><br />Providers **MUST** remove pointers containing no allergy information as soon as possible. |
| [`CareConnect-Patient-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Patient-1)| 1..1 | Identifies the patient the allergies relate to. |
| [`CareConnect-Organization-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Organization-1) | 1..* | The `Organization` resources reference by the `List` resource represent the organisation sharing the information and **MUST** contain contact details for use in relation to data quality issues. References between the resources will put any other included `Organization` resources in context. |

The Bundle **MAY** contain the following resources:

|Resource|Cardinality|Description|
|--------|-----------|-----------|
| [`CareConnect-Encounter-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Encounter-1) | 0..* | May be included to give context to the allergy information. |
| [`CareConnect-HealthcareService-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-HealthcareService-1) | 0..* | May be included to give additional context to the organisations which are included in the returned information. |
| [`CareConnect-Location-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Location-1) | 0..* | Location where allergy information was recorded. |
| [`CareConnect-Practitioner-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Practitioner-1) | 0..* | May be included in relation to allergy information.<br /><br />**Note:** it is important to consider Information Governance when including practitioner personal data within information shared with other organisations. |
| [`CareConnect-PractitionerRole-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-PractitionerRole-1) | 0..* | May be included to add additional information in relation to practitioners included in the shared information. |

## Resource Population Requirements and Guidance

The following requirements and resource population guidance **MUST** be followed.

### [Bundle](http://hl7.org/fhir/STU3/StructureDefinition/Bundle)

The `Bundle` resource is the container for the record and **MUST** conform to the `Bundle` base FHIR profile and the additional population guidance as per the table below. The first entry within the `Bundle` **MUST** be the mandatory `List` resource.

| Resource Cardinality | 1..1 |

|Element|Cardinality|Additional Guidance|
|-------|-----------|-------------------|
| `type` | 1..1 | Fixed value: `collection` |

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

### [CareConnect-AllergyIntolerance-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-AllergyIntolerance-1)

`AllergyIntolerance` resources included in the `Bundle` **MUST** conform to the `CareConnect-AllergyIntolerance-1` constrained FHIR profile and the additional population guidance as per the table below:

| Resource Cardinality | 0..* |

|Element|Cardinality|Additional Guidance|
|-------|-----------|-------------------|
| `identifier` | 1..1 | A unique identifier for the allergy information which will be maintained across different retrieval endpoints/FHIR interfaces to allow identification of duplicates or updated information. |
| `code` | 1..1 | Where a SNOMED CT code for a Causative Agent is not available, `code.text` should contain a text representation of the Causative Agent. |
| `reaction` | 0..* | Where available, this SHOULD be included. |
| `reaction.manifestation` | 1..* | When no code manifestation coded value is available, a description of the manifestation SHOULD be entered in `manifestation.code.text`. |
| `reaction.severity` | 0..1 | Where available, this SHOULD be included. |
| `type` | 0..1 | Where available, this SHOULD be included. |
| `onset` | 0..1 | Where available, this SHOULD be included. |
| `note` | 0..* | Where coded information is not available or a more detailed description is needed, a free text representation should be included in the note field.<br /><br />Rather than split descriptive and user entered text across a number of note fields, the note element is used as the single notes field to convey all qualifiers and user-entered text associated with the allergy or intolerance in a single place. Qualifiers and values expressed as text **MUST** be appropriately labelled and formatted and where user notes have been entered against explicit fields such as certainty then appropriate labels **MUST** be used. |

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

### [CareConnect-Encounter-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Encounter-1)

`Encounter` resources included in the `Bundle` **MUST** conform to the `CareConnect-Encounter-1` constrained FHIR profile and the additional population guidance as per the table below:

| Resource Cardinality | 0..* |

|Element|Cardinality|Additional Guidance|
|-------|-----------|-------------------|
| `type` | 1..* | A value from the [`EncounterType-1`](https://fhir.nhs.uk/STU3/ValueSet/EncounterType-1) ValueSet. This ValueSet is extensible so additional values and code systems may be added where required. |
| `location` | 0..1 | Reference to the location at which the encounter took place. |
| `subject` | 1..1 | A reference to the `Patient` resource representing the subject of this event. |

### [CareConnect-HealthcareService-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-HealthcareService-1)

`HealthcareService` resources included in the `Bundle` **MUST** conform to the `CareConnect-HealthcareService-1` constrained FHIR profile and the additional population guidance as per the table below:

| Resource Cardinality | 0..* |

|Element|Cardinality|Additional Guidance|
|-------|-----------|-------------------|
| `providedBy` | 1..1 | Reference to the organisation who provides the healthcare service. |
| `type` | 1..1 | A value from the [`CareConnect-CareSettingType-1`](https://fhir.hl7.org.uk/STU3/ValueSet/CareConnect-CareSettingType-1) ValueSet. |
| `specialty` | 1..1 | A value from the [`Specialty-1`](https://fhir.nhs.uk/STU3/ValueSet/Specialty-1) ValueSet. |

### [CareConnect-Location-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Location-1)

`Location` resources included as part of the `Bundle` **MUST** conform to the `CareConnect-Location-1` constrained FHIR profile and the additional population guidance as per the table below:

| Resource Cardinality | 0..* |

|Element|Cardinality|Additional Guidance|
|-------|-----------|-------------------|
| `identifier` | 0..* | Where available, the ODS Site Code slice SHOULD be populated. |

## Examples

<div class="github-sample-wrapper scroll-height-350">
{% highlight xml %}
{% include /examples/retrieval_formats/Allergy_List_v1.xml %}
{% endhighlight %}
</div>
