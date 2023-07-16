# day15 2023 06 27

# for loop: when no of iterations are known
#   e.g. un
# while loop: when no of iterations are unknown
#   e.g. until credit limit>0, transactions are allowed

# for loop
example = function(){
  x = c(3, 8, 7, 6, 1, 4, 0, 8)
  for (ctr in x){
    print(ctr**2)
  }
  print("Hello World")
}
example()

# for loop using vector generation using slicing of positions
MyFunc = function(){
  x = c(3, 8, 7, 6, 1, 4, 0, 8)
  for (ctr in 1:length(x)){
    print(x[ctr]**2)
  }
}
MyFunc()


# while loop
CreditCard = function(){
  credit_limit = 1000
  while(credit_limit>0){
    pur = as.numeric(readline("Enter purchase amount: "))
    credit_limit = credit_limit - pur
  }
  print("Txn Declined: Your card limit is less than purchase")
}
CreditCard()

var1 = c(4, 7, 6, 4, 2, 9, 1, 8)
# creating a vector
var1 %in% c(7, 10)
# checking if each of the element in var1 is in vector of 7, 10

which(var1 %in% c(7, 10))
# check position that satisfies condition 
var1[2]
# printing value at the position 2 which satisfied the condition

example2 = function(){
  x = c(3, 8, 7, 6, 1, 4, 0, 8)
  for(ctr in x){
    if (ctr %in% c(0, 1)){
      break
    }
    else{
      print(ctr**2)
    }
  }
}
example2()

#####
# python pass & continue comparison
# def MyCalc():
#   x = [2, 1, 8, 0, 5]
#   for ctr in x:
#     if ctr in [0, 1]:
#       continue
#     else:
#       print(ctr**2)
#     print('Hello')

# def MyCalc():
#   x = [2, 1, 8, 0, 5]
#   for ctr in x:
#     if ctr in [0, 1]:
#       pass
#     else:
#       print(ctr**2)
#     print('Hello')


# local variable
MyCalc = function(x, y){
  z = 2*x+y
  print(z)
}
MyCalc(3, 8)
print(z)
# throws error, z is local variable and not accessible outside function


# global variable
# a is global variable so accessible in local scope of function too
a=7
MyCalc1 = function(x, y){
  z = 2*x+y+a
  print(z)
}
MyCalc1(3, 8)


# global variable, value update
# a is global variable so accessible in local scope of function too
a=7
print(a) # prints a=7, it is global access
MyCalc2 = function(x, y){
  a=5
  print(a)# prints a=5, it is local access, and value is updated to 5
  z = 2*x+y+a
  print(z)
}
MyCalc2(3, 8)
print(a)# prints a=7, it is global access again


# returning value
MyCalc3 = function(x, y){
  z = 2*x+y+a # local variable z
  print(z)
  return(z)
}
f = MyCalc3(3, 8) # saved to f, global variable
f
z = MyCalc3(3, 8) # saved to z, another global variable
z


# returning multiple values of same type
MyCalc4 = function(x, y){
  a=5
  z = 2*x+y+a # local variable z
  t = x+y
  print(z)
  return(c(z, t))
}
e = MyCalc4(3, 8)
e

# returning multiple values of different type
MyCalc5 = function(x, y){
  a=5
  z = 2*x+y+a # local variable z
  t = 'abc'
  print(z)
  return(list(z, t))
}
e = MyCalc5(3, 8)
e # prints a list of different types


MyCalc6 = function(x, y){
  z = 2*x+y
  print(z)
  return(z)
}
MainFunc = function(a, b){
  t = MyCalc(a, 3)
  z = t + b
  print(z)
}
MainFunc(2, 4)


getwd()
# checking working dir
setwd('C:/Users/lootera-ip-win/Downloads/advanced-analytics-files/day15')
# changing working dir
df = read_excel('ERPData.xlsx')
# loading excel sheet to data.frame
head(df)
str(df)
# data type is data.frame

nrow(df)
# prints number of rows in data.frame
ncol(df)
# prints number of cols in data.frame
colnames(df)
# printing columns in df
colnames(df)[2] = 'Station'
# renaming name of col#2 
colnames(df)
# printing columns in df

which(df$Station=='MWH-2')
# prints positions satisfying condition
df[which(df$Station=='MWH-2'), 3]
# prints 3rd column of records which satisfy the condition


# fetch some specific records based on condition
# method#1
mydf = df[which(df$Station=='MWH-2'),]
# copying full records from data.frame df which  satisfy the condition
mydf
# printing new data.frame

# fetch some specific records based on condition, but fetch only specific columns
# method#1.1
mydf = df[which(df$Station=='MWH-2'), -2]
# copying records but without col#2 from data.frame df which satisfy the condition
mydf
# printing new data.frame

# fetch some specific records based on condition
# method#12
mydf = subset(df, df$Station='MWH-2')
# using subset command to create a subset of data.frame
mydf2
# printing subset data.frame with some specific records which satisfy the condition

# location MWH-2 Qty>=50
mydf3 = df[which(df$Station=='MWH-2' & df$Quantity>=50), ]
mydf3
#method 2
mydf31 = subset(df, df$Station=='MWH-2' & df$Quantity>=50)
mydf31


# Q. add one column if one column scrap, if qty>=50, then mark scrap
# method1
df = read_excel('ERPData.xlsx')
# loading excel sheet to data.frame
head(df)
use = c()
idx = which(df$Quantity>= 50)
for (ctr in 1:nrow(df)){
  if (df$Quantity[ctr]>=50){
    use = append(use, "useful")
  }
  else{
    use = append(use, "scrap")
  }
}
use
idx

df$Status = use
print(head(df))
sum(df$Quantity[df$Status=='scrap'])
sum(df$Quantity[df$Status=='useful'])

#method 2
df = read_excel('ERPData.xlsx')
# loading excel sheet to data.frame
head(df)
CountScrapUseful = function(){
  use=c()
  for(ctr in 1:nrow(df)){
    if(df$Quantity[ctr]>=50){
      use[ctr]='useful'
    }
    else{
      use[ctr]='scrap'
    }
  }
  df$status = use
  head(df)
}
CountScrapUseful()


head(airquality)
# first 5 records from airquality
nrow(airquality)
# print number of rows in airquality

x = c(4, 7, 6, NA, 2, 3, NA, 9)
#  creating a vector with null values represented by NA
x
is.na(x)
# returns a vector of logi types indicating if it has null value or not
which(is.na(x))
# returns positions where value is null


which(is.na(airquality$Ozone))
# indices of records where Ozone has null value
length(which(is.na(airquality$Ozone)))
# count of records where Ozone is null

# Q. row indices where Ozone & Solar.R is missing
which(is.na(airquality$Ozone) & is.na(airquality$Solar.R))
airquality[which(is.na(airquality$Ozone) & is.na(airquality$Solar.R)), ]
mydf4 = airquality[-which(is.na(airquality$Ozone) & is.na(airquality$Solar.R)), ]
head(mydf4)

# Q. temp between 65 & 85
length(which(airquality$Temp>=65 & airquality$Temp<=85))
# count of records with 65<=temp<=85
head(airquality[which(airquality$Temp>=65 & airquality$Temp<=85), ])
# records with 65<=temp<=85


stu_name = c('Sachin', 'Dhoni', 'Virat', 'Sehwag', 'Rahane', 'Rohit')
stu_ID = c('A12', 'D34', 'A12', 'A12', 'D34', 'Y45')
stu_df = data.frame(Name=stu_name, ID=stu_ID)
stu_df

stu_name = c('Sachin', 'Dhoni', 'Virat', 'Sehwag', 'Rahane', 'Rohit', 'Yuvraj')
stu_ID = c('A12', 'D34', 'A12', 'A12', 'D34', 'Y45', 'T23')
stu_df = data.frame(Name=stu_name, ID=stu_ID)
stu_df

duplicated(stu_df$ID)
# marks duplicate values except the first one
# returns a vector of logi values
which(duplicated(stu_df$ID))
# returns positions which have duplicate values
dup_ID = unique(stu_df$ID[idx])
dup_ID
# prints unique duplicate items from ID col of stu_df
# to identify the values which are duplicated

stu_df %in% dup_ID
# marks all the duplicate items, does not leave the first duplicate too
# better than duplicated method

which(stu_df$ID %in% dup_ID)
# returns positions which are duplicates
idx2 = which(stu_df$ID %in% dup_ID)
idx2
# splitting the data.frame into one with duplicate values, one with unique values
df1 = stu_df[idx2, ]
# data.frame with null values
df1

df2 = stu_df[-idx2, ]
# data.frame without null values
df2

# R lang provides a vector of letters incase you need to check if value is alphabet or not
letters
LETTERS

# R lang provides multiple data sets , you can use them on-the-go
head(airquality)
head(faithful)
head(stackloss)


getwd()
ldf1 = read_excel('locations.xlsx', sheet='Pune')
# loading Pune work sheet into data.frame
ldf1

ldf2 = read_excel('locations.xlsx', sheet='Mumbai')
# loading Mumbai work sheet into data.frame
ldf2

merge(ldf1, ldf2)
# joins data.frames

merge(ldf1, ldf2, by='Subject')
# does inner join on column Subject
# acts as intersection

merge(ldf1, ldf2, by = c('Subject', 'Grade'))
# does inner join on two columns Subject & Grade
# acts as intersection


merge(ldf1, ldf2, by = c('Subject', 'Grade'), all=T)
# does outer join on two columns Subject & Grade
# acts as union

merge(ldf1, ldf2, by = 'Subject', all=T)
# does outer join on Subject
# acts as union

merge(ldf1, ldf2, by = 'Subject', all=F)
# does inner join on Subject as all=F
# acts as intersection

merge(ldf1, ldf2, by = 'Subject', all.x =T)
# does left join on Subject as all.x=T

merge(ldf1, ldf2, by = 'Subject', all.y =T)
# does right join on Subject as all.y=T

dfl1 = read_excel('locations.xlsx', sheet = 'Salary')
dfl1
dfl2 = read_excel('locations.xlsx', sheet = 'Deptt')
dfl2

merge(dfl1, dfl2)
# does an inner join, by default, all=T

merge(dfl1, dfl2, all=T)
# does an inner join

merge(dfl1, dfl2, all.x = T)
# does left join

merge(dfl1, dfl2, all.y=T)
# does right join


getwd()
setwd('C:/Users/lootera-ip-win/Downloads/advanced-analytics-files/day15')
library('readxl')
df = read_excel('ERPData.xlsx')
# loading dataset into df
head(df)

x = c(4, 8, 7, 2, 3, 6, 9, 6)
# creating a vector
sort(x)
# sort vector in increasing order
sort(x, decreasing = T)
# sort vector in decreasing order

order(x)
# returns positions in increasing order of values
order(x, decreasing = T)
# returns positions in decreasing order of values

head(df)
q = df$Quantity
# copying Quantity column of data.frame df into vector q
idx3 = order(q)
# generating positions in increasing order of values
head(idx3)
# printing first 6 records from positions
tail(idx3)
# printing last 6 records from positions
df_sorted = df[idx3, ]
# using positions to create a separate data.frame which
# has records sorted on Quantity column
head(df_sorted)
# printing first 6 records from positions

# Q.sort as per location column
head(df)
# printing first 6 records from data.frame
idx4 = with(df, order(Location, MaterialID, Quantity))
# return indices with ordering on multiple columns
df_sorted4 = df[idx4, ]
# creating another data.frame using ordered indices
head(df_sorted4)
# printing sorted data.frame
idx5 = with(df, order(Location, MaterialID, Quantity))
# return indices with ordering on multiple columns
df_sorted5 = df[idx5, ]
# creating another data.frame using ordered indices
head(df_sorted5)
# printing sorted data.frame


# dplyr
install.packages('dplyr')
# tidyverse
install.packages('tidyverse')

library('dplyr')
library('tidyverse')
# activating the library

# piped command
round(34.7246, 3)
# rounding off to 3 decimals
round(34.7243, 3)
# rounding off to 3 decimals
32.7243 %>% round(3)
# piped command

head(df)
mean(df$Quantity)
# mean of Quantity column

# summarise()
summarise(df, MyData=mean(Quantity))
# calculate separate metrics
summarise(group_by(df, Location), MyData=mean(Quantity), Nums=n())
# calculate separate metrics for different groups
# mean(): calculates mean
# n(): calculates count


# group_by()
grp1 = group_by(df, Location, MaterialID)
# grp1 created on Location & MaterialID of data.frame df
grp1
# prints the groupd_df
summarise(grp1, TotalQuantity=sum(Quantity), Nums=n())
# prints the metrics sum() & n() for group1

mydf= summarise(grp1, TotalQuantity=sum(Quantity), Nums=n())
# stores the metrics sum() & n() of  into data.frame
mydf
# prints summary data.frame

mydf = subset(mydf, mydf$Location=='MWH-1')
# creates a subset data.frame where Location=MWH-1
mydf
# prints subset data.frame



df = read_excel('data1.xlsx')
library(tidyverse)
# activates library tidyverse
df

df1 = gather(df, Year, Cases, c('2019', '2020', '2021'))
# converts broad structure into tall structure
df1

df2 = spread(df1, Disease, Cases)
# converts tall structure into broad structure
df2

