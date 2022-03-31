# Monitoring: Modeling multiple-choice calibration
Master Thesis for the degree of Cognitive Science, Aarhus University
Supervisors: Daina Crafa & Joshua Charles Skewes

## Packages
- [rjags, coda](https://mcmc-jags.sourceforge.io/), [R2jags](https://cran.r-project.org/web/packages/R2jags/index.html)
- [polspline](https://cran.r-project.org/web/packages/polspline/index.html)
- [extraDistr](https://cran.r-project.org/web/packages/extraDistr/index.html)

## Overview
This project is a local, online calibration study in the context of a non-traditional multiple-choice knowledge task. The aim of the thesis was to investigate metacognitive monitoring and operationalize it through Bayesian cognitive modelling of behavioural data. 
In this modelling practice latent psychological variables are hypothesized that produce data that is observed. Such models are considered algorithmic hypotheses of cognitive processes through following probabilistic procedures of making inferences. For more information on the practice of cognitive modelling see the works of Lee & Wagenmakers. With regards to this study, see the included pdf: THESIS.pdf, Methods/Cognitive Modelling pp. 24-26
Four alternative models were built and investigated in light of one another.

### Task environment
The physical context of this research was a course that I instructed. Students were asked to individually send me a question from the course material they have covered and three alternative questions out of which one is the right answer to their question. These questions were combined in a test on SurveyXact. At the testing, questions appeared one-by-one and after each the student was asked to rate their confidence in finding the correct answer just before on a 4-point rating scale. They received no external feedback on their performance, instead they had to solely rely on their implicit judgments.
Task characteristics:
- uncontrolled questions (not set by the experimenter, various levels of difficulty varying across students)
- 3 options to choose from (not true or false), but outcome binary with being correct or incorrect (1/3 chance level of being correct)
- 4-point rating scale for confidence (no middle value)
- no feedback on performance (no process of internal correction/adjustment based on external feedback during the task)

The models and associated hypotheses were built to operationalize behaviour in this specific task environment. The overarching question was: how well can students distinguish between their correct and incorrect responses indicated by their confidence ratings?
- RQ1: Is monitoring accuracy tightly linked with performance? 'The more you know, the more you know what you know and what you don't.'
- RQ2: Does perceived difficulty of questions affect performance and biases on the confidence scale? = Is the hard-easy effect reproducible also in this task environment?

### Process of investigation and files
Apart from the first model (random responding), the rest three are built on the signal detection paradigm and mainly inspired by the following work: 
Selker, R., van den Bergh, D., Criss, A. H., & Wagenmakers, E. J. (2019). Parsimonious estimation of signal detection models from confidence ratings. Behavior Research Methods, 51(5), 1953-1967.
For details on SDT, underlying Maths and plate notations see Thesis.pdf pp.26-40

The 4 models: (Thesis.pdf pp.34-40)
- Random Responding: an underlying skill level produces performance on the knowledge questions but related confidence ratings are completely random (sanity-check and baseline null-hypothesis) ==> function: randomresp.R, jags: randomresp.txt
- Model Unrelated: null-hypothesis model of RQ1; skill and monitoring are unrelated (priors drawn from separate underlying distributions and thus updated separately) ==> function: unrelated.R, jags: unrelated.txt
- Model: model operationalizing RQ1; monitoring (d') is expressed from skill utilizing d' assumptions ==> function: model.R, jags: model.txt
- Model with added question difficulty: model operationalizing RQ2; see plate notation below (included here, as this model 'won') ==> function: model_qdb.R, jags: model_qdb.txt



## Cite this
If you find any parts of my work useful for your own project, you may cite it as (in APA):
Palfi, B. S. (2021). A metacognitive journey in monitoring: Modelling students' multiple-choice calibration in a non-traditional task environment (Unpublished manuscript). Department of Linguistics, Cognitive Science and Semiotics, Aarhus University.
