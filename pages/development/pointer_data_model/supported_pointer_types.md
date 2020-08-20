---
title: Pointer Types
keywords: structured rest documentreference
tags: [fhir,pointers,record_retrieval]
sidebar: accessrecord_rest_sidebar
permalink: supported_pointer_types.html
summary: NRL supported pointer types.
---

The following table outlines the currently supported NRL pointer types; this list will be updated as support for other pointer types are introduced to the NRL.

The table outlines the `Retrieval Format` supported for each pointer type. Details about the retrieval formats can be found on the [Retrieval Overview](retrieval_overview.html) page.

| Pointer Type | Code | System | Retrieval Format(s) |
| --- | --- | --- | --- |
| End of life care plan | 736373009 | http://snomed.info/sct | ["Unstructured Document (PDF)"](retreival_unstructured_document.html) |
| Mental Health Crisis Plan | 736253002 | http://snomed.info/sct | ["Contact Details"](retrieval_contact_details.html) <br/>["Unstructured Document (PDF)"](retreival_unstructured_document.html) |
| Allergy List | 163221000000102 | http://snomed.info/sct | ["Allergy List - FHIR STU3 v1"](retrieval_allergies_fhir_stu3.html) |
| Observation List | 1102421000000108 | http://snomed.info/sct | ["Observation List - FHIR STU3 v1"](retrieval_observations_fhir_stu3.html) |
| Vaccination List | 1102181000000102 | http://snomed.info/sct | ["Vaccination List - FHIR STU3 v1"](retrieval_vaccinations_fhir_stu3.html) |
