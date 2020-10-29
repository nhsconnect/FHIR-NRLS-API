---
title: Product Versioning
keywords: development versioning
tags: [development]
sidebar: overview_sidebar
permalink: overview_product_versioning.html
summary: An overview of how implementation guides (and other technical assets) are versioned.
---

## Product Versioning

Versioning of each technical "Product" or asset (i.e. API Implementation Guide, Design Principle(s), Data Library, FHIR profiles) is managed using [Semantic Versioning 2.0.0](https://semver.org/spec/v2.0.0.html).

### Semantic Versioning

Given a version number MAJOR.MINOR.PATCH, increment the:

- MAJOR version when you make incompatible API changes,
- MINOR version when you add functionality in a backwards-compatible manner, and
- PATCH version when you make backwards-compatible bug fixes.

Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

A pre-release version MAY be denoted by appending a hyphen (see [Semantic Versioning - Item 9](https://semver.org/spec/v2.0.0.html#spec-item-9)).

For example: 1.0.0-alpha.1 is a valid pre-release version.

### Pre-Release Labels

When FHIR API implementation guides are published, they MUST have an associated maturity label. These labels are based on the Government Digital Service (GDS) development process [phases](https://www.gov.uk/service-manual/agile-delivery) and MUST conform to one of the labels defined in the [FHIR-PUB-04: FHIR API Maturity](https://nhsconnect.github.io/fhir-policy/publication.html) 'Publication Requirements' section of the [NHS FHIR Policy](https://nhsconnect.github.io/fhir-policy/index.html).

<!-- TODO add more info -->
