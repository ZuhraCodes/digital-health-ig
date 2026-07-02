CodeSystem: CerebrovascularRiskCS
Id: cerebrovascular-risk-cs
Title: "Cerebrovascular Risk CodeSystem"
Description: "Answer codes for the cerebrovascular risk"
* insert OriginalCodeSystem(cerebrovascular-risk-cs)
* ^language = #uz

* #unknown-bp
  * ^designation[0].language = #ru
  * ^designation[=].value = "Не знаю / измеряю нерегулярно"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Bilmayman / muntazam o‘lchamayman"

* #atrial-fibrillation
  * ^designation[0].language = #ru
  * ^designation[=].value = "Да, мерцательная аритмия"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Ha, bo‘lmachalar fibrillyatsiyasi"

* #other-heart-disease
  * ^designation[0].language = #ru
  * ^designation[=].value = "Да, другие болезни сердца"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Ha, boshqa yurak kasalliklari"

* #unknown
  * ^designation[0].language = #ru
  * ^designation[=].value = "Не знаю"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Bilmayman"

* #diabetes
  * ^designation[0].language = #ru
  * ^designation[=].value = "Да, установлен диабет"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Ha, qandli diabet tashxisi qo‘yilgan"

* #prediabetes
  * ^designation[0].language = #ru
  * ^designation[=].value = "Да, предиабет"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Ha, prediabet"

* #unknown-last-year
  * ^designation[0].language = #ru
  * ^designation[=].value = "Не знаю / не обследовался в течение последнего года"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Bilmayman / oxirgi bir yil ichida tekshiruvdan o‘tmaganman"

* #smoking-current
  * ^designation[0].language = #ru
  * ^designation[=].value = "Да, курю сейчас"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Ha, hozir chekaman"

* #quit-lt-5y
  * ^designation[0].language = #ru
  * ^designation[=].value = "Бросил(а) менее 5 лет назад"
  * ^designation[+].language = #uz
  * ^designation[=].value = "5 yildan kam vaqt oldin tashlaganman"

* #quit-gt-5y
  * ^designation[0].language = #ru
  * ^designation[=].value = "Бросил(а) более 5 лет назад"
  * ^designation[+].language = #uz
  * ^designation[=].value = "5 yildan ko‘proq vaqt oldin tashlaganman"

* #never-smoked
  * ^designation[0].language = #ru
  * ^designation[=].value = "Никогда не курил(а)"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Hech qachon chekmaganman"

* #cholesterol-high
  * ^designation[0].language = #ru
  * ^designation[=].value = "Да, общий холестерин > 5,2 ммоль/л"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Ha, umumiy xolesterin > 5,2 mmol/l"

* #taking-statins
  * ^designation[0].language = #ru
  * ^designation[=].value = "Да, принимаю статины"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Ha, statinlarni qabul qilaman"

* #bmi-over-30
  * ^designation[0].language = #ru
  * ^designation[=].value = "ИМТ > 30 (ожирение)"
  * ^designation[+].language = #uz
  * ^designation[=].value = "TVI > 30 (semizlik)"

* #bmi-25-30-waist
  * ^designation[0].language = #ru
  * ^designation[=].value = "ИМТ 25–30 / окружность талии выше порога"
  * ^designation[+].language = #uz
  * ^designation[=].value = "TVI 25–30 / bel aylanasi me’yordan yuqori"

* #weight-normal
  * ^designation[0].language = #ru
  * ^designation[=].value = "Нет, вес в норме"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Yo‘q, vaznim me’yorda"

* #sedentary
  * ^designation[0].language = #ru
  * ^designation[=].value = "Малоподвижный образ жизни"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Kamharakat turmush tarzi"

* #moderate-activity
  * ^designation[0].language = #ru
  * ^designation[=].value = "Умеренная активность"
  * ^designation[+].language = #uz
  * ^designation[=].value = "O‘rtacha jismoniy faollik"

* #high-activity
  * ^designation[0].language = #ru
  * ^designation[=].value = "Высокая активность"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Yuqori jismoniy faollik"

* #personal-stroke-tia
  * ^designation[0].language = #ru
  * ^designation[=].value = "Да, у меня был инсульт или ТИА"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Ha, menda insult yoki TIA bo‘lgan"

* #family-early-stroke-mi
  * ^designation[0].language = #ru
  * ^designation[=].value = "Да, у родственников был ранний инсульт / инфаркт"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Ha, qarindoshlarimda erta insult yoki yurak xuruji bo‘lgan"

* #high-alcohol
  * ^designation[0].language = #ru
  * ^designation[=].value = "Регулярное употребление алкоголя в больших количествах"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Spirtli ichimliklarni muntazam ko‘p miqdorda iste’mol qilaman"

* #high-stress
  * ^designation[0].language = #ru
  * ^designation[=].value = "Постоянный высокий уровень стресса"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Doimiy yuqori stress darajasi"

* #both-factors 
  * ^designation[0].language = #ru
  * ^designation[=].value = "Присутствуют оба фактора"
  * ^designation[+].language = #uz
  * ^designation[=].value = "Ikkala omil ham mavjud"
  
* #age-45-plus 
  * ^designation[0].language = #ru
  * ^designation[=].value = "45 лет и старше"
  * ^designation[+].language = #uz
  * ^designation[=].value = "45 yosh va undan katta"

* #age-30-45
  * ^designation[0].language = #ru
  * ^designation[=].value = "30–45 лет"
  * ^designation[+].language = #uz
  * ^designation[=].value = "30–45 yosh"

* #before-30
  * ^designation[0].language = #ru
  * ^designation[=].value = "Младше 30 лет"
  * ^designation[+].language = #uz
  * ^designation[=].value = "30 yoshdan kichik"