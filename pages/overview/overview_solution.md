---
title: Getting involved with NRLS
keywords: engage, about
tags: [overview]
sidebar: overview_sidebar
permalink: overview_engage.html
summary: Getting involved with NRLS
---

{% include important.html content="This site is under active development by NHS Digital and is intended to provide all the technical resources you need to successfully develop the NRLS API. This project is being developed using an agile methodology so iterative updates to content will be added on a regular basis." %}


This section is a placeholder and content will be added in a later phase of the project.

<!--

## The Open API ecosystem ##

GP Connect is part of the a wider initiative to expose standards based [Open APIs](https://www.england.nhs.uk/digitaltechnology/info-revolution/interoperability/open-api/){:target="_blank"} to promote innovation and improve care across the NHS.

To make use of the ecosystem and GP Connect APIs we're asking all involved to sign-up to an [Open API licence](designprinciples_open_api_licence_principles.html) which enshrines concepts such as fair-use and expectations around reciprocity of access to data to improve interoperability beyond just primary care.


### Capabilities ###

A capability is an area of focus for the GP Connect APIs. There are several [initial capabilities defined](overview_priority_capabilities.html).

### Become an API consumer ###

If you're planning on consuming data using GP Connect APIs then you're a consumer system.

### Become an API provider

If you're planning on providing data using GP Connect APIs then you're a provider system. 



## 1. Get started ##

- Read about the GP Connect [Priority capabilities](overview_priority_capabilities.html).
- Look through the design decisions made so far in relation to each capability packs ([Foundations](foundations_design.html), [Access Record HTML](accessrecord_design.html), [Access Record REST](accessrecord_rest.html), [Appointment Management](appointments_design.html) and [Task Management](tasks_design.html)) and get involved:
	- <span class="label label-success">SELECTED</span> / <span class="label label-info">DECISION</span> A decision has been made for first release.
	- <span class="label label-warning">ASSUMPTION</span> An assumption has been made which is under review/needs validated.

## 2. Explore ## 

- Try out the [GP Connect Demonstrator](system_demonstrator.html) system.
- Optionally download the [GP Connect Demonstrator Codebase](https://github.com/nhs-digital/gpconnect){:target="_blank"} to see how it works. 
- Download our [PostMan Collection](system_reference_postman.html) and explore the GP Connect interactions.

## 3. Develop ##

- Familiarise yourself with HL7&reg; FHIR&reg; ([developer introduction](http://www.hl7.org/implement/standards/fhir/overview-dev.html){:target="_blank"}, [executive summary](http://www.hl7.org/implement/standards/fhir/summary.html){:target="_blank"}, or [clinical intro](http://www.hl7.org/implement/standards/fhir/overview-clinical.html){:target="_blank"}).
- Grab an [open source FHIR development library](development_fhir_open_source_guidance.html) for your favourite programming language.
- Familiarise yourself with our GP Connect [FHIR API guidance](development_fhir_api_guidance.html) common to all APIs.
- Explore the GP Connect profiled FHIR resources, a variation of the international [FHIR resources](https://www.hl7.org/fhir/STU3/){:target="_blank"}, for [Foundations](datalibraryfoundation.html), [Access Record HTML](datalibraryaccessRecord.html), and [Appointment Management](datalibraryappointment.html).
- Dig in deep and explore one or more of the GP Connect capability packs and start building new or hitting existing APIs.
  - [Foundations](foundations.html) (e.g. resolve a patient to their logical identifier for further API calls).
  	- Note the foundation per-requisites are mandatory and may restrict your ability to utilise the GP Connect APIs.
  - [Access Record HTML](accessrecord.html) (e.g. Access html views from the primary care record).
  - [Access Record REST](accessrecord_rest.html) (e.g. Access structured data from the primary care record).
  - [Appointment Management](appointments.html) (e.g. Book an appointment for a patient).
  - [Task Management](tasks.html) (e.g. Send a notification task to a general practice organisation).
- Finally take a look at cross-cutting areas:
  - JSON Web Token - Provides [Cross organisation audit and provenance](integration_cross_organisation_audit_and_provenance.html) details.
  - Additional HTTP headers and proxy URL - This gives you access to the [Spine Security Proxy](integration_spine_security_proxy.html), the secure 'front door' of GP Connect APIs.
  - Configure HTTPS and TLS/MA - [Security guidance](development_api_security_guidance.html) allows you to secure and mutually authenticate your service with the Spine (which refers to two parties authenticating each other at the same time). 

## 4. Assure ##

- Read about the [Provider testing](testing_api_provider_testing.html) and [Consumer testing](testing_api_consumer_testing.html) process.

## 5. Deploy ##

- Become a [First of Type](overview_first_of_type.html) deployment!




## Provide feedback

To provide feedback on the GP Connect specification please send an email to the [GP Connect Team Inbox](mailto://gpconnect@nhs.net).

Some early feedback on the May 2016 release of the GP Connect draft specification can be found on the [OpenHealthHub forum](https://www.openhealthhub.org/c/fhir-implementation){:target="_blank"} under the category of "FHIR Implementation".

## Community engagement

GP Connect is working closely with a number of interoperability communities:

- [Code4Health interoperability community](http://interoperability.code4health.org/){:target="_blank"}
- [INTEROPen supplier-led healthcare IT interoperability community](http://www.interopen.org/){:target="_blank"}

## Timescales, benefits and more

The content here is designed for a technical audience (i.e. developers, architects and data scientists) for other details (i.e. the vision, timescales, business benefits and case studies) then please see the [NHS Digital GP Connect homepage](https://digital.nhs.uk/article/1275/GP-Connect){:target="_blank"}.

-->