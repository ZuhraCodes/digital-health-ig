ValueSet: MedicationAdministrationStatusCodesVS
Id: medication-administration-status-codes-vs
Title: "Medication Administration Status VS"
Description: "VS"
* ^url = "https://terminology.dhp.uz/fhir/core/ValueSet/medication-administration-status-codes"

* ^experimental = true
* ^extension[0].url = $valueset-supplement
* ^extension[=].valueCanonical = Canonical(MedicationAdministrationStatusCodesCS)
* include codes from system $medication-administration-status-codes