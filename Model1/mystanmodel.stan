functions {

//------------------
// Declarations 
//------------------

// Have to declare the functions before I can use them


real log_h(real T,  real B, real theta);

real H_t(real T,  real B, real theta);

//------------------
// Definitions 
//------------------

real surv_dens_log(vector T_and_delta,real B, real theta){
    real T;
    real delta;

    T     = T_and_delta[1];
    delta = T_and_delta[2];

    return (delta * log_h(T, B, theta))
                 -    H_t(T, B, theta) ;

    }

real log_h(real T,  real B, real theta){

      return log(B) + theta*T;

}
real H_t(real T,  real B, real theta){

      return (B/theta)*( exp(theta*T)-1 ) ;

}

}

data {

  int<lower=0> N;
  vector[2] Surv_T_and_delta[N];

}
parameters {

  // See section 22.5 in the Stan manual for an explanation of array and vector referencing.
  // Basically:
  // vector[i] thing[j,k,l]
  // is referenced thing[j,k,l,i]
  // That is, thing[j,k,l] is a vector[i]

  real<lower=0> B;
  real<lower=0> theta;


}
model {

  for(i in 1:N){

    Surv_T_and_delta[i] ~ surv_dens( B, theta );
  }

  B ~ lognormal(0,1000);
  theta ~ lognormal(0,1000);

}
