RR <- function(ntrials, nCat, S){
  
  O <- array(0,c(ntrials)) #corr/incorr choice (outcome)
  R <- array(0,c(ntrials)) #conf. rating
  pIn <- array(0,c(nCat)) #probs of incorrect for each rating
  pC <- array(0,c(nCat))
  pR <- array(0,c(ntrials,nCat)) #prob of each rating trial by trial given corr/incorr outcome
  
  #whether correct or incorrect, equally 0.25 probability
  for (c in 1:nCat){
    pC[c] <- 0.25
    pIn[c] <- 0.25
  }
  
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
  
  results <- list(O=O, R=R, pC=pC, pIn=pIn, pR=pR)
  
}