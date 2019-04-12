---
title: ARIMA Processes
date:
      'Thu April 11 2019 05:30:00 GMT+0530 (India Standard Time)': null
tags:
  - Weekly Updates
  - data science
  - Time series
  - AR
  - MA
header:
  image: /images/ARIMA/residual.jpeg
excerpt: 'Weekly Updates, data science, Time Series'
mathjax: 'true'
published: true
---

# ARIMA

## What exactly is ARIMA
Consider a ARMA (p, q) process. If the ARMA(p, q) is extended to let the AR(p) process have 1 as a characteristic root; the ARMA process is called a ARIMA (autoregressive integrated moving average) process.


This constraint of setting the characteristic root to be 1; lets ARIMA processes have a strong memory. The coefficients in MA component of the ARIMA process do not decay strongly to zero over time. This implies that the a<sub>t-1</sub> terms have a longer and lasting effect on the future behaviour of the time series.

Do note that ARIMA is represented as ARIMA(p, d, q) where the coefficients p, d and q represent the AR order, the differencing order and MA order respectively.

We now look at some sample data and model it using ARIMA. We use the bike sharing dataset from UCL-ML data repository. The code can be found on the git repo. [here](https://github.com/atdocboy/atdocboy.github.io/codes)

I attach the final "naive" forecast:
<img src="{{ site.url }}{{ site.baseurl }}/images/ARIMA/final_forecast.jpeg" alt="ARIMA forecast">
