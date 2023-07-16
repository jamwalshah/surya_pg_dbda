# day16 2023 06 28

grades = c('A', 'B', 'A', 'C', 'C', 'B', 'A', 'A', 'B', 'D', 'B', 'A', 'A', 'A', 'B', 'C', 'B', 'A', 'A', 'B')
# creating a vector

length(grades)
# returns count of observations

unique(grades)
# returns unique items from observations

grd_count = table(grades)
# returns frequencies
grd_count
# prints frequencies

grd_prop = grd_count/length(grades)
# calculating proportions from frequencies
grd_prop
# prints proportions

grd_pct = grd_prop * 100
# calculating percentages
grd_pct
# prints percentages

cumsum(grd_pct)
# prints cummulative sum of grd_pct
cumsum(grd_count)
# prints cummulative sum of grd_count

# pie chart / bar graph , x-axis data is continuous
barplot(grd_count)
pie(grd_count)

# in python, matplotlib, seaborne, for data visualization
# in R  lang, we use ggplot, for data visualization



head(faithful)
# printing head from pre-installed data.frame

erupt = faithful$eruptions
# creating vector for eruptions column of faithful data.frame
head(erupt)
# printing head from erupt vector

min(erupt)
# print min value from vector erupt
max(erupt)
# print max value from vector erupt

# 1.5-2.2 , 2.2-3.5 , 3.5-4.7 , 4.7-5.2
# here in above intervals, bin size is not same

b = c(1.5, 2.2, 3.5, 4.7, 5.2)
# creating vector for interval cuts

head(erupt)

erupt_cat = cut(erupt, b)
# creating vector of bind that value belongs based on cuts vector
# bu default, it'll generate bins by right=T, takes right as inclusive & left is non-inclusive
head(erupt_cat)

# '(' & ')' means value not included in interval
# '[' & ']' means value is included in interval

erupt_cat_new = cut(erupt, b, right=F)
# it'll generate bins by right=F, takes right as non-inclusive & left is inclusive now
head(erupt_cat_new)

erupt_cat_name = cut(erupt, b, labels = c('A', 'B', 'C', 'D'))
# it'll generate bins with labelling as per specified vector
head(erupt_cat_name)

table(erupt_cat_name)
# prints freqiencies of each bin

barplot(table(erupt_cat_name))
# generates a bar plot for frequencies of each bin
barplot(sort(table(erupt_cat_name)))
# generates a bar plot for frequencies of each bin in sorted order
barplot(sort(table(erupt_cat_name), decreasing=T))
# generates a bar plot for frequencies of each bin in decreasing sorted order

hist(erupt, b)
# generates histograms using cuts on x-axis

table(erupt_cat_name)/length(erupt)
# calculating weighted mean
round(table(erupt_cat_name)/length(erupt), 3)
# rounding weighted mean to 3 decimals


mean(erupt)
# mean of erupt vector
median(erupt)
# median of erupt vector

erupt_count = table(erupt)
which(erupt_count == max(erupt_count))
# returns indices satisfying the condition
erupt_count[which(erupt_count == max(erupt_count))]
# mode
# fetch mode values from vector which have highest frequencies

max(erupt)
min(erupt)
max(erupt) - min(erupt)
# range
range(erupt)
# interval of observations

quantile(erupt, 0.75) - quantile(erupt, 0.25)
# returns percentage of wuantile & value of IQR

var(erupt)
# calculates variance
sd(erupt)
# calculates S.D.


install.pacakges('moments')
library(moments)

skewness(erupt)
# -ve skewness means Left skewed, peak is at right side of mean
kurtosis(erupt)
# +ve kurtosis means heavy tail
hist(erupt)
# plot histogram to see the properties of distribution


# -------------------------------------------------------------------------------------
### Discrete Probability distributions
# -------------------------------------------------------------------------------------
# Binomial Probability Distribution
# -------------------------------------------------------------------------------------
# chances of rain in June 0.7
# and I stay in Mumbai for 10 days
# 1. it rains for exactly 7d
# 2. rains for upto 7d
# 3. rains for min 7d

dbinom(7, 10, 0.7)
# exactly 7d/10d
# pmf
 
pbinom(7, 10, 0.7) 
# cdf for at max 7d/10d

1- pbinom(6, 10, 0.7)
# cdf for min 7d/10d
# sf for min 7d/10d

pbinom(6, 10, 0.7, lower.tail=F)
# lower.tail = F, same as sf for min 7d/10
# cdf for min 7d/10d
# sf for min 7d/10d

# Q. atleast 3 panelists out of 5 panelists select a candidate with 
1 - pbinom(2, 5, 0.4)
pbinom(2, 5, 0.4, lower.tail = F)
dbinom(3, 5, 0.4) + dbinom(4, 5, 0.4) + dbinom(5, 5, 0.4)

# -------------------------------------------------------------------------------------
# Poisson Probability Distribution
# -------------------------------------------------------------------------------------
# avg occurences for accidents  is 25 per day
# prob of exactly 17 accidents, upto 17 acccidents and min 17 acccidents

dpois(17, 25)
# prob of eactly 17 accidents
# pmf

ppois(17, 25)
# prob of upto 17 accidents
# cdf

1 - ppois(16, 25)
# prob of at least 17 accidents
# 1 - cdf

# Q. 12 cases of lightening strike in kharghar
# prob of lightening not striking in 1 month stay
dpois(0, 1)
# 12 strikes/12m => 1 strike/1month
# need to find for 0 strikes 



# -------------------------------------------------------------------------------------
# Hyper-Geometric Probability Distribution
# -------------------------------------------------------------------------------------
# in the box of 100 LEDs, we'll allow 10 to be defective
# take a sample 10 LEDs, what is the prob that upto 1 will be defective

phyper(1, 100, 10, 10)
# hypergeom.cdf(k, N, K, n)
#  K : outcome of interest in Population
#  N : Population Size
#  k : outcome of interest in Sample
#  n : Sample Size


# -------------------------------------------------------------------------------------
### Continuous Probability distributions
# -------------------------------------------------------------------------------------
#  Exponential Probability Distribution
# -------------------------------------------------------------------------------------
# Q. 200 break downs are reported in a year
# average time between two  break downs
# client is in my office for 60hrs, what is the prob that he'll the breakdown
(24*365)/200
# on an average next break down will take place after 43.8hrs
# hours per breakdown is 43.8hrs
pexp(60, 1/43.8)
# pexp(timeFrame, 1/avgFailureTime)
# for client staying 60hrs

# Q. 200 break downs are reported in a year
# average time between two  break downs
# client is in my office for 80hrs, what is the prob that he'll the breakdown

pexp(80, 1/43.8)
# for client staying 80hrs

# -------------------------------------------------------------------------------------
#  Normal Probability Distribution
# -------------------------------------------------------------------------------------
# Q. time to go from station A to station B is 45min with S.D. 3min
# what is the prob that we reach there in less than 40min

pnorm(40, 45, 3)
# pnorm(X, x̄, σ) 
# cdf : takes Z-statistics on x-axis
# cdf : returns area under the curve/probability


# z = (X, x̄)/σ
z = (40-45)/3
pnorm(z)
 
# Q. time to go from station A to station B is 45min with S.D. 3min
# what is the prob that we reach there taking more than 40min
1 - pnorm(47, 45, 3)
# gives sf probabilityusing 1-cdf


pnorm(47, 45, 3, lower.tail = F)
# gives sf probability

qnorm(0.6)
# ppf : takes probability / area under the curve
# ppf : returns Z-Statistics on x-axis

qnorm(0.6)*5 + 70
# ppf: returns Z-statistics on right side of mean on x-axis
# qnorm(Area)*σ+x̄
# x̄ = 70
# σ = 5
qnorm(0.6, 70, 5)
# qnorm(Area, x̄, σ)

# Normal Distribution used when sample size > 30, and if Sample Size <= 30, then use Student's t distribution [as per Central Limit Theorem]
# Population S.D. is known, then use Normal Distribution and if Population S.D. is not known, then use Student's t distribution


# -------------------------------------------------------------------------------------
# t Probability Distribution
# -------------------------------------------------------------------------------------
# Q. time to go from station A to station B is 45min with S.D. 3min based on Sample Size of 21 trips
# what is the prob that we reach there in less than 40min

# z = (X-x̄)/σ
z = (40-45)/3
z

# for 21 trips, dof=20
pt(z, 20)
# pt(z, dof)
# cdf : takes Z-Satistics & dof
# cdf : returns probability/area under the curve

# for 2000 trips, dof=1999
pt(z, 1999)
# pt(z, dof)
# with increase in sample size, probability decreases


qt(0.6, 20)
# qt(area/probability, dof)
# ppf: takes area under the curve & dof
# ppf : returns Z-Satistics

# -------------------------------------------------------------------------------------
# Q1. completing a course takes 60hrs with population S.D. 2hrs. what is the probability that your course gets over between 57 & 61 hrs
pnorm(61, 60, 2) - pnorm(57, 60, 2)
# pnorm(X, x̄, σ)

# Q2. what is time above which 30% of the course will get over
# 61.048
# qnorm(Area, x̄, σ)
qnorm(0.7, 60, 2)
# area onleft side is 70%
# it returns Z-Satistics onright side of mean

# Q3. do the same questions above considering the sample S.D. based on a sample of 15 values
# Q 3.1
# z = (X, x̄)/σ
za = (61-60)/2
zb = (57-60)/2
# pt(z, dof)
pt(za, 15-1) - pt(zb, 15-1)

# Q3.2
# qt(area/probability, dof)
qt(0.7, 15-1)
# Z-Statistics*σ + x̄
qt(0.7, 15-1)*2 + 60
# -------------------------------------------------------------------------------------







# -------------------------------------------------------------------------------------
# Continuous data tools
# -------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------
# one-Sample t test
# -------------------------------------------------------------------------------------

erupt = faithful$eruptions
s1 = erupt[35:80]

# Q1.
# mean of s1 is at least 3.8
# Hₒ : mean(s1) >= 3.8 
# Hᴀ : mean(s1) < 3.8 ---> left tail test

t.test(s1, mu=3.8, alternative='less')
# t.test(sample, mu=claimedValue, alternative='less')
# t = -1.7325, degreeOfFreedom df = 45, p-value = 0.04502
# Interval Estimatation: 95 percent confidence interval: (-Inf, 3.790116)
# ActualMean : mean of x  (3.477152)
# P-Value 0.04502 < 0.05, so Hₒ is rejected

t.test(s1, mu=3.6, alternative='less')
# t.test(sample, mu=claimedValue, alternative='less')
# new claimed value = 3.6
# P-Value 0.2566 < 0.05, so Hₒ is rejected

t.test(s1, mu=3.6, alternative='less', conf.level = 0.98)
# t.test(sample, mu=claimedValue, alternative='less')
# C.L. = 0.98
# P-Value 0.2566 < 0.05, so Hₒ is rejected


# Q2. 
# mean of s1 is at most 3.3
# Hₒ : mean(s1) <= 3.3
# Hᴀ : mean(s1) > 3.3 ---> right tail test  

t.test(s1, mu=3.3, alternative='greater')
# t.test(sample, mu=claimedValue, alternative='greater')
# P-Value 0.1734 < 0.05, so Hₒ is rejected




# Q3. 
# mean of s1 = 3.3
# Hₒ : mean(s1) = 3.3
# Hᴀ : mean(s1) > 3.3 ---> right tail test  

t.test(s1, mu=3.3)
# by default alternative='two-sided'
# t.test(sample, mu=claimedValue)
# P-Value 0.3469 < 0.05, so Hₒ is rejected

t.test(s1, mu=3.3, alternative='two.sided')
# t.test(sample, mu=claimedValue, alternative='two.sided')
# P-Value 0.3469 < 0.05, so Hₒ is rejected


# -------------------------------------------------------------------------------------
# one-Sample t test
# -------------------------------------------------------------------------------------
erupt = faithful$eruptions
s1 = erupt[35:80]
s2 = erupt[130:160]

length(s1)
length(s2)

mean(s1)
# actual mean of s1
mean(s2)
# actual mean of s2

# Q3. 
# mean of s1 at least 0.25
# Hₒ : mean(s2) - mean(s1) >= 0.25
# Hᴀ : mean(s2) - mean(s1) < 0.25 --- > left tail test

t.test(s1, s2, mu=0.25, alternative='less') 
# t.test(s1, s2, mu=claimedValue, alternative='less')
# P-Value 0.125 < 0.05, so Hₒ is rejected



# -------------------------------------------------------------------------------------
# Paired t test
# -------------------------------------------------------------------------------------
# two samples are dependent and paired to each other
# sample size has to be same
# whenever performance/some numbers/parameters need to be compared before and after an event
# in two-sample t test: difference of averages/means of two samples is compared with claimed value
# in paired t test: mean of differences of two samples  is compared with claimed value

# before & after covid started, 
# before people worked from home and after people worked from office
before = c(7, 9, 8, 6, 7, 8)
after = c(6, 8, 9, 5, 6, 8)
# Q1. 
# since people started working from home, their time of delivery has increased by an avg of 0.2min
# Hₒ : avg(after-before) >= 0.2
# Hᴀ : avg(after-before) < 0.2 ---> left tail test

t.test(after, before, mu=0.2, alternative='less', paired=T)
# t.test(s1, s2, mu=claimedValue, alternative='less', paired=T)
# difference of means is statistically significant as P-Value 0.04786 < 0.05,
# so Hₒ is rejected


# -------------------------------------------------------------------------------------
# one-way ANOVA test
# -------------------------------------------------------------------------------------

head(InsectSprays)

str(InsectSprays)

unique(InsectSprays$spray)

InsectSprays$sprays = as.factor(InsectSprays$spray)
# changing data type to factors
str(InsectSprays$sprays)
# since people started working from home, their time of delivery has increased by an avg of 0.2min
# Hₒ : counts are the same for all the pairs of sprays
# Hᴀ : 

mod1 = aov(count ~ spray, data=InsectSprays)
#mod1 = aov(Response ~ Predictor, data=dataset)

summary(mod1)

TukeyHSD(mod1)
# calculate Tukey Honest Significant Differences

# -------------------------------------------------------------------------------------
# one-way ANOVA test
# -------------------------------------------------------------------------------------

head(ToothGrowth)

str(ToothGrowth)
# checking structure/datatype of ToothGrowth
ToothGrowth$dose = as.factor(ToothGrowth$dose)
# change type of dose column from num to factor
str(ToothGrowth)
# checking the datatype of column dose if it is factor

mod2 = aov(len ~ supp * dose, data=ToothGrowth)
#mod1 = aov(Response ~ Predictors with interaction, data=dataset)

summary(mod2)
# more number of '*' at end of row with predictor name indicates more interaction
# less number of  '*' at end of row with predictor name indicates less interaction












