ValueSet: MedicationAdministrationStatusCodesVS
Id: medication-administration-status-codes-vs
Title: "Medication Administration Status VS"
Description: "VS"
* ^url = "http://hl7.org/fhir/ValueSet/medication-admin-status"

* ^experimental = true
* ^extension[0].url = $valueset-supplement
* ^extension[=].valueCanonical = Canonical(MedicationAdministrationStatusCodesCS)
* include codes from system $medication-administration-status-codes