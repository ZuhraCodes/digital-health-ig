ValueSet: MedicationAdministrationLocationCodesVS
Id: medication-administration-location-codes-vs
Title: "Medication Administration Location Codes VS"
Description: "VS"
* ^url = "https://terminology.dhp.uz/fhir/core/ValueSet/medication-administration-location-codes"

* ^experimental = true
* ^extension[0].url = $valueset-supplement
* ^extension[=].valueCanonical = Canonical(MedicationRequestAdminLocationCS)
* include codes from system $medicationrequest-admin-location