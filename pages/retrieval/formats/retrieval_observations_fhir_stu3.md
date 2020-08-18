---
title: Observation List FHIR STU3 v1
keywords: structured rest documentreference
tags: [fhir,pointers,record_retrieval]
sidebar: accessrecord_rest_sidebar
permalink: retrieval_observations_fhir_stu3.html
summary: Observation List, FHIR STU3 information format for retrieval
---


The `Observation List FHIR STU3 v1` retrieval format represents a list of observations that were made in relation to a patient, and any required supporting information.

All pointers which allow for retrieval in the `Observation List FHIR STU3 v1` record format MUST return information conforming to the guidance and requirements specified on this page.


## Shared Information 

The scope of observations is potentially very broad, and some use cases may benefit from the observation being linked to additional supporting information. The following page includes guidance around how information should be represented and how resources should be linked to give each resource context. 

Some use cases may require additional contextual information to be included and linked to the observation, but the aim of the requirements and guidance on this page is to try and ensure that there is always a standard set of useful information that has context but also allows additional information to be included when needed. 

The diagram below shows the basic information model for representing an observation. The observation is the focus but needs to be linked to the patient that the observation relates to. In addition, there may be use cases that need some supporting information to be included in order to add context to the information being shared. 

<img alt="Observation information model diagram" src="images/retrieval/formats/observation_information_model.png" style="width:100%;max-width: 100%;">

The aim of a provider MUST be to include enough information in the Observation, with values which gives the observation enough context to be useful to a clinician without requiring the consuming system to understand all the supporting information. 

For example, in an observation about a blood test result, the observation will contain the type of observation, the value/result of the observation and potentially the interpretation of that result. The observation may reference supporting information about the device used to get the result, the specimen that the test was performed on and the episode of care in which the observation was made, but without looking at the supporting information and only looking at the observation a clinician should be able to understand the observation that was made. 


## Pointer Retrieval `Format` Code 

The NRL pointer `format` code for this structure is as follows: 

| Code | Display |
| --- | --- |
| urn:nhs-ic:fhir:stu3:observation-list:1 | Observation List FHIR STU3 v1 |


## Retrieval Interaction  

For the “Observation List FHIR STU3 v1” record format, the [SSP Read](retrieval_ssp.html) retrieval interaction **MUST** be supported.

The provider defines the endpoint URL that is included in the NRL pointer, but when a consumer requests the information using the pointer no additional headers or parameters should be needed beyond those required by the SSP.


## Citizen vs Health Care Professional request 

A provider may wish to return different data when the request for information is from a health care professional to when the request is from a citizen facing application.

An example of this might be:
- a provider might share some practitioner contact details with other healthcare professionals but may not wish to share those contact details with a citizen
- a provider might wish to hold back information from a citizen about a sensitive result until the information has been shared with the patient by a practitioner, but that same information may be very useful to other healthcare professionals and could result in significantly improved care/life saving for the patient if they were to attend as service such as A&E before the provider has had chance to share that information with the patient.

To enable this control within the provider, all consumers which wishes to retrieve data via the SSP must send the request with an appropriate JSON Web Token (JWT), which identifies if the request is for a healthcare professional or for citizen access. The requirements for the JWT are on the [JSON Web Token Guidance](jwt_guidance.html) page.


## Retrieval Response 

When successfully responding to the request the provider MUST return: 

- a HTTP status code of 200
- a payload conforming to the requirements on this page


## Retrieved Data Structure 

The response payload will consist of a [FHIR Bundle](http://hl7.org/fhir/STU3/StructureDefinition/Bundle) resource of type “collection”. The `Bundle` will include a [FHIR List](http://hl7.org/fhir/STU3/list.html) resource as the first entry, which is used to manage the collection of resources.

The diagram below shows the referencing between FHIR resources within the response Bundle resource:

<img alt="Observation information FHIR Bundle diagram" src="images/retrieval/formats/observation_list_fhir_stu3.png" style="width:100%;max-width: 100%;">
 
 
The `Bundle` **MUST** contain the following resources: 

| Resource | Cardinality | Description |
| --- | --- | --- |
| [`List`](http://hl7.org/fhir/STU3/list.html) | 1..1 | Container for list of observations related to the patient. |
| [`CareConnect-Observation-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Observation-1) | 0..* | Observations listed will be included in the bundle as Observation resources.<br/><br/>The cardinality allows for zero observations to be included to allow for where pointer maintenance may not align with data management. For example: if pointers are maintained as an overnight batch process, but an observation could be removed at any time in the day, this may result in a pointer pointing to an empty list.<br/><br/>Providers **MUST** remove pointers which will not return any observations, as soon as possible. |
| [`CareConnect-Patient-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Patient-1) | 1..1 | The Patient resource identifies the patient which the observations relate to. |
| [`CareConnect-Organization-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Organization-1) | 1..* | The Organization resources reference by the List resource will represent the organisation sharing the information and **MUST** contain contact details for use in relation to data quality issues. References between the resources will put any other included Organization resources in context. |


The Bundle **MAY** contain **any** resources reference by other resources, to add additional information to the observation being shared. The following table contains **some** of the resource that could be included and guidance around the use of these resources: 

| Resource | Cardinality | Description |
| --- | --- | --- |
| [`CareConnect-Encounter-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Encounter-1) | 0..* | Where an observation is tied to a specific encounter, this would be the most appropriate resource to use. |
| [`CareConnect-EpisodeOfCare-1`]((https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-EpisodeOfCare-1) | 0..* | Where an observation is made as part of an episode of care rather than a specific encounter, this might be a more appropriate resource to use. |
| [`CareConnect-HealthcareService-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-HealthcareService-1) | 0..* | HealthcareService resources may be included to give additional context to the organisations. This might be where the observation is tied to a specific service within an organisation or as a place to share the care setting in which the observations were made. |
| [`CareConnect-Practitioner-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Practitioner-1) | 0..* | Practitioner details may be included in the bundle in relation to observations.<br/><br/>**Note:** it is important to consider Information Governance when including practitioner personal data within information shared with other organisations. |
| [`CareConnect-PractitionerRole-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-PractitionerRole-1) | 0..* | PractionerRole resources may be included to add additional information about practitioners included in the shared information. |
| [`CareConnect-RelatedPerson-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-RelatedPerson-1) | 0..* | Observations may contain a reference to the person who is the source of the observation. This might be a practitioner but in may also be a family member or carer. The related person resource might be useful in representing this information.<br/><br/>**Note:** As with the practitioner resource, information governance should be considered when including details of any person who is not the patient this observation information is related to. |


## Resource Population Requirements and Guidance 

The following requirements and resource population guidance must be followed. Only resources which require additional guidance or requirements have been listed. Other referenced resources MUST align with the restrictions imposed by the references within the referencing resource. 

### [Bundle](http://hl7.org/fhir/STU3/StructureDefinition/Bundle)

The Bundle resource is the container for the record and MUST conform to the `Bundle` base FHIR profile and the additional population guidance as per the table below. The first entry within the `Bundle` MUST be the mandatory `List` resource. 

| Resource Cardinality | 1..1 |

| Element | Cardinality | Additional Guidance |
| --- | --- | --- |
| type | 1..1 | MUST have the fixed value: `collection` |


### [List](http://hl7.org/fhir/STU3/list.html)

The List resource MUST conform to the `List` base FHIR profile and the additional population guidance as per the table below. 

| Resource Cardinality | 1..1 |

| Element | Cardinality | Additional Guidance |
| --- | --- | --- |
| Extension (informationProvider).valueReference | 1..1 | This must reference the `Organization` resource representing the organisation sharing the information. This organisation resource will include contact details for the organisation in relation to data quality issues with the retrieved data. |
| status | 1..1 | MUST have the fixed value: `current` |
| mode | 1..1 | MUST have the fixed value: `snapshot` |
| subject | 1..1 | A reference to the `Patient` resource representing the subject of this record |
| code | 1..1 | The purpose of the list. The value SHALL match the record type code on the associated pointer (`DocumentReference.type`). |


### [CareConnect-Observation-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Observation-1)

The Observation resources included as part of the returned information SHALL conform to the `CareConnect-Observation-1` constrained FHIR profile and the additional population guidance as per the table below. 

The aim MUST be to include enough information in the observation resource to give it context without the need for any supporting information to be considered. Where additional supporting information is included this SHOULD be made available to the user, where possible. If supporting information is included and it is not possible to render for the user, the observation information could be shown to the user but SHOULD be flagged to let them know additional information around the observation cannot be shown. 

| Resource Cardinality | 0..* |

The following table pulls out some key elements in the observation resource and give some guidance around how the different elements should be used. 

| Element | Cardinality | Additional Guidance |
| --- | --- | --- |
| identifier | 1..1 | A publisher defined unique identifier for the observation which will be maintained across different retrieval endpoints/FHIR interfaces to allow subscribers to identify duplicates or updated information. |
| code | 1..1 | This will be the main identifier which tells the consumer what type of observation this is. |
| subject | 1..1 | This will be the patient who is the subject of this list of observations. |
| context | 0..1 | Where additional context around the “Encounter” or "EpisodeOfCare” in which the observation was made or recorded, it SHOULD be referenced from here. Where a resource is referenced the constraints of the profile must be followed. |
| effective | 1..1 | This element SHOULD contain the datetime at which the observation was made or recorded. |
| performer | 0..* | Where additional context around who made or is responsible for the observation is required, it SHOULD be referenced from this element. Constraints within the profile should be followed when referencing other resources.<br/><br/>**Note:** Where information about any individual is included information governance should be considered. |
| value | 0..1 | Where the observation has a result it SHOULD be included in this element. |
| interpretation | 0..1 | Where there is an interpretation about an observation it SHOULD be included in this element. |
| comment | 0..1 | A comment MAY be included, but content should be considered carefully in relation to information governance and in terms of a serious harm test for use cases where this comment may be displayed to a user. |
| component | 0..* | Where components of the observation are expressed as separate code value pairs then this element should be used.<br/><br/>A consumer should consider how these components and the observation code and value should be displayed to user in the most clinically safe way possible. |


### [CareConnect-Patient-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Patient-1)

The patient resources included in the bundle SHALL conform to the `CareConnect-Patient-1` constrained FHIR profile and the additional population guidance as per the table below: 

| Resource Cardinality | 1..1 |

| Element | Cardinality | Additional Guidance |
| --- | --- | --- |
| identifier | 1..1 | Patient NHS Number identifier SHALL be included within the nhsNumber identifier slice. The NHS Number SHALL match the NHS Number on the associated pointer (`DocumentReference.subject`). |
| name (official) | 1..1 | Patients name as registered on PDS, included within the resource as the official name element slice |
| birthDate | 1..1 | The patient's date of birth |


### [CareConnect-Organization-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Organization-1)

All Organization resources included in the bundle SHALL conform to the `CareConnect-Organization-1` constrained FHIR profile and the additional population guidance as per the table below: 

| Resource Cardinality | 1..* |

| Element | Cardinality | Additional Guidance |
| --- | --- | --- |
| identifier | 1..* | The organisation ODS code identifier SHALL be included within the `odsOrganizationCode` identifier slice. |
| name | 1..1 | A human readable name for the organisation SHALL be included in the organization resource. |
| telecom | 0..* | Where the Organization resource is referenced directly from the List (`Extension (informationProvider)`), contact details for the organisation MUST be included for use in relation to data quality issues. |
| telecom.system | 1..1 | MUST contain a value of phone or email matching the included contact method within the value element |
| telecom.value | 1..1 | A phone number or email address |


### [CareConnect-Practitioner-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Practitioner-1)

The Practitioner resources included in the bundle SHALL conform to the `CareConnect-Practitioner-1` constrained FHIR profile. 

| Resource Cardinality | 0..* |

**Note:** Information Governance should be considered before including practitioner’s personal data within shared information. 


### [CareConnect-PractitionerRole-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-PractitionerRole-1)

The PractitionerRole resources included in the bundle SHALL conform to the `CareConnect-PractitionerRole-1` constrained FHIR profile. 

| Resource Cardinality | 0..* |

| Element | Cardinality | Additional Guidance |
| --- | --- | --- |
| organization | 1..1 | Reference to the Organization where the practitioner performs this role |
| practitioner | 1..1 | Reference to the Practitioner who this role relates to |
| code | 1..* | The practitioner role SHALL include a value from the [`ProfessionalType-1`](https://fhir.nhs.uk/STU3/ValueSet/ProfessionalType-1) value set. The `PractitionerRole.code` SHOULD include the SDS Job Role name where available. |
| specialty | 1..1 | `PractitionerRole.specialty` SHALL use a value from [`Specialty-1`](https://fhir.nhs.uk/STU3/ValueSet/Specialty-1) value set |


### [CareConnect-Encounter-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Encounter-1)

The Encounter resources included in the bundle SHALL conform to the `CareConnect-Encounter-1` constrained FHIR profile and the additional population guidance as per the table below: 

| Resource Cardinality | 0..* |

| Element | Cardinality | Additional Guidance |
| --- | --- | --- |
| Encounter.type | 1..* | The encounter type SHOULD include a value from the [`EncounterType-1`](https://fhir.nhs.uk/STU3/ValueSet/EncounterType-1) value set. This value set is extensible so additional values and code systems may be added where required. |
| subject | 1..1 | A reference to the Patient resource representing the subject of this event |

### [CareConnect-HealthcareService-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-HealthcareService-1)

The HealthcareService resources included in the bundle SHALL conform to the `CareConnect-HealthcareService-1` constrained FHIR profile and the additional population guidance as per the table below: 

| Resource Cardinality | 0..* |

| Element | Cardinality | Additional Guidance |
| --- | --- | --- |
| providedBy | 1..1 | Reference to the organisation who provides the healthcare service |
| type | 1..1 | This type SHALL have a value from the [`CareConnect-CareSettingType-1`](https://fhir.hl7.org.uk/STU3/ValueSet/CareConnect-CareSettingType-1) value set |
| specialty | 1..1 | The specialty SHALL be a value from the [`Specialty-1`](https://fhir.nhs.uk/STU3/ValueSet/Specialty-1) value set |



## Examples

An example of observation data from within a Digital Child Health specific care setting.

<div class="github-sample-wrapper scroll-height-350">
{% highlight xml %}
{% include_relative examples/Observation_List_v1_DCH.xml %}
{% endhighlight %}
</div>