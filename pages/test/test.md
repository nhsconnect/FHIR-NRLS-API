---
title: Test Overview
keywords: test
tags: [testing]
search: exclude
sidebar: foundations_sidebar
permalink: test.html
summary: "These pages assist with requirements for testing the API."
---

{% include custom/under.construction.html content="Please check back later for any updates to this page." %}

<!--
### 1. Testing Overview
The Test section contains a common baseline for testing FHIR-based APIs to ensure a satisfactory level of technical conformance has been reached. A FHIR-based API contains individual layers that require testing, which when combined will form a complete and detailed test log for the API prior to any formal assurance activities being carried out.

Testing may include the following:

- API conformance based on NHS Digital FHIR policy 
- RESTful conformance
- Security
- Authentication
- Payload(s)
- Spine Integration
- Clinical Safety
- End-to-End Testing

Depending on the API, it may be necessary to carry out the additional non-functional testing:

- Penetration Testing
- Performance
- Volumetrics

### 2. FHIR Servers

Where testing requires the use of a FHIR server, there are several options available.

#### 2.1 Public Servers

There are many freely available public servers that can be used to test with.  For a comprehensive list of servers, navigate to [Publicly Available FHIR Servers for testing](http://wiki.hl7.org/index.php?title=Publicly_Available_FHIR_Servers_for_testing)

#### 2.2 Local/Private Server

There are two well supported FHIR servers that can be downloaded and used for testing within your own environment:

**HAPI-FHIR**

A servlet based RESTful server, which is an open-source application written in Java. More information can be found at [http://hapifhir.io/](http://hapifhir.io/).

**Furore Vonk**

Vonk is created by Furore and is a user friendly RESTful server. It's free for testing, but does require that you restart the server everyday. It can be ran in Docker or as a .NET executable. More information can be found at [https://fhir.furore.com/](https://fhir.furore.com/)
-->

<!--
The Test section contains descriptions of approaches and suggestions for building APIs.

| Page              |  Description    |
|+---------------------|+--------------------------------+|
| Patterns / Topology | Describes access patterns necessary which influence the access, security, and use of APIs. Depending on the pattern or topology of the requesting and responding system. The relationship between the requestor and responder influences the choice of access mechanism, security of payload and access finally build of the system |
| Access | The access mechanism and of requesting system is influenced by many factors. This section demonstrates the design decisions to consider | 
| Security | The security of the FHIR payload, access, and data at rest are all important design decisions while building an API. | 
| Test Data | The test data allows the testing of the API at the individual response level. | 

{% include note.html content="This section provides an overview of the main elements of the testing process to consider within API development" %}

# Providing an API

The following diagram explains the elements of APIs allowing a the development of APIs:

{% include custom/provide_api.svg %}

# Contribute

This site is structured around API users, developers, and architects. Please get involved in the journey.

{% include custom/api_overview.svg %}
-->