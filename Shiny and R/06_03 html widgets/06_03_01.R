library(WDI)
library(highcharter)
library(forecast)

#fertility rate data world bank of USA:
wdi_data <- WDI(
  country = "US",
  indicator = "SP.DYN.TFRT.IN",
  start = 1960,
  end = 2012
)

#convert into a timeseries - ts()
wdi_data <-
  ts(
    data = wdi_data$SP.DYN.TFRT.IN,
    start = 1960,
    end = 2012,
    frequency = 1
  )

#create a highcharter diagram
forecast(ets(wdi_data),
         h = 48 / 12,
         level = 95) %>%
  hchart %>%
  #adding additional info to our chart
  hc_tooltip(
    valuePrefix = "There were ",
    valueSuffix = " births per women",
    valueDecimals = 2
  ) %>%
  hc_title(text = "Fertility Forecast for the US")