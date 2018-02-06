---
title: Authentication & Authorisation
keywords: spine, security
tags: [integration]
sidebar: overview_sidebar
permalink: integration_authentication_authorisation.html
summary: "Authentication and Authorisation"
---

## Authentication and Authorisation ##


### Introduction ###

Access to the NRLS will not be without restriction. The [security](development_api_security_guidance.html) section outlines the need for any client to be able to take part in a mutual authentication session at the transport layer. This will protect traffic flowing between client and server and to some extent gives the NRLS server confidence in the identity of the client system. However, this transport layer security does not address authorisation. Additionally the level of granularity in terms of establishing identity stops at the system level. 

<!--
Authentication of a user and subsequent Authorisation of that identified user are important aspects of system security and the NRLS is tackling these aspects with a tactical approach and a longer term strategic approach. -->

### Authentication ###

<!--
#### Tactical ####

The NRLS' preference is any client (Consumer or Provider) interacting with the API has had their identity established by a national identity provider. At the moment NHS Digital's identity provider platform is the Care Identify Service which is based around smartcards.  

The NRLS project understands that for some clients the use of smartcards may not be practical. This is why the use of smartcards to establish a national identity is stated as a preference. Where a client is unable to provide a national identity then that client's individual circumstances will be considered and it may be possible to allow that client to connect without a national identity however this would be on the understanding that over time they commit to align with the NRLS' strategic plans for authentication. 

#### Strategic ####
-->

The NRLS is aligning itself with the Care Access Service which will become NHS Digital's national Authentication and Authorisation service. As well as providing support for existing smartcard-based mechanisms CAS will provide an array of other authentication types. Clients will need to integrate with CAS to access the NRLS.  

### Authorisation ###

<!--
#### Tactical ####
-->

The NRLS uses the well established ASID + interactionId approach to control access to the API. Each RESTful endpoint is associated with a unique interactionId. Each system that is accredited by NHS Digital as being a Consumer or Provider will have a set of interactions that they have been authorised to perform. These interactions are mapped to interactionIds. Each ASID is associated with a set of interactionIds. It is this combination of interactionIds that govern what RESTful endpoints a particular system can interact with. 

<!--
#### Strategic #### 

As well as providing an authentication service, CAS also provides an authorisation service. Longer term the NRLS is looking into making use of this capability. However, no decision has been taken as of yet and for now the ASID + interactionId mechanism will be used. -->



