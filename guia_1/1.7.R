
# 0 - Setup ---------------------------------------------------------------

renv::consent(provided = TRUE); renv::restore();

# 1 - Enunciado -----------------------------------------------------------

# Una empresa automotriz está equipada para producir automóviles y camiones. Su planta fabril
# está organizada en cuatro departamentos: Estampado, Montaje de motores, Línea de montaje
# de automóviles y Línea de montaje de camiones.
# La capacidad de producción de cada departamento está limitada de la siguiente forma:
# * Estampado: 25000 automóviles o 40000 camiones por año (o cualquier combinación lineal convexa intermedia).
# * Montaje de motores: 33333 automóviles o 16667 camiones por año (o cualquier combinación lineal convexa intermedia).
# * Línea de montaje de automóviles: 22500 unidades por año.
# * Línea de montaje de camiones: 15000 unidades por año.
# Por otra parte, se desea producir como mínimo 12000 automóviles y 8000 camiones por año,
# estimándose asimismo en 18000 unidades la cantidad demandada máxima anual de
# automóviles.
# El margen de beneficios es de $ 15000 por automóvil y $ 12500 por camión.
# Se desea conocer el plan de producción que haga máximo el margen total de beneficios.


# 2 - Resolución ----------------------------------------------------------

# Z = beneficio total anual ($)
# Xa = cantidad anual de autos
# Xb = cantidad anual de camiones

# Z = 15000 $/u * Xa + 12500 $/u * Xb

# Restricciones
# 
# A) Xa/25000 + Xb/40000 <= 1  
# B) Xa/33333 + Xb/16667 <= 1  
# C) Xa <= 22500   --- está de más
# D) Xb <= 15000  
# E) Xa >= 12000  
# E) Xb >= 8000  
# E) Xa <= 18000  


# * 1 Importo librerías ---------------------------------------------------

library(tibble)
library(ggplot2)

# * 2 Creo rectas para graficar -------------------------------------------

# Genero la recta a partir los puntos de la misma en el intersecto con los ejes
# las horizontales y verticales las hago directamente en el gráfico, no hace falta pregenerar puntos

rectaA <- tribble(
  ~xa,  ~xb,
  25000, 0,
  0   , 40000
)

rectaB <- tribble(
  ~xa,  ~xb,
  16667, 0,
  0   , 33333
)

# * 3. Grafico las rectas -------------------------------------------------


grafico_base <- ggplot() +
  geom_line(data = rectaA, aes(x = xb, y = xa), color = "blue") +
  geom_line(data = rectaB, aes(x = xb, y = xa), color = "red") +
  geom_hline(yintercept = 15000, color = "green") + # recta D
  geom_vline(xintercept = 12000, color = "orange") + # recta E
  geom_hline(yintercept = 8000, color = "violet") + # recta F
  geom_vline(xintercept = 18000, color = "forestgreen") + # recta G
  theme_classic() +
  scale_x_continuous(expand = c(0, 0)) + 
  scale_y_continuous(expand = c(0, 0))

grafico_base

# * 4. Grafico el conjunto de soluciones permitidas -----------------------

area_posible <- tribble(
  ~xa,  ~xb,
  10666, 12000,
  8000 , 17333,
  8000 , 12000
)

grafico_base +
  geom_polygon(data = area_posible, mapping = aes(x = xb, y = xa), alpha = 0.2) 

# * 5. Grafico la recta con el Z máximo -----------------------------------

Z_opt <- rectaZ <- tribble(
  ~xa,  ~xb,
  22444, 0,
  0    , 26933
)

grafico_base +
  geom_polygon(data = area_posible, mapping = aes(x = xb, y = xa), alpha = 0.2) +
  geom_line(data = rectaZ, aes(x = xb, y = xa), color = "black", size = 0.9) +
  geom_point(aes(x = 17333, y = 8000), color = "red", size = 3)
