---
title: Pointer Types
keywords: structured rest documentreference
tags: [fhir,pointers,record_retrieval]
sidebar: accessrecord_rest_sidebar
permalink: supported_pointer_types.html
summary: NRL supported pointer types.
---

The following table outlines the currently supported NRL information categories and types; this list will be updated as other information types become supported by the NRL. The codes for each information category and type can be found in the relevant value sets detailed on the [Pointer FHIR Resource](pointer_fhir_resource.html) page.

The table outlines each `Retrieval Format` supported for each pointer type. Details about the retrieval formats can be found on the [information retrieval overview](information_retrieval_overview.html) page.

<table style="width:100%;">
    <tr>
        <th><a href="pointer_fhir_resource.html#information-category">Information Category</a></th>
        <th><a href="pointer_fhir_resource.html#information-type">Information Type</a></th>
        <th><a href="pointer_fhir_resource.html#retrieval-format">Retrieval Format(s)</a></th>
	</tr>
    <tr>
        <td rowspan="3">
			<a href="https://fhir.nhs.uk/STU3/ValueSet/NRL-RecordClass-1">Care plan</a>
			<br/>(734163000)
		</td>
        <td>
			<a href="https://fhir.nhs.uk/STU3/ValueSet/NRL-RecordType-1">End of life care coordination summary</a>
			<br/>(861421000000109)</td>
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
        <td>
			<a href="https://fhir.nhs.uk/STU3/ValueSet/NRL-RecordType-1">Mental health crisis plan</a>
			<br/>(736253002)
		</td>
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
        <td>
			<a href="https://fhir.nhs.uk/STU3/ValueSet/NRL-RecordType-1">Emergency health care plan</a>
			<br/>(887701000000100)
		</td>
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
        <td rowspan="1">
			<a href="https://fhir.nhs.uk/STU3/ValueSet/NRL-RecordClass-1">Record headings</a>
			<br/>(716931000000107)
		</td>
        <td>
			<a href="https://fhir.nhs.uk/STU3/ValueSet/NRL-RecordType-1">Immunisations</a>
			<br/>(1102181000000102)
		</td>
        <td>
            <ul>
				<li>
                    <a href="retrieval_careconnect_immunizations_fhir_stu3.html">"CareConnect Immunizations FHIR STU3"</a>
                </li>
            </ul>
        </td>
    </tr>
	<tr>
		<td rowspan="1">Patient Record</td>
        <td>Healthcare Record</td>
        <td>
            <ul>
				<li>
                    <a href="retrieval_careconnect_fhir_stu3.html">"CareConnect FHIR STU3"</a>
                </li>
            </ul>
        </td>
    </tr>
</table>
