# day17 2023 06 29


install.packages('EnvStats')
library(EnvStats)

# -------------------------------------------------------------------------------------
# Continuous data tools
# -------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------
# one-Sample Variance test
# -------------------------------------------------------------------------------------

erupt = faithful$eruptions
s1 = erupt[30:80]
# creating one-Sample
var(s1)
# calculating variance of one-Sample

# Q1.
# variance of s1 is at least 3.8
# Hₒ : var(s1) <= 1
# Hᴀ : var(s1) > 1 ---> left tail test

varTest(s1, sigma.squared = 1, alternative = 'greater')
# varTest(one-Sample, sigma.squared = claimed-Variance, alternative = 'Sign of Hᴀ')
# $conf.int
# LCL      UCL 
# 1.104715      Inf 
# here lower bound is 1.104715, but claimed value is lesser
# so we reject the Hₒ

# -------------------------------------------------------------------------------------
# two-Sample Variance test
# -------------------------------------------------------------------------------------
erupt = faithful$eruptions

s1 = erupt[30:80]
s2 = erupt[210:240]
# creating two-Samples
var(s1)
var(s2)
# calculating variance of two-Samples

# Q1.
# variance of s1 is at least 3.8
# Hₒ : var(s2)-var(s1) >= 1.1
# Hᴀ : var(s2)-var(s1) < 1.1 ---> right tail test

var.test(s2, s1, ratio = 1.1, alternative = 'less')
# var.test(s2, s1, ratio = claimed value, alternative = 'less')
# F = 0.70485, num df = 30, denom df = 50, p-value = 0.1541
# since p-value = 0.1541 < 0.05, so we don't reject Hₒ

# -------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------
# Discrete data tools
# -------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------
# one-Sample Proportion test
# -------------------------------------------------------------------------------------
# Q1.
# at least 70% of the people in the batch are Males
# Hₒ : prop(males) >= 0.7
# Hᴀ : prop(males) < 0.7

# from a sample of 84 people, 65 are males
65/84

# from a sample of 84 people, 50 are males
50/84
prop.test(50, 84, p=0.7, alternative = 'less')
# prop.test(score, total, p=claimedProportion, alternative = 'less')
# X-squared = 3.9053, df = 1, p-value = 0.02407
# p-value = 0.02407 < 0.05 so we reject the Hₒ

# Q2.
# at least 65% of the people in the batch are Males
# Hₒ : prop(males) >= 0.65
# Hᴀ : prop(males) < 0.65


prop.test(50, 84, p=0.65, alternative = 'less')
# prop.test(score, total, p=claimedProportion, alternative = 'less')
# X-squared = 0.87964, df = 1, p-value = 0.1741
# p-value = 0.1741 > 0.05 so we don't reject the Hₒ

# -------------------------------------------------------------------------------------
# two-Samples Proportion test
# -------------------------------------------------------------------------------------
# Q1.
# MH has  at least 12% more COVID infected people as compared to GJ
# from MH, in a sample of 150 people, 115 were infected
# from GJ, in a sample of 100 people, 80 were infected

115/150 - 80/100
# difference of proportions
# Note: 
# R Lang two samples Proportion test does not allow you to 
# enter claimed value, default claim value is 0 (zero)
# Don't take the decision of rejecting Hₒ on basis of P-Value, as it is on
# basis of claim value 0

# at least 70% of the people in the batch are Males
# Hₒ : prop(MH) - prop(GJ) >= 0.12
# Hᴀ : prop(MH) - prop(GJ) >= 0.12
prop.test(c(115, 80), c(150, 100), alternative = 'less')
# prop.test(c(115, 80), c(150, 100), alternative = 'less')
# X-squared = 0.21853, df = 1, p-value = 0.3201
# 95 percent confidence interval:
#   -1.00000000  0.06192227
# P-Value is misleading, don't decide on basis of P-value
# check with interval, upper interval 0.06192227 < claimed value 0.12,
# so we reject Hₒ

# -------------------------------------------------------------------------------------
# Goodness of Fit test
# -------------------------------------------------------------------------------------
# Q1.
pattern = c(0.6, 0.2, 0.15, 0.05)
# defining the pattern of observations
sum(pattern)
# sum of all the pattern values in observation should be 1

# Hₒ : sample follows the defined pattern
# Hᴀ : sample does not follow the defined pattern

cts = c(120, 50, 40, 30)
# actual observations from market

chisq.test(cts, p=pattern)
# chisq.test(cts, p=pattern)
# X-squared = 31.528, df = 3, p-value = 6.581e-07
# here p-value = 6.581e-07 = 0 < 0.05 ,so we reject the Hₒ

sum(cts)
# finding sum of all actual observations to spread on pattern 
# to generate expected values
exp = 240*pattern
exp
# generates expected values on basis of pattern

x = (exp-cts)**2/exp
x
# finding variance of each of the observed value w.r.t. expected value
#   4.00000000  0.08333333  0.44444444 27.00000000
# statistically , actual value 30 and expected value 12 
# have a significant difference

sum(x)
# finding test Statistic

# -------------------------------------------------------------------------------------
# Degree of Association Test
# -------------------------------------------------------------------------------------
# Q1.
train = c(50, 80, 30)
flight=c(20, 50, 25)
bus=c(80, 30, 50)
travel = rbind(train, flight, bus)
colnames(travel) = c('Summer', 'Rain', 'Winter')
travel # prints contingency table

# Hₒ : season does not impact the time taken to travel
# Hᴀ : season impact the time taken to travel
chisq.test(travel)
# chisq.test(contingency table)
# X-squared = 47.132, df = 4, p-value = 1.431e-09
# p-value = 1.431e-09 < 0.05 , so we reject Hₒ

# -------------------------------------------------------------------------------------
# one-Sample Poisson Rate
# -------------------------------------------------------------------------------------
# claim against the ratio of occurrences in one sample 
# compare against claimed value
# Q1.
# to compare the counts obtained from a sample against the claimed value
# claimed that fewer than 3 accidents take place on the local every day
# Hₒ : n <= 3
# Hᴀ : n > 3

# in a sample of 20 days, I saw 75 accidents were reported
75/20
# calculating ratio of occurrence

poisson.test(75, T=20, r=3, alternative = 'greater')
# poisson.test(NumberOfEventsInSample, T=SampleSize, r=claimRatio, alternative = 'greater')

# number of events = 75, time base = 20, p-value = 0.03407
# 95 percent confidence interval:
#   3.067294      Inf

# here, p-value = 0.03407 < 0.05,  so we reject Hₒ
# claimed value = 3 < lowerIntervalLimit = 3.067294, so we reject Hₒ

# -------------------------------------------------------------------------------------
# two-Sample Poisson Rate
# -------------------------------------------------------------------------------------
# ratio of the rates of occurrences in two different samples
# is compared against a claimed value


# Q1.
# in a sample of 30 days, I saw 100 accidents were reported in Blore
# in a sample of 20 days, I saw 75 accidents were reported in Mumbai

(100/30) / (75/20)
# ratio of rates of occurrences

# to compare the counts obtained from a sample against the claimed value
# claimed that fewer than 3 accidents take place on the local every day
# Hₒ : rate(Blr) / rate(Mum) = 1
# Hᴀ : rate(Blr) / rate(Mum) != 1 --> two-tail test

poisson.test(c(100, 75), T=c(30, 20), r=1, alternative = 'two.sided')
# poisson.test(c(obs1, obs2), T=c(sampleSize1, sampleSize2), r=claimedRatio, alternative = 'two.sided')

# count1 = 100, expected count1 = 105, p-value = 0.4414
# 95 percent confidence interval:
# 0.6523343 1.2156621

# here, p-value = 0.4414 > 0.05, so we don't reject Hₒ
# also, claimed value, r=1 lies in interval, so we don't reject Hₒ



# -------------------------------------------------------------------------------------
# Regression models
# -------------------------------------------------------------------------------------
# Scaling
# -------------------------------------------------------------------------------------
# scaling: 3 - min(x1) / max(x1) - min(x1)
# scaling (Std Normal Distribution): x - mean(x1) / σ(x1)
x = c(3,8,6,5,4,8,9,2)
# creating sample
x_sc = (x - mean(x)) / sd(x)
x_sc
# scaling w.r.t.  Standard Normal Distribution

mean(x_sc)

sd(x_sc)

# -------------------------------------------------------------------------------------
# simple linear regression
# -------------------------------------------------------------------------------------

# Hₒ : response Stack.loss does not depend on Acid.Conc
# Hᴀ : response Stack.loss depends on Acid.Conc

head(stackloss)

str(stackloss)
# checking type

mod1 = lm(stack.loss ~ Air.Flow + Water.Temp + Acid.Conc., data=stackloss)
# mod1 = lm(response ~ predictors, data=dataset)
# creating model

mod1 = lm(stack.loss ~ ., data=stackloss)
# mod1 = lm(response ~ allPredictorsExceptResponse, data=dataset)
# creating same model using '.'

summary(mod1)
# printing model summary
# intercept = constant
# adj R-Squared increases as num of predictors increases
# Residual:  diff b/w predicted value & actual value, 
#         values of residuals should be normally 
#         distributed with AverageValuemean=0
#         residuals should be independent of the 
#         actual value & Predicted value
# 

mod2 = lm(eruptions ~ waiting, data=faithful)
plot(mod2)
# shows Residuals vs.fitted
# shows Q-Q Residuals
# shows Scale vs. Location
# shows Residuals vs. Leverage

# -------------------------------------------------------------------------------------
# multiple linear regression
# -------------------------------------------------------------------------------------

# Hₒ : salary does not depend on yrs.service
# Hᴀ : salary depends on yrs.service

install.packages('car')
library(car)

head(Salaries)

df = Salaries[, c('rank', 'yrs.service', 'salary')]
head(df)
# selecting only specific columns

str(df)
# check if categorical data is factor type, if not, 
# then change type to factor

levels(df$rank)
# checking possible values of rank column in data.frame df

df$rank = relevel(df$rank, ref = 'AsstProf')
# changing the reference event for categorical data


mod1 = lm(salary ~ ., data = df)
# creating model
summary(mod1)
# printing summary of model


# with 1 yr increase in yrs.service, salary decreases with 158.1rs
# with AsstProf-->AssocProf, salary increases with 14615.4rs

# -------------------------------------------------------------------------------------
# binary logistic regression
# -------------------------------------------------------------------------------------

# Hₒ : wt does not impact on am
# Hᴀ : wt impacts on am

head(mtcars)

unique(mtcars$cyl)
# checking unique values of cyl column, which seems categorical 
str(mtcars)
# but cyl is num type, so need to convert it to factor type
df  = mtcars[,c('wt', 'cyl', 'am')]
head(df)


df$cyl = as.factor(df$cyl)
# changing type of cyl col to factor
str(df)
# checking type of cyl column

mod1 = glm(am ~ ., data = df, family = 'binomial')
# glm(response ~ predictors, data = dataset, family = 'binomial')
# creating model
summary(mod1)
# printing summary

# wt            -7.859      3.055  -2.573  0.01009 * 
# P-Value 0.01009 < 0.05, so Hₒ is rejected, so wt impacts car 
# being automatic/manual
# when weight decreases, chances of car being automatic 
# increases by 7.859 times

# -------------------------------------------------------------------------------------
# Nominal/Multi-Nomimnal logistic regression
# -------------------------------------------------------------------------------------

# Hₒ : ses does not impact on prog
# Hᴀ : ses impacts on prog
library('readxl')
getwd()
setwd('C:/Users/lootera-ip-win/Downloads/advanced-analytics-files/day17')

df = read_excel('CDAC_DataBook.xlsx', sheet='nominal')
# load dataset
str(df)
# check type of columns
df$ses = as.factor(df$ses)
df$prog = as.factor(df$prog)
str(df)
# converting cols ses & prog to factor type

install.packages('nnet')
library(nnet)

mod1 = multinom(prog ~ ., data=df)

summary(mod1)

z = summary(mod1)$coefficients/ summary(mod1)$standard.errors
# Z = coefficients/StandardErrors
z
# printing value of Z

p = (1-pnorm(abs(z)))*2
# p = (1-cdf(|z|))*2
# p = (sf(|z|))*2
# calculating p-value
p
# printing P-value




# -------------------------------------------------------------------------------------
# Sudeep's work
# -------------------------------------------------------------------------------------
mod1 = glm(am~wt+as.factor(cyl), data=mtcars, family = "binomial")
# creating model with Binary Logistic Regression
mydata = data.frame(wt=2.5, cyl=c('4','6','8'))
# creating test data for predition
predict(mod1, mydata, type = 'response')
# generate prediction using test data in model
log(0.9986194 /(1-0.9986194 )) - log(0.7693113/(1-0.7693113))
# finding the coefficient of Binary Logistic Regression Equation
summary(mod1)
# coefficient found by formula in last step is same as coefficient in 
# model summary









