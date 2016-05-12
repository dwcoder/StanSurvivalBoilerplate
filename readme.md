# Readme

Each of the folders labelled `Model#` contains an R file and a stan model file.
The R file simulates data according to hazard rate with known parameters, and then the stan file tries to fit the model and recover these parameters.

Coding up complicated survival models in the MCMC languages is error-prone.
Even if the code executes successfully, it may be giving erroneous output and locating errors is a frustrating process.
The approach we follow here is to build a selection of simpler models, while validating them using simulated data. These models can then be used as a stepping stone for more complicated models.

Thus, the model files in this repository serve as a proof of concept to get survival models running in Stan (Stan Development Team, 2015).
They start with a simple model and progress to more complicated models thereafter.
They can also serve as an audit trial of the model development process.


## Running the code

Each of the `Model#` folders contain the files `simulate_and_estimate.R` and `mystanmodel.stan`. They depend on the R library `rstan`, which can be installed from CRAN using `install.packages("rstan")`. To run the model 1, for instance, we would start R and make `Model1/` our working directory. Then, either run
```R
source("simulate_and_estimate.R")
```
or run the code in this file line by line. This will produce an object called `fit`, containing all the MCMC samples. This object will be of class `stanfit-class`, and the `rstan` library contains useful functions for inspection.
The `fit` object can also be inspected by calling the usual R functions such as `summary`, `print`, or `plot`, with the optional argument `pars` to specify the parameters of interest.
Output of the following functions is usually of interest:
```R
print(fit, pars=c("gompertz","beta"))
plot(fit, pars=c("gompertz","beta"))
stan_ac(fit, pars=c("gompertz","beta"))
stan_hist(fit, pars=c("gompertz","beta"))
```
To see a list of all the functions that can act on the `stanfit-class`, see `help("stanfit-class")`.


# Description of models

A description of the models can be found in the [documentation pdf](doc/Documentation.pdf) along with a discussion about building survival models in Stan.


# References

Stan Development Team (2015). *Stan: A C++ Library for Probability and
Sampling, Version 2.8.0.* URL http://mc-stan.org/.

