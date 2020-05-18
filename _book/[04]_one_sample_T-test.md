# t-toets voor één steekproef

\BeginKnitrBlock{ABD}<div class="ABD">
Lees Paragraph 11.3 (*The one-sample t-test*)
</div>\EndKnitrBlock{ABD}

## Geschatte standaarddeviatie
In de vorige les hebben jullie met de normale verdeling gerekend.
Hiermee kan je de waarschijnlijkheid berekenen of een bepaalde steekproef afwijkt van een theoretische waarde.

Allemaal leuk in theorie, maar de praktijk is weerbarstig.
Dat is niet omdat variatie zich niet volgens een normale kansverdeling gedraagt, maar omdat je de standaarddeviatie schat aan de hand van je steekproef.

Als voorbeeld gebruiken we weer het gewicht van de koeien.
Het gewicht is gemiddeld 540 kg met een standaarddeviatie van 5 kg.



\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:stdev"><strong>(\#exr:stdev) </strong></span>standaardeviatie schatten

* Voer de volgende functie uit:
    * `s <- replicate(10000, sd(rnorm(3, 540, 5)))`
* Nu heb je 10000 keer een steekproef getrokken uit de populatie van de koeien, en van iedere steekproef heb je de standaarddeviatie berekend. Maak hier nu een histogram van (op de snelle manier):
    * `hist(s)`
* Wat valt je op?
</div>\EndKnitrBlock{exercise}

## Z-toets
Zoals je in de vorige oefening zag, is gemiddeld je schatting van de standaarddeviatie kleiner dan de werkelijke standaarddeviatie.

Als je dan, op basis van de geschatte standaarddeviatie, de kansverdeling van je nulhypothese opzet, dan is die klokvormige kansverdeling smaller dan in werkelijkheid.
Dus verwerp je sneller je nulhypothese.

Als voorbeeld weer de koeien.

De volgende code voert 10000 keer een Z-toets uit op random steekproeven van n=3, met de juiste standaarddeviatie:


```r
#Functie om steekproef te nemen en z-toets erop uit te voeren
z_sigma <- function(n, mean, sigma) {
  sample <- rnorm(n, mean, sigma)
  p <- pnorm(mean(sample), mean, sigma/sqrt(n))
}

#10000 keer bovenstaande functie uitvoeren
ps <- replicate(10000, z_sigma(n=3, mean=540, sigma=5))

#welke fractie van de samples verwerpt (ten onrechte!) de H0?
alpha=0.05
length(ps[ps<alpha])/length(ps)
```

```
## [1] 0.0519
```

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:ztoets"><strong>(\#exr:ztoets) </strong></span>Z_sigma

* Neem bovenstaande code over in een script, en voer uit.
* Varieer met de $\alpha$ en check of de fractie significant afwijkende steekproeven de \alpha volgt.
</div>\EndKnitrBlock{exercise}


Stel nu dat we de standaarddeviatie van de populatie niet weten, dan moeten we die schatten vanuit de steekproef.
Wat heeft dat voor consequenties voor de fout van de eerste soort (ten onrechte H0 verwerpen)?

Dat kan je testen met de volgende code:


```r
#Functie om steekproef te nemen en z-toets erop uit te voeren
z_sigma <- function(n, mean, sigma) {
  sample <- rnorm(n, mean, sigma)
  p <- pnorm(mean(sample), mean, sd(sample)/sqrt(n))
}

#10000 keer bovenstaande functie uitvoeren
ps <- replicate(10000, z_sigma(n=3, mean=540, sigma=5))

#welke fractie van de samples verwerpt (ten onrechte!) de H0?
alpha=0.05
length(ps[ps<alpha])/length(ps)
```

```
## [1] 0.1208
```

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:zstschat"><strong>(\#exr:zstschat) </strong></span>Z_s

* Neem bovenstaande code over in een script, en voer uit.
* Varieer met de $\alpha$ en check of de fractie significant afwijkende steekproeven de $\alpha$ volgt.
* Herhaal met n=30 (dus een steekproefgrootte van 30)
* Wat is het verschil?
</div>\EndKnitrBlock{exercise}

##t-verdeling
In de vorige oefening zag je het effect van een te kleine schatting van je standaarddeviatie op het voorkomen van een type-1-fout (ten onrechte verwerpen van de Ho).
Dit is vooral een probleem bij kleine steekproeven.
In een beroemd wetenschappelijk artikel van een mederwerker van Guinness (onder pseudoniem *Student*), wordt dit probleem uitgelegd en een oplossing gegeven.
De oplossing is om een aangepaste kansverdeling te gebruiken: de **t-verdeling**:

![]([04]_one_sample_T-test_files/figure-latex/unnamed-chunk-4-1.pdf)<!-- --> 

In rood is de t-verdeling en met een zwarte lijn is de normale verdeling geplot.
Je ziet dat de staarten van de t-verdeling dikker zijn dan de normale verdeling.
In de volgende paragraaf gaan we aan de slag met de t-toets die i.t.t. de z-toets wel rekening houdt met het effect van steekproefgrootte op de kansverdeling.

## one-sample t-test in R
De functie voor de t-toets in R is `t.test()`.
Deze functie heeft als *argument* een vector (rij data) nodig.
Daarnaast kan je onder andere de volgende opties aangeven:

* mu = ... (een getal waartegen je de dataset test, standaard is 0)
* alternative = (kies uit "greater" of "less" als je eenzijdig wilt testen)


Als voorbeeld willen we testen of het gemiddelde voor biocalculus1 hoger ligt dan 6:


```r
library(readxl)
cijfers <- read_excel("../data/cijfers.xlsx")
```



```r
t.test(cijfers$biocalculus, mu=6, alternative = "greater")
```

```
## 
## 	One Sample t-test
## 
## data:  cijfers$biocalculus
## t = 3.3258, df = 205, p-value = 0.0005223
## alternative hypothesis: true mean is greater than 6
## 95 percent confidence interval:
##  6.215195      Inf
## sample estimates:
## mean of x 
##   6.42767
```

In bovenstaande output zie je de berekende t-waarde (*t*), het aantal vrijheidsgraden (*df*) en de p-waarde (*p-value*).
Verder ook het betrouwbaarheidsinterval (die voor een eenzijdige toets naar oneindig loopt (*inf*) en het gemiddelde van de steekproef.

Om te checken of de t-toets wel een betrouwbare p-waarde geeft voor de waarschijnlijkheid dat de H0 waar is, kan je de volgende code uitvoeren:


```r
#Nu met t-toets
ttoets <- function(n, mu, sigma) {
  sample <- rnorm(n, mu, sigma)
  return(t.test(sample, mu=mu)$p.value)
}

#10000 keer bovenstaande functie uitvoeren
tp <- replicate(10000, ttoets(n=3, mu=540, sigma=5)) 

#Fractie gevallen waarin H0 ten onrechte wordt verworpen
alpha <- 0.05
length(tp[tp<alpha])/length(tp)
```

```
## [1] 0.0492
```


In 1996 heeft statistiekdocent Allen Shoemaker een dataset met lichaamstemperatuur, hartslag en geslacht van 130 studenten gepubliceerd.
Op blackboard vind je een naar Celsius omgerekende versie hiervan.

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:onesamplettest"><strong>(\#exr:onesamplettest) </strong></span>Eenzijdige t-toets

* Test met een eenzijdige t-toets of de gemiddelde lichaamstemperatuur afwijkt van 37°.
    * Schrijf eerste de nulhypothese en alternatieve hypothese op.
    * Voer de toets en geef de conclusie.
</div>\EndKnitrBlock{exercise}
