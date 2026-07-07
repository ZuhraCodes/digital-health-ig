CodeSystem: AddressTypeCS
Id: address-type-cs
Title: "Address type translations"
Description: "Address type supplement with Uzbek and Russian translations"
* insert SupplementCodeSystemDraft(address-type-cs, $address-type, 5.0.0)
* #home
  * ^designation[0].language = #ru
  * ^designation[=].value = "Адрес прописки"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Ro'yxatdan o'tish manzili"
* #temp
  * ^designation[0].language = #ru
  * ^designation[=].value = "Адрес проживания"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Yashash manzili"
* #postal
  * ^designation[0].language = #ru
  * ^designation[=].value = "Почтовый адрес"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Pochta manzili"
* #physical
  * ^designation[0].language = #ru
  * ^designation[=].value = "Физический адрес"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Jismoniy manzil"
* #both
  * ^designation[0].language = #ru
  * ^designation[=].value = "Почтовый и физический адрес"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Pochta va jismoniy manzil"
