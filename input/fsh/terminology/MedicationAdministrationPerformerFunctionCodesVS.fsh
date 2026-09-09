ValueSet: MedicationAdministrationPerformerFunctionCodesVS
Id: medication-administration-performer-function-codes-vs
Title: "Medication Administration Performer Function VS"
Description: "VS"
* ^url = "https://terminology.dhp.uz/fhir/core/ValueSet/medication-administration-performer-function-codes"

* ^experimental = true
* ^extension[0].url = $valueset-supplement
* ^extension[=].valueCanonical = Canonical(MedicationAdministrationPerformerFunctionCodesCS)
* include codes from system $medication-administration-performer-function-codes