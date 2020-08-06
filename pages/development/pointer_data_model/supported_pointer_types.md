---
title: Pointer Types
keywords: structured rest documentreference
tags: [fhir,pointers,record_retrieval]
sidebar: accessrecord_rest_sidebar
permalink: supported_pointer_types.html
summary: Pointer types supported by NRL
---

The following table outlines the currently supported pointer types on NRL. As support for other pointer types is added to the NRL this list will be updated.

The table outlines the `Retrieval Format` and `Retrieval Interactions` supported for each pointer type. Details of the retrieval format and interactions can be found on the [Retrieval Overview](retrieval_overview.html) page.

| Pointer Type | Code | System | Retrieval Formats | Retrieval Interactions |
| --- | --- | --- | --- | --- |
| End of life care plan | 736373009 | http://snomed.info/sct | [Unstructured : PDF](retreival_unstructured_document.html) | [SSP Read](retrieval_ssp.html) |
| Mental Health Crisis Plan | 736253002 | http://snomed.info/sct | [Contact Details](retrieval_contact_details.html) | [Public Web](retrieval_http_unsecure.html) |
| Mental Health Crisis Plan | 736253002 | http://snomed.info/sct | [Unstructured : PDF](retreival_unstructured_document.html) | [SSP Read](retrieval_ssp.html) |
| Allergy List | 163221000000102 | http://snomed.info/sct | [Allergy List - FHIR STU3 v1](retrieval_allergies_fhir_stu3.html) | [SSP Read](retrieval_ssp.html) |
| Observation List | 1102421000000108 | http://snomed.info/sct | [Observation List - FHIR STU3 v1](retrieval_observations_fhir_stu3.html) | [SSP Read](retrieval_ssp.html) |
| Vaccination List | 1102181000000102 | http://snomed.info/sct | [Vaccination List - FHIR STU3 v1](retrieval_vaccinations_fhir_stu3.html) | [SSP Read](retrieval_ssp.html) |
