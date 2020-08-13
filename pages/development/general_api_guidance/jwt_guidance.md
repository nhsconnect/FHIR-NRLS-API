---
title: JSON Web Token Guidance
keywords: fhir development
tags: [fhir,development,for_providers,for_consumers]
sidebar: overview_sidebar
permalink: jwt_guidance.html
summary: "Implementation guidance for developers - focusing on the required JSON Web Token"
---

The JSON Web Token (JWT) is required for interaction with both the NRL and the SSP and MUST meet the requirements outlined on this page.


## Format

The JWT MUST be included in the standard HTTP `Authorization` request header.

The JWT MUST conform to the [Spine JWT](https://developer.nhs.uk/apis/spine-core/security_jwt.html) definition, but the validation of the claims is extended by the rules defined on this page. Where there is a difference between the requirements and validation specified in the Spine Core specification and on this page, the requirements on this page override the rules defined for the Spine Core specification.


## Claims

For all requests the following claim requirements MUST be met:

| claim | Requirements |
| --- | --- |
| requesting_organisation | The claim MUST be populated with the details of the requesting organisation and be in the form:<br/><br/>`https://fhir.nhs.uk/Id/ods-organization-code|[ODS_code]`<br/><br/>The ODS code MUST be known to the Spine. |
| requesting_system | The claim MUST be populated with the details of the requesting system and be in the form:<br/><br/>`https://fhir.nhs.uk/Id/accredited-system|[ASID]`<br/><br/>The ASID MUST be known to Spine.<br/>The ASID MUST be associated with the ODS code in the requesting_organisation claim. |
| `scope` | For requests to the NRL: `scope` MUST have the value of `patient/DocumentReference.read` (consumer interactions) or `patient/DocumentReference.write` (provider interactions). <br/><br/> For requests to the SSP (see [SSP Information Retrieval Interaction](retrieval_ssp.html)): `scope` MUST have the value of `patient/*.read` (consumer interactions) or `patient/*.write` (provider interactions). |  


### Healthcare Professional Access

Where the consuming system is making a request for healthcare professional access to information, the following claim requirements MUST be met:

| claim | Requirements |
| --- | --- |
| `sub` | The value of the `sub` claim MUST match the value of the `requesting_user` claim. | 
| reason_for_request | The claim MUST have the value of "**directcare**" |
| requesting_user | The claim MUST be populated with the requesting user details. |
| requesting_patient | The claim MUST **NOT** be included. |

**Example - Healthcare Professional Access**

```json
{
       "iss": "https://cas.nhs.uk",
       "sub": "https://fhir.nhs.uk/Id/sds-role-profile-id|4387293874928",
       "aud": "https://clinicals.spineservices.nhs.uk",
       "exp": 1469436987,
       "iat": 1469436687,
       "reason_for_request": "directcare",
       "scope": "patient/Documentreference.read",
       "requesting_system": "https://fhir.nhs.uk/Id/accredited-system|200000000205",
       "requesting_organisation": "https://fhir.nhs.uk/Id/ods-organization-code|RXA", 
       "requesting_user": "https://fhir.nhs.uk/Id/sds-role-profile-id|4387293874928"
}
```

### Citizen Access

Where the consuming system is making a request for citizen access to information, the following claim requirements MUST be met:

| claim | Requirements |
| --- | --- |
| `sub` | The value of the `sub` claim MUST match the value of the `requesting_patient` claim. | 
| reason_for_request | The claim MUST have the value of "**patientaccess**" |
| requesting_patient | The claim MUST be populated with the patient details for which the request is about. And must be in the format `http://fhir.nhs.net/Id/nhs-number|[nhs_number]` |
| act | This claim is for use where there is delegated access by one citizen on behalf of another citizen.<br/><br/>Where the request is citizen access but not to their own record the `act` claim **MUST** be populated with the details of the requesting citizen.<br/><br/> The claim MUST be in the format:<br/><br/>```"act" : {```<br/>```   "sub" : "http://fhir.nhs.net/Id/nhs-number|[nhs_number]"```<br/>```}```|
| requesting_user | The claim MUST **NOT** be included. |

**Example - Citizen access to own records**

```json
{
       "iss": "https://cas.nhs.uk",
       "sub": "http://fhir.nhs.net/Id/nhs-number|6101231234",
       "aud": "https://clinicals.spineservices.nhs.uk",
       "exp": 1469436987,
       "iat": 1469436687,
       "reason_for_request": "patientaccess",
       "scope": "patient/Documentreference.read",
       "requesting_system": "https://fhir.nhs.uk/Id/accredited-system|200000000205",
       "requesting_organisation": "https://fhir.nhs.uk/Id/ods-organization-code|RXA", 
       "requesting_patient": "http://fhir.nhs.net/Id/nhs-number|6101231234"
}
```

**Example - Citizen access to another citizent's record**

```json
{
       "iss": "https://cas.nhs.uk",
       "sub": "http://fhir.nhs.net/Id/nhs-number|6101231234",
       "aud": "https://clinicals.spineservices.nhs.uk",
       "exp": 1469436987,
       "iat": 1469436687,
       "reason_for_request": "patientaccess",
       "scope": "patient/Documentreference.read",
       "requesting_system": "https://fhir.nhs.uk/Id/accredited-system|200000000205",
       "requesting_organisation": "https://fhir.nhs.uk/Id/ods-organization-code|RXA", 
       "requesting_patient": "http://fhir.nhs.net/Id/nhs-number|6101231234",
       "act": {
            "sub": "http://fhir.nhs.net/Id/nhs-number|9876543210"
       }
}
```

### Unattended Access

Where an interaction is performed without a user being present, the following claim requirements must be met:

| claim | Requirement |
| --- | --- |
| `sub` | The value of the `sub` claim MUST match the value of the `requesting_system` claim. | 
| reason_for_request | MUST have the value of "**directcare**" |
| requesting_user | The claim MUST **NOT** be included. |
| requesting_patient | The claim MUST **NOT** be included. |

**Example - Unattended Access**

```json
{
       "iss": "https://cas.nhs.uk",
       "sub": "https://fhir.nhs.uk/Id/accredited-system|200000000205",
       "aud": "https://clinicals.spineservices.nhs.uk",
       "exp": 1469436987,
       "iat": 1469436687,
       "reason_for_request": "directcare",
       "scope": "patient/Documentreference.read",
       "requesting_organisation": "https://fhir.nhs.uk/Id/ods-organization-code|RXA",
       "requesting_system": "https://fhir.nhs.uk/Id/accredited-system|200000000205"
}
```
