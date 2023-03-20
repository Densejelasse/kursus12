#general information---------

# Title: Script
# Beskrivelse: Kodefil der indeholder scriptet til hele R-kursus for ØF
# Dato: 20-03-2023
# Uddybbende: ...


# opsætning af nyt script, grammatik osv -----

rm(list = ls())
cat("\014") #fjerne alt fra "console", ctrl + L kan gøre det samme

# Dette hjælpe os med at fjerne alt det som vi har lavet før og ikke skal bruges nu

# Hvordan finder man Working directory? getwd()

getwd()

# er den rigtig? ellers er en god ide at bruge Session > Set Working Directory
# > Choose Directory (eller ctrl+shift+h)

# setwd("C:/Users/Lasse H. Krejberg/Desktop/R-kursus")

# Programmatik

# Notation: brug hungarian notation
# iN - integer/heltal
# dN - double/reeltal
# vN - vektor
# mN - matrix
# lN - liste
# sN - string/ord
# ...

# forskellige data klasser etc.------


# vektor og matricer

# en vektor
vX <- c(1:9)
vX

# og matrix

mY <- matrix(c(1:27), nrow = 3, ncol = 9, byrow = T)
mY

# hvordan ganges de sammen

mY * vX
mY %*% vX
vX %*% mY


# andre dataformer?

dfA <- data.frame(rnorm = rnorm(10), col = c("red", "green"))
dfA

# hvad er forskellen

mA <- matrix(c(1, 2, 3, "red"), 2, 2)
mA[1, 1] * mA[1, 2]

# dette virker ikke, da alle indgange står som en "character", dette kan ses ved
# at bruge class, class viser hvordan R har læst enten data, indgange eller andet..

class(mA[1, 1])

# Man skal altså huske at have styr på hvordan data ser ud


# lister kan derimod være fuldstændigt uafhængige af hinanden

lM <- list()

lM[[1]] <- c(1:9)
lM[[2]] <- c(c("red", "green"))
class(lM)

lM[[1]][2] * lM[[1]][2]

# men man kan selvfølgelig stadig ikke gange rød med 1


# brug af loops og lignende apply funktion------
iN <- 1e6
vZ <- numeric(iN)
set.seed(1)
for (i in 1:iN) {
  vZ[i] <- rnorm(1, i, i*5)
}
vZ


# hvad burde man gøre i dette tilfælde?
set.seed(1)
vQ <- rnorm(iN, 1:iN, 1:iN*5)
vQ


identical(vZ, vQ)
# hvornår burde man bruge loops? når ting ikke kan sættes på vektorform


# vektorisering af loops (brug af R-funktioner der er bedre end loops)

# apply funktioner er rimeligt fede?
set.seed(1)
mY <- matrix(rnorm(5*100), ncol = 5)
mY

sd(mY) #dette kan jo ikke rigtig bruges?

# for-loop
vSTD1 <- numeric(ncol(mY))
for (i in 1:ncol(mY)){
  vSTD1[i] <- sd(mY[, i])
}
vSTD1

# vi tjekker lige apply funktionen
?apply

vSTD2 <- apply(mY, 2, sd)
vSTD2

# if- statements ---------

# vi kan her bare bruge vores data fra før 
if(mY > 0) {mY = 1} else{mY = 0} # det virker ikke

# vi prøver nu et dobbelt for-loop, bøvlet og svært

for (j in 1:ncol(mY)){
  for (i in 1:nrow(mY)){
    if(mY[i, j] > 0) {mY[i, j] = 1}
    else {mY[i, j] = 0}
  }
}
mY


# hvad burde vi gøre? vi søger på google og finde ud af at vi kan bruge "ifelse"
# (vektorisering af if-else statements)
ifelse(mY > 0, 1, 0)

# if-else statements er en måde at explicit specificere en slags logisk test på
# en logisk test er også noget der kan bruges til at manipulere vektor of matricer 
# på. 
# hvis vi kigger på vQ fra før kan man i fikantede paranteser [] også indsætte
# statements og hive ting ud

# vi vil gerne have alle negative værdier i en vektor og alle positive i en anden
vQ[vQ < 0]
vQ[vQ > 0]

# andre typer af statements kan bruge i while-loops såsom ==, !=, ||, && osv.
i <- 1
sum <- 0
while (i != 101) {
  sum <- sum + i #summer tallene
  
  i <- i + 1 #argument der stopper while loopet, placeres oftest til sidst
}


# gode vaner i simple funktioner? ----------

# herunder en funktion af to variable
Rosenbrock <- function(dX, dY){
  Out <- (1 - dX)^2 + 100 * (dY - dX^2)^2
  return(Out)
}

Rosenbrock(5, 5)


# global vs lokal
# funktion-variable er ikke defineret globalt, men kun inde i funktionen. Der kan
# opstå problemer hvis man skal bruge en global variabel men kun skal bruge den
# lokalt og omvendt

# vi vil for eksempel gerne have to funktioner der hver især spytter en lige lang
# tidsserie ud. Return af 2 aktieafkast følger henholdsvis

return_norm <- function(iT, dMean, dSd) {
  
  return(rnorm(iT, mean = dMean, sd = dSd))
  
}

# og

return_t <- function(iT, dDf) {
  
  return(rt(iT, df = dDf))
  
}

iT <- 1000

return_norm(iT, 0, 3)
return_t(iT, 2)

# eksemplet er meget simplificeret men man skal huske på at hvis der er variable
# som skal bruges meget, går igen osv så burde de være globale. Hvis de er globale
# kan de stadig ændres internt i funktionen. Men hvis de er lokale i funktionen 
# skal de ændres i alle funktioner hver gang
return_norm(1, 0, 3)


# funktioner-i-funktioner

# har man en funktion som gerne skulle bruge sin egen værdi forstå R godt dette
# et eksempel der muligvis er kendt er binomial koefficienten
binom <- function(iN, iK) {
  if(iN == iK | iK == 0) {
    return (1)
  } else {
    return (binom(iN-1, iK-1) + binom(iN-1, iK))
    
  }
}
binom(6, 3)


# vi kan bruge R's indbyggede funktion for at se om det virker
factorial(6)/(factorial(3)*factorial(3))

# R kan altså godt finde ud af at bruge funktionen inde i funktionen. Andre mere
# omfattende funktioner kan også igen bruge funktioner i funktioner.

# hvordan loades der datasæt ind i R-----
# (dataet bliver brugt i de efterfølgende funktioner og en opgave)?

# Data kan være besværligt at få ind uden at visualisere det først. Koden kan være
# bøvlet og der er mange ting man skal huske på
?read.csv

# Det er en god ide at bruge import Dataset under environment i stedet. Her kan
# koden også efterfølgende kopieres

# rente <- read.csv("C:/Users/Lasse H. Krejberg/Desktop/R-kursus/rente.csv", header=FALSE, row.names=1)

# alternativt skrives koden en gang og kopieres hver gang (husk at setwd() skal bruges)

rente <- read.table(file = "rente.csv",
                    sep = ",", dec = ".",
                    header = F, row.names = 1,
                    na.strings = "null")

# dette datasæt er faktisk rigtig pænt. Det kan vi tjekke

any(is.na(rente)) #er der NA med, hvis ja så which(is.na(NVO)) for at finde dem

# max og min for at se om tingene er mærkelige i eksempelvis volume

max(rente[, 1])
min(rente[, 1])

# hvis vi vil vide hvilken dag dette skete på kan vi bruge følgende

which(rente[, 1] == max(rente[, 1]), arr.ind = T) #hvis vi havde datoer med
# eller
which(rente[, 1] == max(rente[, 1]))

# vi kan også hurtigt plotte renten

ts.plot(rente[, 1], type = "l", col = "red")
# her er x-aksen grim fordi at den ikke ved at det er en tidsserie med datoer i
# kolonne 1. Det kan man altid lege med og ændre hvis man synes. Vi starter
# bare i 0. Der findes pakker der kan løse problemet


#(ex med hjemmelavet data hvis der er tid)----

data <- c(rnorm(100), NA, 3, 1, NA, rnorm(100))
data
any(is.na(data))
which(is.na(data))
na.omit(data)
#----




# optimering i R, herunder gode vaner til funktioner der er mere omfattende----

# for at vise den næste opgave skal vi bruge noget data. R har meget indbygget
# data, og man kan også finde data i pakker. 

data("EuStockMarkets")
head(EuStockMarkets)

# vi vil gerne regne returns
ret <- diff(log(EuStockMarkets)) * 100

MV_filt <- function(vW, mY) {
  
  # funktionen tager det data vi vil bruge og den vektor af vægte vi vil optimere
  # den skal retunere værdien af variansen af en portefølje af alle aktiver
  Sigma <- cov(mY)
  
  Var_port <- t(vW) %*% Sigma %*% vW
  Ret_port <- vW %*% apply(mY, 2, mean)
  
  lOut <- list()
  
  lOut[["Var"]] <- Var_port
  lOut[["Ret"]] <- Ret_port
  return(lOut) # vi vil gerne have et tal
}

optimizer <- function(mY){
  
  # vi skal have initialiseret alle vægtene. Der husker vi at vægtene skal være
  # lokale og ikke globale. 
  
  vW <- rep(1/ncol(mY), ncol(mY))
  # nu er alle vægte ens
  # vi finder ud af at vi kan bruge en ikke-lineær optimeringsalgoritme. Dette 
  # kræver en pakke der hedder Rsolnp
  
  require(Rsolnp)
  
  optim <- solnp(vW, function(vW, mY) {
    
    Out <- MV_filt(vW, mY)$Var #det er variansen vi skal have her
    
    return(as.numeric(Out))
  }, mY = mY, eqfun = function(vW, ...) {sum(vW)}, eqB = 1)
  
  # vi vil gerne have varianssen, return og vægtene
  
  vW <- optim$pars #vægte
  Var <- tail(optim$values, 1)
  Ret <- MV_filt(vW, mY)$Ret
  
  lOut <- list()
  lOut[["Var"]] <- Var
  lOut[["vW"]] <- vW
  lOut[["Ret"]] <- Ret
  return(lOut)
}

optimizer(ret)


# Pakker -----

# pakker i R er en fantastisk ting. Der er ikke nogen som ikke har haft jeres 
# problemstilling før. Mange vil bidrage og derfor findes der en pakke til alt

# til at lave porteføljesortering - portsort
# til at lave VAR modeller - vars
# til at lave ekstremt fede datamanipulationer - tidyverse (tidyverse er endda
# flere pakker i en - ggplot2, dplyr osv.)

# dadjoke - den kan vi lige prøve
install.packages("dadjoke")
library(dadjoke)
?dadjoke
dadjoke()

# googlesøgninger-----

# googlesøgninger er klart vigtigst for at blive god til R

# hvad kan vi ikke finde ud af? søg på google, og brug for det meste stackoverflow

# brug af hjælp-funktionen

?regression
??regression
??OLS

# det er godt nok træls, vi går på google

# "how to make a regression in R stackoverflow"

# vi finder ud af at lm er det vi skal bruge

?lm #nu kan vi specifikt finde ud af hvad lm gør, herunder hvordan man trækker
# værdier ud osv. (under help)


