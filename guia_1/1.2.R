
# 0 - Setup ---------------------------------------------------------------

renv::consent(provided = TRUE); renv::restore();

# 1 - Enunciado -----------------------------------------------------------

# Un fabricante de bombones entrega sus productos en cajas de un kilogramo, en dos
# variedades, A y B.
# La caja tipo A, contiene 300 gramos de bombones de licor, 500 gramos de bombones de nuez,
# y 200 gramos de bombones de fruta. La caja tipo B contiene 400 gramos, 200 gramos y 400
# gramos de cada tipo de bombón respectivamente.
# La utilidad por cada caja de tipo A es de $ 120, y por cada de tipo B es de $ 90.
# El fabricante dispone de 100 kilogramos de bombones de licor, 120 kilogramos de bombones
# de nuez, y 100 kilogramos de bombones de fruta.
# Se pide definir la cantidad de cajas de cada tipo que debe armar en esta situación, para que su
# beneficio sea máximo.


# 2 - Resolución ----------------------------------------------------------

# Z = utilidad ($)
# Xa = cantidad de A 
# Xb = cantidad de B 

# Z = 120 * Xa + 90 * Xb

# Restricciones
# 
# A) 0.3 * Xa + 0.4 * Xb <= 100  
# B) 0.5 * Xa + 0.2 * Xb <= 120  
# C) 0.2 * Xa + 0.4 * Xb <= 100  


# * 1 Importo librerías ---------------------------------------------------

library(tibble)
library(ggplot2)

# * 2 Creo rectas para graficar -------------------------------------------

# Genero la recta a partir los puntos de la misma en el intersecto con los ejes

rectaA <- tribble(
  ~xa,  ~xb,
  250, 0,
  0  , 333.33
)

rectaB <- tribble(
  ~xa,  ~xb,
  600, 0,
  0  , 240
)

rectaC <- tribble(
  ~xa,  ~xb,
  250, 0,
  0  , 500
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
  250, 0,
  100, 200,
  0  , 240,
  0  , 0
)

grafico_base +
  geom_polygon(data = area_posible, mapping = aes(x = xb, y = xa), alpha = 0.2) 

# * 5. Grafico la recta con el Z máximo -----------------------------------

Z_opt <- rectaZ <- tribble(
  ~xa,  ~xb,
  366.6, 0,
  0    , 275
)

grafico_base +
  geom_polygon(data = area_posible, mapping = aes(x = xb, y = xa), alpha = 0.2) +
  geom_line(data = rectaZ, aes(x = xb, y = xa), color = "black", size = 0.9) +
  geom_point(aes(x = 200,y = 100), color = "red", size = 3)


