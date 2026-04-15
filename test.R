library(dplyr)

mtcars |>
  filter(cyl == 4) |>
  summarise(mean_mpg = mean(mpg))