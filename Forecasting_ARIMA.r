# R implementation of a high-challenging time-series forecasting problem using ARIMA (AutoRegressive Integrated Moving Average) and Prophet (a Facebook-developed forecasting tool). This approach can handle complex time-series data, seasonal trends, and irregular patterns.





# Install required libraries
if (!require("forecast")) install.packages("forecast")
if (!require("prophet")) install.packages("prophet")
if (!require("ggplot2")) install.packages("ggplot2")

library(forecast)
library(prophet)
library(ggplot2)

# Step 1: Simulate a time-series dataset (e.g., monthly sales with seasonality and trend)
set.seed(123)
n <- 120  # 10 years of monthly data
time_series <- ts(
  100 + 2 * (1:n) + 20 * sin(2 * pi * (1:n) / 12) + rnorm(n, sd = 10),
  frequency = 12,
  start = c(2010, 1)
)

# Plot the data
autoplot(time_series) +
  ggtitle("Simulated Time Series Data") +
  xlab("Time") + ylab("Value") +
  theme_minimal()

# Step 2: Forecast using ARIMA
arima_model <- auto.arima(time_series, seasonal = TRUE)

# Summary of the ARIMA model
summary(arima_model)

# Forecast for the next 24 months
arima_forecast <- forecast(arima_model, h = 24)

# Plot ARIMA forecast
autoplot(arima_forecast) +
  ggtitle("ARIMA Forecast") +
  xlab("Time") + ylab("Value") +
  theme_minimal()

# Step 3: Forecast using Prophet
# Prepare data for Prophet
prophet_data <- data.frame(
  ds = seq.Date(from = as.Date("2010-01-01"), by = "month", length.out = n),
  y = as.numeric(time_series)
)

# Fit the Prophet model
prophet_model <- prophet(prophet_data)

# Future dataframe for 24 months
future <- make_future_dataframe(prophet_model, periods = 24, freq = "month")

# Forecast
prophet_forecast <- predict(prophet_model, future)

# Plot Prophet forecast
prophet_plot <- prophet_plot_components(prophet_model, prophet_forecast)
plot(prophet_plot)

# Step 4: Compare Results
# Extract forecasts from Prophet
prophet_pred <- prophet_forecast$yhat[(n + 1):(n + 24)]

# Extract forecasts from ARIMA
arima_pred <- as.numeric(arima_forecast$mean)

# Combine results
forecast_comparison <- data.frame(
  Month = seq.Date(from = as.Date("2020-01-01"), by = "month", length.out = 24),
  ARIMA_Forecast = arima_pred,
  Prophet_Forecast = prophet_pred
)

# Plot comparison
ggplot(forecast_comparison, aes(x = Month)) +
  geom_line(aes(y = ARIMA_Forecast, color = "ARIMA")) +
  geom_line(aes(y = Prophet_Forecast, color = "Prophet")) +
  labs(title = "Forecast Comparison: ARIMA vs Prophet",
       x = "Month", y = "Forecasted Value") +
  theme_minimal() +
  scale_color_manual(name = "Method", values = c("ARIMA" = "blue", "Prophet" = "red"))

# Step 5: Evaluate Accuracy
# Simulate actual future values (if available) for evaluation
actual_values <- ts(
  100 + 2 * (121:144) + 20 * sin(2 * pi * (121:144) / 12) + rnorm(24, sd = 10),
  frequency = 12,
  start = c(2020, 1)
)

arima_accuracy <- accuracy(arima_forecast, actual_values)
prophet_accuracy <- data.frame(
  ME = mean(prophet_pred - as.numeric(actual_values)),
  RMSE = sqrt(mean((prophet_pred - as.numeric(actual_values))^2)),
  MAE = mean(abs(prophet_pred - as.numeric(actual_values))),
  MAPE = mean(abs(prophet_pred - as.numeric(actual_values)) / as.numeric(actual_values)) * 100
)

cat("ARIMA Accuracy:\n")
print(arima_accuracy)

cat("\nProphet Accuracy:\n")
print(prophet_accuracy)
