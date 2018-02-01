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

A Provider can be thought of as a system that has <b>write access</b> to the NRLS with some <b>limited read-access</b> that is designed to support Pointer maintenance. 

A Consumer can be thought of as a system that has <b>read-access</b> though the way that Pointers can be retrieved from the system is different from the read-access that a Provider has. The read access that a Consumer has is designed to facilitate the retrieval of Pointers that are of interest to the Consuming system.



<img src="images/solution/Solution_Behaviour_diagram.png" style="width:100%;max-width: 100%;">

### Identity on the NRLS ###


The NRLS has two roles – Provider and Consumer. A Consumer is a read-only view of the NRLS. A Provider should be seen as a superset of Consumer, it can read but it can also write. 

Each client system will be given an Accredited System ID (ASID) by NHS Digital. Each ASID will be associated with one or more interaction IDs. An interaction ID defines an action that can be performed against NRLS (for example creating a new DocumentReference). As part of a request, a client will supply thier ASID and the interaction ID that relates to the action that they are trying to perform. If the interaction ID is not associated with the client's ASID then the request will be blocked.

### Pointer maintenance by Providers ###

If a client system is in the Provider role then as already mentioned they are permitted to create new Pointers, delete and update existing Pointers. Note that when it comes to the modification of existing Pointers the Provider is only permitted to change the Pointers that it owns. The concept of ownership is carried on the Pointer itself and is again centered around the ODS code. So long as the ASID of the client system puts the client in the Provider role and so long as the ODS code associated wth that ASID matches the owner’s ODS code found on the Pointer in question then the client can modify that Pointer.

In order to manipulate a Pointer a Provider must know the logical identifier of that Pointer. The logical identifier is an NRLS generated value that uniquely identifies a Pointer across an instance of the NRLS. 


### Pointer retrieval by Consumers ###

A Consumer is a read-only client of the NRLS. All interaction with the NRLS is predicated on the Consumer having a verified NHS number prior to retrieving Pointers. How this NHS number is retrieved is not the concern of the NRLS.

Once the Consumer has a verified NHS number the NRLS can be asked to retrieve a collection of Pointers that relate to that number. The NRLS looks for Pointer’s whose Patient property matches the NHS number query parameter. On this basis the NRLS will return a collection of zero or more matching Pointers.

Note that in order to execute this kind of query a client must have been assigned the Consumer role. A Provider is not authorised to query the NRLS in this way unless they have also been placed in the Consumer role.

### Record retrieval by Consumers ###

The NRLS does not take part in Record retrieval. The Pointers that is holds can be seen as signposts that show the way. Actually following these signposts to reach the Record that they point to is not facilitated by the NRLS.

In order to retrieve Records it is likely that there will need to be a degree of integration between the Consumer and the Record Provider. Consider for example that the Provider exposes a Record of type X over a proprietary interface. It is not within the scope of the NRLS to negotiate the retrieval of that Record from that proprietary interface. Instead it is the responsibility of the Consumer to integrate with the proprietary API exposed by the Provider.

NHS Digital are considering how some of this integration burden can be lifted from the Consumers. The current view is that national data standards in the form of centrally defined data models and API definitions will greatly aid in the goal of reducing the Consumer integration burden by increasing interoperability between third party systems.

By relying on national standards NHS Digital may be able to act on behalf of Consumers to retrieve Records from Providers that exposed Records conforming to standard data models that are exposed over APIs which conform to standardised API definitions. Numerous things need to align to make this goal a reality however on the assumption that a standards based approach is realistic then an existing NHS Digital service known as the Spine Security Proxy or SSP may be used to mediate Record retrieval on behalf of Consumers.

Briefly, the SSP is a forward HTTP proxy which will be used as a front-end to control and protect access to Provider IT systems that will be exposing Records in a standards compliant way. Additional responsibilities of the SSP include auditing of requests and throttling of requests.


## Auditing ##
The NRLS will capture an audit trail for each request-response interaction that a client (Consumer or Provider) has with the system. Once captured the audit trail can be retrieved.

### Capturing an audit trail ###
The audit trail begins with capturing key data from a client request and it ends with capturing the NRLS' response to that request. The request audit trail and response audit
trail will be combined to form a full end to end audit of a given request and response interaction with NRLS.

An audit trail will capture different information about who or what is making the request depending on whether the client is a person or a system. In the latter case one can imagine a Provider may have a batch job that runs periodically to synchronise its Pointers in the NRLS. In this case it cannot be assumed that there will be a person making the requests. Instead it may well be a system making the request. When capturing the audit trail the system needs to be aware of this difference. On that basis the audit capability views the user id as an optional piece of the audit data. Having said that the user id is optional in very specific circumstances; namely in the context of a Provider reading, searching, creating, updating or deleting their Pointers. It is not optional in a Consumer context. If the user id is available then the guidence is that it should always be provided regardless of whether the client is a Provider or a Consumer.

#### Request audit trail ####
_"This [local user on this] system from this organisation with this legitimate relationship has sent this request at this time..."_

#### Response audit trail ####
_"...which resulted in this response at this time"_

### Retrieving an audit trail ###
The Providers are the actors who will be retrieving an audit trail. Specifically they will be able to retrieve the audit trail data in two different ways - 

1. By asking for all audit trails related to a given patient (identified by their NHS number)
2. By asking for all audit trails that relate to the Pointers that they own

In both cases it is important to understand that the Provider will not be able to view audit trail information that relates to Pointers other than the ones that they own and maintain.
