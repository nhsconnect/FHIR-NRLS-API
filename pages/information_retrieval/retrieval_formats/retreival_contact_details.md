---
title: Contact Details
keywords: structured rest documentreference
tags: [fhir,pointers,record_retrieval]
sidebar: overview_sidebar
permalink: retrieval_contact_details.html
summary: Contact Details retrieval format information.
---

The `Contact Details` retrieval format allows providers to share with consumers, contact details to use in relation to obtaining information about a patient.

### Information Retrieval

There are three steps to `Contact Details` information retrieval:

1. Identify which providers have information about a patient.
2. Information in the pointers allow the consumer to retrieve the providers' contact details.
3. The consumer uses the retrieved contact details to interact directly with the providers to obtain patient information.

## Pointer Retrieval `format` Code

The NRL pointer [`format`](pointer_fhir_resource.html#retrieval-format) code for this retrieval format is as follows:

|System|Code|Display|
|------|----|-------|
| https://fhir.nhs.uk/STU3/CodeSystem/NRL-FormatCode-1 | urn:nhs-ic:record-contact | Contact details (HTTP Unsecured) |

## Retrieval Interaction

The `Contact Details` retrieval format **MUST** support the [Public Web](retrieval_http_unsecure.html) retrieval interaction and may be in the form of either:
- an HTML web page.
- a PDF document.

## Retrieval Response

The public web page or PDF document **MUST** contain contact details to the appropriate individual or team who can provide more information about the associated patient.

The contact details web page or PDF should meet the following guidelines:

1. The contact details (name and phone number) for the individual or team who can provide information on the record SHOULD be provided.
2. The contact details **MUST** contain a work telephone number. It **MUST NOT** be a personal number which may not be answered when an individual is absent from work, unless mitigating actions are put in place, such as diverting to an alternative number.
3. The telephone number:
- SHALL NOT go directly to voicemail/answerphone.
- MAY go through a generic/Trust level switchboard to reach the identified individual.
4. The hours of availability for the telephone number SHOULD be clearly stated e.g. 8am-6pm.
5. During out of hours, alternative contact details SHOULD be provided where available (also meeting points 3, 4 and 5).
6. If there is not an out of hours option available, or the out of hours option does not cover all hours, this SHOULD be made clear.
7. Contact details for individuals or teams that are not involved in the care of the patient SHOULD NOT be provided i.e. the contact details should be specific. This is to avoid confusion for those consuming the contact details.
