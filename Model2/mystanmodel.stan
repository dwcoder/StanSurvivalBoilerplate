functions {

  //------------------
  // Declarations
  //------------------

  // Have to declare the functions before I can use them


  real log_h(real T,  real[] gompertz);

  real H_t(real T,  real[] gompertz);

  //------------------
  // Definitions
  //------------------

  real surv_dens_log(vector T_and_delta, real[] gompertz){
      real T;
      real delta;

      T     = T_and_delta[1];
      delta = T_and_delta[2];

      return (delta * log_h(T, gompertz))
                  -    H_t(T, gompertz) ;

      }

  real log_h(real T, real[] gompertz){
        real B;
        real theta;

        B     = gompertz[1];
        theta = gompertz[2];

        return log(B) + theta*T;

  }
  real H_t(real T,  real[] gompertz){
        real B;
        real theta;

        B     = gompertz[1];
        theta = gompertz[2];

        return (B/theta)*( exp(theta*T)-1 ) ;

  }

}

data {

  int<lower=0> N;
  int<lower=0> group[N];
  vector[2] Surv_T_and_delta[N];

}
parameters {

  // See section 22.5 in the Stan manual for an explanation of array and vector referencing.
  // Basically:
  // vector[i] thing[j,k,l]
  // is referenced thing[j,k,l,i]
  // That is, thing[j,k,l] is a vector[i]

  real<lower=0> gompertz[2,2]; // gompertz[group, {1=B, 2=theta}]

}
model {

  for(i in 1:N){
    Surv_T_and_delta[i] ~ surv_dens( gompertz[group[i]] );
  }

  for(i in 1:2){
    for(j in 1:2){
      gompertz[i,j] ~ lognormal(0,1.5);
    }
  }

}
