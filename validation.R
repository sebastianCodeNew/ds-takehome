# Load package
library(glmtoolbox)

# Load dataset
df <- read.csv("C:/Sebastian/ds-takehome/data/credit_scoring.csv")

# Drop kolom leakage & ID
df <- subset(df, select = -c(application_id, leak_col_good, leak_col_subtle))

# Fit model logistik
model <- glm(default ~ ., data = df, family = "binomial")

# Hosmer-Lemeshow test
hl <- hltest(model, g = 10)  # g = jumlah grup decile
print(hl)

# Pastikan sudah load data dan model prediksi
# Jika belum:
library(ggplot2)

# Ambil probabilitas dari model logistik
df$predicted_proba <- predict(model, type = "response")

# Binning prediksi ke 10 grup (deciles)
df$prob_bin <- cut(df$predicted_proba,
                   breaks = quantile(df$predicted_proba, probs = seq(0, 1, 0.1)),
                   include.lowest = TRUE, labels = FALSE)

# Hitung rata-rata prediksi dan aktual default per bin
calibration <- aggregate(cbind(predicted_proba, default) ~ prob_bin, data = df, mean)

# Plot
ggplot(calibration, aes(x = predicted_proba, y = default)) +
  geom_point(size = 3, color = "blue") +
  geom_line(color = "blue") +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "gray") +
  labs(
    title = "Calibration Curve",
    x = "Average Predicted Probability",
    y = "Actual Default Rate"
  ) +
  theme_minimal()
