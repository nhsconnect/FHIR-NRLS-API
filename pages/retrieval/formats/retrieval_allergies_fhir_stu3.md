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

The NRL pointer [`format`](explore_reference.html#retrieval-format) code for this structure is as follows: 

|Code|Display|
|----|-------|
| urn:nhs-ic:fhir:stu3:allergy-intolerance-list:1 | Allergy List FHIR STU3 v1 |

## Retrieval Interaction

The `Allergy List FHIR STU3 v1` retrieval format **MUST** support the [SSP Read](retrieval_ssp.html) retrieval interaction.

The endpoint URL included in the NRL pointer **MUST** require no additional/custom headers or parameters beyond those required by the SSP.

## Citizen vs Health Care Professional Request

A provider may wish to return different data when the request for information is from a health care professional to when the request is from a citizen facing application.

An example of this might be:
- a provider might share some practitioner contact details with other healthcare professionals but may not wish to share those details with a citizen.
- a provider might wish to hold back information from a citizen about a sensitive result until the information has been shared with the patient by a practitioner, but that same information may be very useful to other healthcare professionals and could result in significantly improved care/life saving for the patient if they were to attend a service such as A&E before the provider has had chance to share that information with the patient.

To enable the provider to return appropriate information, all consumers wishing to retrieve data via the SSP **MUST** send the request with an appropriate JSON Web Token (JWT) identifying the intended audience. The requirements for the JWT are on the [JSON Web Token Guidance](jwt_guidance.html) page.

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
| [`CareConnect-AllergyIntolerance-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-AllergyIntolerance-1) | 0..* | Allergies listed will be included in the bundle as AllergyIntolerance resources.<br /><br />The cardinality allows for zero allergies to be included to allow for where pointer maintenance may not align with data management. For example: if pointers are maintained as an overnight batch process, but an allergy could be removed at any time in the day, this may result in a pointer pointing to an empty list.<br /><br />Providers **MUST** remove pointers which will not return any allergy information, as soon as possible. |
| [`CareConnect-Patient-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Patient-1)| 1..1 | The patient resource identifies the patient the allergies are related to. |
| [`CareConnect-Organization-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Organization-1) | 1..* | The Organization resources reference by the List resource will represent the organisation sharing the information and **MUST** contain contact details for use in relation to data quality issues. References between the resources will put any other included Organization resources in context. |

The Bundle **MAY** contain the following resources: 

|Resource|Cardinality|Description|
|--------|-----------|-----------|
| [`CareConnect-Encounter-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Encounter-1) | 0..* | Encounter resources may be included to give context to the allergy information. |
| [`CareConnect-HealthcareService-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-HealthcareService-1) | 0..* | HealthcareService resources may be included to give additional context to the organisations which are included in the returned information. |
| [`CareConnect-Location-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Location-1) | 0..* | Location resources may be included to add context to the location where allergy information was recorded. |
| [`CareConnect-Practitioner-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Practitioner-1) | 0..* | Practitioner details may be included in the bundle in relation to allergy information.<br /><br />**Note:** it is important to consider Information Governance when including practitioner personal data within information shared with other organisations. |
| [`CareConnect-PractitionerRole-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-PractitionerRole-1) | 0..* | PractionerRole resources may be included to add additional information in relation to practitioners included in the shared information. |

## Resource Population Requirements and Guidance

The following requirements and resource population guidance **MUST** be followed.

### [Bundle](http://hl7.org/fhir/STU3/StructureDefinition/Bundle)

The Bundle resource is the container for the record and **MUST** conform to the `Bundle` base FHIR profile and the additional population guidance as per the table below. The first entry within the `Bundle` **MUST** be the mandatory `List` resource.

| Resource Cardinality | 1..1 |

|Element|Cardinality|Additional Guidance|
|-------|-----------|-------------------|
| `type` | 1..1 | Fixed value: `collection` |

### [List](http://hl7.org/fhir/STU3/list.html)

The List resource **MUST** conform to the `List` base FHIR profile and the additional population guidance as per the table below:

| Resource Cardinality | 1..1 |

|Element|Cardinality|Additional Guidance|
|-------|-----------|-------------------|
| Extension `(informationProvider).valueReference` | 1..1 | This **MUST** reference the `Organization` resource representing the organisation sharing the information. This Organization resource SHALL include contact details for the organisation in relation to data quality issues with the retrieved data. |
| `status` | 1..1 | Fixed value: `current` |
| `mode` | 1..1 | Fixed value: `snapshot` |
| `subject` | 1..1 | A reference to the `Patient` resource representing the subject of this record. |
| `code` | 1..1 | The purpose of the list. The value SHALL match the record type code on the associated pointer (`DocumentReference.type`). |

### [CareConnect-AllergyIntolerance-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-AllergyIntolerance-1)

The AllergyIntolerance resources included as part of the returned information SHALL conform to the `CareConnect-AllergyIntolerance-1` constrained FHIR profile and the additional population guidance as per the table below:

| Resource Cardinality | 0..* |

|Element|Cardinality|Additional Guidance|
|-------|-----------|-------------------|
| `identifier` | 1..1 | A publisher defined unique identifier for the allergy which will be maintained across different retrieval endpoints/FHIR interfaces to allow subscribers to identify duplicates or updated information. Where the information has been sent within an event message via NEMS, the identifier should be consistent. |
| `code` | 1..1 | Where a SNOMED CT code for a Causative Agent is not available, then `code.text` should be used to contain a text representation of the Causative Agent. |
| `reaction` | 0..* | Where available this should be included. |
| `reaction.manifestation` | 1..* | When no code manifestation coded value is available, a description of the manifestation should be entered in `manifestation.code.text`. |
| `reaction.severity` | 0..1 | Where available this should be included. |
| `type` | 0..1 | Where available this should be included. |
| `onset` | 0..1 | Where available this should be included. |
| `note` | 0..* | Where coded information is not available or a more detailed description is needed, a free text representation should be included in the note field.<br /><br />Rather than split descriptive and user entered text across a number of note fields the note element is used as the single notes field to convey all qualifiers and user-entered text associated with the allergy or intolerance in a single place. Qualifiers and values expressed as text **MUST** be appropriately labelled and formatted and where user notes have been entered against explicit fields such as certainty then appropriate labels **MUST** be used. |

### [CareConnect-Patient-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Patient-1)

The patient resources included in the bundle SHALL conform to the `CareConnect-Patient-1` constrained FHIR profile and the additional population guidance as per the table below: 

| Resource Cardinality | 1..1 |

|Element|Cardinality|Additional Guidance|
|-------|-----------|-------------------|
| `identifier` | 1..1 | Patient NHS Number identifier SHALL be included within the nhsNumber identifier slice. The NHS Number SHALL match the NHS Number on the associated pointer (`DocumentReference.subject`). |
| `name` (official) | 1..1 | Patients name as registered on PDS, included within the resource as the official name element slice. |
| `birthDate` | 1..1 | The patient's date of birth. |

### [CareConnect-Organization-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Organization-1)

All Organization resources included in the bundle SHALL conform to the `CareConnect-Organization-1` constrained FHIR profile and the additional population guidance as per the table below: 

| Resource Cardinality | 1..* |

|Element|Cardinality|Additional Guidance|
|-------|-----------|-------------------|
| `identifier` | 1..* | The organisation ODS code identifier SHALL be included within the `odsOrganizationCode` identifier slice. |
| `name` | 1..1 | A human readable name for the organisation SHALL be included in the organization resource. |
| `telecom` | 0..* | Where the Organization resource is referenced from the List (`Extension (informationProvider)`), contact details for the organisation **MUST** be included for use in relation to data quality issues. |
| `telecom.system` | 1..1 | **MUST** contain a value of phone or email matching the included contact method within the value element. |
| `telecom.value` | 1..1 | A phone number or email address. |

### [CareConnect-Practitioner-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Practitioner-1)

The Practitioner resources included in the bundle SHALL conform to the `CareConnect-Practitioner-1` constrained FHIR profile.

| Resource Cardinality | 0..* |

**Note:** Information Governance should be considered before including practitioner's personal data within shared information.

### [CareConnect-PractitionerRole-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-PractitionerRole-1)

The PractitionerRole resources included in the bundle SHALL conform to the `CareConnect-PractitionerRole-1` constrained FHIR profile.

| Resource Cardinality | 0..* |

|Element|Cardinality|Additional Guidance|
|-------|-----------|-------------------|
| `organization` | 1..1 | Reference to the Organization where the practitioner performs this role. |
| `practitioner` | 1..1 | Reference to the Practitioner who this role relates to. |
| `code` | 1..* | The practitioner role SHALL include a value from the [`ProfessionalType-1`](https://fhir.nhs.uk/STU3/ValueSet/ProfessionalType-1) value set. The `PractitionerRole.code` SHOULD include the SDS Job Role name where available. |
| `specialty` | 1..1 | `PractitionerRole.specialty` SHALL use a value from [`Specialty-1`](https://fhir.nhs.uk/STU3/ValueSet/Specialty-1) value set. |

### [CareConnect-Encounter-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Encounter-1)

The Encounter resources included in the bundle SHALL conform to the `CareConnect-Encounter-1` constrained FHIR profile and the additional population guidance as per the table below: 

| Resource Cardinality | 0..* |

|Element|Cardinality|Additional Guidance|
|-------|-----------|-------------------|
| `Encounter.type` | 1..* | The encounter type SHOULD include a value from the [`EncounterType-1`](https://fhir.nhs.uk/STU3/ValueSet/EncounterType-1) value set. This value set is extensible so additional values and code systems may be added where required. |
| `location` | 0..1 | Reference to the location at which the encounter took place. |
| `subject` | 1..1 | A reference to the Patient resource representing the subject of this event. |

### [CareConnect-HealthcareService-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-HealthcareService-1)

The HealthcareService resources included in the bundle SHALL conform to the `CareConnect-HealthcareService-1` constrained FHIR profile and the additional population guidance as per the table below: 

| Resource Cardinality | 0..* |

|Element|Cardinality|Additional Guidance|
|-------|-----------|-------------------|
| `providedBy` | 1..1 | Reference to the organisation who provides the healthcare service. |
| `type` | 1..1 | This type SHALL have a value from the [`CareConnect-CareSettingType-1`](https://fhir.hl7.org.uk/STU3/ValueSet/CareConnect-CareSettingType-1) value set. |
| `specialty` | 1..1 | The specialty SHALL be a value from the [`Specialty-1`](https://fhir.nhs.uk/STU3/ValueSet/Specialty-1) value set. |

### [CareConnect-Location-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Location-1)

The Location resources included as part of the bundle SHALL conform to the `CareConnect-Location-1` constrained FHIR profile and the additional population guidance as per the table below:

| Resource Cardinality | 0..* |

|Element|Cardinality|Additional Guidance|
|-------|-----------|-------------------|
| `identifier` | 0..* | Where available, the ODS Site Code slice should be populated. |

## Examples

<div class="github-sample-wrapper scroll-height-350">
{% highlight xml %}
{% include_relative examples/Allergy_List_v1.xml %}
{% endhighlight %}
</div>
