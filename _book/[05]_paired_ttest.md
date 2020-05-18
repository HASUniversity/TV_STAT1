# Gepaarde t-toets

\BeginKnitrBlock{ABD}<div class="ABD">
Lees Paragraph 12.1 (*Paired sample versus two independent samples*)

Lees Paragraph 12.2 (*Paired comparison of means*)
</div>\EndKnitrBlock{ABD}

Met een enkelvoudige t-toets (*one-sample t-test*) bereken je de overschrijdingskans van een steekproef t.o.v. een **normaal** verdeelde waarde.
Een voorbeeld van vorige week: "wat is de kans op een gemiddeld gewicht van een steekproef van 5 koeien van kleiner of gelijk aan 530 kg, aangenomen dat een koe gemiddeld 540 kg weegt?".

In de vorige les hebben jullie ontdekt dat de kansverdeling van een steekproefgemiddelde alleen een normale verdeling volgt als je van tevoren weet wat de standaarddeviatie is in je populatie.
Wanneer je dat niet weet, en de standaarddeviatie schat aan de hand van je steekproef, dan wijkt de verdeling iets af van de normale verdeling.
Deze kansverdeling volgt een t-verdeling.
Door een t-toets te gebruiken, i.p.v. een z-toets, kan je wel de juiste overschrijdingskans berekenen.

## Gepaarde data
De *one-sample t-test* kan je ook gebruiken als je verschillen tussen twee behandelingen wil laten zien als de data **gepaard** is.
Je laat bevoorbeeld studenten een wiskundetoets doen voor en na een paar glazen bier.
Natuurlijk verwacht je dat je rekencapaciteit achteruit gaat na het drinken van bier (toch?),
De hypotheses zijn:

>H~0~: Score vóór drinken is gelijk aan score ná het drinken van bier.

>H~1~: Score vóór drinken is lager dan score ná het drinken van bier.

Onder de H~0~ verwacht je dat de score voor en na het drinken van bier gemiddeld gelijk is.
Met andere woorden: het verschil tussen voor en na is gemiddeld 0.
Stap 1 is voor iedere student het verschil te berekenen tussen beide testen.
Stap 2 is om te berekenen wat de overschrijdingskans is van deze uitkomst als de H~0~ waar is.
Dat doe je met een *one-sample t-test*.

Maar deze twee stappen kan je ook in één keer uitvoeren met een gepaarde t-toets (*paired t-test*).

##Gepaarde t-toets
Belangrijk met gepaarde data is dat het helder is welke metingen bij elkaar horen.
Dat doe je door op de volgende manier je data te ordenen:


\begin{tabular}{r|r|r}
\hline
student & voor & na\\
\hline
1 & 7 & 5\\
\hline
2 & 4 & 4\\
\hline
3 & 6 & 5\\
\hline
4 & 9 & 7\\
\hline
5 & 5 & 5\\
\hline
\end{tabular}

Wanneer je de data ingelezen hebt in R (bijv. als objectnaam `bier`), kan je met de volgende functie een gepaarde t-toets uitvoeren:


```r
t.test(bier$voor, bier$na, paired = TRUE)
```
\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:machomerels"><strong>(\#exr:machomerels) </strong></span>Macho merels

* Download met de volgende functie de data van de *Red-winged Blackbirds*:
    * `blackbird <- read.csv(url("http://www.zoology.ubc.ca/~schluter/WhitlockSchluter/wp-content/data/chapter12/chap12e2BlackbirdTestosterone.csv"))`
* Voor dezelfde toets uit als in het boek. Check evt. de opties voor de functies via de code `?t.test`

</div>\EndKnitrBlock{exercise}

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:oef_H11"><strong>(\#exr:oef_H11) </strong></span>Maak de volgende oefeningen uit het boek:

* 11.5
* 11.11
</div>\EndKnitrBlock{exercise}

