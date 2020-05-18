# Werkcollege 2: Statistische toetsen

\BeginKnitrBlock{ABD}<div class="ABD">
Lees Chapter 6 (*Hypothesis testing*)
</div>\EndKnitrBlock{ABD}

Belangrijkste leerdoelen:

* Hypotheses kunnen opstellen
* Kunnen omschrijven wat de p-waarde is die uit een statistische toets rolt
* Begrijpen wat fouten van eerste (type I) en tweede (type II) soort zijn.


## Hypotheses
Statistische toetsen zijn ontwikkeld om helder te krijgen hoe betrouwbaar een bepaalde uitspraak is.
In blok 2 hebben jullie geleerd om vanuit een steekproef het betrouwbaarheidsinterval te berekenen van het gemiddelde.
Je geeft daarmee aan dat het gemiddelde, met een bepaalde waarschijnlijkheid (meestal 95%) tussen een minimale en maximale waarde zit.

Met een statistische toets, doe je precies het omgekeerde.
In plaats van het bepalen van het betrouwbaarheidsinterval, bepaal je de waarschijnlijkheid dat iets gelijk is aan een preciese waarde (je veronderstelling).
De vergelijking die je maakt wordt de nul-hypothese genoemd.
Wanneer het helemaal niet waarschijnlijk is dat je nul-hypothese waar is, verwerp je deze.
Je neemt dan de alternatieve hypothese aan.
De alternatieve hypothese is nooit precies (bijv. het gemiddelde is niet gelijk aan 10).

Meestal is de nul-hypothese niet jouw onderzoekshypothese!
Meestal verwacht je een verschil tussen bijv. twee behandelingen, maar je nul-hypothese stelt dat er geen verschil is.

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:hypotheses"><strong>(\#exr:hypotheses) </strong></span>Hypotheses opstellen

* Maak de volgende opgaven:

    * Opgave 15 (blz. 170)
    * Opgave 16 (blz. 170)
    * Ogave 17 (blz. 171)</div>\EndKnitrBlock{exercise}


## Type I en type II fouten
Je hoopt natuurlijk altijd de juiste conclusie te trekken uit je data.
Helaas is dat niet altijd het geval.
Gelukkig kunnen we met statistiek wel aangeven hoe betrouwbaar je conclusie is.

De meeste kritieke fout is het ten onrechte verwerpen van de nul-hypothese: je toont een verschil aan die er niet is.
De kans op deze fout wordt (bijna) standaard op 5% gezet.
De p-waarde geeft de waarschijnlijkheid dat de nul-hypothese **waar** is.
Komt de p-waarde onder de 0,05 (=5%), dan verwerpen we de nul-hypothese.

Een irritante fout is als er echt wel een verschil is (dus de nul-hypothese is **niet** waar), maar je kan het niet aantonen.
Dit wordt een fout van de tweede soort genoemd.
Hoe strenger je bent voor de kans op een fout van de eerste soort, hoe groter de kans op een fout van de tweede soort (denk daar maar even over na!).


\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:typefouten"><strong>(\#exr:typefouten) </strong></span>Type I en type II fouten

* Beschrijf in eigen woorden de betekenis van:

    * p-waarde
    * fout van de eerste soort
    * fout van de tweede soort</div>\EndKnitrBlock{exercise}


## Eenzijdig en tweezijdig toetsen
Als je wilt testen of er een verschil is tussen twee groepen, dan test je tweezijdig.
Het maakt niet uit welke van de twee groter is, als er maar verschil is.

Soms ben je alleen geïnteresseerd of er een verschil in één richting is, bijv. of biologen hoger scoren voor biologie dan voor wiskunde.
Dan ben je eenzijdig aan het toetsen.

## Simuleren
De beste manier om begrip te krijgen van statistische toetsen, is om met data te simuleren.
R is hier ideaal voor.
Met de functie `sample()` kan je een random sample nemen uit een populatie:


```r
steekproef1 <- sample(c("links", "rechts"), 18, replace = TRUE)
```

De functie `sample()` heeft in bovenstaand voorbeeld 3 **argumenten**.
Het eerste argument is een **vector** met de mogelijke waarden in de populatie, het tweede argument geeft de grootte van de steekproef en het derde argument geeft aan dat er een oneindige populatie is met "links"- en"rechts"-waarden.
De functie neemt aan dat "links" en "rechts" beiden evenveel voorkomen.

Met de table-functie kan je gemakkelijk checken hoeveel rechtshandige padden er in de steekproef zitten:


```r
table(steekproef1)
```


\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:steekproef"><strong>(\#exr:steekproef) </strong></span>Steekproef

* Gebruik bovenstaande code om een steekproef te nemen van 18 padden
* Geef het aantal rechtshandige padden door aan de docent. Of via de volgende <a href="https://forms.office.com/Pages/ResponsePage.aspx?id=KiOfzFGYsEayPmQdaAWQ3wQeab5hX9VKmg2j17Cef29UMVUzWUNZT1RKVVNNVjlRSjRBMkNVNVVNWS4u" target="_blank">link</a></div>\EndKnitrBlock{exercise}


Stel dat er wel een voorkeur voor rechtshandigheid is bij padden.
Zeg dat 80% van de padden rechtshandig is.

Met een iets aangepaste code kunnen we weer een steekproef nemen, maar nu van deze populatie:


```r
steekproef2 <- sample(c("links", "rechts"), 18, replace = TRUE, prob = c(0.2, 0.8))
```

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:steekproef2"><strong>(\#exr:steekproef2) </strong></span>Steekproef2

* Neem nu een steekproef van de populatie padden met 80% rechtshandigheid.
* Geef het aantal rechtshandige padden door aan de docent. Of via de link.</div>\EndKnitrBlock{exercise}


Je ziet dat het moeilijk is om de juiste conclusie te trekken uit een steekproef.
Er zit altijd een mate van onzekerheid omheen.

De oplossing is om die onzekerheid goed te omschrijven.
Met een statistische toets neem je de kansverdeling onder de nulhypothese als basis.
In het geval van de padden gaan we onder de nulhypothese er van uit dat er geen verschil is tussen kans op links- of rechtshandigheid bij padden.
Met R code kunnen we die kansverdeling berekenen en in een histogram weergeven:


```r
library(tidyverse)

#10000 steekproeven nemen, resultaat is een matrix
samples <- replicate(10000, sample(c("links", "rechts"), 18, replace = TRUE))
#Matrix omzetten naar een dataframe
samples <- data.frame(samples) %>% gather(key = "steekproef", value = "voorkeur")

#Aantal rechtshandigen per steekproef
rechts <- samples %>% 
  filter(voorkeur == "rechts") %>% 
  group_by(steekproef) %>% 
  count()

#Histogram maken van het gevonden aantal rechtshandige padden per steekproef
rechts %>% 
  ggplot(aes(n)) +
  geom_histogram(binwidth = 1, center = 0, 
    fill = "white", colour = "black") +
  xlab("aantal rechtshandige padden") +
  theme_classic()
```

Met de volgende functie kan je de kans berekenen (onder de nulhypothese) op minstens het aantal rechtshandige padden, als in je eigen steekproef (als voorbeeld minstens 14):


```r
#Op basis van gesimuleerde kansverdeling
sum(rechts$n>=14)/length(rechts$n)

#Op basis van theoretische kansverdeling
binom.test(14,18, alternative = "greater")
```


\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:stattoets"><strong>(\#exr:stattoets) </strong></span>Statistische toets

* Gebruik bovenstaande code om uit te rekenen wat de kans is op minstens zoveel rechtshandige padden als je gevonden hebt in je steekproef (doe dat voor beide steekproeven).
* Stel de drempelwaarde van de kans op fout van de eerste soort op 0,05. Wat is dan je conclusie bij beide steekproeven. Geef dat door aan de docent. Of via de link.
* Als iedereen het heeft uitgevoerd:
    * Hoeveel procent van de studenten verwerpt ten onrechte de nul-hypothese van de eerste steekproef (type I fout)?
    * Hoeveel procent van de studenten verwerpt niet de nulhypothese (type II fout)?</div>\EndKnitrBlock{exercise}

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:oefeningen_H6"><strong>(\#exr:oefeningen_H6) </strong></span>
* 6.1
* 6.2
* 6.3
* 6.7
* 6.8
* 6.10
* 6.12
</div>\EndKnitrBlock{exercise}

