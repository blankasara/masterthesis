QD <- function(ntrials, nCat, S, d, a, b){
  
  O <- array(0,c(ntrials)) #corr/incorr choice (outcome)
  R <- array(0,c(ntrials)) #conf. rating
  Qd <- array(0,c(ntrials)) #Qd
  sQd <- array(0,c(ntrials)) #scaled Qd for bias
  prob_c <- array(0,c(ntrials)) #prob_c
  gam <- array(0,c(nCat-1)) #unbiased thresholds
  gamReal <- array(0,c(nCat-1))
  dReal <- array(0,c(nCat-1)) #actual/biased thresholds for the conf ratings
  dRealt <- array(0,c(ntrials,c(nCat-1))) #biased thresholds on trial t
  pIn <- array(0,c(ntrials,nCat)) #probs of incorrect for each rating
  pC <- array(0,c(ntrials,nCat)) #probs of correct for each rating
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
  
  #####Data draws by trials
  for (t in 1:ntrials){
    
    ## outcome of the trial based on S and Qd
    Qd[t] <- runif(1,1/3,1) #difficulty of question on trial t = prob of answering correct
    prob_c[t] <- S*Qd[t] #prob of answering right = product of skill and Qd
    O[t] <- rbern(1, prob_c[t]) #outcome of trial t (0/1) is a bernoulli trial
    
    ## rating based on adjusted scale on Qd
    #transform Qd to a different scale
    sQd[t] <- -log((1-Qd[t])/Qd[t])
    #decreasing bias (shift) along with increasing Q difficulty
    for (c in 1:(nCat-1)){
      dRealt[t,c] <- dReal[c] + sQd[t]
    }

    #for rating 1 on trial t given incorr./corr.
    pIn[t,1] <- pnorm(dRealt[t,1],0,1)
    pC[t,1] <- pnorm(dRealt[t,1],d,1)
    #prob for rest of the ratings given incorr. and corr.
    for (c in 2:(nCat-1)){
      pIn[t,c] <- pnorm(dRealt[t,c],0,1) - sum(pIn[t,1:(c-1)])
      pC[t,c] <- pnorm(dRealt[t,c],d,1) - sum(pC[t,1:(c-1)])
    }
    #prob for last rating
    pIn[t,nCat] <- 1 - sum(pIn[t,1:(nCat-1)])
    pC[t,nCat] <- 1 - sum(pC[t,1:(nCat-1)])
    
    ## rating
    for (c in 1:(nCat)){
      pR[t,c] <- ifelse(O[t]==1, pC[t,c], pIn[t,c])
    }
    
    R[t] <- rcat(1,pR[t,])
    #if 1 (corr), rating according to pC owtherwise pIn
    
  }
  
  results <- list(O=O, R=R, Qd=Qd, sQd=sQd, prob_c=prob_c, dReal=dReal, dRealt=dRealt, gam=gam, gamReal=gamReal, pC=pC, pIn=pIn, pR=pR)
  
}