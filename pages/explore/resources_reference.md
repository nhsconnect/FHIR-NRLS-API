---
title: NRLS | Reference
keywords: development Reference
tags: [development,fhir,profiles]
sidebar: overview_sidebar
permalink: explore_reference.html
summary: "Developer Cheat Sheet shortcuts for the <br/>technical build of NRLS API."
---

{% include custom/search.warnbanner.html %}

## 1. API Profiles: ##

| Profile | ValueSets |
| :--------- |:-------- |
| [CareConnect-Patient-1](StructureDefinitions/CareConnect-Patient-1.xml) | [CareConnect-RegistrationType-1](ValueSets/CareConnect-RegistrationType-1.xml) <br /> [CareConnect-RegistrationStatus-1](ValueSets/CareConnect-RegistrationStatus-1.xml) <br /> [CareConnect-CareConnect-ResidentialStatus-1](ValueSets/CareConnect-ResidentialStatus-1.xml) <br /> [CareConnect-TreatmentCategory-1](ValueSets/CareConnect-TreatmentCategory-1.xml) <br /> [CareConnect-HumanLanguage-1](ValueSets/CareConnect-HumanLanguage-1.xml) <br /> [CareConnect-LanguageAbilityMode-1](ValueSets/CareConnect-LanguageAbilityMode-1.xml) <br /> [CareConnect-LanguageAbilityProficiency-1](ValueSets/CareConnect-LanguageAbilityProficiency-1.xml) <br /> [CareConnect-AdministrativeGender-1](ValueSets/CareConnect-AdministrativeGender-1.xml) <br /> [CareConnect-MaritalStatus-1](ValueSets/CareConnect-MaritalStatus-1.xml) <br />[CareConnect-PersonRelationshipType-1](ValueSets/CareConnect-PersonRelationshipType-1.xml) <br /> |
| [CareConnect-Practitioner-1](StructureDefinitions/CareConnect-Practitioner-1.xml) | [CareConnect-HumanLanguage-1](ValueSets/CareConnect-HumanLanguage-1.xml) <br /> [CareConnect-LanguageAbilityMode-1](ValueSets/CareConnect-LanguageAbilityMode-1.xml) <br /> [CareConnect-LanguageAbilityProficiency-1](ValueSets/CareConnect-LanguageAbilityProficiency-1.xml) <br /> [CareConnect-AdministrativeGender-1](ValueSets/CareConnect-AdministrativeGender-1.xml) <br /> [CareConnect-SDSJobRoleName-1](ValueSets/CareConnect-SDSJobRoleName-1.xml) |
| [CareConnect-DocumentReference-1](StructureDefinitions/CareConnect-Procedure-1.xml) | |


## 2. Identifiers ##

| identifier | URI | Comment |
|--------------------------------------------|----------|----|
| NHS Number | https://fhir.nhs.uk/Id/nhs-number | Patient - England and Wales |
| SDS User Id/ Practitioner Code | https://fhir.nhs.uk/Id/sds-user-id | Practitioner |
| SDS/ODS Organisation Code | https://fhir.nhs.uk/Id/ods-organization-code | Organization |
| SDS/ODS Site Code | https://fhir.nhs.uk/Id/ods-site-code | Location |

```
TODO: Insert a picture here to show the overall process (e.g. TLS, Setting Audit headers, etc)]
```
