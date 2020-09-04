---
title: Access Controls
keywords: RBAC authorisation documentreference
tags: [security,authorisation,spine_secure_proxy]
sidebar: accessrecord_rest_sidebar
permalink: access_controls.html
summary: Overview of NRL access controls.
---

The NRL and SSP are subject to various technical access controls and restrictions, as outlined on the [security](security_guidance.html) page. These controls protect information flowing between the client and server. However, this transport-layer security does not address authentication and authorisation of the users consuming the shared information.

Consumers are required to ensure an appropriate level of authentication and authorisation is applied, within their systems, when giving users access to information received via Spine services.

# Healthcare Professional Access

Where the consuming system is making a request on behalf of a healthcare professional, the system **MUST** have authenticated the user using:

- NHS Identity
- National Smartcard Authentication
- Equivalent level-3 Authentication

The user details, including user ID and associated [Role Based Access Controls](https://developer.nhs.uk/apis/spine-core/security_rbac.html) (RBAC) role, **MUST** be included in the JWT as specified on the [JSON Web Token Guidance](jwt_guidance.html) page.

Consumers **MUST** apply appropriate RBAC governance to manage access to different types of pointers and retrieved information.

# Citizen Access

Where the consuming system is making a request for information on behalf of a citizen, the system **MUST** have authenticated the citizen to the [DCB3051 Identity Verification and Authentication Standard for Digital Health and Care Services](https://digital.nhs.uk/data-and-information/information-standards/information-standards-and-data-collections-including-extractions/publications-and-notifications/standards-and-collections/dcb3051-identity-verification-and-authentication-standard-for-digital-health-and-care-services).

The user details **MUST** be included in the JWT as specified on the [JSON Web Token Guidance](jwt_guidance.html) page.

## NHS Login

[NHS login](https://www.nhs.uk/using-the-nhs/nhs-services/nhs-login/) verifies citizens' identities and authenticates them to the required standard to use the NRL and SSP services.

## Types of Citizen Access

There are a number of different scenarios in which citizens may require access to information. For each of these scenarios there are a number of information governance requirements that must be met, as outlined in the sections below.

### Citizens accessing their own data

The following requirements **MUST** be met when giving a citizen access to their own data:

<table>
  <tr>
    <th style="width:35%">Requirement</th>
    <th>Acceptance Criteria</th>
  </tr>
  <tr>
    <td>Citizens need to be able to see their own data to be fully informed and to check that data held about them is correct.</td>
    <td>
      <ul>
        <li>Citizen <b>MUST</b> be able to log on using NHS login (or equivalent).</li>
        <li>Citizen <b>MUST</b> be able to see their own medical records that have been approved for sharing.</li>
        <li>Citizen <b>MUST NOT</b> be able to see their own medical records that have not been approved for sharing.</li>
        <li>Citizen <b>MUST NOT</b> be able to see another person's data.</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>A system/process <b>MUST</b> be in place for a patient to get errors in their record corrected.</td>
    <td>
      <ul>
        <li>Citizen <b>MUST</b> be able to report an error in their data.</li>
        <li>The relevant Data Controller <b>MUST</b> be able to amend the citizen's data.</li>
        <li>Citizen <b>MUST</b> be able to see their data has been corrected.</li>
        <li>If the data doesn't change, the citizen <b>MUST</b> be able to have a note added to the record, stating they disagree.</li>
        <li>An audit of data changes <b>MUST</b> be maintained by the relevant Data Controller(s).</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>Citizens needs to know who has accessed their data.</td>
    <td>
      <ul>
        <li>Citizen <b>MUST</b> be able to request to know who has accessed their data.</li>
        <li>The relevant Data Controller(s) <b>MUST</b> maintain an audit of each time a citizen's data is accessed, recording who accessed the data and when, and which parts of the record were accessed.</li>
        <li>On request the Data Owner <b>MUST</b> provide a report to the citizen of who has accessed their data, when they accessed it, and which parts of the record were accessed.</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>The relevant Data Controller(s) need(s) to be able to hide third-party information from the patient when that information is not known to them.</td>
    <td>
      <ul>
        <li>The relevant Data Controller(s) <b>MUST</b> be able to identify data which contains third-party information.</li>
        <li>The relevant Data Controller(s) <b>MUST</b> have the ability to withhold the third-party information from the citizen.</li>
        <li>When a citizen accesses their data, third-party information <b>MUST NOT</b> be displayed if the Data Owner has chosen to withhold it.</li>
      </ul>
    </td>
  </tr>
</table>

### Delegated access

The following requirements **MUST** be met in a use case where a citizen grants access to their data to another citizen:

<table>
  <tr>
    <th style="width:35%">Requirement</th>
    <th>Acceptance Criteria</th>
  </tr>
  <tr>
    <td>Delegated data access <b>MUST</b> be consented to and confirmed by the individual.</td>
    <td>
      <ul>
        <li>Citizen <b>MUST</b> be able to grant access to another person or persons (the delegate), to view all, or part of their data.</li>
        <li>Delegate <b>MUST</b> be able to log on using NHS login (or equivalent).</li>
        <li>Delegate <b>MUST</b> be able to view the citizen's data they've been granted access to.</li>
        <li>Delegate <b>MUST NOT</b> be able to view the citizen's data they've not been granted access to.</li>
        <li>Delegate <b>MUST NOT</b> be able to view data for anyone they've not been granted access to.</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>The relevant Data Controller needs to establish that consent has been freely given (e.g. witnessed by an appropriated registered professional).</td>
    <td>
      <ul>
        <li>Clinician <b>MUST</b> be satisfied that consent has been freely given for a delegate to view a citizen's data.</li>
        <li>Clinician <b>MUST</b> be able to record that they are satisfied that consent was freely given, and their name and professional capacity should be recorded.</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>Citizens needs to be able to easily see what data was accessed and when by their delegate.</td>
    <td>
      <ul>
        <li>Citizen <b>MUST</b> be able to request who has accessed their data, when the data was accessed, and which parts of the data where accessed.</li>
        <li>The relevant Data Controller <b>MUST</b> maintain an audit every time the citizen's data is accessed by a delegate.</li>
        <li>On request, the relevant Data Controller <b>MUST</b> provide a report to the citizen of who has accessed the data, when they accessed it, and which parts of the record were accessed.</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>Citizens needs to be able to revoke a delegate's access quickly and easily.</td>
    <td>
      <ul>
        <li>Citizen <b>MUST</b> be able to revoke a delegate's access to their data.</li>
        <li>Subsequently, when that delegate attempts to access the citizen's data, access <b>MUST</b> be denied.</li>
        <li>The Data Owner <b>MUST</b> record that the delegate's access has been revoked.</li>
        <li>Any other delegates for the same citizen (whose access has not been revoked), <b>MUST</b> still be able to access the citizen's data.</li>
      </ul>
    </td>
  </tr>
</table>

### Legal responsibility

The following requirements **MUST** be met when a citizen gives access to another citizen's data, where they have a leagal responsibility for that citizen:

<table>
  <tr>
    <th style="width:35%">Requirement</th>
    <th>Acceptance Criteria</th>
  </tr>
  <tr>
    <td>A person can register for access to another citizen's medical record as a delegate, where they have the legal power to do so. Legal power can be proven either by Power of Attorney, or Welfare Deputy (the [Court of Protection](https://www.gov.uk/courts-tribunals/court-of-protection) can prove this).</td>
    <td>
      <ul>
        <li>Clinician <b>MUST</b> be able to record that the person registering for access has the correct legal power.</li>
        <li>The relevant Data Controller <b>MUST</b> maintain an audit every time the citizen's data is accessed by a delegate.</li>
        <li>On request, the relevant Data Controller <b>MUST</b> provide a report to the citizen (assuming the citizen has the mental capacity) of who has accessed the data, when they accessed it, and which parts of the record were accessed.</li>
      </ul>
    </td>
  </tr>
</table>

### Parental access

The following requirements **MUST** be met when a citizen is given access to another citizen's data, where they have parental responsibility for that citizen:

<table>
  <tr>
    <th style="width:35%">Requirement</th>
    <th>Acceptance Criteria</th>
  </tr>
  <tr>
    <td>There <b>MUST</b> be a process for recording and verifying who a "Legal Parent" is. This may be a natural parent, but for a "Looked After Child", it may be the Local Authority who may delegate to a professional carer or relative.</td>
    <td>
      <ul>
        <li>Clinician <b>MUST</b> be able to record who a child's "Legal Parent" is, and the source of and/or reason for the decision (e.g. Social Services).</li>
        <li>Clinician <b>MUST</b> be able to amend who a Child's "Legal Parent" is, and the source of and/or reason for the change (e.g. Social Services).</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>There <b>MUST</b> be a process for recording and maintaining who has parental rights e.g. in the case of separated parents it could be both, but might just be the principal carer.</td>
    <td>
      <ul>
        <li>Clinician <b>MUST</b> be able to record who has parental access and the source of and/or reason for the decision.</li>
        <li>Clinician <b>MUST</b> be able to amend who has parental access and the source of and/or reason for the change.</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>Children 16 or over, who are deemed competent, <b>MUST</b> be able to block parental access quickly if they choose to.</td>
    <td>
      <ul>
        <li>Child <b>MUST</b> be able to revoke a parent's access to their data.</li>
        <li>Subsequently, when that parent attempts to access the child's data, access <b>MUST</b> be denied.</li>
        <li>The Data Owner <b>MUST</b> record that the parent's access has been revoked.</li>
        <li>If the child has another parent delegate (whose access has not been revoked), they <b>MUST</b> still be able to access the child's data.</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>Children under the age of 16 <b>MUST</b> be able to restrict access to some or all of their record, in consultation with a clinician.</td>
    <td>
      <ul>
        <li>Clinician <b>MUST</b> be able to mark part of a child's record as restricted.</li>
        <li>When a parent accesses the child's record, the restricted part of the record <b>MUST NOT</b> be displayed.</li>
        <li>If the child has access to their own record, they <b>MUST</b> be able to access their whole record, including records previously restricted by their parent(s).</li>
      </ul>
    </td>
  </tr>
</table>

### Child accessing their own record

The following requirements **MUST** be met when giving a child access to their own data:

<table>
  <tr>
    <th style="width:35%">Requirement</th>
    <th>Acceptance Criteria</th>
  </tr>
  <tr>
    <td>Children aged 16 or over should have access to their own medical record, as if they were an adult, unless there is a clear legal basis against it (e.g. child lacks mental capacity).</td>
    <td>
      <ul>
        <li>Child <b>MUST</b> to be able to log on using NHS login (or equivalent).</li>
        <li>Child <b>MUST</b> be able to see their own data.</li>
        <li>Child <b>MUST NOT</b> be able to see anyone else's data.</li>
        <li>Where there is a clear legal basis against it, the Child <b>MUST NOT</b> be able to see their own data.</li>
        <li>Where access is denied, the person who made the decision, the reason, and the date the decision was made should be recorded.</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>Access for children under 16 should only be with consent from the "Legal Parent" and lead clinician.</td>
    <td>
      <ul>
        <li>Clinician <b>MUST</b> be able to record that the child has consent of their "Legal Parent".</li>
        <li>Child <b>MUST</b> to be able to log on using NHS login (or equivalent).</li>
        <li>Child <b>MUST</b> be able to see their own data if they have consent of their "Legal Parent".</li>
        <li>The "Legal Parent" <b>MUST</b> be able to restrict part of the record from the child.</li>
        <li>Child <b>MUST NOT</b> be able to see their own data if they do not have consent of their "Legal Parent".</li>
        <li>Child <b>MUST NOT</b> be able to see anyone else's data.</li>
        <li>Where there is a clear legal basis against it, the Child <b>MUST NOT</b> be able to see their data, and the person who made the decision, the reason, and the date the decision was made should be recorded.</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>Access for children under 13 should be flagged up with the Data Controller.</td>
    <td>
      <ul>
        <li>Clinician should be able to grant access to children under 13 to access their own data.</li>
        <li>Data Owner should record when access is granted to a child under 13, and by whom.</li>
        <li>Data Controller should be alerted when a child under 13 is granted access to their data.</li>
      </ul>
    </td>
  </tr>
</table>
