
MC <- function(ntrials, nCat, S, d, a, b){
  
  O <- array(0,c(ntrials)) #corr/incorr choice (outcome)
  R <- array(0,c(ntrials)) #conf. rating
  gam <- array(0,c(nCat-1)) #unbiased thresholds
  gamReal <- array(0,c(nCat-1))
  dReal <- array(0,c(nCat-1)) #actual/biased thresholds for the conf ratings
  pIn <- array(0,c(nCat)) #probs of incorrect for each rating
  pC <- array(0,c(nCat)) #probs of correct for each rating
  pR <- array(0,c(ntrials,nCat)) #prob of each rating trial by trial given corr/incorr outcome
  
  #Unbiased thresholds for the ratings
  for (c in 1:(nCat-1)){
    gam[c] <- c/nCat
    gamReal[c] <- -log((1-gam[c])/gam[c])
  }
  
  #linear regression to set thresholds
  for (c in 1:(nCat-1)){
    dReal[c] <- a * gamReal[c] + b
  }
  
  ##set probabilities for each rating given corr and incorr responses
  #for rating 1 given incorr. (0,1 for incorr. distr.) and corr (mu,lambda)
  pIn[1] <- pnorm(dReal[1],0,1)
  pC[1] <- pnorm(dReal[1],d,1)
  #prob for rest of the ratings given incorr. and corr.
  for (c in 2:(nCat-1)){
    pIn[c] <- pnorm(dReal[c],0,1) - sum(pIn[1:(c-1)])
    pC[c] <- pnorm(dReal[c],d,1) - sum(pC[1:(c-1)])
  }
  #prob for last rating
  pIn[nCat] <- 1 - sum(pIn[1:(nCat-1)])
  pC[nCat] <- 1 - sum(pC[1:(nCat-1)])
  
  #####Data draws by trials
  for (t in 1:ntrials){
    
    ## outcome of the trial based on S
    O[t] <- rbinom(1, 1, S) #outcome of trial t (0/1) follows skill binomial distr. = real skill

    ## rating
    for (c in 1:(nCat)){
      pR[t,c] <- ifelse(O[t]==1, pC[c], pIn[c])
    }
    
    R[t] <- rcat(1,pR[t,])
    #if 1 (corr), rating according to pC owtherwise pIn
    
  }
  
  results <- list(O=O, R=R, dReal=dReal, gam=gam, gamReal=gamReal, pC=pC, pIn=pIn, pR=pR)
  
}