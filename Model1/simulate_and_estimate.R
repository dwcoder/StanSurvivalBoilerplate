

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

N <- 1000
B <- 0.1
theta <- 0.2

T_real <- H_inv_t( rexp(N, rate=1), B, theta)

# Now for the censoring process
c_time <- runif(N, min=0, max=max(T_real)*1.2 )

# We only see events if they happen before censoring
delta <- T_real <= c_time
T <- apply( cbind(T_real, c_time), 1, min)



Surv_T_and_delta <- as.array(as.matrix(data.frame(T=T, delta=as.numeric(delta))))


standata <- list(
Surv_T_and_delta = Surv_T_and_delta,
N = N)

myinits_f <- function(chainnum) {
 return( list(B=1, theta=1))
}

library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

fit <- stan(file="mystanmodel.stan",
            data=standata, init=myinits_f,
            iter=1000, chains=4)

