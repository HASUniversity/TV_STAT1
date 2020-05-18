# Normale verdeling

\BeginKnitrBlock{ABD}<div class="ABD">
Lees Chapter 10 (*Normal distribution*), behalve 10.2, 10.4 en 10.7.
</div>\EndKnitrBlock{ABD}

Zoals jullie in blok 2 hebben geleerd, gedraagt veel variatie zich op een karakteristieke manier die omschreven kan worden als de **normale verdeling**.

Ter illustratie hieronder een histogram van de gemiddelde cijfers van het HAVO-eindexamen biologie per school weergegeven.
Je ziet dat de verdeling min of meer een normale verdeling volgt (de zwarte lijn).

![]([03]_normal_distribution_files/figure-latex/unnamed-chunk-2-1.pdf)<!-- --> 


\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:nverdeling"><strong>(\#exr:nverdeling) </strong></span>normale verdeling

* Op basis van welke twee parameters is bovenstaande normale verdeling gebaseerd?
</div>\EndKnitrBlock{exercise}

##R als alternatief voor een tabel
In blok 2 heb je, met behulp van een tabel, de volgende vraag op kunnen lossen:

> Koeien van het ras Holstein-Friesian hebben gemiddeld een gewicht van 540 kg, met een standaarddeviatie van 5 kg.
De vraag is: Hoe hoog is de fractie koeien van het ras Holstein-Friesian met een gewicht tussen 542 en 545 kg?

Hoe pakte je dat aan in blok 2?
Het gaat om de volgende verdeling: $\underline{x} \sim N(\mu=540, \sigma=5)$.
Fractie koeien tussen 542 en 545 kg: $P(542<\underline{x}<545)$.

Volgende stap is omrekenen naar de standaard normale verdeling, je berekent dan de z-waardes van 542 en 545 kg: $P \left( \frac{542-540}{5}<Z< \frac{545-540}{5} \right)$.

Vervolgens zoek je in de tabel de kans op $P \left( Z>\frac{2}{5} \right)$ en $P \left( Z>\frac{5}{5} \right)$ en trek deze van elkaar af: $0.3446-0.1587 = 0.1859$

In plaats van de tabel, kan je ook R-code gebruiken: `pnorm()`.
NB: deze functie berekent standaard $P \left( \underline{x}<q \right)$, dus de *lower tail* als je een normale verdeling bekijkt.
Wil je het oppervlak aan de rechterkant van q weten, voeg dan het argument `lower.tail = FALSE` toe.
Verder kan je ook aangeven wat het gemiddelde en de standaarddeviatie is, je hoeft dus niet eerst de z-waarden uit te rekenen.
Wil je nu weten welke fractie koeien tussen 542 en 545 kg is, voer dan de volgende code uit:


```r
pnorm(542, mean = 540, sd = 5, lower.tail = FALSE) - 
  pnorm(545, mean = 540, sd = 5, lower.tail = FALSE)
```

Of korter:


```r
pnorm(542, 540, 5, lower.tail = FALSE) -
  pnorm(545, 540, 5, lower.tail = FALSE)
```

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:koe1"><strong>(\#exr:koe1) </strong></span>Koeien, deel 1

* Schets de normale verdeling van het gewicht van de koeien.
* Geef met twee kleuren aan welke oppervlakken met bovenstaande code worden uitgerekend.
</div>\EndKnitrBlock{exercise}


Stel, we willen weten welk deel van de populatie koeien minder dan 430 kg weegt.
Het gaat dan om het rood gekleurde deel in onderstaande grafiek:

![]([03]_normal_distribution_files/figure-latex/unnamed-chunk-5-1.pdf)<!-- --> 


\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:koe2"><strong>(\#exr:koe2) </strong></span>Koeien

* Bereken de fractie koeien lichter dan 430 kg.
</div>\EndKnitrBlock{exercise}


##Hypotheses toetsen
Een boer vermoedt dat zijn koeien lichter zijn dan de gemiddelde Holsteiner-Friesian. 
Hij zet een koe op de weegschaal, en leest 535 kg af.

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:koe3"><strong>(\#exr:koe3) </strong></span>Koe, deel 3

* Bereken m.b.v. pnorm() hoe waarschijnlijk het is dat je een koe hebt die 535 kg of minder weegt bij een populatiegemiddelde van 540 kg en standaarddeviatie van 5 kg.
</div>\EndKnitrBlock{exercise}

Bovenstaande opgave is de essentie van een statistische toets.
Je stelt een nulhypothese op:

> Het gewicht van de koeien van de boer wijkt niet af van het gewicht van Holstein-Friesian koeien.

Blijkt je steekproef heel onwaarschijnlijk te zijn onder de nulhypothese, dan verwerp je deze, en neem je de alternatieve hypothese aan.
In dit geval gaat het om een eenzijdige toets (de boer denkt dat zijn koeien lichter zijn).

In het geval dat de boer vermoedt dat het gewicht **afwijkt** van Holstein-Friesians, dan hebben we het over een tweezijdige toets.
De kans op een minstens zo grote afwijking als gevonden kan twee kanten op zijn:

* lichter dan 535 kg
* zwaarder dan 545 kg

Hieronder is die kans geïllustreerd:

![]([03]_normal_distribution_files/figure-latex/unnamed-chunk-6-1.pdf)<!-- --> 

Je ziet dus dat als je tweezijdig toetst, de waarschijnlijk dat minstens zo'n grote afwijking voorkomt, twee keer zo groot is dan als je eenzijdig toetst.

De boer slaat er zijn statistiekaantekeningen op na, en komt tot de conclusie dat hij een grotere steekproef moet nemen.
Hij zet 6 koeien op een weegbrug en leest 3216 kg af, dus het steekproefgemiddelde is 536 kg.

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:koe4"><strong>(\#exr:koe4) </strong></span>Koe, deel 4

* De standaarddeviatie voor het gewicht van één Holstein-Friesiankoe is 5 kg. Wat wordt de standaarddeviatie voor een steekproef van 6 koeien?
* Bereken, met deze standaarddeviatie de waarschijnlijk van maximaal een gemiddeld gewicht van 536 als de nulhypothese waar is?
* Bereken de waarschijnlijkheid als je tweezijdig toetst.
</div>\EndKnitrBlock{exercise}

