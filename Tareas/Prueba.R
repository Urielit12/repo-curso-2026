library(tidyverse)
library(nycflights13)
flights
glimpse(flights)

#Hola estoy probando



#Buscamos solo los vuelos cuyo destino es IAH
flights |>
  filter(dest == "IAH") |> 
  group_by(year, month, day) |> 
  summarize(
    arr_delay = mean(arr_delay, na.rm = TRUE)
  )


planes |>
  filter(model == "EMB-145XR") |> 
  group_by(year, engine, seats)
  


# cargar librerias --------------------------------------------------------
llibrary (tidyverse)

anac_2025 <- read_csv()

  
  