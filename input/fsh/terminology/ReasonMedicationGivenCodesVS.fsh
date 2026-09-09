ValueSet: ReasonMedicationGivenCodesVS
Id: reason-medication-given-codes-vs
Title: "Reason Medication Given VS"
Description: "VS with Uzbek and Russian translations"
* ^url = "https://terminology.dhp.uz/fhir/core/ValueSet/reason-medication-given-codes"

* ^experimental = true
* ^extension[0].url = $valueset-supplement
* ^extension[=].valueCanonical = Canonical(ReasonMedicationGivenCodesCS)
* include codes from system $reason-medication-given-codes