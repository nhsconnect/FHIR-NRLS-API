---
title: JSON Web Token Guidance
keywords: fhir development
tags: [fhir,development,for_providers,for_consumers]
sidebar: overview_sidebar
permalink: jwt_guidance.html
summary: JSON Web Token implementation guidance for developers.
---

The JSON Web Token (JWT) is required for interaction with both the NRL and SSP and **MUST** meet the requirements outlined on this page.

## Format

The JWT **MUST**:

- be included in the standard HTTP `Authorization` request header.
- conform to the [Spine JWT](https://developer.nhs.uk/apis/spine-core/security_jwt.html) definition, taking note of the validation of claims extended by the rules defined on this page. Where there is a difference between the requirements and validation specified in the Spine Core specification and on this page, the requirements on this page take precedence.

## Claims

For all requests the following claim requirements **MUST** be met:

|Claim|Requirement|
|-----|-----------|
|`requesting_organisation`|The ODS code of the requesting organisation **MUST** be known to the Spine and be in the form:<br /><br />`https://fhir.nhs.uk/Id/ods-organization-code|[ODS_code]`|
|`requesting_system`|The ASID of the requesting system (associated with the ODS code in the `requesting_organisation` claim) **MUST** be known to Spine and be in the form:<br /><br />`https://fhir.nhs.uk/Id/accredited-system|[ASID]`|
|`scope`|For requests to the NRL: `scope` **MUST** have the value `patient/DocumentReference.read` (consumer interactions) or `patient/DocumentReference.write` (provider interactions).<br /><br />For requests to the SSP (see [SSP Information Retrieval Interaction](retrieval_ssp.html)): `scope` **MUST** have the value `patient/*.read` (consumer interactions) or `patient/*.write` (provider interactions).|

### Healthcare Professional Access

Where a consuming system is making a request on behalf of a healthcare professional, the following claim requirements **MUST** be met:

|Claim|Requirement|
|-----|-----------|
|`requesting_user`|The claim **MUST** be populated with the requesting user details in the form:<br /><br />`https://fhir.nhs.uk/Id/sds-role-profile-id|[sds_role_profile_id]`|
|`sub`|The value **MUST** match the value of the `requesting_user` claim.|
|`reason_for_request`|Fixed value: `directcare`.|
|`requesting_patient`|The claim **MUST NOT** be included.|

#### Example: Healthcare Professional Access

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

Where a consuming system is making a request on behalf of a citizen, the following claim requirements **MUST** be met:

|Claim|Requirement|
|-----|-----------|
|`requesting_patient`|The claim **MUST** be populated with the citizen's patient details (the subject of the information being requested) in the form:<br /><br />`http://fhir.nhs.net/Id/nhs-number|[nhs_number]`|
|`sub`|The value **MUST** match the value of the `requesting_patient` claim.|
|`reason_for_request`|Fixed value: `patientaccess`.|
|`act`|This claim is for use where there is delegated access by one citizen on behalf of another citizen. Where the request is citizen access but not to their own record the `act` claim **MUST** be populated with the details of the requesting citizen.<br/><br/>The claim **MUST** be in the form:<br/><br/>```"act": {```<br />```   "sub": "http://fhir.nhs.net/Id/nhs-number|[nhs_number]"```<br />```}```|
|`requesting_user`|The claim **MUST NOT** be included.|

#### Example: Citizen accessing own record

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

#### Example: Citizen accessing another citizen's record

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

Where an interaction is performed without a user being present, the following claim requirements **MUST** be met:

|Claim|Requirement|
|-----|-----------|
|`sub`|The value **MUST** match the value of the `requesting_system` claim.|
|`reason_for_request`|Fixed value: `directcare`.|
|`requesting_user`|The claim **MUST NOT** be included.|
|`requesting_patient`|The claim **MUST NOT** be included.|

#### Example: Unattended Access

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
