#### Datos y librerias ####
rm(list = ls())
setwd("C:/Users/AZCH/Desktop/Clase3R4DS")
library(dplyr)
# Desarrollado por Hadley Wikham (Rstudio)
# Dplyr : gramatica para manipulacion de datos 

#### cargar data : storms, pollution, tb ####
storms <- read.csv("https://raw.githubusercontent.com/robintux/Datasets4StackOverFlowQuestions/master/storms.csv")
# Velocidades maximas de viento para 6 huracanes
# https://www.nhc.noaa.gov/

pollution <- read.csv("https://raw.githubusercontent.com/robintux/Datasets4StackOverFlowQuestions/master/pollution.csv")
# NIvel promedio de contaminacion del aire por particular (ciudad de NY, London, Beijing)
# https://www.who.int/phe/health_topics/outdoorair/databases/cities/en/

tb <- read.csv("https://raw.githubusercontent.com/robintux/Datasets4StackOverFlowQuestions/master/tb.csv")
# numero de casos de tuberculosis : 1995-2013

### Algunas funciones de dplyr ####
class(storms)
dim(storms)
head(storms,n = 2)
tail(storms, n = 3)
colnames(storms)
names(storms)
str(storms)

# Es notorio que la variable $date debe ser una variable que represente 
# a la linea del tiempo
class(storms$date)
storms$date <- as.Date(storms$date)


#### Funcion select ####
# permite seleccionar columna(s) (2da dimension)  de  un data frame.
# Seleccionar las variables "storm" y "pressure"
help("select")
select(storms, storm, pressure)
select(storms, colnames(storms)[1], colnames(storms)[3])

# Verifiquemos que el resultado es un objeto de tipo data frame:
class(select(storms, storm, pressure))

# Utilizando sintaxis matricial
storms[,c(1,3)]

# para excluir una columna utilizamos el operador (unario) : -
select(storms, -storm)

# con notacion matricial 
storms[,-1] # storms[,-c(1)]

# podemos utilizar a notacion : para seleccionar un rando de columnas
select(storms, wind:date)

# utilizando los operadores : y - de forma conjunta podemos hacer mas cosas
select(storms, -(storm:wind))

# Selecciona columnas cuyo nombres contiene un patron
select(storms, starts_with("w"))

# seleccionar las columnas cuyo nombre termina con la letra "e"
select(storms, ends_with("e"))

# selecciona todas las columnas
select(storms, everything())

# Selecciona columnas cuyo nombre contiene un string 
select(storms, contains("essur"))

# Algunas funciones de select son bastantes utiles 
# -
# :
# contains()
# star_with()
# ends_with()
# everything()
help(starts_with)


#### filter ####
# La funcion filter nos permite filtrar filas segun una condicion
filter(storms, wind >= 50)
filter(storms, wind >= 50, storm %in% c("Alberto", "Alex", "Allison"))

# el siguiente ejemplo filtra aquellas filas con wind>=50 y pressure<1010
filter(storms, wind>=50 & pressure<1010)

#### arrange ####
# La funcion arrange() se utiliza para ordenas las filas de un data frame
# deacuerdo a una o varias columnas (variables)
# Por defecto arrange ordena las filas en orden ascendente
# Para ordenar las filas por la variables wind de forma ascendente :
arrange(storms, wind)

# si las queremos ordenar de forma descendente :
arrange(storms, desc(wind))

#### rename ####
names(storms)

rename(storms, tormenta = storm, viento = wind, presion = pressure, fecha = date)

#### mutate ####
# con la funcion mutate poder computar/calcular transformaciones de variables
# de un data frame. A menurdo, tendremos la necesidad de crear nuevas variables 
# que se caclulan a partir de variables existentes, murate() proporciona
# una interface para realizar este tipo de operaciones 
# Deseo calcular una variable ratio que sea definica como el cociente
# entre presion(presuure) y viento(wind)
StormsNuevo <- mutate(storms, ratio = pressure/wind)

# mutate nos permite encadenar varias expresiones 
StormsNuevo <- mutate(storms , ratio = pressure/wind , inverse = ratio^-1)

StormsNuevo$wind
mean(StormsNuevo$wind)

summary(StormsNuevo)




#### summarise ####
# funciona de forma analoga a la funcion mutate , excepto que en lugar de añadir nuevas 
# columnas crea un nuevo dataframe 
#  Por ejemplo, para calcular la mediana y la varianza de lavariable amount del 
# dataframe pollution 
summarise(pollution, mediana = median(amount), variance = var(amount))
class(summarise(pollution, mediana = median(amount), variance = var(amount)))

#### Operador pipe ####
# El uso es bastante y basicamente sirve para concatenar expresiones 
# de la gramatica de dplyr
pollution %>% summarise(mediana2 = median(amount), varianza = var(amount))
class(pollution %>% summarise(mediana2 = median(amount), varianza = var(amount)))

# Funciones que trabajan conjuntamente con summarise
# base : min, max, median, mean, sum, var, sd,
# dplyr : first , last, n ,n_distinct , nth

#### group_by ####
pollution
group_by(pollution, city)
class(group_by(pollution, city))

pollution %>% group_by(city) %>%
  summarise(media = mean(amount) , suma = sum(amount), n = n())

Info <- pollution %>% group_by(city) %>% 
  summarise(media = mean(amount) , suma = sum(amount), n = n())

class(Info)


















































