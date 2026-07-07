CodeSystem: ConsentVerificationCS
Id: consent-verification-cs
Title: "Consent Verification"
Description: "Consent verification and validation method codes"
* insert SupplementCodeSystemDraft(consent-verification-cs, $consent-verification, 5.0.0)

* #family "Oila/qarindosh tekshiruvi"
  * ^designation[0].language = #ru
  * ^designation[=].value = "Проверка семьей/родственником"
  * ^designation[+].language = #en
  * ^designation[=].value = "Verification by Family/RelatedPerson"

* #validation "Grant oluvchining qarorini davriy tekshirish"
  * ^designation[0].language = #ru
  * ^designation[=].value = "Периодическая перепроверка решения получателя гранта"
  * ^designation[+].language = #en
  * ^designation[=].value = "Periodic Re-validation of Grantee decision"