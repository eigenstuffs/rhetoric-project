library(tidyverse)
library(sf)

turbines <- read.csv("data/uswtdb_v7_2_20241120.csv")

turbines <- turbines %>%
  mutate(
    month = as.integer(format(as.Date(t_img_date, "%m/%d/%Y"), "%m")),
    day = as.integer(format(as.Date(t_img_date, "%m/%d/%Y"), "%d")),
    year = as.integer(format(as.Date(t_img_date, "%m/%d/%Y"), "%Y"))
  )

turbines <- turbines %>% rename(x = xlong, y = ylat)

plot(turbines$p_cap)

turbines <- st_as_sf(turbines, coords = c("x", "y"))

ggplot(turbines) +
  geom_sf(aes(color = t_manu)) +
  theme_minimal()
