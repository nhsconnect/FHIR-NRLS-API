---
title: Product Versioning
keywords: development, versioning
tags: [development]
sidebar: overview_sidebar
permalink: overview_guide_versioning.html
summary: An overview of how implementation Guides (and other technical assets) are versioned.
---

## Product Versioning ##

Versioning of each technical "Product" or asset (i.e. API Implementation Guide, Design Principle(s), Data Library, FHIR profiles) is managed using [Semantic Versioning 2.0.0](http://semver.org/){:target="_blank"}.

### Semantic Versioning ###

Given a version number MAJOR.MINOR.PATCH, increment the:

- MAJOR version when you make incompatible API changes,
- MINOR version when you add functionality in a backwards-compatible manner, and
- PATCH version when you make backwards-compatible bug fixes.

Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

A pre-release version MAY be denoted by appending a hyphen (refer to [Semantic Versioning - Item 9](http://semver.org/#spec-item-9){:target="_blank"})

For examples: 1.0.0-alpha.1 is a valid pre-release version.


### Pre-release Labels ###

When FHIR API implementation guides are published, they MUST have an associated maturity label. These labels are based on the GDS development process stages and MUST conform to one of the labels defined in the [FHIR-PUB-04: FHIR API Maturity](https://nhsconnect.github.io/fhir-policy/publication.html) 'Publication Requirements' section of the [NHS FHIR Policy](https://nhsconnect.github.io/fhir-policy/index.html).

<!--
<p>These labels will be taken from the GDS development process stages, and will be one of:</p>

<ul>
  <li><strong>Experimental</strong>: Early development/proof of concept version of an API for early sight during discovery.</li>
  <li><strong>Alpha</strong>: Initial test APIs, likely to change substantially.
    <ul>
      <li><em>Typical Usage</em>: Engagement with others interested in being involved with early development work and influencing the direction taken.</li>
    </ul>
  </li>
  <li><strong>Beta</strong>: APIs that are still under active development and subject to change.
    <ul>
      <li><em>Typical Usage</em>: Engagement with ‘first of type’ or early adopters by the creation of first of type or pilot systems for testing, proof of concept etc. This development can assist in progression to a release candidate for a wider rollout.</li>
    </ul>
  </li>
  <li><strong>Release Candidate</strong>: APIs that are largely complete, unlikely to change substantially, but still need further testing by a wider group of implementers before becoming live.
    <ul>
      <li><em>Typical Usage</em>: After having been previously implemented by ‘first of type’ or pilot sites and now to be rolled out to a wider group of implementers.</li>
    </ul>
  </li>
  <li><strong>Live</strong>: Release live APIs.</li>
  <li><strong>Discontinued</strong>: APIs which have been discontinued and should not be used for new development.</li>
</ul>


The following pre-release labels will be used across all products:

| Pre-release Label | Lifecycle | Description |
|-------------------|-----------|-------------|
| `alpha` | &nbsp; | Complete enough for internal testing. |
| `beta` | early | Complete enough for external testing. |
| `beta` | late | Complete enough for external testing. Usually feature complete. |
| `rc` | &nbsp; | Almost ready for final release. No new feature enhancements. |

> rc = Release Candidate. 

### Maturity Levels ###

{% include todo.html content="The following table is published as a **work in progress** version and as such is subject to change and extension." %}

Taking a similar approach to the [FHIR Maturity Model](http://wiki.hl7.org/index.php?title=FHIR_Maturity_Model){:target="_blank"} NRLS will only freeze / master a technical specification once it has been independently implemented in at least three commercial systems and demonstrated to interoperate.

| Level | Version | Description | 
|-------|---------|-------------| 
| 1 | `X.Y.Z-alpha.n` | Alpha; rapid interations, fail fast, exploration, proof of concepts, approach flexible. | Draft may not have been implemented at all but has been published. |
| 2 | `X.Y.Z-beta.n` | Early Beta; rapid iterations, community engaged, scope flexible, high-level approach agreed in principle. | Draft partially implemented in one or more prototype systems. |
| 3 | `X.Y.Z-beta.n` | Late Beta; slower iterations, community engaged, scope largely agreed, high-level approach fixed. | Draft partially implemented two or more commercial systems. |
| 4 | `X.Y.Z-rc.n` | Release Candidate; slower iterations, community engaged, scope fixed, detailed approach fixed, no new features, bug fixes and amendments for clinical safety & IG only. | Draft implemented in at least two commercial systems. |
| 5 | `X.Y.Z` | Stable; release version. | Draft implemented in at least three commercial systems with full accreditation and assurance mechanisms in place. |
-->

