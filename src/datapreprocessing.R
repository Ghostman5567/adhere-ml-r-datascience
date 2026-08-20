library(tidyverse)
library(lubridate)

data <- read.csv("~/KaggleV2-May-2016.csv")

data <- data %>%
  rename(
    PatientID = PatientId,
    Hypertension = Hipertension,
    Handicap = Handcap,
    NoShow = No.show
  )

data <- data %>%
  mutate(PatientID = sprintf("%.0f", PatientID))

data <- data %>%
  mutate(
    ScheduledDay = ymd_hms(ScheduledDay),
    AppointmentDay = ymd_hms(AppointmentDay),
    ScheduledDate = as.Date(ScheduledDay),
    AppointmentDate = as.Date(AppointmentDay),
    WaitTime = as.numeric(AppointmentDate - ScheduledDate)
  )

data <- data %>%
  mutate(
    NoShow_Binary = ifelse(NoShow == "Yes", 1, 0),
    Gender = as.factor(Gender)
  )

data_clean <- data %>%
  filter(WaitTime >= 0, Age >= 0, Age <= 100)

Q1 <- quantile(data_clean$WaitTime, 0.25, na.rm = TRUE)
Q3 <- quantile(data_clean$WaitTime, 0.75, na.rm = TRUE)
IQR_val <- Q3 - Q1
upper_bound <- Q3 + 1.5 * IQR_val

data_filtered <- data_clean %>%
  filter(WaitTime <= upper_bound)

write.csv(data_filtered, "~/cleaned_medical_appointments.csv", row.names = FALSE)