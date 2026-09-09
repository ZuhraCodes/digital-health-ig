ValueSet: MedicationAdministrationPerformerFunctionCodesVS
Id: medication-administration-performer-function-codes-vs
Title: "Medication Administration Performer Function VS"
Description: "VS"
* ^url = "http://terminology.hl7.org/ValueSet/med-admin-perform-function"

* ^experimental = true
* ^extension[0].url = $valueset-supplement
* ^extension[=].valueCanonical = Canonical(MedicationAdministrationPerformerFunctionCodesCS)
* include codes from system $medication-administration-performer-function-codes