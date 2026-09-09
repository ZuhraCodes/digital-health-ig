CodeSystem: MedicationAdministrationPerformerFunctionCodesCS
Id: medication-administration-performer-function-codes-cs
Title: "Medication Administration Performer Function CS"
Description: "CS"

* insert SupplementCodeSystemDraft(medication-administration-performer-function-codes-cs, $medication-administration-performer-function-codes, 5.0.0)

* #performer
  * ^designation[0].language = #uz
  * ^designation[=].value = "Ijrochi"
  * ^designation[+].language = #ru
  * ^designation[=].value = "Исполнитель"

* #verifier
  * ^designation[0].language = #uz
  * ^designation[=].value = "Tekshiruvchi"
  * ^designation[+].language = #ru
  * ^designation[=].value = "Проверяющий"
  
* #witness
  * ^designation[0].language = #uz
  * ^designation[=].value = "Guvoh"
  * ^designation[+].language = #ru
  * ^designation[=].value = "Свидетель"