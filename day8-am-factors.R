library(tidyverse)

glimpse(gss_cat)
levels(gss_cat$rincome) # levels() pulls out. the categories available in a factor

# barplot with the levels of the factor set
ggplot(
  data = gss_cat,
  mapping = aes(x = rincome)
) + # plus for to continue to plotting
  geom_bar() +
  theme_bw()+
  theme(axis.text.x = element_text(angle = 90))

# The order of the catgeories come from the order of the levels
# What if we strip away the levels?
gss_cat |> # Changing to "alphabetical order"
  mutate(rincome = as.character(rincome)) |> # changing a column, as.character strips away the levels
  ggplot(
  mapping = aes(x = rincome)
) +
  geom_bar() +
  theme_bw()+
  theme(axis.text.x = element_text(angle = 90))

# Wihthout the levels, the axis is sorted "alphabetically"

# Reordering
relig_summary <- gss_cat |> 
  summarize(tvhours = mean(tvhours, na.rm = TRUE),
.by = relig)

ggplot(
  data = relig_summary,
  mapping = aes(x = tvhours, y = relig)
) + 
  geom_point() # our categorical axis ir ordered by levels


# fct_reorder() reorders a factor by values in another column
ggplot(
  data = relig_summary,
  mapping = aes(x = tvhours, y = fct_reorder(relig, tvhours))
) + 
  geom_point()

# Collapsing Factor Levels

gss_cat |> 
  count(partyid)
#10 party affiliated categories

# Let's collapse down o four: R, I, D, O (other)

gss_cat |> 
  mutate(
    partyid = fct_collapse(
      partyid,
      "R" = c("Strong republican", "Not str republican"),
      "I" = c("Ind,near rep", "Ind,near dem", "Independent"),
      "D" = c("Strong democrat", "Not str democrat"),
      "O" = c("No answer", "Don't know", "Other party")
    )
  ) |> 
  count(partyid)