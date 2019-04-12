library('ggplot2')
library('forecast')
library('tseries')

data = read.csv('/home/docboy/Desktop/5th Year/day.csv', header=TRUE, stringsAsFactors=FALSE)
data$Date = as.Date(data$dteday)

ggplot(data, aes(Date, cnt)) + geom_line() + scale_x_date('month')  + ylab("Daily Bike Checkouts") +
    xlab("")

count_ts = ts(data[, c('cnt')])

data$clean_cnt = tsclean(count_ts)

ggplot() +
    geom_line(data = data, aes(x = Date, y = clean_cnt)) + ylab('Cleaned Bicycle Count')

data$cnt_ma = ma(data$clean_cnt, order=7) # using the clean count with no outliers
data$cnt_ma30 = ma(data$clean_cnt, order=30)


ggplot() +
    geom_line(data = data, aes(x = Date, y = clean_cnt, colour = "Counts")) +
    geom_line(data = data, aes(x = Date, y = cnt_ma,   colour = "Weekly Moving Average"))  +
    geom_line(data = data, aes(x = Date, y = cnt_ma30, colour = "Monthly Moving Average"))  +
    ylab('Bicycle Count')

count_ma = ts(na.omit(data$cnt_ma), frequency=30)
decomp = stl(count_ma, s.window="periodic")
deseasonal_cnt <- seasadj(decomp)

plot(decomp)

adf.test(count_ma, alternative = "stationary")



Acf(count_ma, main='')

Pacf(count_ma, main='')



count_d1 = diff(deseasonal_cnt, differences = 1)
plot(count_d1)
adf.test(count_d1, alternative = "stationary")

Acf(count_d1, main='ACF for Differenced Series')
Pacf(count_d1, main='PACF for Differenced Series')
auto.arima(deseasonal_cnt, seasonal=FALSE)

fit2 = arima(deseasonal_cnt, order=c(1,1,7))

fit2

tsdisplay(residuals(fit2), lag.max=15, main='Seasonal Model Residuals')

fcast <- forecast(fit2, h=30)
plot(fcast)


hold <- window(ts(deseasonal_cnt), start=700)

fit_no_holdout = arima(ts(deseasonal_cnt[-c(700:725)]), order=c(1,1,7))

fcast_no_holdout <- forecast(fit_no_holdout,h=25)
plot(fcast_no_holdout, main=" ")
lines(ts(deseasonal_cnt))

fit_w_seasonality = auto.arima(deseasonal_cnt, seasonal=TRUE)
fit_w_seasonality

seas_fcast <- forecast(fit_w_seasonality, h=30)
plot(seas_fcast)
