---
title: Assure Overview
keywords: assure, accredit
tags: [overview]
sidebar: foundations_sidebar
permalink: assure.html
summary: "These pages assist with the NRLS Service Assurance Process"
---


<!--{% include custom/under.construction.html content="Please check back later for any updates to this page." %}-->

### Solution Assurance Process Overview ###

1.	The Programme Team will provide Suppliers with the necessary information and materials to enable them to determine the feasibility of developing a technical product. This can be done with a combination of face to face and WebEx.

2.	Supplier completes a Usage and Settings document to get Programme approval for usage and settings of the NRLS. 
	
	*Note*: The Usage and Settings document is not needed for the pilot.
 
3. The <a href="mailto:itkconformance@nhs.net">Solution Assurance team</a> will work with the supplier through development and assurance to provide assistance with technical support and test and assurance queries and conduct the review of Supplier submissions.

4. Supplier should carry out initial development against [TKW testbench](https://hscic365-my.sharepoint.com/:u:/g/personal/chbe53_log1_hscic_gov_uk/EdO79_cHfj5LqEOJv7o-zj4B9tTK8T6PBnOEN88e19_Edw?e=xeKfqj).

5.	Further testing can be done in test environments OpenTest or DEV. The environments will be populated with test data which will support all test cases detailed within the TOM.  Suppliers will be able to carry out their own initial testing in these environments.

6.	Further data can be added to test environments by suppliers using a self-service portal.

7.	Solution Assurance will provide access to the test environments.

8.	Whilst connected to the INT test environment, the Supplier will be expected to execute the System Test cases provided by NHS Digital within the TOM. The linked evidence of screenshots and message logs from these tests will be captured within the TOM and provided to NHS Digital for validation. The Functional Integration Tests against a PTL environment (specifically INT) provides risk mitigation against the live service deployment.

9.	Some negative Functional Tests which form part of the assurance will be performed against TKW testbench. 

10.	On successful completion of testing, Solution Assurance will provide a Conformance Certificate, and the TOM is updated to reflect this status.

11.	In parallel the non-test related TOM tabs will be completed by the supplier.

12.	Any open defects relating to the test are shared with NHS Digital stakeholders for 
agreement regarding a work off plan. Work off plan items may need to be resolved prior to Go Live/Post Pilot.

13.	The supplier is now ready for a live deployment, which will be managed by the NHS Digital Operations and Service Management team. This will involve the end user organisation completing their sections of the TOM and providing sign-off to NHS Digital. Note: there may be some additional Solution Assurance Clinical Safety group involvement at this stage, should the TOM assessment flag their sign-off as being required. The same applies to the IG assessment, which may also flag NHS Digital sign-off required.



<!--
The Assure section contains descriptions of approaches and suggestions for building APIs at the Assure stage.

Any API developed must go through an solution assurance process which will assure the API meets the highest level of quality, is clinically safe for use and provides the necessary security features to keep organisations safe. This can be achieved through the test phase of development that may include the use of test services, involving the wider healthcare community and enabling end to end testing through tooling and test environments.

Additional details on how an API can be assured will be provided in due course.
-->


<!--
The Assure section contains descriptions of approaches and suggestions for building APIs at the Assure stage.

| Page              |  Description    |
|+---------------------|+--------------------------------+|
| Access | The access mechanism and of requesting system is influenced by many factors. This section demonstrates the design decisions to consider | 
| Security | The security of the FHIR payload, access and data at rest are all important design decisions while building an API.  | 
| End to end | The end to end assurance necessary to deliver an assured API.  | 

Please support the wider health and care community efforts of providing a completely defined API service.


# Providing an API #

The following diagram explains the elements of APIs allowing the development of APIs:

{% include custom/provide_api.svg %}

NHS Digital is contributing to progressing the profile development (see Overview section). Invitations are open to the health and care community to get involved and progress the wider developer ecosystem as defined above. 


# Contribute #

This site is structured around API users, developers and architects. Please get involved in the journey.

{% include custom/api_overview.svg %}

{% include custom/contribute.html content="If you want to get involved in any part of this then please get in touch with interoperabilityteam@nhs.net "%}
-->