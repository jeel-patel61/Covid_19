summary(covid19)
dim(covid19)

vector_col <- colnames(covid19)
vector_col

head(covid19)
library(tibble)

glimpse(covid19)
library(dplyr)
??dplyr

covid_df_all_states <- covid19 %>% 
  filter(Province_State == "All States") %>% 
  select(-Province_State)

covid_df_all_states_daily <- covid_df_all_states %>% 
  select(Date, Country_Region, active, hospitalizedCurr, daily_tested,
         daily_positive)

head(covid_df_all_states_daily)


covid_df_all_states_daily_sum <- covid_df_all_states_daily %>% 
  group_by(Country_Region) %>% 
  summarise(tested = sum(daily_tested), 
            positive = sum(daily_positive),
            active = sum(active),
            hospitalized = sum(hospitalizedCurr)) %>% 
  arrange(desc(tested)) 

covid_df_all_states_daily_sum

# for error checking 
rlang::last_error()

covid_top_10 <- head(covid_df_all_states_daily_sum,10)
covid_top_10


remove(covid19_all_states_daily)
remove(covid19_all_states)

countries <- covid_top_10$Country_Region
tested <- covid_top_10$tested
positive <- covid_top_10$positive
active <- covid_top_10$active
hospitalized <- covid_top_10$hospitalized


names(positive_cases) <- countries
names(tested_cases) <- countries
names(active_cases) <- countries
names(hospitalized_cases) <- countries

positive_cases
sum(positive_cases)
mean(positive_cases)
positive_cases/sum(positive_cases)


positive_cases/tested_cases

positive_tested_top_3 <- c("United Kingdom = 0.11", "United States = 0.10", 
                           "Turkey = 0.08")


United_kingdom <- c(0.11, 1473672, 166909, 0, 0)
United_states <- c(0.10, 17282363, 1877179, 0, 0 )
Turkey <- c(0.08, 2031192, 163941, 2980960, 0)

covid_mat <- rbind(United_kingdom, United_states, Turkey)
colnames(covid_mat) <- c("Ratio", "Tested", "Positive", "Active", "Hospitalized")
covid_mat

question <- "Which country have had the highest number of positive cases 
against number of tests?"
answer <- c("Positive tested cases" = positive_tested_top_3)

datasets <- list(
  original = covid19,
  all_states = covid_df_all_states,
  daily = covid_df_all_states_daily,
  top_10 = covid_top_10
)

matrices <- list(covid_mat)
vectors <- list(vector_col, countries)
data_structure <- list("dataframe"= datasets, "matrix"= matrices, "vector"= vectors)

covid_analysis <- list(question,answer,data_structure)
covid_analysis[[1]]
covid_analysis[[2]]
covid_analysis[[3]]

