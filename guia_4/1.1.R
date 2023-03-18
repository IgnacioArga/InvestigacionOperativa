
# 0 - Setup ---------------------------------------------------------------

renv::consent(provided = TRUE); renv::restore();

# 1 - Enunciado -----------------------------------------------------------

# x1 <= 3
# x2 <= 6
# 6 x1 + 4 x2 <= 36 
# Max: Z = 8 x1 + 3 x2
 
# 2 - Resolución ----------------------------------------------------------

# * 1 Importo librerías ---------------------------------------------------

library(boot) # documentación -> https://cran.r-project.org/web/packages/boot/boot.pdf

# función simplex:
# 
# This function will optimize the linear function a%*%x subject to the constraints A1%*%x <= b1,
# A2%*%x >= b2, A3%*%x = b3 and x >= 0. Either maximization or minimization is possible but the
# default is minimization.

# * 2. Creo modelo Simplex ------------------------------------------------

a <- c(8, 3)

A1 <- matrix(
  c(1, 0,
    0, 1,
    6, 4),
  nrow = 3,
  byrow = TRUE
)

b1 <- c(3, 6, 36)

result <- simplex(
  a    = a,
  A1   = A1,
  b1   = b1,
  maxi = TRUE
)

# el output de la función simplex es una lista con varios resultados dentro

# * 3. Interpretación de output -------------------------------------------

# Summary 
result

# Valor final de las variables fuertes
result$soln

# Z máximo
result$value

# matriz de coeficientes de tabla final de simplex
result$A

# Valor final de las variables slack
result$slack


