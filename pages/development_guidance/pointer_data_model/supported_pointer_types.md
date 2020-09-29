---
title: Pointer Types
keywords: structured rest documentreference
tags: [fhir,pointers,record_retrieval]
sidebar: accessrecord_rest_sidebar
permalink: supported_pointer_types.html
summary: NRL supported pointer types.
---

The following table outlines the currently supported NRL information categories and types; this list will be updated as other information types are supported by the NRL. The codes for each information category and type can be found in the relevant value sets detailed on the [FHIR Resource Mapping](fhir_resource_mapping.html) page.

The table outlines each `Retrieval Format` supported for each pointer type. Details about the retrieval formats can be found on the [Retrieval Overview](retrieval_overview.html) page.

<table style="width:100%;">
    <tr>
        <th><a href="fhir_resource_mapping.html#information-category">Information Category</a></th>
        <th><a href="fhir_resource_mapping.html#information-type">Information Type</a></th>
        <th><a href="fhir_resource_mapping.html#retrieval-format">Retrieval Format(s)</a></th>
	  </tr>
    <tr>
        <td rowspan="2">Care plan</td>
        <td>End of life care coordination summary</td>
        <td>
            <ul>
                <li>
                    <a href="retrieval_contact_details.html">"Contact Details"</a>
                </li>
                <li>
                    <a href="retrieval_unstructured_document.html">"Unstructured Document (PDF)"</a>
                </li>
            </ul>
        </td>
    </tr>
    <tr>
        <td>Mental health crisis plan</td>
        <td>
            <ul>
                <li>
                    <a href="retrieval_contact_details.html">"Contact Details"</a>
                </li>
                <li>
                    <a href="retrieval_unstructured_document.html">"Unstructured Document (PDF)"</a>
                </li>
            </ul>
        </td>
    </tr>
    <!--
    <tr>
        <td rowspan="3">Care record elements</td>
        <td>Allergies and adverse reactions</td>
        <td><a href="retrieval_allergies_fhir_stu3.html">"Allergy List - FHIR STU3 v1"</a></td>
    </tr>
    <tr>
        <td>Observations</td>
        <td><a href="retrieval_observations_fhir_stu3.html">"Observation List - FHIR STU3 v1"</a></td>
    </tr>
    <tr>
        <td>Immunisations</td>
        <td><a href="retrieval_vaccinations_fhir_stu3.html">"Vaccination List - FHIR STU3 v1"</a></td>
    </tr>
    -->
</table>