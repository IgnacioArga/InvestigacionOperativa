
# 0 - Setup ---------------------------------------------------------------

renv::consent(provided = TRUE); renv::restore();

# 1 - Enunciado -----------------------------------------------------------

# En un taller metalúrgico se fabrican dos tipos de piezas A y B, que deben seguir los siguientes
# procesos:
# 1. Estampado en hojas metálicas
# 2. Soldado
# 3. Pintado
# La operación de estampado consiste en preparar partes idénticas que luego serán soldadas de a
# pares, formando la pieza A. El mismo proceso se realiza para la pieza B.
# Los insumos de equipos son los siguientes, para la realización de cada una de las operaciones
# (expresados en segundos por pieza):
#                      |  Pieza   |  Tiempo disponible
# Operación            |  A  | B  |    (seg./semana)
# 
# Estampado de c/parte |  3  | 8  |      48000
# Soldado              |  12 | 6  |      42000
# Pintado              |  9  | 9  |      36000
# 
# La utilidad unitaria es de $ 4 para la pieza A y $ 3 para la pieza B. Se desea establecer el
# programa semanal de producción que maximice la utilidad del taller con respecto a las piezas
# consideradas.
 

# 2 - Resolución ----------------------------------------------------------

# Z = utilidad semanal ($)
# Xa = cantidad de piezas A semanales
# Xb = cantidad de piezas B semanales

# Z = 4 $/u * Xa + 3 $/u * Xb

# Restricciones
# 
# A) 6 seg/u * Xa + 16 seg/u * Xb <= 48000 seg 
# B) 12seg/u * Xa + 8  seg/u * Xb <= 42000 seg 
# C) 9 seg/u * Xa + 9  seg/u * Xb <= 36000 seg 


# * 1 Importo librerías ---------------------------------------------------

library(tibble)
library(ggplot2)

# * 2 Creo rectas para graficar -------------------------------------------

# Genero la recta a partir los puntos de la misma en el intersecto con los ejes

rectaA <- tribble(
  ~xa,  ~xb,
  8000, 0,
  0   , 3000
)

rectaB <- tribble(
  ~xa,  ~xb,
  3500, 0,
  0   , 7000
)

rectaC <- tribble(
  ~xa,  ~xb,
  4000, 0,
  0   , 4000
)

# * 3. Grafico las rectas -------------------------------------------------


grafico_base <- ggplot() +
  geom_line(data = rectaA, aes(x = xb, y = xa), color = "blue") +
  geom_line(data = rectaB, aes(x = xb, y = xa), color = "red") +
  geom_line(data = rectaC, aes(x = xb, y = xa), color = "green") +
  theme_classic() +
  scale_x_continuous(expand = c(0, 0)) + 
  scale_y_continuous(expand = c(0, 0))
 
grafico_base

# * 4. Grafico el conjunto de soluciones permitidas -----------------------

grafico_base +
  geom_area(data = rectaA, aes(x = xb, y = xa, alpha = 0.2), fill = "blue") +
  geom_area(data = rectaB, aes(x = xb, y = xa, alpha = 0.2), fill = "red") +
  geom_area(data = rectaC, aes(x = xb, y = xa, alpha = 0.2), fill = "green")

area_posible <- tribble(
  ~xa,  ~xb,
  3500, 0,
  3000, 1000,
  1600, 2400,
  0   , 3000,
  0   , 0
)

grafico_base +
  geom_polygon(data = area_posible, mapping = aes(x = xb, y = xa), alpha = 0.2) 

# * 5. Grafico la recta con el Z máximo -----------------------------------

rectaZ <- tribble(
  ~xa,  ~xb,
  3750, 0,
  0   , 5000
)

grafico_base +
  geom_polygon(data = area_posible, mapping = aes(x = xb, y = xa), alpha = 0.2) +
  geom_line(data = rectaZ, aes(x = xb, y = xa), color = "black", size = 0.9) +
  geom_point(aes(x = 1000,y = 3000), color = "red", size = 3)


