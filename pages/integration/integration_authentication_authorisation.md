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

Access to NHS Digital SPINE services will not be without restriction. The [security](development_api_security_guidance.html) section outlines the need for any client to be able to take part in a mutual authentication session at the transport layer. This will protect traffic flowing between client and server and to some extent gives the NHS Digital SPINE services confidence in the identity of the client system. However, this transport layer security does not address authorisation. Additionally the level of granularity in terms of establishing identity stops at the system level.

Directly we are referring to the NRL and the SSP NHS Digital SPINE services.

Consumers and Providers are required to ensure the correct level of authentication and authorisation is applied to their systems and user access when interacting with NHS Digital SPINE services. 

A summary of these requirements are outlined in the following sections.

### Authentication ###

Clients are required to authenticate and authorise users, using a mechanism that conforms to the level 3 authentication and RBAC control requirements. 

Clients are required to apply RBAC control to manage access to different types of Pointers and their referenced records and documents appropriately. 

This level of control can be achieved and verified through integration with the Care Identity Service (CIS), which will become the NHS Digital’s National Identity service. As well as providing support for existing smartcard-based mechanisms the National Identity service will provide an array of other authentication types. Clients will need to integrate with CIS to access the NRL and the SSP.

Please see the [NRL RBAC mapping table](explore_rbac_mapping.html) for details on the mappings between RBAC codes and Pointer types.

### Authorisation ###

The NRL and SSP use the well established ASID + interactionId approach to control access to these services. Each RESTful endpoint is associated with a unique interactionId. Each system that is accredited by NHS Digital as being a Consumer or Provider will be issued with an ASID and assigned a set of interactions that they have been authorised to perform. These interactions are mapped to interactionIds. Each ASID is associated with a set of interactionIds. It is this combination of interactionIds that govern what RESTful endpoints a particular system can interact with.

Interaction IDs for retrieval are specific to the format code for the record or document. Please see the [Formats](retrieval_formats.html) page for details.

