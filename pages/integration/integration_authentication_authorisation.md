---
title: Authentication & Authorisation
keywords: spine, security
tags: [integration]
sidebar: overview_sidebar
permalink: integration_authentication_authorisation.html
summary: "Authentication and Authorisation"
---

## Authentication and Authorisation

### Introduction

The NRL and SSP NHS Digital Spine services are subject to various access restrictions. The [security](development_api_security_guidance.html) section outlines the need for any client to be able to take part in a mutual authentication session at the transport layer. This will protect traffic flowing between client and server and, to some extent, gives the NHS Digital SPINE services confidence in the identity of the client system. However, this transport-layer security does not address authorisation. Additionally, the level of granularity in terms of establishing identity stops at the system level.

Consumers and Providers are required to ensure the correct level of authentication and authorisation is applied to their systems and user access when interacting with NHS Digital SPINE services. 

### Authentication

Clients are required to authenticate and authorise users, using a mechanism that conforms to the level-3 authentication and RBAC control requirements.

Clients are required to apply appropriate RBAC control to manage access to different types of Pointers and their referenced records.

This level of control can be achieved and verified through integration with the [Care Identity Service (CIS)](https://digital.nhs.uk/services/registration-authorities-and-smartcards/care-identity-service), which will become [NHS Identity](https://digital.nhs.uk/services/nhs-identity/guidance-for-developers/an-introduction-to-nhs-identity). As well as providing support for existing smartcard-based mechanisms, NHS Identity will provide an array of other authentication types. Consumers will need to integrate with CIS or NHS Identity to access the NRL and the SSP.

Please see the [NRL RBAC mapping table](explore_rbac_mapping.html) for details on the mappings between RBAC codes and Pointer types.

### Authorisation

The NRL and SSP use the well-established ASID + interactionId approach to control access to these services. Each RESTful endpoint is associated with a unique interactionId. Each system accredited by NHS Digital as a Consumer or Provider will be issued with an ASID and assigned a set of interactions that it has been authorised to perform. These interactions are mapped to interactionIds. Each ASID is associated with a set of interactionIds. It is this combination of interactionIds that govern which RESTful endpoints a particular system can interact with.
