library(tidyverse)
library(scales)
library(reshape2)

df <- read.csv("cleaned_medical_appointments.csv")

p1 <- ggplot(df, aes(x = factor(NoShow_Binary, labels = c("Show", "No-Show")), fill = factor(NoShow_Binary))) +
  geom_bar(width = 0.5) +
  geom_text(stat = 'count', aes(label = ..count..), vjust = -0.5, size = 4) +
  scale_fill_manual(values = c("#2ecc71", "#e74c3c")) +
  theme_minimal() +
  labs(title = "Figure 1: Overall Appointment Attendance Distribution", x = "Status", y = "Patient Count", fill = "Status")
print(p1)

p2 <- ggplot(df, aes(x = Age, fill = factor(NoShow_Binary, labels = c("Show", "No-Show")))) +
  geom_density(alpha = 0.5) +
  scale_fill_manual(values = c("#3498db", "#e67e22")) +
  theme_minimal() +
  labs(title = "Figure 2: Patient Age Distribution by Attendance Status", x = "Age (Years)", y = "Density", fill = "Status")
print(p2)

p3 <- ggplot(df, aes(x = factor(NoShow_Binary, labels = c("Show", "No-Show")), y = WaitTime, fill = factor(NoShow_Binary))) +
  geom_boxplot(outlier.alpha = 0.1) +
  scale_fill_manual(values = c("#1abc9c", "#9b59b6")) +
  theme_minimal() +
  labs(title = "Figure 3: Impact of Booking Lead Time on Attendance", x = "Status", y = "Wait Time (Days)", fill = "Status")
print(p3)

p4 <- df %>%
  group_by(SMS_received, Scholarship) %>%
  summarise(NoShow_Rate = mean(NoShow_Binary), .groups = 'drop') %>%
  ggplot(aes(x = factor(SMS_received, labels = c("No SMS", "SMS Received")), y = NoShow_Rate, fill = factor(Scholarship, labels = c("No Welfare", "Welfare")))) +
  geom_col(position = "dodge", width = 0.6) +
  scale_y_continuous(labels = percent_format()) +
  scale_fill_manual(values = c("#34495e", "#f1c40f")) +
  theme_minimal() +
  labs(title = "Figure 4: Non-Adherence Rate by Notification & Welfare Status", x = "SMS Status", y = "No-Show Rate (%)", fill = "Scholarship")
print(p4)

cor_matrix <- cor(df %>% select(Age, WaitTime, Hypertension, Diabetes, Alcoholism, Scholarship, SMS_received, NoShow_Binary))
melted_cor <- melt(cor_matrix)

p5 <- ggplot(melted_cor, aes(Var1, Var2, fill = value)) +
    geom_tile(color = "white") +
    geom_text(aes(label = round(value, 2)), size = 3) +
    scale_fill_gradient2(low = "#4575b4", high = "#d73027", mid = "#ffffbf", midpoint = 0, limit = c(-1,1)) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    labs(title = "Figure 5: Preprocessed Feature Correlation Heatmap", x = "", y = "", fill = "Correlation")
  print(p5)