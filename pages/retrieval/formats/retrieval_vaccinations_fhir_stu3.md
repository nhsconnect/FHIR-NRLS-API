---
title: Vaccination List - FHIR STU3
keywords: structured rest documentreference
tags: [fhir,pointers,record_retrieval]
sidebar: accessrecord_rest_sidebar
permalink: retrieval_vaccinations_fhir_stu3.html
summary: Vaccination List, FHIR STU3 information format for retrieval
---


The `Vaccination List FHIR STU3 v1` record format represents a list of vaccinations that were given or not-given to a patient and any relevant supporting information.

All pointers which allow for retrieval in the `Vaccination List FHIR STU3 v1` record format MUST return information conforming to the guidance and requirements specified on this page.


## Pointer Retrieval `Format` Code

The NRL pointer [`format`](explore_reference.html#retrieval-format) code for this structure is as follows:

| Code | Display |
| --- | --- |
| urn:nhs-ic:fhir:stu3:vaccination-list:1 | Vaccination List FHIR STU3 v1 |


## Retrieval Interaction 

For the “Vaccination List FHIR STU3 v1” record format, the [SSP Read](retrieval_ssp.html) retrieval interaction **MUST** be supported.

The provider defines the endpoint URL that is included in the NRL pointer, but when a consumer requests the information using the pointer no additional headers or parameters should be needed beyond those required by the SSP.


## Citizen vs Health Care Professional request

A provider may wish to return different data when the request for information is from a health care professional to when the request is from a citizen facing application.

An example of this might be:
- a provider might share some practitioner contact details with other healthcare professionals but may not wish to share those details with a citizen
- a provider might wish to hold back information from a citizen about a sensitive result until the information has been shared with the patient by a practitioner, but that same information may be very useful to other healthcare professionals and could result in significantly improved care/life saving for the patient if they were to attend as service such as A&E before the provider has had chance to share that information with the patient.

To enable this control within the provider, all consumers which wishes to retrieve data via the SSP must send the request with an appropriate JSON Web Token (JWT), which identifies if the request if for a healthcare professional or for citizen access. The requirements for the JWT are on the [JSON Web Token Guidance](jwt_guidance.html) page.


## Retrieval Response

When successfully responding to the request the provider MUST return:

- a HTTP status code of 200
- a payload conforming to the requirements on this page


## Retrieved Data Structure

The response payload will consist of a [FHIR Bundle](http://hl7.org/fhir/STU3/StructureDefinition/Bundle) resource of type “collection”. The `Bundle` will include a [FHIR List](http://hl7.org/fhir/STU3/list.html) resource as the first entry, which is used to manage the collection of resources.

The diagram below shows the referencing between FHIR resources within the response Bundle resource: 

<img alt="Vaccination information FHIR Bundle diagram" src="images/retrieval/formats/vaccination_list_fhir_stu3.png" style="width:100%;max-width: 100%;">


The `Bundle` **MUST** contain the following resources:

| Resource | Cardinality | Description |
| --- | --- | --- |
| [`List`](http://hl7.org/fhir/STU3/list.html) | 1..1 | Container for list of immunization for the patient.|
| [`CareConnect-Immunization-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Immunization-1) | 0..* | Immunizations listed will be included in the Bundle as Immunization resources.<br/><br/>The cardinality allows for zero immunizations to be included to allow for where pointer maintenance may not align with data management. For example: if pointers are maintained as an overnight batch process, but a vaccination could be removed at any time in the day, this may result in a pointer pointing to an empty list.<br/><br/>Providers **MUST** remove pointers which will not return any immunizations, as soon as possible. |
| [`CareConnect-Patient-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Patient-1) | 1..1 | The Patient resource identifies the patient which the immunizations relate to. |
| [`CareConnect-Organization-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Organization-1) | 1..* | The Organization resource referenced by the List resource will represent the organisation sharing the information and **MUST** contain contact details for use in relation to data quality issues. References between the resources will put any other included Organization resources in context. |


The `Bundle` **MAY** contain the following resources:

| Resource | Cardinality | Description |
|---|---|---|
| [`CareConnect-Encounter-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Encounter-1) | 0..* | Encounter resources may be included to give context to the immunization. |
| [`CareConnect-HealthcareService-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-HealthcareService-1) | 0..* | HealthcareService resources may be included to give additional context to the organizations which are included in the returned information. |
| [`CareConnect-Location-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Location-1) | 0..* | Location resources may be included to add context to the location where immunizations occurred. |
| [`CareConnect-Practitioner-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Practitioner-1) | 0..* | Practitioner details may be included in the bundle in relation to immunizations.<br/><br/>**Note:** it is important to consider Information Governance when including practitioner personal data within information shared with other organisations. |
| [`CareConnect-PractitionerRole-1`](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-PractitionerRole-1) | 0..* | PractionerRole resources may be included to add additional information in relation to practitioners included in the shared information. |


## Resource Population Requirements and Guidance

The following requirements and resource population guidance MUST be followed.


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
| Extension (informationProvider).valueReference | 1..1 | This MUST reference the `Organization` resource representing the organisation sharing the information. This Organization resource SHALL include contact details for the organisation in relation to data quality issues with the retrieved data. |
| status | 1..1 | MUST have the fixed value: `current` |
| mode | 1..1 | MUST have the fixed value: `snapshot` |
| subject | 1..1 | A reference to the `Patient` resource representing the subject of this record |
| code | 1..1 | The purpose of the list. The value SHALL match the record type code on the associated pointer (`DocumentReference.type`). |


### [CareConnect-Immunization-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Immunization-1)

The Immunization resources included as part of the returned information MUST conform to the `CareConnect-Immunization-1` constrained FHIR profile and the additional population guidance as per the table below:

| Resource Cardinality | 0..* |

| Element | Cardinality | Additional Guidance |
| extension(vaccinationProcedure) | 0..1 | Free text field should be used if no coded text available using extension(vaccinationProcedure).valueCodeableConcept.text |
| identifier | 1..1 | A publisher defined unique identifier for the vaccination which will be maintained across different retrieval endpoints/FHIR interfaces to allow subscribers to identify duplicates or updated information. Where the information has been sent within an event message via NEMS, the identifier should be consistent. |
| notGiven | 1..1 | Value SHALL be FALSE when the vaccination was given or reported as given, TRUE when not given |
| vaccineCode | 1..1 | `Immunization.vaccineCode` SHALL use a value from the [`CareConnect-VaccineCode-1`](https://fhir.hl7.org.uk/STU3/ValueSet/CareConnect-VaccineCode-1) value set. Where the vaccineCode is not known, such as when a vaccination is reported, a unknown value should be used. |
| date | 1..1 | The date or partial date that the vaccination was administered, or reported vaccination was given in the opinion of the child and/or parent carer |
| primarySource | 1..1 | Value should be FALSE if the vaccination was reported, TRUE if the vaccination was administered |
| reportOrigin | 0..1 | If the vaccination was reported, the original source SHOULD be included |
| manufacturer | 0..1 | Where available, this SHOULD be included |
| site | 0..1 | Where available, this SHOULD be included |
| route | 0..1 | Where available, this SHOULD be included |
| explanation.reasonNotGiven | 0..1 | If the vaccination was notGiven then the `reasonNotGiven` element SHALL be included |
| vaccinationProtocol.doseSequence | 0..1 | Where available, the `doesSequence`SHOULD be include |


### [CareConnect-Patient-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Patient-1)

The Patient resources included in the bundle SHALL conform to the `CareConnect-Patient-1` constrained FHIR profile and the additional population guidance as per the table below: 

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
| location | 0..1 | Reference to the location at which the encounter took place |
| subject | 1..1 | A reference to the Patient resource representing the subject of this event |


### [CareConnect-HealthcareService-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-HealthcareService-1)

The HealthcareService resources included in the bundle SHALL conform to the `CareConnect-HealthcareService-1` constrained FHIR profile and the additional population guidance as per the table below: 

| Resource Cardinality | 0..* |

| Element | Cardinality | Additional Guidance |
| --- | --- | --- |
| providedBy | 1..1 | Reference to the organisation who provides the healthcare service |
| type | 1..1 | This type SHALL have a value from the [`CareConnect-CareSettingType-1`](https://fhir.hl7.org.uk/STU3/ValueSet/CareConnect-CareSettingType-1) value set |
| specialty | 1..1 | The specialty SHALL be a value from the [`Specialty-1`](https://fhir.nhs.uk/STU3/ValueSet/Specialty-1) value set |


### [CareConnect-Location-1](https://fhir.hl7.org.uk/STU3/StructureDefinition/CareConnect-Location-1)

The Location resources included as part of the bundle SHALL conform to the `CareConnect-Location-1` constrained FHIR profile and the additional population guidance as per the table below:

| Resource Cardinality | 0..* |

| Element | Cardinality | Additional Guidance |
| identifier | 0..* | Where available, the ODS Site Code slice SHOULD be populated |


## Examples

<div class="github-sample-wrapper scroll-height-350">
{% highlight xml %}
{% include_relative examples/Vaccination_List_v1.xml %}
{% endhighlight %}
</div>