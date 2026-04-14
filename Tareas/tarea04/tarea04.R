library(tidyverse)
library(nycflights13)

glimpse(flights)


#Seccion 3.5.6:
#Ejercicio 1.1
flights |> 
  filter(dep_delay > 120)

#Ejercicio 1.2
flights |>
  filter(dest == "IAH" | dest == "HOU")

#Ejercicio 1.3
flights |> 
  filter(carrier == "UA" | carrier == "AA" | carrier == "DL")


#Ejercicio 1.4
flights |> 
  filter(month == 7 | month == 8 | month == 9)

#Ejercicio 1.5
flights |> 
  filter(arr_delay > 120, dep_delay <= 0)

#Ejercicio 1.6
flights |> 
  filter(dep_delay >= 60, (dep_delay - arr_delay) > 30)


#Ejercicio 2.1
flights |> 
  arrange(desc(dep_delay))


#Ejercicio 2.2
flights |> 
  arrange(dep_time)


#Ejercicio 3
flights |> 
  arrange(desc(distance / air_time))


# Ejercicio 4
flights |> 
  distinct(year, month, day)


#Ejercicio 5.1 El que viajó más lejos
flights |> arrange(desc(distance))

#Ejercicio 5.2 El que viajó menos
flights |> arrange(distance)

#Ejercicio 6: En cuanto al resultado final, sera el mismo si primero se filtra-
# y luego se usa el arrange. En cuanto a eficacia u orden al momento de traba-
#jar una base de datos, es mejor filtrarlos y luego ordenarlos, ya que es menos
#el trabajo que tiene que hacer el arrange si ya los datos estan filtrados.


#Seccion 3.2.5:
#Ejercicio 1
flights |> 
  mutate(
    #Convierto la hora programada a minutos desde la medianoche
    sched_dep_time_min = (sched_dep_time %/% 100) * 60 + (sched_dep_time %% 100),
    #Convierto la hora real a minutos desde la medianoche
    dep_time_min = (dep_time %/% 100) * 60 + (dep_time %% 100),
    #Calculo la diferencia
    diferencia_calculada = dep_time_min - sched_dep_time_min
  ) |> 
  select(dep_delay, diferencia_calculada, everything())


#Ejercicio 3:
flights |> 
  select(year, month, year, day, year)
#Conclusion: R no repite la columna, simplemente hace caso omiso a la segunda vez-
#que la menciono, y toma una unica vez dicha columna al momento de seleccionarlas.


#Ejercicio 4: any_of() permite seleccionar columnas usando un vector de nombres
# (strings), pero Si le pasás una lista de nombres y falta uno solo en el dataset-
#R no frena el script, sino que omite a el faltante, a diferencia del all_of.

variables <- c("year", "month", "day", "dep_delay", "arr_delay", "un_invento")

flights |> 
  select(all_of(variables))

flights |> 
  select(any_of(variables))

#Hice la prueba, verifica lo dicho.


#Ejercicio 5:
flights |> select(contains("TIME"))
#R ignora las mayusculas y toma como valido el que diga "time" en minuscula.
#Para que no lo ignore, se deberia hacer esto:

flights |> select(contains("TIME", ignore.case = FALSE))


#Ejercicio 6:
flights |> 
  rename(air_time_min = air_time) |> 
  relocate(air_time_min)

#Ejercicio 7:
flights |> select(tailnum) |> arrange(arr_delay)
#Falla ya que al seleccionar tailnum, ya no existe arr_delay. Habria que o bien
#seleccionar ambas y luego hacer arrange al arr_delay, o primero hacer arrange
#y luego hacer el select.




#Seccion 3.5.7:

#Ejercicio 1:
flights |> 
  group_by(carrier) |> 
  summarize(
    retraso_promedio = mean(arr_delay, na.rm = TRUE)
  ) |> 
  arrange(desc(retraso_promedio))

flights |> 
  group_by(carrier, dest) |> 
  summarize(
    n = n(), 
    retraso_promedio = mean(arr_delay, na.rm = TRUE),
    .groups = "drop"
  ) |> 
  arrange(desc(retraso_promedio))


#Ejercicio 2:
flights |> 
  group_by(dest) |> 
  slice_max(dep_delay, n = 1) |> 
  select(dest, month, day, dep_delay, carrier)


#Ejercicio 3:
retrasos_por_hora <- flights |> 
  group_by(hour) |> 
  summarize(
    avg_dep_delay = mean(dep_delay, na.rm = TRUE)
  )

ggplot(retrasos_por_hora, aes(x = hour, y = avg_dep_delay)) +
  geom_line() + 
  geom_point() +
  labs(title = "Retraso promedio según la hora del día")


#Ejercicio 4
flights |> 
  slice_min(dep_delay, n = -5)
#R da todos los datos excepto los 5 más grandes.


#Ejercicio 5
flights |> 
  group_by(dest) |> 
  summarize(n = n()) |> 
  arrange(desc(n))

flights |> 
  count(dest, sort = TRUE)
#count() hace el group_by(), el summarize(n = n()) y el arrange(desc(n))
#todo junto usando el sort true.


#Ejercicio 6
df <- tibble(
  x = 1:5, 
  y = c("a", "b", "a", "a", "b"), 
  z = c("K", "K", "L", "L", "K")
)

df |> group_by(y)#
#no cambia los datos, solo los AGRUPA internamente por y

df |> arrange(y)
#ORDENA las filas por y.

df |> group_by(y) |> summarize(mean_x = mean(x))
#Calcula el promedio de x por cada grupo de y.

df |> group_by(y) |> summarize(mean_x = mean(x))
#Promedio de x por combinaciones de y y z.

df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x), .groups = "drop")
#Mismo resultado, pero elimina todos los grupos.

df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))
#summarize reduce datos, los promedia.

df |>
  group_by(y, z) |>
  mutate(mean_x = mean(x))
#Mantiene todas las filas y agrega columna con el promedio por grupo.


#JOINS

#EJERCICIO 1
#La relación faltante es entre weather y airports, conectando weather.origin-
#con airports.faa

#EJERCICIO 2
#Aparecería una nueva relación con flights.dest, ya que el clima también podría-
#asociarse al aeropuerto de destino

#Ejercicio 3
#La duplicación ocurre porque durante el cambio al horario de verano una hora-
#se repite

#Ejercicio 4:
#Se modela como una tabla con clave primaria date, Relacionada con flights- 
#mediante la fecha derivada de sus variables del tiempo.

