library(tidyverse)
library(palmerpenguins)

#Ejercicios 1.2.5 ----
#Ej 1
nrow(penguins)
ncol(penguins)

#Ej 2:
#Expresa la longitud del pico en milimetros

#Ej 3:
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point()

#Ej 4:
ggplot(penguins, aes(x = species, y = bill_depth_mm)) +
  geom_point()
#No sirve porque species es categorica, entonces los puntos quedan todos superpuestos


#Ej 5:
ggplot(data = penguins) +
  geom_point()
#Falta definir las variables en aes().
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point()

#Ej 6:
#na.rm Elimina valores NA y evita warnings
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(na.rm = TRUE)

#Ej 7:
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point() +
  labs(caption = "Data come from the palmerpenguins package.")

#Ej 8:
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g, color = bill_depth_mm)) +
  geom_point()

#Ej 9:
#Entiendo que tendra en x la longitud de las aletas, en y la masa corporal-
#No tengo en claro que seria color island, pero imagino que a mayor masa corporal
#mayor longitud de aleta.
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)
) +
  geom_point() +
  geom_smooth(se = FALSE)
#Se cumple lo que dije, excepto en los Torgersen, en los cuales hay un maximo
#previo a la mayor masa corporal registrada, y un minimo posterior a la minima.


#Ej 10
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point() +
  geom_smooth()

ggplot() +
  geom_point(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  ) +
  geom_smooth(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  )

# No hay cambio visual, ya que en ambos casos se utilizan los mismos datos y-
#mapeos estéticos. La única diferencia es que en el primer caso se definen de-
#forma global en ggplot(), mientras que en el segundo se especifican dentro de-
#cada capa (geom)


#Ejercicios 1.4.3 ----

#Ej 1
ggplot(penguins, aes(y = species)) +
  geom_bar()
#las barras se muestran horizontalmente en lugar de verticalmente, ya que la-
#variable categórica se asigna al eje y en lugar del eje x.

#Ej 2
ggplot(penguins, aes(x = species)) +
  geom_bar(color = "red")
ggplot(penguins, aes(x = species)) +
  geom_bar(fill = "red")
#El primero hace el outline rojo, el segundo hace el outline y el relleno.

#Ej 3
#bins determina el número de intervalos en el histograma, lo que afecta el-
#nivel de detalle de la distribución

#Ej 4
ggplot(diamonds, aes(x = carat)) +
  geom_histogram()
#Pruebas:
ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = 0.5)
ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = 0.1)
ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = 0.05)
#A medida que se achica el binwidth, se pueden ver las distribuciones con mayor-
#detalle, mientras que un mayor binwidth es mas abarcativo y generaliza mas los-
#resultados observables.


#Ejercicios 1.5.5 ----

library(ggplot2)
#Ej 1
#Categóricas:
  #manufacturer, model, trans, drv, fl, class
#Numéricas:
  #displ, year, cyl, cty, hwy
glimpse(mpg)

#Ej 2
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() #Base
ggplot(mpg, aes(displ, hwy, color = cty)) +
  geom_point() #Color
ggplot(mpg, aes(displ, hwy, size = cty)) +
  geom_point() #Size
ggplot(mpg, aes(displ, hwy, color = cty, size = cty)) +
  geom_point() #Ambos
ggplot(mpg, aes(displ, hwy, shape = class)) +
  geom_point() #Shape

#Las variables numéricas generan escalas continuas (gradientes o tamaños-
#progresivos), mientras que las categóricas producen diferencias discretas-
#como colores o formas distintas.

#Ej 3
#Linewidth se usa para líneas, no para puntos, por lo cual no tiene utilidad-
#usarlo.

#Ej 4
#Se refuerza la representación visual, pero puede ser redundante y dificultar-
#la interpretación si no se usa con cuidado.

#Ej 5
ggplot(penguins, aes(bill_length_mm, bill_depth_mm, color = species)) +
  geom_point()
#Aparecen grupos o clusters claros por especie
ggplot(penguins, aes(bill_length_mm, bill_depth_mm)) +
  geom_point() +
  facet_wrap(~ species)
#La primer opcion lo muestra en un solo grafico con distintos colores, la-
#segunda lo muestra en 3 distintos.

#Ej 6
ggplot(
  data = penguins,
  mapping = aes(
    x = bill_length_mm, y = bill_depth_mm, 
    color = species, shape = species
  )
) +
  geom_point() +
  labs(color = "Species")
#El ultimo deberia ser con shape="species" tambien.
ggplot(
  data = penguins,
  mapping = aes(
    x = bill_length_mm, y = bill_depth_mm, 
    color = species, shape = species
  )
) +
  geom_point() +
  labs(color = "Species", shape = "Species")

#Ej 7
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill") #Responde cuál es la proporción de especies-
#dentro de cada isla.
ggplot(penguins, aes(x = species, fill = island)) +
  geom_bar(position = "fill") #Responde cómo se distribuyen las islas dentro de-
#cada especie


#Ejecicios 1.6.1 ----

#Ej 1
ggplot(mpg, aes(x = class)) +
  geom_bar()
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave("mpg-plot.png")
#Se guarda el segundo gráfico (el scatterplot de cty vs hwy) porque ggsave-
#guarda el ultimo grafico generado

#Ej 2
#Se tendria que cambiar a .pdf el ggsave:
ggsave("mpg-plot.pdf")
#Lo averiguo llamando al help de ggsave:
?ggsave
#Extra: Averigue y se puede elegir cual, pero se debe hacer esto:
p <- ggplot(...) + ...
ggsave("plot.png", plot = p)
#(Ejemplo)

#Fin tarea03