ValueSet: ConsentVerificationVS
Id: consent-verification-vs
Title: "Consent Verification ValueSet"
Description: "Types of consent verification status in Uzbekistan"
* ^url = "http://terminology.hl7.org/CodeSystem/consentverification"
* ^experimental = true
* ^extension[0].url = $valueset-supplement
* ^extension[=].valueCanonical = Canonical(ConsentVerificationCS)

* include codes from system $consent-verification