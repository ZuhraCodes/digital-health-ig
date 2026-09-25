Profile: AmbulanceEncounter
Parent: Encounter
Id: uz-ambulance-encounter
Title: "UZ Ambulance Encounter"
Description: "Uzbekistan Ambulance Encounter profile, used to represent clinical encounters where patients receive emergency medical assistance services"
* ^experimental = true
* ^status = #active
* ^date = "2025-08-01"
* ^publisher = "Uzinfocom"

* identifier 1..1 MS
* identifier ^short = "Call card number from emergency medical services MIS"
* identifier ^definition = "A unique identifier for the ambulance call/encounter"

* status 1..1 MS
* status from EncounterStatusVS (required)
* status ^short = "Current status of the ambulance encounter"

* class 0..* MS
* class from EncounterClassVS (required)
* class ^short = "Classification of the ambulance encounter with patient"

* priority 0..1 MS
* priority from EncounterPriorityVS (required)
* priority ^short = "Indicates urgency of the ambulance encounter"

* type 0..* MS
* type ^short = "Specific type of ambulance encounter"
* type ^slicing.discriminator.type = #value
* type ^slicing.discriminator.path = "coding.system"
* type ^slicing.rules = #open
* type ^slicing.description = "A national encounter-type classification is required; additional type codings from other systems are allowed"

* serviceType 0..* MS
* serviceType only CodeableReference(UZCoreHealthcareService)
* serviceType ^short = "Broad categorization of services that should be provided"

* subject 1..1 MS
* subject only Reference(UZCorePatient)
* subject ^short = "Patient associated with this ambulance encounter"

* subjectStatus 0..1 MS
* subjectStatus from EncounterSubjectStatusVS (required)
* subjectStatus ^short = "Tracking of patient status during the encounter"

* basedOn 0..* MS
* basedOn only Reference(UZCoreMedicationRequest or UZCoreServiceRequest)
* basedOn ^short = "Request that initiated this encounter"

* partOf 0..1 MS
* partOf only Reference(UZCoreEncounter)
* partOf ^short = "Another encounter of which this encounter is part"

* serviceProvider 1..1 MS
* serviceProvider only Reference(UZCoreOrganization)
* serviceProvider ^short = "Responsible emergency medical services organization"

* participant 0..* MS
* participant ^short = "List of participants involved in the encounter"
* participant.type 0..* MS
* participant.type from EncounterParticipantTypeVS (extensible)
* participant.type ^short = "Role of the encounter participant"
* participant.actor 1..1 MS
* participant.actor only Reference(UZCorePatient or UZCoreRelatedPerson or UZCorePractitioner or UZCorePractitionerRole or UZCoreHealthcareService)
* participant.actor ^short = "Person or service participating in the encounter"

* reason 0..* MS
* reason ^short = "List of medical indications that are expected to be considered during care provision"
* reason.use 0..* MS
* reason.use from EncounterReasonUseVS (preferred)
* reason.use ^short = "For what purpose the reason value should be used"

* reason.value 0..* MS
* reason.value only CodeableReference(UZCoreCondition or DiagnosticReport or Procedure or UZCoreObservation)
* reason.value ^short = "Medical reason requiring consideration"

* actualPeriod 1..1 MS
* actualPeriod ^short = "Actual start and end time of the ambulance encounter"

* diagnosis 0..* MS
* diagnosis ^short = "List of diagnoses relevant to this case"
* diagnosis.condition 0..* MS
* diagnosis.condition only CodeableReference(UZCoreCondition)
* diagnosis.condition ^short = "Diagnosis relevant to the encounter"

* admission 0..1 MS
* admission ^short = "Details about the admission during which medical services are provided"
* admission.admitSource 0..1 MS
* admission.admitSource from EncounterAdmitSourceVS (required)
* admission.admitSource ^short = "Location from where the patient was transported for the ambulance encounter"
* admission.destination 0..1 MS
* admission.destination only Reference(UZCoreLocation or UZCoreOrganization)
* admission.destination ^short = "Place/organization to which the patient is transported after ambulance services"
* admission.dischargeDisposition 1..1 MS
* admission.dischargeDisposition from EncounterDischargeDispositionVS (required)
* admission.dischargeDisposition ^short = "Category or type of location after discharge"

* location 1..1 MS
* location.location 1..1 MS
* location.location only Reference(UZCoreLocation)
* location.location ^short = "Location where the ambulance encounter occurs"
* location.status 0..1 MS


Instance: example-ambulance-encounter
InstanceOf: AmbulanceEncounter
Title: "Example Ambulance Encounter"
Description: "Example of an ambulance encounter for emergency medical services"
Usage: #example

* identifier.system = "https://mis.ambulance.uz"
* identifier.value = "01.CM5742/26"

* status = #completed "Completed"
* class = $v3-ActCode#EMER "Emergency"
* priority = encounter-priority-ambulance-cs#emer5-0005-1 "Tez tibbiy yordam"
* type = encounter-type-cs#mserv-0001-00001 "Preventive services"

* serviceType = Reference(example-healthcareservice)
* subject = Reference(example-patient)
* subjectStatus = encounter-subject-status-cs#gencl-0003-00001 "Awake"

* serviceProvider = Reference(tashkent-diseases-hospital)

* participant.type = participanttype-cs#ATND "Attender"
* participant.actor = Reference(example-practitioner)

* reason.use = encounter-reason-use-ambulance-cs#emer103054 "Significant change in blood pressure"
* reason.value = Reference(example-cancer)

* actualPeriod
  * start = "2024-03-01T09:30:00Z"
  * end = "2024-03-01T10:15:00Z"

* diagnosis.condition = Reference(example-cancer)

* admission.admitSource = encounter-admit-source-ambulance-cs#emer1-0005-9 "Boshqa"
* admission.destination = Reference(example-location)
* admission.dischargeDisposition = encounter-discharge-disposition-cs#home "Home"

* location.location = Reference(example-location)
* location.status = #completed
