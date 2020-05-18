# Onafhankelijke t-toets:

\BeginKnitrBlock{ABD}<div class="ABD">
Lees Paragraph 12.3 (*Two-sample comparison of means*)
NB: je hoeft niet de berekeningen te kennen.
</div>\EndKnitrBlock{ABD}

Bij een *one-sample t-test* en een gepaarde t-toets heb je te maken met één rij data waarvan je wilt weten of het gemiddelde ervan significant afwijkt van een bepaalde waarde.
Maar vaak heb je te maken met meerdere groepen waarvan je wilt weten of ze écht van elkaar verschillen.
De nulhypothese is dan dat het gemiddelde van de groepen niet van elkaar verschillen.
Dat is een subtiel verschil met de gepaarde t-toets waarbij je voor iedere herhaling verwacht dat eerste en tweede behandeling gelijk aan elkaar zijn.

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:welnietgepaard"><strong>(\#exr:welnietgepaard) </strong></span>Gepaard of niet?

* Los *Practice problem* 12.4 (blz. 355) op
</div>\EndKnitrBlock{exercise}

##Standaarddeviatie

Bij een *one-sample t-test* is het recht-toe-recht-aan om de standaarddeviatie te schatten.
Je hebt één rij data waarvan je gemiddelde en steekproefstandaarddeviatie berekent.
Aan de hand daarvan bepaal je hoe waarschijnlijk je afwijking is ten opzichte van je nulhypothese.

In de traditionele **onafhankelijke t-toets** (*independent t-test*) wordt de standaarddeviatie van het verschil in de gemiddelde waardes van beide groepen geschat via een gewogen gemiddelde van de standaarddeviaties in beide groepen.
Dat werkt alleen als de standaarddeviatie niet te veel verschilt tussen de twee groepen.

Verschilt de standaarddeviatie flink van elkaar, dan kan je bovenstaande aanpak niet gebruiken.
Je moet dan een alternatieve toets gebruiken, de **Welch's t-toets**.
Deze toets maakt niet de aanname dat de standaarddeviatie gelijk is in beide groepen.

In de praktijk wordt tegenwoordig aangeraden om **altijd** de Welch's t-toets te gebruiken, tenzij je sterke aanwijzing hebt dat je de standaardeviaties voor beide groepen gelijk zijn.
Zie ook het volgende [artikel](https://academic.oup.com/beheco/article/17/4/688/215960).


##T-toets in R
De *one-sample t-test*, de gepaarde t-toets, de onafhankelijke t-toets en de Welch's t-toets zijn allemaal uit te voeren met de volgende functie: `t.test()`.

In dit hoofdstuk willen we twee groepen vergelijken.
Dat kan je op twee manieren aangeven in `t.test()`:

* `t.test(g1, g2)`
* `t.test(v~g)`

De eerste optie is hetzelfde als je bij de gepaarde t-toets hebt gezien: g1 en g2 zijn twee vectoren.
In tegenstelling tot bij de gepaarde t-toets, hoeft bij een onafhankelijke t-toets of Welch's t-toets beide vectoren niet even lang te zijn.

De tweede optie heeft de voorkeur.
Waarom? Omdat die aansluit bij de standaardmanier om je data te organiseren.
Heb je bijvoorbeeld de lengte van planten gemeten in twee groepen (bijv, met of zonder bemesting), dan is dit de manier om je data in een tabel te zetten:


\begin{tabular}{l|r}
\hline
behandeling & plantlengte\\
\hline
controle & 15\\
\hline
controle & 17\\
\hline
controle & 16\\
\hline
controle & 14\\
\hline
controle & 16\\
\hline
bemest & 15\\
\hline
bemest & 23\\
\hline
bemest & 21\\
\hline
bemest & 27\\
\hline
bemest & 18\\
\hline
\end{tabular}

Met de tweede optie (`v~g`) geef je aan dat de vector verdeeld is in groepen (aangegeven met de variabele g).
In het geval van het bemestingsexperiment voor je met de volgende code de Welch' t-toets uit: `t.test(plantdata$plantlengte~plantdata$behandeling)`.
De standaardinstelling van R voor `t.test()` is dat er **geen** gelijke variantie wordt aangenomen, dus de Welch't-toets wordt uitgevoerd.
Wil je wel een 'gewone' onafhankelijke t-toets uitvoeren, moet je expliciet aangeven dat er gelijke standaarddeviatie wordt aangenomen voor beide groepen (`t.test(v~g, var.equal = TRUE)).

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:bemesting"><strong>(\#exr:bemesting) </strong></span>Bemesting

* Voer de data uit bovenstaande tabel in een Excel file
* Formuleer de H~0~ en H~1~
* Maak een script die de data importeert en een t-toets uitvoert.
* Wat is je conclusie?
</div>\EndKnitrBlock{exercise}

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:muggen"><strong>(\#exr:muggen) </strong></span>Bier en muggen

* Voer *Practise problem* 12.16 (blz. 359) uit
</div>\EndKnitrBlock{exercise}

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:oef_H12"><strong>(\#exr:oef_H12) </strong></span>Maak de volgende oefeningen uit het boek:

* 12.4
* 12.5
* 12.8
* 12.11
</div>\EndKnitrBlock{exercise}

