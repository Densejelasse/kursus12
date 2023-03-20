

# opgaven går ud på at bruge data fra statistikbanken til at løse nogle problemstillinger
# vi vil gerne kunne løse problemerne for flere forskellige lande så det hele skal
# samles i EN funktion. 


# 1. Load både rente og inflation fra excelfilerne (hint: se tidligere kode)

# 2. rens dataet, der er en ting i en af dem som gør det træls at arbejde med
# (hint: NA)

# 3. tjek om datoerne passer imellem de to datasæt

# 4. skriv nu en funktion der tager en 3 argumenter. 2 vektorer, rente og inflation,
# og en vektor med datoer som 3. argument. 


analysis <- function(jeres argumenter) {
  
  
  # 4.1 lav en test på om de to vektorer er lige lange, testen kan laves i et if
  # statement. Se om i kan få funktionen til at stoppe hvis de ikke er lige lange
  

  if ( jeres argument) {
    cat("Vi har en fejl og funktionen stoppe her")
    # cat printer her en besked
  }else{
    
    # 4.2 lav realrenten
    # 4.3 hvornår er realrenten negativ
    # 4.4 regresser inflation og rente som AR(1) modellerne
    # 4.5 regresser rente på inflation og gem residualerne
    # tjek om disse er stationære (ny AR(1) regression)
    
    
  
  }
  
  # 4.6 Få alt det i har lavet fra 4.2 til 4.5 spyttet ud i en liste
  
  lOut <- list()
  lOut[["Navn"]] <- værdi
  return(lOut)
  
}

# 5 hvornår er realrenten negativ
# 6 er inflation og rente stationære?
# 7 er de cointegrated




