---
title: Access Controls
keywords: RBAC authorisation documentreference
tags: [security,authorisation,spine_secure_proxy]
sidebar: accessrecord_rest_sidebar
permalink: explore_rbac_mapping.html
summary: "Overview of the access controls for NRL pointers"
---


## Introduction

The NRL and SSP NHS Digital Spine services are subject to various access restrictions. The [security](development_api_security_guidance.html) section outlines the need for any client to be able to take part in a mutual authentication session at the transport layer. This will protect traffic flowing between client and server and, to some extent, gives the NHS Digital SPINE services confidence in the identity of the client system. However, this transport-layer security does not address authorisation. Additionally, the level of granularity in terms of establishing identity stops at the system level.

Consumers and Providers are required to ensure the correct level of authentication and authorisation is applied to their systems and user access when interacting with NHS Digital SPINE services. 

## Authentication

Clients are required to authenticate and authorise users, using a mechanism that conforms to the level-3 authentication and RBAC control requirements.

Clients are required to apply appropriate RBAC control to manage access to different types of Pointers and their referenced records.

This level of control can be achieved and verified through integration with the [Care Identity Service (CIS)](https://digital.nhs.uk/services/registration-authorities-and-smartcards/care-identity-service), which will become [NHS Identity](https://digital.nhs.uk/services/nhs-identity/guidance-for-developers/an-introduction-to-nhs-identity). As well as providing support for existing smartcard-based mechanisms, NHS Identity will provide an array of other authentication types. Consumers will need to integrate with CIS or NHS Identity to access the NRL and the SSP.

Please see the [NRL RBAC mapping table](explore_rbac_mapping.html) for details on the mappings between RBAC codes and Pointer types.

## Authorisation

The NRL and SSP use the well-established ASID + interactionId approach to control access to these services. Each RESTful endpoint is associated with a unique interactionId. Each system accredited by NHS Digital as a Consumer or Provider will be issued with an ASID and assigned a set of interactions that it has been authorised to perform. These interactions are mapped to interactionIds. Each ASID is associated with a set of interactionIds. It is this combination of interactionIds that govern which RESTful endpoints a particular system can interact with.


## Overview

Access to NRL records is determined by Record Groups, where a Record Group contains one or more Record Types. Access to each Record Group is controlled by Role Based Access Control (RBAC) codes from the [National RBAC Database](https://developer.nhs.uk/apis/spine-core/security_rbac.html) and administered by an RA Managers within Trusts.  

For each Record Group there are two RBAC codes: 

1. The first RBAC code will allow a user to view pointers only (for all the Record Types in that Record Group) 

2. The second RBAC code will allow a user to view pointers and retrieve records (for all the Record Types in that Record Group) 

The two RBAC codes support the needs of different roles. For example, many clerical roles may only need to view pointers whereas most clinical roles will need to view pointers and retrieve records. This model of access is illustrated in the following diagram, with each box representing a separate RBAC code. 

<img alt="Three Record Groups, each of which contains one RBAC code for pointer-only access and another for pointer-and-record access" src="images/authorisation/record_group_diagram.png" style="width:65%;max-width: 100%;margin: 0 auto;display: block;">

A user may have access to one or more Record Groups depending on the information needs of their role. Please note that there is currently only one Record Group, but this is expected to change as more Record Types are added to the NRL. To work out which RBAC codes should be applied to a user, refer to the RBAC Mapping Table in the following section. A user should have only one RBAC code for each Record Group assigned to them by their Trust’s RA Manager.

## RBAC Mapping Table

This table outlines how records are allocated to different RBAC codes and whether an RBAC code provides **pointer-only access** or **pointer and record access**. The exact RBAC codes will be provided to an organisation once they complete the onboarding process.

<table>
    <thead>
        <tr>
            <th>Record Group</th>
            <th>Record Types Contained</th>
            <th>Access Level</th>
            <th>RBAC Code</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td rowspan="2">Record Group 1</td>
            <td rowspan="2">Mental health crisis plan</td>
            <td>Pointer-only access</td>
            <td>Bxxxx</td>
        </tr>
        <tr>
            <td>Pointer and record access</td>
            <td>Bxxxy</td>
        </tr>
  </tbody>
</table>

The RBAC codes listed in this mapping table are limited by the number of {% include gloss.html text="Record Types" term="Record Type" %} currently available on the NRL. As additional Record Types are added to the NRL, the associated RBAC codes will be added to this table.

The {% include gloss.html term="Record Group" %} that a Record Type fits into depends on its sensitivity. Record group 1 is a general grouping, to contain the majority of Record Types that are not deemed to be sensitive. Further Record Groups will be added if additional Record Types are deemed to need more restrictive controls. Using additional Record Groups for such Record Types ensures that they are protected by further access controls and will not routinely be available to the majority of NRL users. 
