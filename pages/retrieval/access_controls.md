---
title: Access Controls
keywords: RBAC authorisation documentreference
tags: [security,authorisation,spine_secure_proxy]
sidebar: accessrecord_rest_sidebar
permalink: access_controls.html
summary: "Overview of access controls required when using NRL"
---

The NRL and SSP are subject to various technical access controls and restrictions, as outlined on the [security](development_api_security_guidance.html) page. These controls protect information flowing between the client and server. However, this transport-layer security does not address authentication and authorisation of the users consuming the shared information.

Consumers are required to ensure the appropriate level of authentication and authorisation are applied, in their systems, when giving users access to information received via Spine services.


# Healthcare Professional Access

Where the consuming system is making a request for healthcare professional access to information, the system **MUST** have authenticated the user using

- NHS Identity
- National Smartcard Authentication
- Equivalent level-3 Authentication

The user details, including user ID and associated RBAC role, **MUST** be included in the JWT as specified on the [JSON Web Token Guidance](jwt_guidance.html) page.

Consumers **MUST** apply appropriate RBAC control to manage access to different types of pointers and retrieved information.


# Citizen Access

Where the consuming system is making a request for citizen access to information, the system **MUST** have authenticated the citizen to the `DCB3051` Identity Verification and Authentication Standard for Digital Health and Care Services.

The user details **MUST** be included in the JWT as specified on the [JSON Web Token Guidance](jwt_guidance.html) page.

## NHS Login

NHS Login verifyies the citizens identity and authenticates them to the required standard to use the NRL and SSP services.


## Types of Citizen Access

There are a number of different scenarios in which citizens may require access to information. For each of these scenarios there are a number of information governance requirements that must be met, as outlined in the sections below.

### Citizen accessing their own data

The following requirements **MUST** be met when giving a citizen access to their own data.

<table>
	<tr>
		<th style="width:40%">Requirement</th>
		<th>Acceptance Criteria</th>
	</tr>
	<tr>
		<td>Citizens need to be able to see their own data to check it is correct</td>
		<td>
			<ul>
				<li>Citizen must to be able to log on using NHS login (or equivalent)</li>
				<li>Citizen must be able to see their own medical records that have been approved for sharing</li>
				<li>Citizen must be not be able to see their own medical records that have not been approved for sharing</li>
				<li>Citizen must not be able to see another person’s data</li>
			</ul>
		</td>
	</tr>
	<tr>
		<td>A system/process must be in place for a patient to get errors in their record corrected</td>
		<td>
			<ul>
				<li>Citizen must be able to report an error in their data</li>
				<li>Data Owner must be able to amend the Citizen’s data</li>
				<li>Citizen must be able to see that their data has been corrected</li>
				<li>An audit of the changes to the data is maintained by the Data Owner</li>
			</ul>
		</td>
	</tr>
	<tr>
		<td>Citizens needs to know who has accessed their data via NRL</td>
		<td>
			<ul>
				<li>Citizen must be able to request to know who has accessed their data</li>
				<li>Data Owner must maintain an audit of whenever the Citizen’s data is accessed, recording who has accessed the data, when they accessed it, and which parts of the record were accessed</li>
				<li>Data Owner must provide a report to the citizen of who has accessed the data, when they accessed it, and which parts of the record were accessed</li>
			</ul>
		</td>
	</tr>
	<tr>
		<td>Need to be able to hide third-party information from the patient when that information is not known to them</td>
		<td>
			<ul>
				<li>Data Owner must be able to identify data which contains third-party information</li>
				<li>Data Owner must have the ability to withhold the third-party information from the citizen</li>
				<li>When the Citizen accesses their data, third-party information should not be displayed if the data owner has chosen to withhold it</li>
			</ul>
		</td>
	</tr>
</table>


### Delegated access

The following requirements **MUST** be met in a use case where a citizen grants acces, to their data, by another citizen.

<table>
	<tr>
		<th style="width:40%">Requirement</th>
		<th>Acceptance Criteria</th>
	</tr>
	<tr>
		<td>Delegated data access must be consented to and confirmed by the individual</td>
		<td>
			<ul>
				<li>Citizen must be able to grant access to another person (or persons) to view their data (the delegate)</li>
				<li>Delegate must be able to log on using NHS login (or equivalent)</li>
				<li>Delegate must be able to view the Citizen’s data that they have been granted access to</li>
				<li>Delegate must not be able to view data for anyone that they have not been granted access to</li>
			</ul>
		</td>
	</tr>
	<tr>
		<td>Need to establish that consent has been freely given (e.g. witnessed by an appropriated registered professional)</td>
		<td>
			<ul>
				<li>Clinician must be satisfied that consent has been freely given for a delegate to view a Citizen’s data</li>
				<li>Clinician must be able to record that the are satisfied that consent was freely given</li>
			</ul>
		</td>
	</tr>
	<tr>
		<td> Citizens needs to be able to easily see what was accessed and when by their Delegate</td>
		<td>
			<ul>
				<li>Citizen must be able to request who has accessed their data, when the data was accessed, and which parts of the data where accessed</li>
				<li>Data Owner must maintain an audit every time the citizen’s data is accessed by a Delegate</li>
				<li>Data Owner must provide a report to the citizen of who has accessed the data, when they accessed it, and which parts of the record were accessed</li>
			</ul>
		</td>
	</tr>
	<tr>
		<td> Citizens needs to be able to revoke access quickly and easily</td>
		<td>
			<ul>
				<li>Citizen must be able to revoke access to a Delegate</li>
				<li>When Delegate tries to access the citizen’s data, access should be denied</li>
				<li>Data Owner must record that a Delegate’s access has been revoked</li>
				<li>If there are other Delegates, whose access has not been revoked, they must still be able to access the Citizen’s data</li>
			</ul>
		</td>
	</tr>
</table>


### Legal responsibility

The following requirements **MUST** be met when a citizen is given access to another citizens data, where they have a leagally responsible for that citizen.

<table>
	<tr>
		<th style="width:40%">Requirement</th>
		<th>Acceptance Criteria</th>
	</tr>
	<tr>
		<td>The person registering for access needs to prove they have the legal power – either Power of Attorney, or Welfare Deputy (court of protection can prove this)</td>
		<td>
			<ul>
				<li>Clinician must be able to record that the person registering for access has the correct legal power</li>
				<li>Data Owner must maintain an audit every time the Citizen’s data is accessed by a Delegate</li>
			</ul>
		</td>
	</tr>
</table>


### Parental access

The following requirements **MUST** be met when a citizen is given access to another citizens data, where they have parental responsibility for that citizen.

<table>
	<tr>
		<th style="width:40%">Requirement</th>
		<th>Acceptance Criteria</th>
	</tr>
	<tr>
		<td>There must be a process for recording and verifying who the “Legal Parent” is.  This may be the natural parent, but for a “Looked After Child”, it may be the Local Authority who may delegate to a professional carer or relative.</td>
		<td>
			<ul>
				<li>Clinician must be able to record who a Child’s “Legal Parent” is</li>
				<li>Clinician must be able to amend who a Child’s “Legal Parent” is</li>
			</ul>
		</td>
	</tr>
	<tr>
		<td>There must be a process for recording and maintaining who has parental rights – e.g. in the case of separated couple it could be both, but might just be the principal carer</td>
		<td>
			<ul>
				<li>Clinician must be able to record who has parental access</li>
				<li>Clinician must be able to amend who has parental access</li>
			</ul>
		</td>
	</tr>
	<tr>
		<td> Children 16 or over, who are deemed competent, must be able to block parental access quickly if they choose to</td>
		<td>
			<ul>
				<li>Child must be able to revoke access to a Parent</li>
				<li>When a Parent (whose access has been revoked) tries to access the child’s data, access should be denied</li>
				<li>Data Owner must record that a Parent’s access has been revoked</li>
				<li>If there is another Parent, whose access has not been revoked, they must still be able to access the Child’s data</li>
			</ul>
		</td>
	</tr>
	<tr>
		<td>Children under the age of 16 must be able to restrict access to some or all of their record, in consultation with a clinician</td>
		<td>
			<ul>
				<li>Clinician must be able to mark part of a Child’s record as restricted</li>
				<li>When a Parent accesses the Child’s record, the restricted part of the record should not be displayed</li>
				<li>If the Child has access to their own record, they should be able to access the whole record, including that which has been restricted from their Parent(s)</li>
			</ul>
		</td>
	</tr>
</table>


### Child accessing their own record

The following requirements **MUST** be met when giving a child access to their own data.

<table>
	<tr>
		<th style="width:40%">Requirement</th>
		<th>Acceptance Criteria</th>
	</tr>
	<tr>
		<td>Children aged 16 or over should have access to their own medical record, as if they were an adult, unless there is a clear legal basis against it (e.g. child lacks capacity)</td>
		<td>
			<ul>
				<li>Child must to be able to log on using NHS login (or equivalent)</li>
				<li>Child must be able to see their own data</li>
				<li>Child must not be able to see anyone else’s data</li>
				<li>Where there is a clear legal basis against it, the Child must not be able to see their data</li>
			</ul>
		</td>
	</tr>
	<tr>
		<td>Access for children under 16 should only be with consent from the “Legal Parent” and lead clinician</td>
		<td>
			<ul>
				<li>Clinician must be able to record that the Child has consent of their “Legal Parent”</li>
				<li>Child must to be able to log on using NHS login (or equivalent)</li>
				<li>Child must be able to see their own data if they have consent of their “Legal Parent”</li>
				<li>Child must not be able to see their own data if they do not have consent of their “Legal Parent”</li>
				<li>Child must not be able to see anyone else’s data</li>
				<li>Where there is a clear legal basis against it, the Child must not be able to see their data</li>
			</ul>
		</td>
	</tr>
	<tr>
		<td> Access for children under 13 should be flagged up with the data controller</td>
		<td>
			<ul>
				<li>Clinician should be able to grant access to Children under 13 to their own data</li>
				<li>Data Owner should record when access is granted to a child under 13, and by whom</li>
				<li>Data Controller should be alerted when a Child under 13 is granted access to their data</li>
			</ul>
		</td>
	</tr>
</table>

