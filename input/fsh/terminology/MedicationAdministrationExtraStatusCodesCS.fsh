CodeSystem: MedicationAdministrationExtraStatusCodesCS
Id: medication-administration-extra-status-codes-cs
Title: "Medication Administration Extra Status Codes CS"
Description: "Local code system for supplementary medication administration status codes not present in the FHIR core medication-admin-status value set."

* insert OriginalCodeSystemDraft(medication-administration-extra-status-codes-cs)

* #status-0001-00001
  * ^designation[0].language = #uz
  * ^designation[=].value = "Rejelashtirildi"
  * ^designation[+].language = #ru
  * ^designation[=].value = "Запланировано"
  * ^designation[+].language = #en
  * ^designation[=].value = "Planned"