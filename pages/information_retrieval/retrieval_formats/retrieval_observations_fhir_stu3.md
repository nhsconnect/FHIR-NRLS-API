---
title: Observation List FHIR STU3 v1
keywords: structured rest documentreference
tags: [fhir,pointers,record_retrieval]
sidebar: overview_sidebar
permalink: retrieval_observations_fhir_stu3.html
summary: Observation List, FHIR STU3 format information retrieval.
---

{% include warning.html content="This retrieval format is currently in DRAFT and is included for informational purposes only. No development or technical decision making should be done against this page's content without first consulting the NRL team." %}

The `Observation List FHIR STU3 v1` retrieval format represents a list of observations made in relation to a patient, with required supporting information.

All pointers which allow for retrieval in the `Observation List FHIR STU3 v1` record format **MUST** return information conforming to the guidance and requirements specified on this page.

## Shared Information

The scope of observations is potentially very broad, and some use cases may benefit from the observation being linked to additional supporting information. The following page includes guidance around how information should be represented and how resources should be linked to give each resource context.

Some use cases may require additional contextual information to be included and linked to the observation, but the aim of the requirements and guidance on this page is to try and ensure there is always a standard set of useful information that has context, but also allows additional information to be included when needed.

The diagram below shows the basic information model for representing an observation. The observation is the focus but needs to be linked to the patient that the observation relates to. In addition, there may be use cases that need some supporting information to be included to add context.

<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="721px" height="226px" viewBox="-0.5 -0.5 721 226" style="background-color: rgb(255, 255, 255);"><defs/><g><rect x="0" y="0" width="720" height="225" fill="none" stroke="none" pointer-events="all"/><path d="M 255 56.25 L 284.55 56.25 L 279.8 56.33" fill="none" stroke="#000000" stroke-miterlimit="10" pointer-events="stroke"/><path d="M 283.74 56.34 L 278.48 58.95 L 279.8 56.33 L 278.5 53.7 Z" fill="#000000" stroke="#000000" stroke-miterlimit="10" pointer-events="all"/><path d="M 135 97.5 L 135 122.72" fill="none" stroke="#000000" stroke-miterlimit="10" pointer-events="stroke"/><path d="M 135 126.66 L 132.38 121.41 L 135 122.72 L 137.63 121.41 Z" fill="#000000" stroke="#000000" stroke-miterlimit="10" pointer-events="all"/><rect x="15" y="15" width="240" height="82.5" fill="#dae8fc" stroke="#6c8ebf" pointer-events="all"/><g transform="translate(-0.5 -0.5)scale(0.75)"><switch><foreignObject style="overflow: visible; text-align: left;" pointer-events="none" width="134%" height="134%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe flex-start; width: 287px; height: 1px; padding-top: 75px; margin-left: 32px;"><div style="box-sizing: border-box; font-size: 0; text-align: left; "><div style="display: inline-block; font-size: 18px; font-family: Helvetica; color: #000000; line-height: 1.2; pointer-events: all; white-space: normal; word-wrap: normal; "><div style="text-align: center ; font-size: 20px"><b>Observation </b><span>(Mandatory)</span></div><ul style="font-size: 18px"><li><span>The type of observation</span><br /></li><li style="font-size: 18px"><span style="font-size: 18px">The result of the observation</span></li></ul></div></div></div></foreignObject><text x="32" y="80" fill="#000000" font-family="Helvetica" font-size="18px">Observation (Mandatory)...</text></switch></g><rect x="15" y="127.5" width="240" height="82.5" fill="#d5e8d4" stroke="#82b366" pointer-events="all"/><g transform="translate(-0.5 -0.5)scale(0.75)"><switch><foreignObject style="overflow: visible; text-align: left;" pointer-events="none" width="134%" height="134%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe flex-start; width: 298px; height: 1px; padding-top: 225px; margin-left: 32px;"><div style="box-sizing: border-box; font-size: 0; text-align: left; "><div style="display: inline-block; font-size: 18px; font-family: Helvetica; color: #000000; line-height: 1.2; pointer-events: all; white-space: normal; word-wrap: normal; "><font style="font-size: 20px"><b>Patient </b>(Mandatory)</font><br style="font-size: 18px" /><br style="font-size: 18px" /><div style="font-size: 18px"><span style="font-size: 18px">Information about the patient this observation relates to.</span></div></div></div></div></foreignObject><text x="32" y="230" fill="#000000" font-family="Helvetica" font-size="18px">Patient (Mandatory)...</text></switch></g><rect x="285" y="15" width="420" height="195" fill="#fff2cc" stroke="#d6b656" pointer-events="all"/><g transform="translate(-0.5 -0.5)scale(0.75)"><switch><foreignObject style="overflow: visible; text-align: left;" pointer-events="none" width="134%" height="134%" requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns="http://www.w3.org/1999/xhtml" style="display: flex; align-items: unsafe center; justify-content: unsafe flex-start; width: 538px; height: 1px; padding-top: 150px; margin-left: 392px;"><div style="box-sizing: border-box; font-size: 0; text-align: left; "><div style="display: inline-block; font-size: 18px; font-family: Helvetica; color: #000000; line-height: 1.2; pointer-events: all; white-space: normal; word-wrap: normal; "><font style="font-size: 20px"><b>Supporting Information </b>(Optional)</font><br style="font-size: 18px" /><span><br />Other resources could be included to give additional context to the observation. </span><span>This might include:</span><span><br /></span><div style="font-size: 18px"><ul style="font-size: 18px"><li style="font-size: 18px">An "encounter" or "episode of care" in which this observation was made.</li><li style="font-size: 18px">The source of the observation, such as the patient, a practitioner or a related person.</li><li style="font-size: 18px">Device which was used to take measurement for observation.</li><li style="font-size: 18px">A related specimen which affected the observation.</li></ul></div></div></div></div></foreignObject><text x="392" y="155" fill="#000000" font-family="Helvetica" font-size="18px">Supporting Information (Optional)...</text></switch></g></g><switch><g requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"/><a transform="translate(0,-5)" xlink:href="https://desk.draw.io/support/solutions/articles/16000042487" target="_blank"><text text-anchor="middle" font-size="10px" x="50%" y="100%">Viewer does not support full SVG 1.1</text></a></switch></svg>

Providers SHOULD include sufficient information in the observation for a clinician to understand its context without requiring the consuming system to process and display supporting information. For example, a blood test result observation could include:

- observation type.
- observation result.
- an interpretation of the result.

And supporting information may include:

- the device used to obtain the result.
- the specimen that the test was performed on
- the episode of care in which the observation was made.

## Pointer Retrieval `Format` Code

The NRL pointer `format` code for this structure is as follows:

|System|Code|Display|
|------|----|-------|
| https://fhir.nhs.uk/STU3/CodeSystem/NRL-FormatCode-1 | urn:nhs-ic:fhir:stu3:observation-list:1 | Observation List FHIR STU3 v1 |

## Retrieval Interaction

The `Observation List FHIR STU3 v1` retrieval format **MUST** support the [SSP Read](retrieval_ssp.html) retrieval interaction.

The endpoint URL included in the NRL pointer **MUST** require no additional/custom headers or parameters beyond those required by the SSP.

## Retrieval Response

When successfully responding to a request the provider **MUST** return:
- an HTTP `200` **OK** status code.
- a payload conforming to the requirements on this page.

## Retrieved Data Structure

The response payload will consist of a `collection` [FHIR Bundle](http://hl7.org/fhir/STU3/StructureDefinition/Bundle). The `Bundle` will include a [FHIR List](http://hl7.org/fhir/STU3/list.html) resource as the first entry, which is used to manage the collection of resources.

The diagram below shows the referencing between FHIR resources within the response `Bundle` resource:

<img alt="Observation information FHIR Bundle diagram." src="images/information_retrieval/formats/observation_list_fhir_stu3.png" style="width:100%;max-width: 100%;">

The `Bundle` **MUST** contain the following resources:

|Resource|Cardinality|Description|
|--------|-----------|-----------|
| [`List`](http://hl7.org/fhir/STU3/list.html) | 1..1 | Container for list of observations related to the patient. |
| [`CareConnect-Observation-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Observation-1) | 0..* | The set of observations.<br /><br />The cardinality allows for zero observations to be included to allow for where pointer maintenance may not align with data management. For example, if pointers are maintained as an overnight batch process, but an observation is removed during the day, this may result in a pointer pointing to an empty list.<br /><br />Providers **MUST** remove pointers containing no observations as soon as possible. |
| [`CareConnect-Patient-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Patient-1) | 1..1 | Identifies the patient which the observations relate to. |
| [`CareConnect-Organization-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Organization-1) | 1..* | The `Organization` resources reference by the `List` resource represent the organisation sharing the information and **MUST** contain contact details for use in relation to data quality issues. References between the resources will put any other included `Organization` resources in context. |

The `Bundle` **MAY** contain **any** resources referenced by other resources to add additional information to the observation being shared. The following table contains **some** of the resource that could be included and guidance around the use of these resources:

|Resource|Cardinality|Description|
|--------|-----------|-----------|
| [`CareConnect-Encounter-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Encounter-1) | 0..* | Where an observation is tied to a specific encounter, this would be the most appropriate resource to use. |
| [`CareConnect-EpisodeOfCare-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-EpisodeOfCare-1) | 0..* | Where an observation is made as part of an episode of care rather than a specific encounter, this might be a more appropriate resource to use. |
| [`CareConnect-HealthcareService-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-HealthcareService-1) | 0..* | May be included to give additional context to the associated organisation(s). This might be where the observation is tied to a specific service within an organisation or as a place to share the care setting in which the observation was made. |
| [`CareConnect-Practitioner-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Practitioner-1) | 0..* | May be included in relation to observations.<br /><br />**Note:** it is important to consider Information Governance when including practitioner personal data within information shared with other organisations. |
| [`CareConnect-PractitionerRole-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-PractitionerRole-1) | 0..* | May be included to add additional information about practitioners included in the shared information. |
| [`CareConnect-RelatedPerson-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-RelatedPerson-1) | 0..* | Observations may contain this resource as a reference to the person who is the source of the observation e.g. practitioner, family member or carer.<br /><br />**Note:** As with the `Practitioner` resource, Information Governance should be considered when including details of any person who is not the subject patient. |

## Resource Population Requirements and Guidance

The following requirements and resource population guidance **MUST** be followed. Only resources requiring additional guidance or requirements have been listed. Other referenced resources **MUST** align with the restrictions imposed by the references within the referencing resource.

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

### [CareConnect-Observation-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Observation-1)

`Observation` resources included in the `Bundle` **MUST** SHALL conform to the `CareConnect-Observation-1` constrained FHIR profile and the additional population guidance as per the table below which details some of the key elements:

| Resource Cardinality | 0..* |

|Element|Cardinality|Additional Guidance|
|-------|-----------|-------------------|
| `identifier` | 1..1 | A unique identifier for the observation which will be maintained across different retrieval endpoints/FHIR interfaces to allow identification of duplicates or updated information. |
| `code` | 1..1 | Identifies the observation type. |
| `subject` | 1..1 | The patient who is the subject of this list of observations. |
| `context` | 0..1 | Where additional context around the "Encounter" or "EpisodeOfCare" in which the observation was made or recorded, it SHOULD be referenced from here. |
| `effective` | 1..1 | The datetime at which the observation was made or recorded. |
| `performer` | 0..* | Where additional context around who made or is responsible for the observation is required, it SHOULD be referenced from this element.<br /><br />**Note:** Where information about any individual is included Information Governance should be considered. |
| `value` | 0..1 | Where the observation has a result it SHOULD be included in this element. |
| `interpretation` | 0..1 | Where there is an interpretation about the observation it SHOULD be included in this element. |
| `comment` | 0..1 | A comment MAY be included, but displaying this content should be considered carefully in relation to Information Governance, for example a comment in relation to a serious harm test. |
| `component` | 0..* | This element should be used where components of the observation are expressed as separate code value pairs.<br /><br />A consumer should consider how these components and the observation code and value should be displayed to user in the most clinically safe way possible. |

{% include note.html content="Providers SHOULD include sufficient information in the observation for a clinician to understand its context without requiring the consuming system to process and display supporting information. Where additional supporting information is included this SHOULD be made available to the viewer where possible, alternativively, if this cannot be done, it's recommended to flag the ommission." %}

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

An example of observation data from within a Digital Child Health specific care setting.

<div class="github-sample-wrapper scroll-height-350">
{% highlight xml %}
{% include /examples/retrieval_formats/Observation_List_v1_DCH.xml %}
{% endhighlight %}
</div>
