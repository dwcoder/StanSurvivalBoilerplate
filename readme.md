# Survival models in Stan

This repository is a primer for getting survival models working in [Stan](http://mc-stan.org/).
It focusses on the following two topics:

  1. Censored observations
  2. Arbitrary hazard rate functions

Censoring is one of the characteristics that often make survival analysis hard to implement.
While there are packages that implement specific cases (like the `survival` library in [R](https://www.R-project.org/), which is great for Cox proportional hazards models), going beyond their limited scope is tedious.
Markov Chain Monte Carlo (MCMC) packages like [JAGS](http://mcmc-jags.sourceforge.net/) and [Stan](http://mc-stan.org/) provide a framework to specify flexible statistical models using probabilistic statements.
These make survival models easier, but users are often still required to construct the likelihoods yourself as survival models don't form part of the included syntax (see [this question on Stack Overflow, for example](http://stackoverflow.com/questions/28537323/flexible-survival-models-in-r/28552752#28552752)).

# Details


Coding up complicated survival models in the MCMC languages is error-prone.
Even if the code executes successfully, it may be giving erroneous output and locating errors is a frustrating process.
In this repository, we build a simple, and validate it using simulated data.
We use it as a stepping stone for more complicated models, each time doing the simulation-estimation loop for validation.
It serves as a proof of concept to get survival models running in Stan, as well as an audit trail of the model development process.


## Running the code

Each of the `Model#` folders contain `simulate_and_estimate.R` and `mystanmodel.stan`.
They depend on the R library `rstan`, which can be installed from CRAN using `install.packages("rstan")`.
To run the model 1, for instance, we would start R and make `Model1/` our working directory, then either run
```R
source("simulate_and_estimate.R")
```
or run the code in this file line by line. This will produce an object called `fit`, containing all the MCMC samples. This object will be of class `stanfit-class`, and the `rstan` library contains useful functions for inspection.
The `fit` object can also be inspected by calling the usual R functions such as `summary` or `plot`, with the optional argument `pars` to specify the parameters of interest.
Output of the following functions is usually of interest:
```R
print(fit, pars=c("gompertz","beta"))
plot(fit, pars=c("gompertz","beta"))
stan_ac(fit, pars=c("gompertz","beta"))
stan_hist(fit, pars=c("gompertz","beta"))
```
To see a list of all the functions that can act on the `stanfit-class`, see `help("stanfit-class")`.


# Description of models

The [documentation pdf](doc/Documentation.pdf) contains descriptions of the models, along with a discussion about building survival models in Stan and details about the likelihood construction.


# References

R Core Team (2016). R: A language and environment for statistical computing. R Foundation for Statistical
Computing, Vienna, Austria. URL https://www.R-project.org/.

Stan Development Team (2015). *Stan: A C++ Library for Probability and
Sampling, Version 2.8.0.* URL http://mc-stan.org/.

