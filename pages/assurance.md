---
title: Assurance Overview
keywords: assure assurance accredit
tags: [assurance,for_providers,for_consumers]
sidebar: overview_sidebar
permalink: assurance.html
summary: Assistance for the NRL Service assurance process.
---

### Solution Assurance Process Overview

1. The Programme Team will provide suppliers with the necessary information and materials to enable them to determine the feasibility of developing a technical product. This can be done with a combination of face-to-face meetings and video-conference software. The NRL onboarding guide will be provided, detailing the full end-to-end process for integrating with the NRL. A copy can be obtained from the [NRL Service](https://digital.nhs.uk/services/national-record-locator-nrl) page.

2. The supplier completes a 'Usage and Settings' document to get programme approval for usage and settings of the NRL.

    {% include note.html content="The 'Usage and Settings' document is not needed for the pilot stage." %}

3. The [Solution Assurance](mailto:itkconformance@nhs.net) team will work with the supplier throughout development and assurance, providing assistance with technical support and test and assurance queries. They are also responsible for reviewing and certifying supplier submissions.

4. As part of this process, the supplier will need to complete a Supplier Conformance and Assessment List (SCAL). The SCAL should be completed by adding comments and referencing evidence where needed.

5. A baseline version of the SCAL can be downloaded from the onboarding guide. A copy of this can be obtained from the [NRL Service](https://digital.nhs.uk/services/national-record-locator-nrl) page. The SCAL will be customised for each supplier by the Solution Assurance team to reflect only the requirements and related tests that are in scope for the supplier product.

6. The supplier should carry out initial development against the [TKW testbench](https://developer.nhs.uk/testcentre/itk-nrls/).

7. Further testing can be done in the test environments OpenTest or DEV. These environments will be populated with test data which will support all test cases identified by the SCAL. Suppliers will be able to carry out their own initial testing in these environments.

8. Further data can be added to test environments by suppliers using a self-service portal.

9. Solution Assurance will provide access to the test environments.

10. While connected to the INT test environment, the supplier will be expected to execute the System Test cases provided by NHS Digital as identified within the SCAL. The linked evidence of screenshots and message logs from these tests must be captured and provided to NHS Digital for validation. The Functional Integration Tests against a PTL environment (specifically INT) provides risk mitigation against the live service deployment.

11. Some negative Functional Tests which form part of the assurance will be performed against the TKW testbench.

12. On successful completion of testing, Solution Assurance will provide a Conformance Certificate, and the SCAL will be updated to reflect this status.

13. In parallel, the non-test-related SCAL tabs will be completed by the supplier.

14. Any open defects relating to the test will be shared with NHS Digital stakeholders for agreement regarding a work off plan. Work off plan items may need to be resolved prior to Go Live/Post Pilot.

15. The supplier is now ready for a live deployment, which will be managed by the NHS Digital Operations and Service Management team. This will involve the end-user organisation signing the Data Sharing Arrangement (DSA), providing sign-off to NHS Digital.

    {% include note.html content="There may be some additional Clinical Safety group involvement at this stage, if the SCAL assessment flags their sign-off as being required. The same applies to the IG assessment, which may also flag NHS Digital sign-off required." %}
