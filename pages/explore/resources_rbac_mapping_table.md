---
title: Access Controls
keywords: RBAC authorisation documentreference
tags: [security,authorisation,spine_secure_proxy]
sidebar: accessrecord_rest_sidebar
permalink: explore_rbac_mapping.html
summary: "Overview of the access controls for NRL pointers"
---

## Overview

Access to NRL records is determined by Record Groups, where a Record Group contains one or more Record Types. Access to each Record Group is controlled by Role Based Access Control (RBAC) codes from the [National RBAC Database](https://developer.nhs.uk/apis/spine-core/security_rbac.html) and administered by an RA Managers within Trusts.  

For each Record Group there are two RBAC codes: 

1. The first RBAC code will allow a user to view pointers only (for all the Record Types in that Record Group) 

2. The second RBAC code will allow a user to view pointers and retrieve records (for all the Record Types in that Record Group) 

The two RBAC codes support the needs of different roles. For example, many clerical roles may only need to view pointers whereas most clinical roles will need to view pointers and retrieve records. This model of access is illustrated in the following diagram, with each box representing a separate RBAC code. 

<img alt="Three Record Groups, each of which contains one RBAC code for pointer-only access and another for pointer-and-record access" src="images/authorisation/record_group_diagram.png" style="width:65%;max-width: 100%;margin: 0 auto;display: block;">

A user may have access to one or more Record Groups depending on the information needs of their role. Please note that there is currently only one Record Group, but this is expected to change as more Record Types are added to the NRL. To work out which RBAC codes should be applied to a user, refer to the RBAC Mapping Table in the following section. A user should have only one RBAC code for each Record Group assigned to them by their Trust’s RA Manager.

## RBAC Mapping Table
This table outlines which records an RBAC code gives access to and whether it provides **pointer-only access** or **pointer and record access**.

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
            <td>B0268</td>
        </tr>
        <tr>
            <td>Pointer and record access</td>
            <td>B0269</td>
        </tr>
  </tbody>
</table>

The RBAC codes listed in this mapping table are limited by the number of {% include gloss.html text="Record Types" term="Record Type" %} currently available on the NRL. As additional Record Types are added to the NRL, the associated RBAC codes will be added to this table.

The {% include gloss.html term="Record Group" %} that a Record Type fits into depends on its sensitivity. Record group 1 is a general grouping, to contain the majority of Record Types that are not deemed to be sensitive. Further Record Groups will be added if additional Record Types are deemed to need more restrictive controls. Using additional Record Groups for such Record Types ensures that they are protected by further access controls and will not routinely be available to the majority of NRL users. 
