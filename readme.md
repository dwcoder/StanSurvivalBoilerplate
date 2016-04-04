# Readme

Each of the folders labelled `Model#` contains an R file and a stan model file.
The R file simulates data according to hazard rate with known parameters, and then the stan file tries to fit the model and recover these parameters.

Coding up complicated survival models in the MCMC languages is error-prone. Even if the code executes successfully, it may be giving erroneous output.
Establishing the source these errors is time-consuming, as you have to inspect the code line by line, usually by building smaller, simpler models to see where the code fails. After locating and fixing the error, you reintroduce the desired complexity until you arrive at the model you desire.

Another approach is to build a selection of simpler models, while validating them using simulated data. These models can then be used as a stepping stone for more complicated models.

The model files in this repository serve as a proof of concept to get survival models running in Stan.
They start with a simple model and progress to more complicated models thereafter.
They also serve as an audit trial of the model development process.


## Running the code

Each of the `Model#` folders contain the files `simulate_and_estimate.R` and `mystanmodel.stan`. The depend on the R library `rstan`, which can be installed from CRAN. To run the model 1, for instance, we would start R and make the `Model1/` our working directory. Then, either run `source("simulate_and_estimate.R")` or run the code in this file line by line. This will produce an object called `fit`, containing all the MCMC samples. This object will be of class `stanfit-class`, and the `rstan` library contains useful functions for inspection.
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