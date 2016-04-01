

h_t <- function(t, B, theta){
 return(B*exp(theta * t))
}

H_t <- function(t, B, theta){
 return( (B/theta) * (exp(theta*t) - 1) )
}


H_inv_t <- function(t, B, theta){
  return( log(t*(theta/B) + 1)/theta )
}


# We use H_inv_t to sample values from this hazard rate
# We will simulate using two sets of gompertz parameters

N <- 1000
gompertz <- rbind(c(B=0.1, theta=0.2), #group 1
                  c(B=0.2, theta=0.3)) #group 2


T_real1 <- H_inv_t( rexp(N, rate=1), gompertz[1,1], gompertz[1,2])
T_real2 <- H_inv_t( rexp(N, rate=1), gompertz[2,1], gompertz[2,2])

T_real <- c(T_real1, T_real2)

# Now for the censoring process
c_time <- runif(N*2, min=0, max=max(T_real)*1.2 )


# We only see events if they happen before censoring
delta <- T_real <= c_time
T <- apply( cbind(T_real, c_time), 1, min)

gompgroup <- c(rep(1,N), rep(2,N))
Surv_T_and_delta <- as.array(as.matrix(data.frame(T=T, delta=as.numeric(delta))))


standata <- list(
Surv_T_and_delta = Surv_T_and_delta,
group = gompgroup,
N = N*2)

myinits_f <- function(chainnum) {
 return( list(B=1, theta=1))
}

library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

fit <- stan(file="mystanmodel.stan",
            data=standata, init=myinits_f,
            iter=1000, chains=4)

# Now check the output.
# See help("stanfit-class") for details about the object called "fit"


print(fit, pars="gompertz")
plot(fit, pars="gompertz")
stan_ac(fit, pars="gompertz")
stan_hist(fit, pars="gompertz")

