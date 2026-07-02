// This file contains only example instances to help enforce referential integrity within the profiles
// As soon as a profile for an instance is created, the instance should be removed from this file

Instance: example-patient
InstanceOf: Patient
Usage: #example
Title: "example-patient"
Description: "Example of a patient"
* name
  * family = "Ибрагимов"
  * given = "Алишер"

Instance: example-cbc-order
InstanceOf: ServiceRequest
Usage: #example
Description: "Example ServiceRequest for CBC (Umumiy qon tahlili) order"
* status = #active
* intent = #order
* code = observation-lab-research-codes-cs#lab-A "CBC panel"
* subject = Reference(Patient/example-salim)
* requester = Reference(Practitioner/example-practitioner)
* authoredOn = "2025-11-04T08:00:00Z"
* specimen[0] = Reference(Specimen/example-specimen-blood-cbc)

Instance: example-transaction-bundle
InstanceOf: Bundle
Usage: #example
Title: "Example Transaction Bundle"
Description: "Example transaction bundle that submits an episode of care, two encounters, and three observations in a single transaction"
* type = #transaction

* entry[0].fullUrl = "urn:uuid:a1b2c3d4-5678-90ab-cdef-111111111111"
* entry[=].resource = UZCoreEpisodeOfCare-Example
* entry[=].request.method = #POST
* entry[=].request.url = "EpisodeOfCare"

* entry[+].fullUrl = "urn:uuid:a1b2c3d4-5678-90ab-cdef-222222222222"
* entry[=].resource = example-encounter
* entry[=].request.method = #POST
* entry[=].request.url = "Encounter"

* entry[+].fullUrl = "urn:uuid:a1b2c3d4-5678-90ab-cdef-333333333333"
* entry[=].resource = blood-pressure-example
* entry[=].request.method = #POST
* entry[=].request.url = "Observation"

* entry[+].fullUrl = "urn:uuid:a1b2c3d4-5678-90ab-cdef-444444444444"
* entry[=].resource = body-weight-example
* entry[=].request.method = #POST
* entry[=].request.url = "Observation"

* entry[+].fullUrl = "urn:uuid:a1b2c3d4-5678-90ab-cdef-555555555555"
* entry[=].resource = body-temperature-example
* entry[=].request.method = #POST
* entry[=].request.url = "Observation"

Instance: example-transaction-response
InstanceOf: Bundle
Usage: #example
Title: "Example Transaction Response"
Description: "Example of a successful transaction response where all resources were created"
* type = #transaction-response

* entry[0].response.status = "201 Created"
* entry[=].response.location = "EpisodeOfCare/UZCoreEpisodeOfCare-Example/_history/1"
* entry[=].response.lastModified = "2026-02-24T10:00:00Z"

* entry[+].response.status = "201 Created"
* entry[=].response.location = "Encounter/example-encounter/_history/1"
* entry[=].response.lastModified = "2026-02-24T10:00:00Z"

* entry[+].response.status = "201 Created"
* entry[=].response.location = "Observation/blood-pressure-example/_history/1"
* entry[=].response.lastModified = "2026-02-24T10:00:00Z"

* entry[+].response.status = "201 Created"
* entry[=].response.location = "Observation/body-weight-example/_history/1"
* entry[=].response.lastModified = "2026-02-24T10:00:00Z"

* entry[+].response.status = "201 Created"
* entry[=].response.location = "Observation/body-temperature-example/_history/1"
* entry[=].response.lastModified = "2026-02-24T10:00:00Z"

Instance: example-transaction-response-error
InstanceOf: OperationOutcome
Usage: #example
Title: "Example Transaction Error"
Description: "Example OperationOutcome returned when a transaction fails due to a validation error"
* issue[0].severity = #error
* issue[=].code = #required
* issue[=].diagnostics = "Observation.status: minimum required = 1, but only found 0 (from https://dhp.uz/fhir/core/StructureDefinition/uz-core-observation)"
* issue[=].expression = "Bundle.entry[2].resource.ofType(Observation)"

// Temporary stand-in referenced by the Procedure example; should be fleshed out (or replaced with a proper profile-conforming instance) before publication
Instance: example-careplan
InstanceOf: CarePlan
Usage: #example
Title: "example-careplan"
Description: "Example of a careplan"
* status = #active
* intent = #plan
* subject = Reference(example-david)

// ============== Questionnaire Instance ==============

Instance: PatientSatisfactionQuestionnaire
InstanceOf: UZCoreQuestionnaire
Usage: #definition
Title: "Patient Satisfaction Survey"
Description: "Example patient satisfaction survey questionnaire (for Patient Portal)"
* url = "https://dhp.uz/fhir/core/Questionnaire/PatientSatisfactionQuestionnaire"
* name = "PatientSatisfactionQuestionnaire"
* language = #uz
* status = #active
* subjectType = #Patient
* title = "Bemor so'rovnomasi"
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Опросник удовлетворённости пациента"
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Patient Satisfaction Survey"
* description = "Bemor so'rovnomasi uchun savollar (Patient Portal uchun)"
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Вопросы для опросника пациента (для Patient Portal)"
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Patient satisfaction survey questions (for Patient Portal)"

// Question 1: How did you make an appointment?
* item[+]
  * linkId = "appointment-method"
  * text = "Qabulga qanday yozildingiz?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Как вы записались на приём?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "How did you make an appointment?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $patient-satisfaction-cs#remote "Masofadan yozildim («Портал Пациента» orqali)"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Дистанционно (через Портал Пациента)"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Remotely (via Patient Portal)"
  * answerOption[+].valueCoding = $patient-satisfaction-cs#in-person "Tibbiyot muassasasiga kelib yozildim"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "По приходу в мед.учреждение"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "In person at the medical facility"
  * answerOption[+].valueCoding = $patient-satisfaction-cs#phone "Telefon orqali yozildim"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "По телефону"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "By phone"
  * answerOption[+].valueCoding = $patient-satisfaction-cs#by-staff "Meni shifokor / hamshira yozdi"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Записал врач/мед.сестра"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Scheduled by doctor/nurse"
  * answerOption[+].valueCoding = $patient-satisfaction-cs#other "Boshqa"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Другое"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Other"
  * item[+]
    * linkId = "appointment-method-other"
    * text = "Boshqa (ko'rsating)"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #ru
        * extension[content].valueString = "Другое (укажите)"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #en
        * extension[content].valueString = "Other (please specify)"
    * type = #string

// Question 2: How long did you wait for your appointment?
* item[+]
  * linkId = "wait-time"
  * text = "Qabulni qancha vaqt kutdingiz?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Сколько времени вы ожидали приём?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "How long did you wait for your appointment?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $patient-satisfaction-cs#10-15min "10-15 daqiqa"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "10-15 минут"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "10-15 minutes"
  * answerOption[+].valueCoding = $patient-satisfaction-cs#20-30min "20-30 daqiqa"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "20-30 минут"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "20-30 minutes"
  * answerOption[+].valueCoding = $patient-satisfaction-cs#60min-plus "60 daqiqa yoki undan ortiq"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "60 минут и больше"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "60 minutes or more"

// Question 3: How satisfied are you with the doctor's competence?
* item[+]
  * linkId = "doctor-competence-satisfaction"
  * text = "Shifokorning malakasidan qanchalik mamnunsiz?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Насколько Вы удовлетворены компетентностью врача?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "How satisfied are you with the doctor's competence?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $patient-satisfaction-cs#fully-satisfied "To'liq mamnunman"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Полностью удовлетворен"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Fully satisfied"
  * answerOption[+].valueCoding = $patient-satisfaction-cs#rather-satisfied "Ko'proq mamnunman"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Скорее удовлетворен"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Rather satisfied"
  * answerOption[+].valueCoding = $patient-satisfaction-cs#rather-unsatisfied "Ko'proq mamnun emasman"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Скорее не удовлетворен"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Rather unsatisfied"
  * answerOption[+].valueCoding = $patient-satisfaction-cs#not-satisfied "Umuman mamnun emasman"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Совсем не удовлетворен"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Not satisfied at all"
  * answerOption[+].valueCoding = $patient-satisfaction-cs#other "Boshqa"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Другое"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Other"
  * item[+]
    * linkId = "doctor-competence-other"
    * text = "Boshqa (ko'rsating)"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #ru
        * extension[content].valueString = "Другое (укажите)"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #en
        * extension[content].valueString = "Other (please specify)"
    * type = #string

// Question 4: Was information about your health condition provided in full and in an understandable form?
* item[+]
  * linkId = "health-info-completeness"
  * text = "Sog'lig'ingiz holati haqida ma'lumot to'liq va tushunarli shaklda berildimi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Была ли предоставлена информация о Вашем состоянии здоровья в полном объёме и понятной форме?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Was information about your health condition provided in full and in an understandable form?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $patient-satisfaction-cs#yes-complete "Ha, to'liq"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да, полностью"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes, completely"
  * answerOption[+].valueCoding = $patient-satisfaction-cs#not-quite-complete "Unchalik to'liq emas"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Не совсем полностью"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Not quite completely"
  * answerOption[+].valueCoding = $patient-satisfaction-cs#only-partial "Faqat qisman"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Только частично"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Only partially"
  * answerOption[+].valueCoding = $patient-satisfaction-cs#no "Yo'q"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"
  * answerOption[+].valueCoding = $patient-satisfaction-cs#other "Boshqa"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Другое"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Other"
  * item[+]
    * linkId = "health-info-other"
    * text = "Boshqa (ko'rsating)"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #ru
        * extension[content].valueString = "Другое (укажите)"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #en
        * extension[content].valueString = "Other (please specify)"
    * type = #string

// Question 5: Did you get answers to all your questions?
* item[+]
  * linkId = "questions-answered"
  * text = "Sizni qiziqtirgan barcha savollarga javob oldingizmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Получили ли вы ответы на все интересующие вас вопросы?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Did you get answers to all your questions?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $patient-satisfaction-cs#yes-complete "Ha, to'liq"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да, полностью"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes, completely"
  * answerOption[+].valueCoding = $patient-satisfaction-cs#only-partial "Faqat qisman"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Только частично"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Only partially"
  * answerOption[+].valueCoding = $patient-satisfaction-cs#no-answers "Yo'q, javob olmadim"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет, не получил(а) ответы"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No, I didn't get answers"
  * answerOption[+].valueCoding = $patient-satisfaction-cs#other "Boshqa"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Другое"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Other"
  * item[+]
    * linkId = "questions-answered-other"
    * text = "Boshqa (ko'rsating)"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #ru
        * extension[content].valueString = "Другое (укажите)"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #en
        * extension[content].valueString = "Other (please specify)"
    * type = #string

// Question 6: Do you have any suggestions for improving the quality of service?
* item[+]
  * linkId = "improvement-suggestions"
  * text = "Xizmat ko'rsatish sifatini yaxshilash bo'yicha takliflaringiz bormi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Есть ли у Вас предложения по улучшению качества обслуживания?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Do you have any suggestions for improving the quality of service?"
  * type = #text
  * required = false


// ============== Example Instance ==============

Instance: example-patient-satisfaction-response
InstanceOf: UZCoreQuestionnaireResponse
Usage: #example
Title: "Пример ответа на опросник удовлетворённости"
Description: "Пример заполненного опросника удовлетворённости пациента"
* questionnaire = Canonical(PatientSatisfactionQuestionnaire)
* status = #completed
* subject = Reference(example-salim)
* authored = "2025-01-15T14:30:00+05:00"
* language = #ru

// Answer 1: Как вы записались на приём?
* item[+]
  * linkId = "appointment-method"
  * answer[+].valueCoding = $patient-satisfaction-cs#remote "Дистанционно (через Портал Пациента)"

// Answer 2: Сколько времени вы ожидали приём?
* item[+]
  * linkId = "wait-time"
  * answer[+].valueCoding = $patient-satisfaction-cs#10-15min "10-15 минут"

// Answer 3: Насколько Вы удовлетворены компетентностью врача?
* item[+]
  * linkId = "doctor-competence-satisfaction"
  * answer[+].valueCoding = $patient-satisfaction-cs#fully-satisfied "Полностью удовлетворен"

// Answer 4: Была ли предоставлена информация о Вашем состоянии здоровья?
* item[+]
  * linkId = "health-info-completeness"
  * answer[+].valueCoding = $patient-satisfaction-cs#yes-complete "Да, полностью"

// Answer 5: Получили ли вы ответы на все интересующие вас вопросы?
* item[+]
  * linkId = "questions-answered"
  * answer[+].valueCoding = $patient-satisfaction-cs#yes-complete "Да, полностью"

// Answer 6: Есть ли у Вас предложения по улучшению качества обслуживания?
* item[+]
  * linkId = "improvement-suggestions"
  * answer[+].valueString = "Было бы удобно иметь возможность получать напоминания о приёме через SMS."


Instance: FertilityQuestionnaire
InstanceOf: UZCoreQuestionnaire
Usage: #definition
Title: "Fertility Questionnaire Survey"
Description: "Example Questionnaire for fertility history collection"
* url = "https://dhp.uz/fhir/core/Questionnaire/FertilityQuestionnaire"
* name = "FertilityQuestionnaire"
* language = #uz
* status = #active
* subjectType = #Patient
* title = "Fertillik bo‘yicha so‘rovnoma" 
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Опросник по фертильности"
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Fertility Questionnaire"
* description = "Fertillik anamnezini yig‘ish uchun so‘rovnoma"
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Опросник для сбора анамнеза по менструации, беременности, перинатальным потерям, контрацепции и бесплодию"
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Questionnaire for fertility history collection"

* item[+]
  * linkId = "menstruation"
  * text = "Hayz ko'rish"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Менструация"
  * type = #group

// Question 1: Menstruation
  * item[+]
    * linkId = "menstruation-present"
    * text = "Hayz ko‘rish"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #ru
        * extension[content].valueString = "Менструация"
    * type = #coding
    * required = true
    * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Да"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Yes"
    
    * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Нет"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "No"

  * item[+]
    * linkId = "menstruation-age-start"
    * text = "Hayz necha yoshdan boshlangan"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #ru
        * extension[content].valueString = "Менструации с какого возраста"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #en
        * extension[content].valueString = "Menstruation from what age"
    * type = #integer

* item[+]
  * linkId = "pregnancy"
  * text = "Homiladorlik"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Беременность"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Pregnancy"
  * type = #group

  * item[+]
    * linkId = "pregnancy-total-count"
    * text = "Homiladorliklarning umumiy soni"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #ru
        * extension[content].valueString = "Общее количество беременностей"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #en
        * extension[content].valueString = "Total number of pregnancies"
    * type = #integer

  * item[+]
    * linkId = "birth-total-count"
    * text = "Tug‘ruqlarning umumiy soni"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #ru
        * extension[content].valueString = "Общее количество родов"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #en
        * extension[content].valueString = "Total number of births"
    * type = #integer

  * item[+]
    * linkId = "children-count"
    * text = "Farzandlar soni"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #ru
        * extension[content].valueString = "Количество детей"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #en
        * extension[content].valueString = "Number of children"
    * type = #integer

* item[+]
  * linkId = "perinatal-losses"
  * text = "Perinatal yo‘qotishlar"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Перинатальные потери"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Perinatal losses"
  * type = #group

  * item[+]
    * linkId = "perinatal-losses-present"
    * text = "Perinatal yo‘qotishlar"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #ru
        * extension[content].valueString = "Перинатальные потери"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #en
        * extension[content].valueString = "Perinatal losses"
    * type = #coding
    * required = true
    * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Да"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Yes"
      
    * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Нет"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "No"
    
  * item[+]
    * linkId = "abortion-count"
    * text = "Abort"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #ru
        * extension[content].valueString = "Аборт"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #en
        * extension[content].valueString = "Abortion"
    * type = #integer

  * item[+]
    * linkId = "miscarriage-count"
    * text = "Homila tushishi / homilani ko‘tara olmaslik"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #ru
        * extension[content].valueString = "Ситуации невынашивания беременности"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #en
        * extension[content].valueString = "Miscarriage / pregnancy loss"
    * type = #integer

  * item[+]
    * linkId = "ectopic-pregnancy-count"
    * text = "Bachadondan tashqari homiladorlik"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #ru
        * extension[content].valueString = "Внематочная беременность"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #en
        * extension[content].valueString = "Ectopic pregnancy"
    * type = #integer

  * item[+]
    * linkId = "antenatal-fetal-death-count"
    * text = "Antenatal homila o‘limi"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #ru
        * extension[content].valueString = "Антенатальная гибель плода"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #en
        * extension[content].valueString = "Antenatal fetal death"
    * type = #integer

  * item[+]
    * linkId = "intrapartum-fetal-death-count"
    * text = "Intranatal homila o‘limi"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #ru
        * extension[content].valueString = "Интранатальная гибель плода"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #en
        * extension[content].valueString = "Intrapartum fetal death"
    * type = #integer

  * item[+]
    * linkId = "neonatal-death-count"
    * text = "Yangi tug‘ilgan chaqaloq o‘limi"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #ru
        * extension[content].valueString = "Смерть новорождённого"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #en
        * extension[content].valueString = "Neonatal death"
    * type = #integer

* item[+]
  * linkId = "contraception"
  * text = "Kontratseptsiya"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Контрацепция"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Contraception"
  * type = #group

  * item[+]
    * linkId = "contraception-method"
    * text = "Kontratseptsiya"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #ru
        * extension[content].valueString = "Контрацепция"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #en
        * extension[content].valueString = "Contraception"
    * type = #coding
    * required = true
    * answerOption[+].valueCoding = fertility-questionnaire-cs#surgical-female-sterilization "Jarrohlik — ayol sterilizatsiyasi"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Хирургическая — женская стерилизация"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Surgical — female sterilization"

    * answerOption[+].valueCoding = fertility-questionnaire-cs#surgical-vasectomy "Jarrohlik — vazektomiya"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Хирургическая — вазэктомия"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Surgical — vasectomy"
    
    * answerOption[+].valueCoding = fertility-questionnaire-cs#non-surgical-natural "Jarrohliksiz — tabiiy"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Не хирургическая — естественная"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Non-surgical — natural"

    * answerOption[+].valueCoding = fertility-questionnaire-cs#non-surgical-barrier "Jarrohliksiz — baryer"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Не хирургическая — барьерная"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Non-surgical — barrier"

    * answerOption[+].valueCoding = fertility-questionnaire-cs#non-surgical-chemical "Jarrohliksiz — kimyoviy"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Не хирургическая — химическая"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Non-surgical — chemical"

    * answerOption[+].valueCoding = fertility-questionnaire-cs#non-surgical-intrauterine "Jarrohliksiz — bachadon ichi"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Не хирургическая — внутриматочная"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Non-surgical — intrauterine"
    
    * answerOption[+].valueCoding = fertility-questionnaire-cs#non-surgical-hormonal "Jarrohliksiz — gormonal"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Не хирургическая — гормональная"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Non-surgical — hormonal"

    * answerOption[+].valueCoding = fertility-questionnaire-cs#not-used "Foydalanilmaydi"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Не используется"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Not used"
    
  * item[+]
    * linkId = "contraception-notes"
    * text = "Izohlar"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #ru
        * extension[content].valueString = "Примечания"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #en
        * extension[content].valueString = "Notes"
    * type = #text

* item[+]
  * linkId = "infertility"
  * text = "Bepushtlik"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Бесплодие"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Infertility"
  * type = #group

  * item[+]
    * linkId = "infertility-present"
    * text = "Bepushtlik"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #ru
        * extension[content].valueString = "Бесплодие"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #en
        * extension[content].valueString = "Infertility"
    * type = #coding
    * required = true

    * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Да"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Yes"
      
    * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Нет"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "No"

  * item[+]
    * linkId = "infertility-type"
    * text = "Bepushtlik turi"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #ru
        * extension[content].valueString = "Характер бесплодия"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #en
        * extension[content].valueString = "Type of infertility"
    * type = #coding
    * answerOption[+].valueCoding = fertility-questionnaire-cs#primary "Birlamchi"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Первично"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Primary"
      
    * answerOption[+].valueCoding = fertility-questionnaire-cs#secondary "Ikkilamchi"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Вторично"
    * answerOption[=].valueCoding.display.extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Secondary"

  * item[+]
    * linkId = "infertility-diagnosis-date"
    * text = "Tashxis qo‘yilgan sana"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #ru
        * extension[content].valueString = "Дата постановки диагноза"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #en
        * extension[content].valueString = "Diagnosis date"
    * type = #date

  * item[+]
    * linkId = "infertility-icd-diagnosis"
    * text = "XKT bo‘yicha tashxis"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #ru
        * extension[content].valueString = "Диагноз по МКБ"
      * extension[$translation-extension][+]
        * extension[lang].valueCode = #en
        * extension[content].valueString = "ICD diagnosis"
    * type = #string

Instance: example-fertility-questionnaire-response
InstanceOf: UZCoreQuestionnaireResponse
Usage: #example
Title: "Пример ответа на опросник фертильности"
Description: "Пример заполненного опросника по фертильности пациента"
* questionnaire = Canonical(FertilityQuestionnaire)
* status = #completed
* subject = Reference(example-salim)
* authored = "2026-07-01T14:30:00+05:00"
* language = #ru

* item[+]
  * linkId = "menstruation"
  * item[+]
    * linkId = "menstruation-present"
    * answer[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * item[+]
    * linkId = "menstruation-age-start"
    * answer[+].valueInteger = 15

* item[+]
  * linkId = "perinatal-losses"
  * item[+]
    * linkId = "perinatal-losses-present"
    * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "infertility"
  * item[+]
    * linkId = "infertility-present"
    * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

Instance: ScreeningIHDProbabilityQuestionnaire
InstanceOf: UZCoreQuestionnaire
Usage: #definition
Title: "Preliminary Ischemic Heart Disease Probability Questionnaire"
Description: "Questionnaire for preliminary ischemic heart disease probability assessment"
* url = "https://dhp.uz/fhir/core/Questionnaire/ScreeningIHDProbabilityQuestionnaire"
* name = "IHDProbabilityQuestionnaire"
* language = #uz
* status = #active
* subjectType = #Patient
* title = "Yurak ishemik kasalligi ehtimolini dastlabki baholash so‘rovnomasi" 
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Опросник предварительной вероятности ишемической болезни сердца"
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Preliminary Ischemic Heart Disease Probability Questionnaire"
* description = "Yurak ishemik kasalligi ehtimolini dastlabki baholash uchun so‘rovnoma"
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Опросник для предварительной оценки вероятности ишемической болезни сердца"
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Questionnaire for preliminary ischemic heart disease probability assessment"

* item[+]
  * linkId = "chest-pain"
  * text = "Ko‘krak qafasida og‘riq bormi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Есть ли боль в области груди?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Do you have chest pain?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"
    
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "exertional-pain"
  * text = "Ushbu og‘riq jismoniy yuklama yoki hissiy stress paytida paydo bo‘ladimi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Возникает ли эта боль при физической нагрузке или эмоциональном стрессе?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Does the pain occur during physical exertion or emotional stress?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"
    
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "relief-at-rest"
  * text = "Og‘riq tinch holatda yoki nitrat qabul qilgandan keyin bir necha daqiqada o‘tadimi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Проходит ли боль в покое или после приема нитратов в течение нескольких минут?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Does the pain resolve at rest or after taking nitrates within a few minutes?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"
    
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "dyspnea"
  * text = "Nafas qisishi yoki havo yetishmasligi hissi bormi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Беспокоит одышка или чувство нехватки воздуха?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Do you experience shortness of breath or air hunger?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"
    
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

Instance: example-ihd-probability-questionnaire-response
InstanceOf: UZCoreQuestionnaireResponse
Usage: #example
Title: "Пример ответа на опросник вероятности ИБС"
Description: "Пример заполненного опросника предварительной вероятности ишемической болезни сердца"
* questionnaire = Canonical(ScreeningIHDProbabilityQuestionnaire)
* status = #completed
* subject = Reference(example-salim)
* authored = "2026-07-01T14:30:00+05:00"
* language = #ru

* item[+]
  * linkId = "chest-pain"
  * answer[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"

* item[+]
  * linkId = "exertional-pain"
  * answer[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"

* item[+]
  * linkId = "relief-at-rest"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "dyspnea"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"


Instance: ScreeningCerebrovascularRiskQuestionnaire
InstanceOf: UZCoreQuestionnaire
Usage: #definition
Title: "Cerebrovascular Disease Early Detection Questionnaire"
Description: "Example for Cerebrovascular Disease Early Detection Questionnaire"
* url = "https://dhp.uz/fhir/core/Questionnaire/ScreeningCerebrovascularRiskQuestionnaire"
* name = "ScreeningCerebrovascularRisk"
* language = #uz
* status = #active
* subjectType = #Patient
* title = "Serebrovaskulyar patologiyani erta aniqlash so‘rovnomasi" 
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Опросник по раннему выявлению цереброваскулярной патологии"
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Cerebrovascular Disease Early Detection Questionnaire"

* item[+]
  * linkId = "blood-pressure"
  * text = "Sizda arterial qon bosimi yuqori (≥140/90 mm sim. ust.) yoki qon bosimini pasaytiruvchi dori vositalarini qabul qilasizmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Do you have high blood pressure (≥140/90 mmHg) or do you take medication to lower your blood pressure?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "У вас повышено артериальное давление (≥140/90 мм рт. ст.) или вы принимаете препараты для снижения давления?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"
    
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#unknown-bp "Bilmayman / muntazam o‘lchamayman"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Не знаю / измеряю нерегулярно"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "I don't know / I measure it irregularly"

* item[+]
  * linkId = "heart-rhythm"
  * text = "Sizda yurak ritmi buzilishlari yoki boshqa yurak kasalliklari bormi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "У вас повышено артериальное давление (≥140/90 мм рт. ст.) или вы принимаете препараты для снижения давления?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Do you have high blood pressure (≥140/90 mmHg) or do you take medication to lower your blood pressure?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#atrial-fibrillation "Ha, bo‘lmachalar fibrillyatsiyasi"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да, мерцательная аритмия"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes, atrial fibrillation"

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#other-heart-disease "Ha, boshqa yurak kasalliklari"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да, другие болезни сердца"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes, other heart diseases"
    
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#unknown "Bilmayman"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Не знаю"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "I don't know"

* item[+]
  * linkId = "diabetes"
  * text = "Sizga qandli diabet tashxisi qo‘yilganmi yoki qondagi glyukoza darajasi yuqori bo‘lganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Диагностирован ли у вас сахарный диабет или отмечалось повышение уровня глюкозы в крови?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Have you been diagnosed with diabetes mellitus or have you had elevated blood glucose levels?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#diabetes "Ha, qandli diabet tashxisi qo‘yilgan"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да, установлен диабет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes, diagnosed diabetes"

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#prediabetes "Ha, prediabet"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да, предиабет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes, prediabetes"
    
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#unknown-last-year "Bilmayman / oxirgi bir yil ichida tekshiruvdan o‘tmaganman"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Не знаю / не обследовался в течение последнего года"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "I don't know / I have not been tested within the last year"

* item[+]
  * linkId = "smoking"
  * text = "Hozirda chekasizmi yoki ilgari chekkanmisiz?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Курите ли вы в настоящее время или курили раньше?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Do you currently smoke or have you smoked in the past?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#smoking-current "Ha, hozir chekaman"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да, курю сейчас"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes, I currently smoke"

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#quit-lt-5y "5 yildan kam vaqt oldin tashlaganman"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Бросил(а) менее 5 лет назад"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Quit less than 5 years ago"

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#quit-gt-5y "5 yildan ko‘proq vaqt oldin tashlaganman"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Бросил(а) более 5 лет назад"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Quit more than 5 years ago"

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#never-smoked "Hech qachon chekmaganman"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Никогда не курил(а)"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "I have never smoked"


* item[+]
  * linkId = "cholesterol"
  * text = "Sizda xolesterin darajasi yuqorimi yoki uni pasaytiruvchi dori vositalarini qabul qilasizmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Повышен ли у вас уровень холестерина или вы принимаете препараты для его снижения?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Do you have elevated cholesterol levels or do you take cholesterol-lowering medication?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#cholesterol-high "Ha, umumiy xolesterin > 5,2 mmol/l"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да, общий холестерин > 5,2 ммоль/л"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes, total cholesterol > 5.2 mmol/L"

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#taking-statins "Ha, statinlarni qabul qilaman"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да, принимаю статины"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes, I take statins"
    
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#unknown-last-year "Bilmayman / oxirgi bir yil ichida tekshiruvdan o‘tmaganman"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Не знаю / не обследовался в течение последнего года"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "I don't know / I have not been tested within the last year"

* item[+]
  * linkId = "bmi-waist"
  * text = "Tana vazni indeksi (TVI/BMI) yoki bel aylanasining o‘lchami ortiqcha vaznni ko‘rsatadimi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Индекс массы тела (ИМТ) или окружность талии указывает на избыточный вес?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Does your body mass index (BMI) or waist circumference indicate excess weight?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#bmi-over-30 "TVI > 30 (semizlik)"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "ИМТ > 30 (ожирение)"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "BMI > 30 (obesity)"

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#bmi-25-30-waist "TVI 25–30 / bel aylanasi me’yordan yuqori"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "ИМТ 25–30 / окружность талии выше порога"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "BMI 25–30 / waist circumference above the threshold"

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#weight-normal "Yo‘q, vaznim me’yorda"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет, вес в норме"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No, my weight is normal"

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#unknown "Bilmayman"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Не знаю"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "I don't know"

* item[+]
  * linkId = "physical-activity"
  * text = "Jismoniy faolligingiz qanday?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Какова ваша физическая активность?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "What is your level of physical activity?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#sedentary "Kamharakat turmush tarzi"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Малоподвижный образ жизни"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Sedentary lifestyle"
    
  * answerOption[+].valueCoding = cerebrovascular-risk-cs#moderate-activity "O‘rtacha jismoniy faollik"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Умеренная активность"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Moderate physical activity"

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#high-activity "Yuqori jismoniy faollik"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Высокая активность"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "High physical activity"

* item[+]
  * linkId = "stroke-history"
  * text = "Yaqin qarindoshlaringizda erta insult/yurak xuruji bo‘lganmi yoki sizda insult, TIA yoki yurak xuruji kuzatilganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Были ли у близких родственников ранний инсульт/инфаркт либо у вас лично инсульт/ТИА/инфаркт?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Have any of your close relatives had an early stroke/heart attack, or have you personally had a stroke/TIA/heart attack?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#personal-stroke-tia "Ha, menda insult yoki TIA bo‘lgan"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да, у меня был инсульт или ТИА"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes, I have had a stroke or TIA"

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#family-early-stroke-mi "Ha, qarindoshlarimda erta insult yoki yurak xuruji bo‘lgan"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да, у родственников был ранний инсульт / инфаркт"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes, my relatives had an early stroke or heart attack"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#unknown "Bilmayman"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Не знаю"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "I don't know"

* item[+]
  * linkId = "Age"
  * text = "Yosh"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Возраст"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Age"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#age-45-plus "45 yosh va undan katta"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "45 лет и старше"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "45 years and older"

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#age-30-45 "30–45 yosh"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "30–45 лет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "30–45 years"

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#before-30 "30 yoshdan kichik"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Младше 30 лет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Under 30 years"

* item[+]
  * linkId = "alcohol-stress"
  * text = "Spirtli ichimlik iste’moli va stress darajangiz qanday?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Каков уровень употребления алкоголя и стресса?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "What is your level of alcohol consumption and stress?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#high-alcohol "Spirtli ichimliklarni muntazam ko‘p miqdorda iste’mol qilaman"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Регулярное употребление алкоголя в больших количествах"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Regular heavy alcohol consumption"

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#high-stress "Doimiy yuqori stress darajasi"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Постоянный высокий уровень стресса"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Constant high level of stress"

  * answerOption[+].valueCoding = cerebrovascular-risk-cs#both-factors "Ikkala omil ham mavjud"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Присутствуют оба фактора"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Both factors are present"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

Instance: example-cerebrovascular-risk-questionnaire-response
InstanceOf: UZCoreQuestionnaireResponse
Usage: #example
Title: "Sereброvaskulyar xavf so‘rovnomasiga javob namunasi"
Description: "Bemorning sereброvaskulyar xavfini baholash so‘rovnomasiga to‘ldirilgan javob namunasi"
* questionnaire = Canonical(ScreeningCerebrovascularRiskQuestionnaire)
* status = #completed
* subject = Reference(example-salim)
* authored = "2026-07-01T14:30:00+05:00"
* language = #uz

* item[+]
  * linkId = "blood-pressure"
  * answer[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"

* item[+]
  * linkId = "heart-rhythm"
  * answer[+].valueCoding = cerebrovascular-risk-cs#atrial-fibrillation "Ha, bo‘lmachalar fibrillyatsiyasi"

* item[+]
  * linkId = "diabetes"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "smoking"
  * answer[+].valueCoding = cerebrovascular-risk-cs#quit-gt-5y "5 yildan ko‘proq vaqt oldin tashlaganman"

* item[+]
  * linkId = "cholesterol"
  * answer[+].valueCoding = cerebrovascular-risk-cs#cholesterol-high "Ha, umumiy xolesterin > 5,2 mmol/l"

* item[+]
  * linkId = "bmi-waist"
  * answer[+].valueCoding = cerebrovascular-risk-cs#bmi-25-30-waist "TVI 25–30 / bel aylanasi me’yordan yuqori"

* item[+]
  * linkId = "physical-activity"
  * answer[+].valueCoding = cerebrovascular-risk-cs#moderate-activity "O‘rtacha jismoniy faollik"

* item[+]
  * linkId = "stroke-history"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "Age"
  * answer[+].valueCoding = cerebrovascular-risk-cs#before-30 "30 yoshdan kichik"


* item[+]
  * linkId = "alcohol-stress"
  * answer[+].valueCoding = cerebrovascular-risk-cs#both-factors "Ikkala omil ham mavjud"


Instance: HelminthiasisScreeningQuestionnaire
InstanceOf: UZCoreQuestionnaire
Usage: #definition
Title: "Helminthiasis Early Screening Questionnaire"
Description: "Example for Helminthiasis Early Screening Questionnaire"
* url = "https://dhp.uz/fhir/core/Questionnaire/HelminthiasisScreeningQuestionnaire"
* name = "HelminthiasisEarlyScreeningQuestionnaire"
* language = #uz
* status = #active
* subjectType = #Patient
* title = "Gelmintozlarni erta aniqlash skrining so‘rovnomasi" 
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Опрос Скрининг раннего выявления гельминтозных заболеваний"
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Helminthiasis Early Screening Questionnaire"

* item[+]
  * linkId = "helminthiasis-q1"
  * text = "So‘nggi 6 oy ichida bolada gelmintlar (ichak parazitlari) bilan zararlanish alomatlari kuzatilganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Были ли у ребенка симптомы заражения гельминтами за последние 6 месяцев?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Has the child had symptoms of a helminth (parasitic worm) infection during the last 6 months?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "helminthiasis-q2"
  * text = "Bola anal teshik atrofida qichishishdan shikoyat qiladimi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Ребенок жалуется на зуд в области анального отверстия?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Does the child complain of itching around the anus?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "helminthiasis-q3"
  * text = "Bolada tez charchash va holsizlik kuzatilganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Наблюдалась ли у ребенка повышенная утомляемость и слабость?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Has the child experienced increased fatigue and weakness?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "helminthiasis-q4"
  * text = "Ota-onalar bolada bezovta uyqu yoki uyqu bilan bog‘liq muammolarni sezganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Замечали ли родители нарушения сна (беспокойный сон)?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Have the parents noticed sleep disturbances (restless sleep) in the child?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "helminthiasis-q5"
  * text = "Bolangiz uyquda tishlarini g‘ijirlatadimi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Заметили ли вы, что ребенок скрежещет зубами во сне?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Have you noticed that the child grinds their teeth during sleep?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "helminthiasis-q6"
  * text = "Bolada aniq sababsiz qorin og‘rig‘i holatlari kuzatilganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Были ли случаи болей в животе без видимой причины?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Has the child experienced abdominal pain without an apparent cause?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "helminthiasis-q7"
  * text = "Ota-onalar bolasida ishtahaning pasayishi yoki aksincha, ishtahaning ortishini kuzatganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Замечали ли родители снижение аппетита или наоборот повышенный аппетит?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Have the parents noticed a decreased appetite or, conversely, an increased appetite in the child?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "helminthiasis-q8"
  * text = "Bolada teri holatining yomonlashishi (oq toshmalar, rangparlik) kuzatilganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Отмечалось ли ухудшение состояния кожи (белая сыпь, бледность)?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Has the child shown signs of worsening skin condition (white rash or paleness)?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "helminthiasis-q9"
  * text = "Bolada hech qanday aniq sababsiz vazn kamayishi kuzatilganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Были ли у ребенка случаи необъяснимой потери веса?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Has the child experienced unexplained weight loss?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

Instance: example-helminthiasis-screening-questionnaire-response
InstanceOf: UZCoreQuestionnaireResponse
Usage: #example
Title: "Gelmintozlar skrining so‘rovnomasiga javob namunasi"
Description: "Bolaning gelmintozlarni erta aniqlash skrining so‘rovnomasiga to‘ldirilgan javob namunasi"
* questionnaire = Canonical(HelminthiasisScreeningQuestionnaire)
* status = #completed
* subject = Reference(example-salim)
* authored = "2026-07-01T14:30:00+05:00"
* language = #uz

* item[+]
  * linkId = "helminthiasis-q1"
  * answer[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"

* item[+]
  * linkId = "helminthiasis-q2"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "helminthiasis-q3"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "helminthiasis-q4"
  * answer[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"

* item[+]
  * linkId = "helminthiasis-q5"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "helminthiasis-q6"
  * answer[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"

* item[+]
  * linkId = "helminthiasis-q7"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "helminthiasis-q8"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "helminthiasis-q9"
  * answer[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"

Instance: CVDRiskScreeningQuestionnaire
InstanceOf: UZCoreQuestionnaire
Usage: #definition
Title: "CVD Risk Screening Questionnaire"
Description: "Example for CVD Risk Screening Questionnaire"
* url = "https://dhp.uz/fhir/core/Questionnaire/CVDRiskScreeningQuestionnaire"
* name = "CVDRiskScreeningQuestionnaire"
* language = #uz
* status = #active
* subjectType = #Patient
* title = "Yurak-qon tomir kasalliklari xavfini erta aniqlash skriningi" 
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Скрининг раннего выявления риска сердечно-сосудистых заболеваний"
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Cardiovascular disease risk screening"
* description = "DMed qabulida bemor uchun so'rovnoma: yosh, jins, vazn, bo'y, TVI, arterial bosim va tamaki mahsulotlari iste'moli."
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Опросник для DMed при приёме пациента: возраст, пол, вес, рост, ИМТ, артериальное давление и употребление табачных изделий."
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Questionnaire for DMed during patient visit: age, sex, weight, height, BMI, blood pressure and tobacco use."

* item[+]
  * linkId = "age"
  * text = "Yosh"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Возраст"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Age"
  * type = #integer
  * required = true

* item[+]
  * linkId = "sex"
  * text = "Jins"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Пол"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Sex"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = $administrative-gender#male "Male"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Мужской"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #uz
    * extension[content].valueString = "Erkak"

  * answerOption[+].valueCoding = $administrative-gender#female "Female"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Женский"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #uz
    * extension[content].valueString = "Ayol"

  * answerOption[+].valueCoding = $administrative-gender#other "Other"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Другой"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #uz
    * extension[content].valueString = "Boshqa"

  * answerOption[+].valueCoding = $administrative-gender#unknown "Unknown"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Неизвестно"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #uz
    * extension[content].valueString = "Noma'lum"

* item[+]
  * linkId = "weight"
  * text = "Vazn"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Вес"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Weight"
  * type = #decimal
  * required = true

* item[+]
  * linkId = "height"
  * text = "Bo'y"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Рост"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Height"
  * type = #decimal
  * required = true

* item[+]
  * linkId = "bmi"
  * text = "Tana vazni indeksi"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Индекс массы тела"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Body mass index"
  * type = #decimal
  * required = true

* item[+]
  * linkId = "systolic-bp"
  * text = "Sistolik bosim"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Систолическое давление"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Systolic blood pressure"
  * type = #decimal
  * required = true

* item[+]
  * linkId = "diastolic-bp"
  * text = "Diastilik bosim"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Диастолическое давление"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Diastolic blood pressure"
  * type = #decimal
  * required = true

* item[+]
  * linkId = "tobacco-use"
  * text = "Tamaki mahsulotlarini iste'mol qilish"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Употребление табачных изделий"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Tobacco products use"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = cvd-tobacco-use-cs#not-use "Iste'mol qilmaydi"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Не употребляет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Does not use"

  * answerOption[+].valueCoding = cvd-tobacco-use-cs#use "Iste'mol qiladi"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Употребляет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Uses"

  * answerOption[+].valueCoding = cvd-tobacco-use-cs#quit "Tashlagan"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Бросил"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Quit"

Instance: example-cvd-risk-screening-questionnaire-response
InstanceOf: UZCoreQuestionnaireResponse
Usage: #example
Title: "Yurak-qon tomir kasalliklari xavfi skriningiga javob namunasi"
Description: "Bemorning yurak-qon tomir kasalliklari xavfini erta aniqlash skriningiga to‘ldirilgan javob namunasi"
* questionnaire = Canonical(CVDRiskScreeningQuestionnaire)
* status = #completed
* subject = Reference(example-salim)
* authored = "2026-07-01T14:30:00+05:00"
* language = #uz

* item[+]
  * linkId = "age"
  * answer[+].valueInteger = 52

* item[+]
  * linkId = "sex"
  * answer[+].valueCoding = $administrative-gender#male "Male"

* item[+]
  * linkId = "weight"
  * answer[+].valueDecimal = 84.5

* item[+]
  * linkId = "height"
  * answer[+].valueDecimal = 172

* item[+]
  * linkId = "bmi"
  * answer[+].valueDecimal = 28.6

* item[+]
  * linkId = "systolic-bp"
  * answer[+].valueDecimal = 138

* item[+]
  * linkId = "diastolic-bp"
  * answer[+].valueDecimal = 88

* item[+]
  * linkId = "tobacco-use"
  * answer[+].valueCoding = cvd-tobacco-use-cs#quit "Tashlagan"


Instance: DiabetesScreeningQuestionnaire
InstanceOf: UZCoreQuestionnaire
Usage: #definition
Title: "Diabetes Screening Questionnaire"
Description: "Example for Diabetes Screening Questionnaire"
* url = "https://dhp.uz/fhir/core/Questionnaire/DiabetesScreeningQuestionnaire"
* name = "DiabetesScreeningQuestionnaire"
* language = #uz
* status = #active
* subjectType = #Patient
* title = "Qandli diabetni erta aniqlash skriningi" 
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Скрининг раннего выявления сахарного диабета"
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Early Diabetes Screening"

* item[+]
  * linkId = "age"
  * text = "Yoshi"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Возраст"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Age"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = screening-diabetes-cs#age-40-64 "40-64 yosh"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "40-64 года"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "40-64 years"

  * answerOption[+].valueCoding = screening-diabetes-cs#age-65-plus "65 yosh va undan katta"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "65 лет и выше"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "65 years and older"

* item[+]
  * linkId = "gender"
  * text = "Jinsi"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Пол"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Gender"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = $administrative-gender#male "Male"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Мужской"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #uz
    * extension[content].valueString = "Erkak"

  * answerOption[+].valueCoding = $administrative-gender#female "Female"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Женский"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #uz
    * extension[content].valueString = "Ayol"

* item[+]
  * linkId = "waist"
  * text = "Bel o‘lchami (sm)"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Окружность талии (см)"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Waist circumference (cm)"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = screening-diabetes-cs#sm-94-below "94 sm dan past"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Ниже 94 см"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Below 94 cm"

  * answerOption[+].valueCoding = screening-diabetes-cs#sm-94-101 "94-101"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "94-101"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "94-101"

  * answerOption[+].valueCoding = screening-diabetes-cs#sm-102-plus "102 va undan yuqori"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "102 и выше"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "102 and above"

  * answerOption[+].valueCoding = screening-diabetes-cs#sm-80-below "80 sm dan past"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Ниже 80 см"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Below 80 cm"

  * answerOption[+].valueCoding = screening-diabetes-cs#sm-80-87 "80-87"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "80-87"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "80-87"

  * answerOption[+].valueCoding = screening-diabetes-cs#sm-88-plus "88 va undan yuqori"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "88 и выше"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "88 and above"

* item[+]
  * linkId = "sedentary"
  * text = "Kamharakat hayot tarzi"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Малоподвижный образ жизни"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Sedentary lifestyle"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "family-history"
  * text = "Qarindoshlarda qandli diabet mavjudligi"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Наличие сахарного диабета у родственников"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Family history of diabetes"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = screening-diabetes-cs#first-degree "Ota-ona, aka-uka, opa-singil"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "У родителей, братьев, сестёр"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Parents, siblings"

  * answerOption[+].valueCoding = screening-diabetes-cs#second-degree "Buva, buvi, xola, amaki, tog'a"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "У дедушки, бабушки, тёти, дяди"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Grandparents, aunt, uncle"

  * answerOption[+].valueCoding = screening-diabetes-cs#none "Yo'q"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "glucose"
  * text = "Qondagi shakar miqdori (mmol/l)"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Уровень сахара в крови (ммоль/л)"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Blood glucose level (mmol/L)"
  * type = #decimal
  * required = true

* item[+]
  * linkId = "blood-sampling"
  * text = "Qon qachon olingan?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Когда сделан забор крови?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "When was blood sample taken?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = screening-diabetes-cs#fasting "Och qoringa"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Натощак"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Fasting"

  * answerOption[+].valueCoding = screening-diabetes-cs#post-meal "Ovqatlangandan 2 soat o'tib"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Через 2 часа после приема пищищак"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "2 hours after meal"

Instance: example-diabetes-screening-questionnaire-response
InstanceOf: UZCoreQuestionnaireResponse
Usage: #example
Title: "Qandli diabet skriningiga javob namunasi"
Description: "Bemorning qandli diabetni erta aniqlash skriningiga to‘ldirilgan javob namunasi"
* questionnaire = Canonical(DiabetesScreeningQuestionnaire)
* status = #completed
* subject = Reference(example-salim)
* authored = "2026-07-01T14:30:00+05:00"
* language = #uz

* item[+]
  * linkId = "age"
  * answer[+].valueCoding = screening-diabetes-cs#age-40-64 "40-64 yosh"

* item[+]
  * linkId = "gender"
  * answer[+].valueCoding = $administrative-gender#male "Male"

* item[+]
  * linkId = "waist"
  * answer[+].valueCoding = screening-diabetes-cs#sm-94-101 "94-101"

* item[+]
  * linkId = "sedentary"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "family-history"
  * answer[+].valueCoding = screening-diabetes-cs#first-degree "Ota-ona, aka-uka, opa-singil"

* item[+]
  * linkId = "glucose"
  * answer[+].valueDecimal = 5.8

* item[+]
  * linkId = "blood-sampling"
  * answer[+].valueCoding = screening-diabetes-cs#fasting "Och qoringa"


Instance: BreastCancerScreeningQuestionnaire
InstanceOf: UZCoreQuestionnaire
Usage: #definition
Title: "Breast Cancer Screening Questionnaire"  
Description: "Example for Questionnaire for breast cancer risk screening"
* url = "https://dhp.uz/fhir/core/Questionnaire/BreastCancerScreeningQuestionnaire"
* name = "BreastCancerScreeningQuestionnaire"
* language = #uz
* status = #active
* subjectType = #Patient
* title = "Ko‘krak bezi saratonini aniqlash skrining so‘rovnomasi" 
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Скрининг на выявление рака груди"
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Breast Cancer Screening Questionnaire"
* description = "Ko‘krak bezi saratoni xavf belgilarini aniqlash uchun skrining so‘rovnomasi" 
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Опросник для скрининга на выявление признаков риска рака груди"
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Questionnaire for breast cancer risk screening"

* item[+]
  * linkId = "mastitis-history"
  * text = "Sizda mastit bo‘lganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "У вас был мастит?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Have you had mastitis?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "breast-surgery-history"
  * text = "Sizda ko‘krak bezida operatsiya bo‘lganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Была ли у вас операция на молочной железе?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Have you had breast surgery?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "breast-trauma-history"
  * text = "Sizda ko‘krak bezi jarohati bo‘lganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Были ли у вас травмы молочной железы?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Have you had breast trauma?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "fibrocystic-mastopathy"
  * text = "Sizda fibroz-kistoz mastopatiya bo‘lganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Была ли у вас фиброзно-кистозная мастопатия?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Have you had fibrocystic mastopathy?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "axillary-lymph-node-changes"
  * text = "Qo‘ltiq osti limfa tugunlarida palpatsiyada o‘zgarishlar bormi (kattalashgan, og‘riqli)?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Есть ли изменения в подмышечных лимфоузлах при пальпации (увеличены, болезненны)?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Are there changes in axillary lymph nodes on palpation (enlarged or painful)?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "breast-local-changes"
  * text = "Ko‘krak bezida o‘zgarishlar bormi (teri qizarishi, «limon po‘sti» belgisi, ko‘krak uchidan ajralma, qattiqlashish, o‘sma)?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Есть ли у вас изменения в области молочной железы (покраснение кожи, эффект «лимонной корки», выделения из соска, уплотнения, опухоли)?	Ko‘krak bezida o‘zgarishlar bormi (teri qizarishi, «limon po‘sti» belgisi, ko‘krak uchidan ajralma, qattiqlashish, o‘sma)?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Do you have breast changes (skin redness, orange-peel skin, nipple discharge, lumps, tumors)?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "gynecological-diseases"
  * text = "Sizda ginekologik kasalliklar bo‘lganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Были ли у вас гинекологические заболевания?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Have you had gynecological diseases?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "cyclic-breast-pain"
  * text = "Hayz sikli bilan bog‘liq ko‘krak bezlarida og‘riq bormi (hayz boshlanishidan oldin)?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Есть ли у вас боли в молочных железах, связанные с менструальным циклом (до начала менструации)?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Do you have breast pain related to the menstrual cycle (before menstruation)?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "thyroid-disease"
  * text = "Sizda qalqonsimon bez kasalligi (bo‘qoq) bo‘lganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Было ли у вас заболевание щитовидной железы (зоб)?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Have you had thyroid disease (goiter)?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "relation"
  * text = "Yaqin qarindoshlarda (buvi, ona, xola, opa/singil) ko‘krak bezi saratoni kuzatilganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Был ли рак молочной железы у ваших родственников (бабушка, мать, тетя, сестра)?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Have any of your relatives (grandmother, mother, aunt, sister) had breast cancer?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

Instance: example-breast-cancer-screening-questionnaire-response
InstanceOf: UZCoreQuestionnaireResponse
Usage: #example
Title: "Ko‘krak bezi saratoni skriningiga javob namunasi"
Description: "Bemorning ko‘krak bezi saratonini aniqlash skrining so‘rovnomasiga to‘ldirilgan javob namunasi"
* questionnaire = Canonical(BreastCancerScreeningQuestionnaire)
* status = #completed
* subject = Reference(example-salim)
* authored = "2026-07-01T14:30:00+05:00"
* language = #uz

* item[+]
  * linkId = "mastitis-history"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "breast-surgery-history"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "breast-trauma-history"
  * answer[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"

* item[+]
  * linkId = "fibrocystic-mastopathy"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "axillary-lymph-node-changes"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "breast-local-changes"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "gynecological-diseases"
  * answer[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"

* item[+]
  * linkId = "cyclic-breast-pain"
  * answer[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"

* item[+]
  * linkId = "thyroid-disease"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "relation"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"


Instance: OncohematologyScreeningQuestionnaire
InstanceOf: UZCoreQuestionnaire
Usage: #definition
Title: "Oncohematology Screening Questionnaire"
Description: "Example for Questionnaire for Oncohematology Screening"
* url = "https://dhp.uz/fhir/core/Questionnaire/OncohematologyScreeningQuestionnaire"
* name = "OncohematologyScreeningQuestionnaire"
* language = #uz
* status = #active
* subjectType = #Patient
* title = "Onkogematologik kasalliklarni erta aniqlash so‘rovnomasi" 
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Опросник раннего выявления онкогематологических заболеваний"
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Oncohematologic Disease Early Detection Questionnaire"
* description = "Onkogematologik kasallik belgilarini erta aniqlash uchun so‘rovnoma" 
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Опросник для раннего выявления признаков онкогематологических заболеваний"
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Questionnaire for early detection of signs of oncohematologic diseases"

* item[+]
  * linkId = "unexplained-weight-loss"
  * text = "So‘nggi 6 oy ichida sababsiz vazn yo‘qotish kuzatilganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Наблюдается ли необъяснимая потеря веса в течение последних 6 месяцев?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Is there unexplained weight loss during the last 6 months?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "morning-headaches"
  * text = "Ayniqsa ertalab sababsiz bosh og‘riqlari bo‘ladimi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Бывают ли необъяснимые головные боли, особенно по утрам?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Do unexplained headaches occur, especially in the morning?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "body-joint-pain-limping"
  * text = "Tana va bo‘g‘imlarda kuchayib boruvchi og‘riqlar yoki oqsoqlanish bezovta qiladimi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Беспокоят ли нарастающие боли в теле и суставах, хромота?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Are increasing body and joint pains or limping present?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "unexplained-bruises-rashes"
  * text = "Tanada sababsiz ko‘karishlar va toshmalar paydo bo‘ladimi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Появляются ли по всему телу необъяснимые синяки и высыпания?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Do unexplained bruises and rashes appear over the body?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "spontaneous-bleeding"
  * text = "Burun, og‘iz, milk yoki quloqdan o‘z-o‘zidan qon ketishi kuzatiladimi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Наблюдаются ли спонтанные кровотечения из носа, рта, десен, ушей?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Are there spontaneous bleedings from the nose, mouth, gums, or ears?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "nausea-vomiting-blood"
  * text = "Ko‘ngil aynishi va qon izlari bilan qusish tez-tez bo‘ladimi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Часто ли случаются тошнота и рвота с прожилками крови?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Do nausea and vomiting with blood streaks occur frequently?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "weakness-restlessness-night-sweats"
  * text = "Holsizlik, bezovtalik yoki kechasi ko‘p terlash kuzatiladimi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Наблюдается ли слабость или беспокойство, повышенное ночное потоотделение?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Are weakness, restlessness, or increased night sweating observed?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "dizziness-blurred-vision"
  * text = "To‘satdan bosh aylanishi va ko‘rish xiralashishi xuruji bo‘lganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Возникал ли внезапный приступ головокружения и помутнения зрения?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Has there been a sudden episode of dizziness and blurred vision?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "periodic-fever"
  * text = "Vaqti-vaqti bilan sababsiz tana harorati ko‘tarilishi kuzatiladimi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Наблюдается ли периодическое беспричинное повышение температуры тела?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Is there periodic unexplained fever?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "dysuria-hematuria"
  * text = "Siydik chiqarishda qiyinchilik yoki siydikda qon bormi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Есть ли затрудненное мочеиспускание, кровь в моче?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Is there difficult urination or blood in the urine?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "pallor-bruises-exam"
  * text = "Terining yaqqol oqarishi va tanada ko‘karishlar bormi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Есть ли выраженная бледность кожи и синяки в теле?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Is there marked skin pallor and bruising on the body?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "neck-chest-swelling-lymph-nodes"
  * text = "Bo‘yin yoki ko‘krak qafasi sohasida shishlar va palpatsiyada kattalashgan limfa tugunlari bormi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Есть ли припухлости в области шеи или грудной клетки и увеличенные лимфатические узлы при пальпации?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Are there swellings in the neck or chest area and enlarged lymph nodes on palpation?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "eye-shape-change-glow"
  * text = "Ko‘z shakli yoki ko‘rinishida o‘zgarish kuzatiladimi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Наблюдается ли изменение (свечение), формы глаз?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Are changes in the appearance or shape of the eyes observed?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "nasal-breathing-voice-face-dyspnea"
  * text = "Burundan nafas olish qiyinlashishi, burun ajralmasi, manqalanish, yuz assimetriyasi yoki hansirash bormi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Есть ли затруднение носового дыхания, выделения из носа, гнусавость голоса, асимметрия лица, одышка?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Is there difficulty in nasal breathing, nasal discharge, nasal voice, facial asymmetry, or shortness of breath?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "abdominal-enlargement-stool-changes"
  * text = "Qorin kattalashishi va ich kelishida o‘zgarishlar bormi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Есть ли увеличение размеров живота и изменения стула?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Is there abdominal enlargement and stool changes?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

Instance: example-oncohematology-screening-questionnaire-response
InstanceOf: UZCoreQuestionnaireResponse
Usage: #example
Title: "Onkogematologik skriningga javob namunasi"
Description: "Bemorning onkogematologik kasalliklarni erta aniqlash so‘rovnomasiga to‘ldirilgan javob namunasi"
* questionnaire = Canonical(OncohematologyScreeningQuestionnaire)
* status = #completed
* subject = Reference(example-salim)
* authored = "2026-07-01T14:30:00+05:00"
* language = #uz

* item[+]
  * linkId = "unexplained-weight-loss"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "morning-headaches"
  * answer[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"

* item[+]
  * linkId = "body-joint-pain-limping"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "unexplained-bruises-rashes"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "spontaneous-bleeding"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "nausea-vomiting-blood"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "weakness-restlessness-night-sweats"
  * answer[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"

* item[+]
  * linkId = "dizziness-blurred-vision"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "periodic-fever"
  * answer[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"

* item[+]
  * linkId = "dysuria-hematuria"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "pallor-bruises-exam"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "neck-chest-swelling-lymph-nodes"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "eye-shape-change-glow"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "nasal-breathing-voice-face-dyspnea"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "abdominal-enlargement-stool-changes"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

Instance: BreastCancerRiskQuestionnaire
InstanceOf: UZCoreQuestionnaire
Usage: #definition
Title: "Breast Cancer Risk Questionnaire"
Description: "Example for Questionnaire for Breast Cancer Risk"
* url = "https://dhp.uz/fhir/core/Questionnaire/BreastCancerRiskQuestionnaire"
* name = "BreastCancerRiskQuestionnaire"
* language = #uz
* status = #active
* subjectType = #Patient
* title = "Ko‘krak bezi saratoni xavfini baholash so‘rovnomasi" 
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Опросник по оценке риска рака молочной железы"
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Breast Cancer Risk Assessment Questionnaire"
* description = "Bemorning ko‘krak bezi saratoni xavfini baholash uchun so‘rovnoma" 
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Опросник для оценки риска рака молочной железы пациента"
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Questionnaire for assessing patient breast cancer risk"

* item[+]
  * linkId = "cancer-history"
  * text = "Sizda avval onkologik kasalliklar tashxisi qo‘yilganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Были ли у вас ранее диагностированы онкологические болезни?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Have you previously been diagnosed with oncological diseases?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"


* item[+]
  * linkId = "menarche-age"
  * text = "Birinchi hayz ko‘rish necha yoshda bo‘lgan?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "В каком возрасте была первая менструация?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "At what age was your first menstruation?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = screening-breast-cancer-risk-cs#age-7-11 "7–11 yosh"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "7–11 лет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "7–11 years"

  * answerOption[+].valueCoding = screening-breast-cancer-risk-cs#age-12-13 "12–13 yosh"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "12–13 лет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "12–13 years"

  * answerOption[+].valueCoding = screening-breast-cancer-risk-cs#age-14-plus "14 yosh va undan katta"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "14 лет и старше"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "14 years and older"

* item[+]
  * linkId = "breast-density"
  * text = "Ko‘kragingiz zichligini qanday baholaysiz?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Как вы оцениваете плотность своей груди?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "How would you assess your breast density?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = screening-breast-cancer-risk-cs#soft "Yumshoq"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Мягкая"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Soft"

  * answerOption[+].valueCoding = screening-breast-cancer-risk-cs#medium "O‘rtacha"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Средняя"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Medium"

  * answerOption[+].valueCoding = screening-breast-cancer-risk-cs#dense "Zich"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Плотная"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Dense"

* item[+]
  * linkId = "family-history"
  * text = "Birinchi darajali qarindoshlarda (ona, opa-singil, qiz) ko‘krak bezi saratoni bo‘lganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Есть ли случаи рака молочной железы у родственников первой линии (мать, сестра, дочь)?"
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Is there a history of breast cancer in first-degree relatives (mother, sister, daughter)?"
  * type = #coding
  * required = true
  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "menopause-age"
  * text = "Oxirgi hayz ko‘rish necha yoshda bo‘lgan?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "В каком возрасте была последняя менструация?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "At what age was your last menstruation?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = screening-breast-cancer-risk-cs#no-menopause "Menopauza bo‘lmagan"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет (менопаузы не было)"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No menopause yet"

  * answerOption[+].valueCoding = screening-breast-cancer-risk-cs#age-45-55 "45–55 yosh oralig‘ida"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "В промежутке 45–55 лет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Between 45–55 years"

  * answerOption[+].valueCoding = screening-breast-cancer-risk-cs#before-45 "45 yoshgacha"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "До 45 лет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Before 45 years"

  * answerOption[+].valueCoding = screening-breast-cancer-risk-cs#after-55 "55 yoshdan keyin"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "После 55 лет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "After 55 years"

* item[+]
  * linkId = "first-birth-age"
  * text = "Birinchi tug‘ruq necha yoshda bo‘lgan?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "В каком возрасте были первые роды?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "At what age was your first childbirth?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = screening-breast-cancer-risk-cs#before-30 "30 yoshgacha"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "До 30 лет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Before 30 years"

  * answerOption[+].valueCoding = screening-breast-cancer-risk-cs#after-30 "30 yoshdan keyin"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "После 30 лет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "After 30 years"

  * answerOption[+].valueCoding = screening-breast-cancer-risk-cs#never-given-birth "Tug‘magan"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Не рожала"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Never gave birth"

* item[+]
  * linkId = "breastfeeding-duration"
  * text = "Oxirgi farzandingizni qancha vaqt emizgansiz?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Сколько времени вы кормили грудью последнего ребенка?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "How long did you breastfeed your last child?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = screening-breast-cancer-risk-cs#more-than-12m "12 oydan ko‘p"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Свыше 12 месяцев"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "More than 12 months"

  * answerOption[+].valueCoding = screening-breast-cancer-risk-cs#up-to-6m "6 oygacha"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "До 6 месяцев"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Up to 6 months"

  * answerOption[+].valueCoding = screening-breast-cancer-risk-cs#not-breastfed "Emizmagan"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Не кормила грудью"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Did not breastfeed"

* item[+]
  * linkId = "breast-lump"
  * text = "So‘nggi 3 oyda ko‘krak yoki qo‘ltiq ostida qattiqlashish sezganmisiz?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Замечали ли вы уплотнения в груди или подмышечной области в последние 3 месяца?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Have you noticed lumps in the breast or armpit during the last 3 months?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "nipple-discharge"
  * text = "Emizish bilan bog‘liq bo‘lmagan ko‘krak uchidan ajralma bo‘lganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Были ли у вас выделения из соска, не связанные с кормлением?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Have you had nipple discharge unrelated to breastfeeding?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

  * answerOption[+].valueCoding = screening-breast-cancer-risk-cs#other-color "Boshqa rangli ajralma"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да, другого цвета"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes, other color"

  * answerOption[+].valueCoding = screening-breast-cancer-risk-cs#bloody "Qonli ajralma"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да, кровянистые"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes, bloody"

* item[+]
  * linkId = "breast-appearance-changes"
  * text = "Ko‘krak ko‘rinishida o‘zgarish bo‘lganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Изменился ли внешний вид груди (форма, размер, уплотнение, покраснение кожи, втяжение соска)?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Have there been changes in breast appearance (shape, size, redness, nipple retraction)?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

  * answerOption[+].valueCoding = screening-breast-cancer-risk-cs#one-breast "Bir ko‘krakda"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да, в одной груди"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes, in one breast"

  * answerOption[+].valueCoding = screening-breast-cancer-risk-cs#both-breasts "Ikkala ko‘krakda"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да, в обеих грудях"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes, in both breasts"

* item[+]
  * linkId = "hormonal-therapy"
  * text = "Gormonal preparatlar qabul qilganmisiz?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Принимали ли вы гормональные препараты (противозачаточные, гормональные таблетки во время климакса)?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Have you taken hormonal medications (contraceptives or hormone therapy)?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

Instance: example-breast-cancer-risk-questionnaire-response
InstanceOf: UZCoreQuestionnaireResponse
Usage: #example
Title: "Ko‘krak bezi saratoni xavfini baholash so‘rovnomasiga javob namunasi"
Description: "Bemorning ko‘krak bezi saratoni xavfini baholash so‘rovnomasiga to‘ldirilgan javob namunasi"
* questionnaire = Canonical(BreastCancerRiskQuestionnaire)
* status = #completed
* subject = Reference(example-salim)
* authored = "2026-07-01T14:30:00+05:00"
* language = #uz

* item[+]
  * linkId = "cancer-history"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "menarche-age"
  * answer[+].valueCoding = screening-breast-cancer-risk-cs#age-12-13 "12–13 yosh"

* item[+]
  * linkId = "breast-density"
  * answer[+].valueCoding = screening-breast-cancer-risk-cs#medium "O‘rtacha"

* item[+]
  * linkId = "family-history"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "menopause-age"
  * answer[+].valueCoding = screening-breast-cancer-risk-cs#age-45-55 "45–55 yosh oralig‘ida"

* item[+]
  * linkId = "first-birth-age"
  * answer[+].valueCoding = screening-breast-cancer-risk-cs#before-30 "30 yoshgacha"

* item[+]
  * linkId = "breastfeeding-duration"
  * answer[+].valueCoding = screening-breast-cancer-risk-cs#more-than-12m "12 oydan ko‘p"

* item[+]
  * linkId = "breast-lump"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "nipple-discharge"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "breast-appearance-changes"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "hormonal-therapy"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

Instance: ScreeningCervicalRiskQuestionnaire
InstanceOf: UZCoreQuestionnaire
Usage: #definition
Title: "Cervical Risk Questionnaire"
Description: "Example for Questionnaire for Cervical Risk"
* url = "https://dhp.uz/fhir/core/Questionnaire/ScreeningCervicalRiskQuestionnaire"
* name = "CervicalRiskQuestionnaire"
* language = #uz
* status = #active
* subjectType = #Patient
* title = "Bachadon bo‘yni kasalliklari xavfini baholash so‘rovnomasi" 
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Опросник по оценке риска заболеваний шейки матки"
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Cervical Disease Risk Assessment Questionnaire"
* description = "Bemorning bachadon bo‘yni kasalliklari xavfini baholash uchun so‘rovnoma" 
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Опросник для оценки риска заболеваний шейки матки пациента"
  * extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Questionnaire for assessing patient cervical disease risk"

* item[+]
  * linkId = "gynecological-surgery-history"
  * text = "Ayol jinsiy a’zolarida operatsiya o‘tkazilganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Проводилась ли операция на женских половых органах?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Have you had surgery on female reproductive organs?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = screening-cervical-risk-cs#no-surgery "Operatsiya bo‘lmagan"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Не было операций"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No surgeries"

  * answerOption[+].valueCoding = screening-cervical-risk-cs#ovarian-surgery "Tuxumdonlarda operatsiya"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "На яичниках"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Ovarian surgery"

  * answerOption[+].valueCoding = screening-cervical-risk-cs#cervical-biopsy "Bachadon bo‘yni biopsiyasi"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Биопсия шейки матки"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Cervical biopsy"

  * answerOption[+].valueCoding = screening-cervical-risk-cs#cervical-polyp-removal "Servikal kanal poliplarini olib tashlash"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Удаление полипов цервикального канала"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Removal of cervical canal polyps"

  * answerOption[+].valueCoding = screening-cervical-risk-cs#uterus-removal-without-cervix "Bachadon olib tashlangan, bachadon bo‘yni saqlangan"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Удаление матки без шейки матки"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Removal of uterus without cervix"

  * answerOption[+].valueCoding = screening-cervical-risk-cs#cervix-removal "Bachadon bo‘yni olib tashlangan"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Удаление шейки матки"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Removal of cervix"

  * answerOption[+].valueCoding = screening-cervical-risk-cs#diathermocoagulation "Diatermokoagulyatsiya"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Диатермокоагуляция"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Diathermocoagulation"

* item[+]
  * linkId = "hpv-test-result"
  * text = "HPV testi natijasi"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Результат ВПЧ-теста"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "HPV test result"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = screening-cervical-risk-cs#negative "Manfiy"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Отрицательный"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Negative"

  * answerOption[+].valueCoding = screening-cervical-risk-cs#positive "Musbat"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Положительный"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Positive"

* item[+]
  * linkId = "abnormal-pap-test"
  * text = "PAP testi natijalari anomal bo‘lganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Результаты ПАП-теста аномальные?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Were the Pap test results abnormal?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

* item[+]
  * linkId = "marital-status"
  * text = "Oilaviy holatingiz qanday?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Ваше семейное положение?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "What is your marital status?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = screening-cervical-risk-cs#married "Turmush qurgan"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "В браке"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Married"

  * answerOption[+].valueCoding = screening-cervical-risk-cs#not-married "Turmush qurmagan"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Не замужем"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Not married"

  * answerOption[+].valueCoding = screening-cervical-risk-cs#living-with-partner "Sherik bilan yashaydi"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Проживаю с партнером"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Living with partner"

  * answerOption[+].valueCoding = screening-cervical-risk-cs#divorced-widow "Ajrashgan / beva"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "В разводе / вдова"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Divorced / widow"

* item[+]
  * linkId = "sexual-debut-age"
  * text = "Jinsiy hayotni necha yoshda boshlagansiz?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "В каком возрасте вы начали половую жизнь?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "At what age did you start sexual activity?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = screening-cervical-risk-cs#before-18 "18 yoshgacha"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "До 18 лет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Before 18 years"

  * answerOption[+].valueCoding = screening-cervical-risk-cs#after-18 "18 yoshdan keyin"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "После 18 лет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "After 18 years"

* item[+]
  * linkId = "current-cervical-cancer"
  * text = "Hozirda sizda bachadon bo‘yni saratoni tashxisi qo‘yilganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Диагностирован ли у вас РШМ в данное время?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Are you currently diagnosed with cervical cancer?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

* item[+]
  * linkId = "cervical-cancer-history"
  * text = "Anamnezda bachadon bo‘yni saratoni bo‘lganmi?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Был ли у вас рак шейки матки в анамнезе?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "Have you had cervical cancer in your medical history?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#N "No"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Нет"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "No"

  * answerOption[+].valueCoding = $fertility-questionnaire-cs#Y "Yes"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Да"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "Yes"

* item[+]
  * linkId = "sexual-partners-count"
  * text = "Nechta jinsiy sherigingiz bo‘lgan?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #ru
      * extension[content].valueString = "Сколько сексуальных партнеров у вас было?"
    * extension[$translation-extension][+]
      * extension[lang].valueCode = #en
      * extension[content].valueString = "How many sexual partners have you had?"
  * type = #coding
  * required = true

  * answerOption[+].valueCoding = screening-cervical-risk-cs#partners-1-3 "1–3"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "1–3"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "1–3"

  * answerOption[+].valueCoding = screening-cervical-risk-cs#partners-more-than-3 "3 tadan ko‘p"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #ru
    * extension[content].valueString = "Больше 3"
  * answerOption[=].valueCoding.display.extension[$translation-extension][+]
    * extension[lang].valueCode = #en
    * extension[content].valueString = "More than 3"

Instance: example-cervical-risk-questionnaire-response
InstanceOf: UZCoreQuestionnaireResponse
Usage: #example
Title: "Bachadon bo‘yni kasalliklari xavfini baholash so‘rovnomasiga javob namunasi"
Description: "Bemorning bachadon bo‘yni kasalliklari xavfini baholash so‘rovnomasiga to‘ldirilgan javob namunasi"
* questionnaire = Canonical(ScreeningCervicalRiskQuestionnaire)
* status = #completed
* subject = Reference(example-salim)
* authored = "2026-07-01T14:30:00+05:00"
* language = #uz

* item[+]
  * linkId = "gynecological-surgery-history"
  * answer[+].valueCoding = screening-cervical-risk-cs#no-surgery "Operatsiya bo‘lmagan"

* item[+]
  * linkId = "hpv-test-result"
  * answer[+].valueCoding = screening-cervical-risk-cs#negative "Manfiy"

* item[+]
  * linkId = "abnormal-pap-test"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "marital-status"
  * answer[+].valueCoding = screening-cervical-risk-cs#married "Turmush qurgan"

* item[+]
  * linkId = "sexual-debut-age"
  * answer[+].valueCoding = screening-cervical-risk-cs#after-18 "18 yoshdan keyin"

* item[+]
  * linkId = "current-cervical-cancer"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "cervical-cancer-history"
  * answer[+].valueCoding = $fertility-questionnaire-cs#N "No"

* item[+]
  * linkId = "sexual-partners-count"
  * answer[+].valueCoding = screening-cervical-risk-cs#partners-1-3 "1–3"