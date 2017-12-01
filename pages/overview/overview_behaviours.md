---
title: Solution Behaviour
keywords: engage, about
tags: [overview]
sidebar: overview_sidebar
permalink: overview_behaviours.html
summary: Solution Behaviour
---

{% include important.html content="This site is under active development by NHS Digital and is intended to provide all the technical resources you need to successfully develop the NRLS API. This project is being developed using an agile methodology so iterative updates to content will be added on a regular basis." %}


## Behaviour ##

The NRLS has been designed around the Pointer being the unit of currency. Both Providers and Consumers deal exclusively with Pointers. However the roles of Provider and Consumer have different capabilities when it comes to Pointer manipulation. 
A Provider can be thought of as a system that has write access to the NRLS with some limited read-access that is designed to support Pointer maintenance. 
A Consumer can be thought of as a system that has read-access though the way that Pointers can be retrieved from the system is different from the read-access that a Provider has. The read access that a Consumer has is designed to facilitate the retrieval of Pointers that are of interest to the Consuming system.

[TODO Diagram 5]

<img src="images/solution/Solution_Behaviour_diagram.png" style="width:100%;max-width: 100%;">

### Identity on the NRLS ###

The NRLS has two roles of user – Provider and Consumer. The ODS code is used as a means to identify a user. The NRLS maintains a mapping of ODS code to role; Provider, Consumer role or in some cases both. In order to categorise client systems, the NRLS it must have a means of reliably determining the ODS code of that system. This will be discussed in more detail in the security section (TODO).

### Pointer maintenance by Providers ###

If a client system is in the Provider role then they are permitted to create new Pointers, delete and update existing Pointers. Note that when it comes to the modification of existing Pointers the Provider is only permitted to change the Pointers that it owns. The concept of ownership is carried on the Pointer itself and is again cantered around the ODS code. So long as the ODS code of the client system puts the client in the Provider role and so long as the ODS code of that client matches the owner’s ODS code found on the Pointer in question then the client can modify that Pointer.
In order to manipulate a Pointer a Provider must know the logical identifier of that Pointer. The logical identifier is an NRLS generated value that uniquely identifies a Pointer across an instance of the NRLS. 
The NRLS provides a number of query mechanisms that are only available to Providers which are designed to support resolution of Pointer logical identifier.

### Pointer retrieval by Consumers ###

A Consumer is a read-only client of the NRLS. All interaction with the NRLS is predicated on the Consumer having a verified NHS number prior to retrieving Pointers. How this NHS number is retrieved is not the concern of the NRLS.
Once the Consumer has a verified NHS number the NRLS can be asked to retrieve a collection of Pointers that relate to that number. The NRLS looks for Pointer’s whose Patient property matches the NHS number query parameter. On this basis the NRLS will return a collection of zero or more matching Pointers.
Note that in order to execute this kind of query a client must have been assigned the Consumer role. A Provider is not authorised to query the NRLS in this way unless they have also been placed in the Consumer role.

### Record retrieval by Consumers ###

The NRLS does not take part in Record retrieval. The Pointers that is holds can be seen as signposts that show the way. The actual retrieval of the Record referenced by a given Pointer is facilitated by the Spine Security Proxy (SSP).
The SSP is a forward HTTP proxy which will be used as a front-end to control and protect access to Provider IT systems that will be exposing Records. It provides a single security point for both authentication and authorisation for consuming systems. Additional responsibilities include auditing of all requests, throttling of requests and transaction logging for performance and commercial remuneration purposes.
A consumer should route requests to retrieve Records through the SSP as opposed to attempting to retrieve the Record directly.
