library(tidyverse)
library(stringr)
library(tm)

parsed_speeches <- read.csv("data/dataset_parsed.csv")

stop_words <- stopwords("en")

parsed_speeches <- parsed_speeches %>%
  mutate(
    text = tolower(text),
    text = str_replace_all(text, "http\\S+\\s*", ""), 
    text = str_replace_all(text, "<[^>]+>", ""), 
    text = str_replace_all(text, "[[:punct:]]", ""), 
    text = str_replace_all(text, "\\b(\\w{1,2})\\b", ""), # Remove very short words
    text = str_replace_all(text, "\\s+", " "),
    text = str_remove_all(text, paste0("\\b(", paste(stop_words, collapse = "|"), ")\\b")),
    text = str_squish(text)
  )

######

clean_energy_terms <- c("renewable", "solar", "wind", "geothermal", "hydropower", "clean energy", "green energy")

parsed_speeches <- parsed_speeches %>%
  rowwise() %>%
  mutate(energy = sum(str_count(text, paste0("\\b(", paste(clean_energy_terms, collapse="|"), ")\\b"))))

ggplot(parsed_speeches) +
  geom_line(aes(x = year, y = energy, color = party), alpha = 0.2) +
  geom_smooth(aes(y = energy, x = year)) +
  theme_minimal()

######

climate_terms <- c("climate change", "global warming", "carbon dioxide", "greenhouse gases", "emissions", "carbon footprint", "fossil", "net zero", "sustainability", "environmental policy", "adaptation", "mitigation")

parsed_speeches <- parsed_speeches %>%
  rowwise() %>%
  mutate(climate = sum(str_count(text, paste0("\\b(", paste(climate_terms, collapse="|"), ")\\b"))))

ggplot(parsed_speeches) +
  geom_line(aes(x = year, y = climate, group = state_id), alpha = 0.2) +
  geom_smooth(aes(y = climate, x = year)) +
  theme_minimal()

######

mentions_by_party <- parsed_speeches %>%
  group_by(party, year) %>%
  summarise(sum_mentions = sum(energy))

ggplot(mentions_by_party) +
  geom_line(aes(x = year, y = sum_mentions, color = party), alpha = 1) +
  geom_smooth(aes(y = sum_mentions, x = year, color = party)) +
  theme_minimal()
