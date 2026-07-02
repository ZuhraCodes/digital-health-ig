CodeSystem: CVDTobaccoUseCs
Id: cvd-tobacco-use-cs
Title: "CVD Tobacco Use CodeSystem"
Description: "CVD Tobacco Use CodeSystemm with Uzbek and Russian translations"
* insert OriginalCodeSystemDraft(cvd-tobacco-use-cs)

* #not-use "Iste'mol qilmaydi"
  * ^designation[0].language = #en
  * ^designation[=].value = "Does not use"
  * ^designation[+].language = #ru
  * ^designation[=].value = "Не употребляет"

* #use "Iste'mol qiladi"
  * ^designation[0].language = #en
  * ^designation[=].value = "Uses"
  * ^designation[+].language = #ru
  * ^designation[=].value = "Употребляет"

* #quit "Tashlagan"
  * ^designation[0].language = #en
  * ^designation[=].value = "Quit"
  * ^designation[+].language = #ru
  * ^designation[=].value = "Бросил"