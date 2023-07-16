# day14 2023 06 26
x = 7
x + 3

# variables with R
# number, string, logical

x = 12
y =-14
z = 5.6

# shows data type & variable 
str(x)
str(y)
str(z)

# R lang is case sensitive
# to define integer use 'L'
r = 8L
str(r)

z + r # can add integer with decimal

t = 8.5L 
# thows warning because 'L' is for integer, not for decimal values
# stores it as numeric

t # print value of t

str(t)
# shows type of t is numeric

# discrete data : integer type
# continuous data : numeric type


my_name = 'Sudeep'
instt_name = "CDAC"
# storing ctring type (chr)

w = TRUE
# storing logical/boolean value

str(my_name)
# shows type is chr (string type)

str(w)
# shows type is logi (logical type)

b= FALSE # stores logi FALSE value
str(b)

k=T # same as TRUE, stores logi TRUE value
k # printing value of k

5 + 7
# addition

12 - 3
# subtraction

4 * 5
# multiplication

120 / 4
# division

4 ** 2
# exponent

4 ^ 2 # same as 4**2
# exponent

45 %% 4
# remainder

44 %% 4
# remainder

46 %/% 4
# floor division
46 %% 4
# remainder
46 / 4
# normal division


# order of arithmetic calculation
# brackets
# exponent
# division
# multiplication
# addition
# subtraction


# index / position / numbering starts from 1 in R lang

# Vectors
# 5, 9, 8, 3, 6

x = c(5, 9, 8, 3, 6)
# creates a vector

x[3]
# retrieves element at position 3 and index 3
# index & position in R lang is same, so index starts from 1

x[0]
# returns zero as there is no index zero
x[1]

length(x)
# to check length of x

x = append(x, 10)
# to append new value to vector x
x
# print vector x

# concatenation
y = c(4, 9, 12)
y
# creating and printing another vector

x = c(x,y)
x
# concatenates two vectors into x, and prints x

# to insert a number use append
x = append(x, 15, 4)
# inserts value 15 in vector x at position 4
x

x = append(x, c(4, 9, 2), 6)
# inserting a vector in another vector at position 6
# does not appear as nested list fashion
x

x[3] = 4
# updates element at position 2 to value 4
x

# removing element from vector
x
x[-2]
# returns vector without element at position 2, but does not actually remove
x

x = x[-2]
# to  actually remove an element assign the returned vector
x



# to create a vector of elements at some specific positions
x[c(7, 3, 4)]
# returns a vector of elements at  positions 7, 3, 4


x
# prints x
x[c(2, 5)] = c(9, 2)
# updates vector positions with another vector values
x


# aggregate methods on vector
sum(x)
# sum of vector elements

prod(x)
# product of vector elements

min(x)
# min in vector

max(x)
# max in vector

cummin(x)
# returns vector of cumulative min

cummax(x)
# returns vector of cumulative max

cumsum(x)
# returns vector of cumulative sum

log(x)
# returns natural log base e for vector elements

log(x, 10)
# returns natural log base 10 for vector elements

exp(log(x))
# returns exponent of natural log base e for vector elements

10**exp(log(x, 10))
# returns 10 exponent of natural log base 10 for vector elements


factorial(x)
# returns vector of factorials of each element in vector

factorial(6)
# returns vector of 6


# vector arithmetic
a = c(4, 7, 6, 2)
b = c(2, 1, 4, 9)
c = c(1, 2)
d = c(3, 4, 5)


#   1. scalar operation 
# same operation is broadcasted across the vector
# scalar addition
a + 5
# returns a vector with 5 added to each of elements

#   2. operating vectors with same length
# item to item operation takes place w.r.t. position
a + b

#   3. operating two vectors with different length,
#       but length of bigger vector is multiple of length of smaller vector
# recycling of vector takes place when it falls short of length
# not possible in python
a + c


#   4. operating two vectors with different length,
#       but length of bigger vector is not a multiple of length of smaller vector
# result is same as recycling, but with a warning
# partial recycling
a + d


aa = c(1, 2, 3, 4, 5)
bb = c(11, 12, 13, 14)
cc = c(21, 22, 23, 24, 25, 26, 27, 28, 29, 30)
aa + bb
aa + cc


# special vectors
x = 8:15
# vector with value staring from 8 to 15, both inclusive
x

6:20
# returns vector with values from 6 to 20, both inclusive

seq(4, 20)
# same as 4:20
# start: 4, end: 20

seq(4, 20, 3)
# start: 4, end: 20, step: 3

seq(4, 20, 3.4)
# start: 4, end: 20, step: 3.4
# step can be fractional

z = seq(4, 20, length.out=8)
# to generate vector of values with specified length with 
# equal spacing between two values
# gap is decided automatically
z

length(z)
# length is set as per specified length to seq()

z = seq(4, 20, length.out=9)
z

z[2] - z[1]
z[7] - z[6]
# gap is same and is automatically decided

seq(40, 6, -3)
# to generate decreasing values use negative step



# sorting
x = c(4, 7, 61, 3, 5, 9, 5, 3)
x
sort(x)
# sorts vector

sort(x, decreasing = T)
# sorts a vector in decreasing order


# repeat command : repeats 
rep(c(5, 4,7), times=5)
# returns a vector with repeating a vector with specified number of times

rep(c(5, 4,7), each=5)
# returns a vector with repeating each value of vector
# with specified number of times

# 5 repeats  2 times, 4 repeats 3 times, 7 repeats 4 times
rep(c(5, 4, 7), times=c(2, 3, 4))


# Q1. teacher teaching a full week
# taught for 2 weeks
# for week days, rs. 1000 per hour
# for weekend,   rs. 1500 per hour
# find total bill of two weeks
# sol1
hours = c(5, 4, 3, 6, 5, 4, 6, 2, 4, 5, 6, 5, 6, 4)
hours
weekrate = rep(c(1000, 1500), times=c(5, 2))
weekrate
twoweekshrs = hours * weekrate
twoweekshrs
sum(twoweekshrs)

# sol2
hours = c(5, 4, 3, 6, 5, 4, 6, 2, 4, 5, 6, 5, 6, 4)
hours
sum(hours *(rep(c(1000, 1500), times=c(5, 2))))



# Strings commands
places = c('Mumbai', 'Pune', 'Navi Mumbai', 'Hyderabad', 'Bangalore', 'Allahabad')
# vector of  strings

length(places)
# print length of vector
str(places)
# print data type of elements

nchar("surya")
# to print the count of characters in string
nchar(places)
# to print the count of characters in each string element

grep('bad', places)
# to grep in each of the elements, and return the position of each match

grep('Mumbai', places)
# to grep in each of the elements, and return the position of each match

grep('bad', places, value=T)
# to grep in each of the elements, and return the value of each match


substr(places, 3, 5)
# get sub string of a string 
# substr(string, start, end)

# Q. find places with two words
grep(" ", places) #  prints indices of matches
grep(" ", places, value = T) # prints values from vector matching the pattern


gsub("bad", "baad", places)
# replaces sub string with another replacement sub string, and returns a vector


x = c(4, 8, 7, 3, 2, 5, 9, 1, 6, 3)

which(x>=4)
# similar to np.where() in python
# input to which() is condition
# output of which() is positions

length(which(x>=4))
# count of elements satisfying condition

x[which(x<=4)]
# fetch the values of elements at the positions returned by which() command 


a = TRUE
b = TRUE
c = FALSE
d = F

a & c
# logical AND
# result is T if all the inputs are T

a | c
# logical OR
# result is T if any of the inputs are T

d | c
# logical OR

!a
# logical NOT

!c
# logical NOT

x
which(!x>=4)

# greater than 4, but not divisible by 2
x
x[which(x>=4 & !x%%2==0)]
x[which(x>=4 & x%%2!=0)]
x[which(x>=4 & x%%2==1)]


places
# places vector
strsplit(places[1], "")
# returns characters from string
strsplit(places[1], "")[1]
# returns as list

strsplit(places[1:3], "")
# returns list of three elements split into characters

strsplit(places[3], ' ')[1]
# returns splits of 3rd element in vector



x1 = c('A', 'B', 'C')
x2 = c(1, 2, 3)

# 1. paste(vector) method
paste(x1)
# prints vector as it is

# 2. paste(vector, collapse='**') method
paste(x1, collapse = '')
# joins elements of vector to form a string

d = strsplit("Surya", '')[[1]]
# splitting each character of string into vector d
d
# printing vector d


paste(d, collapse = '')
# join the characters to form a string

paste(x1, x2)
# joins each element of vectors position-wise

# paste(vector1, vector2, sep='-')
paste(x1, x2, sep='')
# joins each element of vectors position-wise, but with no separator in each element

paste(x1, x2, sep='-')
# joins each element of vectors position-wise, but with separator in each element

paste(x1, x2, sep='-', collapse = '')
# joins each element of vectors position-wise, 
# but with separator '-' in each element, 
# and collapse joins the elements into single string

paste(x1, x2, sep='-', collapse = '**')
# joins each element of vectors position-wise, 
# but with separator '-' in each element, 
# and collapse joins the elements into single string with '**'



# Matrix Operation using R lang
mat1 = matrix(1:24, ncol = 6 )
# takes vector/data to convert into matrix
mat1

mat1 = matrix(1:24, nrow = 3 )
# takes vector/data to convert into matrix
mat1


mat1 = matrix(1:24, nrow = 3 , byrow = T)
# byrow: assigns values row wise
# 
mat1


a = c(4, 8, 7, 6)
b = c(1, 4, 3, 9)
c = c(4, 1, 9, 2)

mat1 = rbind(a, b, c)
# join vectors as rows into a matrix
# name of vectors will become the name of rows
mat1

mat1 = cbind(a, b, c)
# join vectors as columns into a matrix
# name of vectors will become the name of columns
mat1

mat1[2, 3]
#  to retrieve the value at [r, c] in matrix

mat1[2, 3] = 7
#  to update/overwrite the value at [r, c] in matrix
mat1

mat1[2, ]
#  prints only 2nd row

mat1[, 2]
#  prints only 2nd column

mat1[c(2, 4), ]
#  prints only 2nd & 4th rows

mat1[ ,c(1, 3)]
#  prints only 1st & 3rd columns

mat1[, c('a', 'b')]
#  prints only 'a' & 'b' columns

mat1

mat1 = cbind(mat1, d=c('a', 'b', 'c', 'd'))
mat1


# data.frame
# creating vectors for data.frame
names = c('Akhil', 'Pankaj', 'Rahul')
instt = c('IITM', 'DIT', 'DECT')
marks = c(79, 86, 93)

# creating data.frame from vectors
stu_df = data.frame(names, instt, marks)
# creating data.frame using vectors names, instt, marks
stu_df
# printing data.frame stu_df

str(stu_df[, 3])
# prints data type of vector of column 3

stu_df[2, 3]
# value of element at position 2nd row, 3rd column of data.frame 

stu_df[2, 3] = 84
# updating element of data.frame at row 2 & column 3

stu_df = data.frame(studentName = names, College = instt, Marks = marks)
# creating a new data.frame with StudentName, College & marks
stu_df
# printing newly created data.frame


colnames(stu_df)
# get column names

colnames(stu_df)[3] = 'Grades'
# updates 3rd column name to 'Grades
stu_df
# print data.frame

# extracting values from column as vector
stu_df[, 2]
stu_df[, 'College']
stu_df$College


install.packages('readxl')
# install package
library(readxl)
# activates installed package

getwd()
# prints current working directory

setwd('C:/Users/lootera-ip-win/Downloads/advanced-analytics-files/day14')
# sets current working directory to specified path

df = read_excel('CDAC_DataBook.xlsx', sheet='faithful')
# loading data set into data.frame using read_excel()
head(df)
# print first 5 records of loaded data set


new_df = data.frame(a=c('Sachin', 'Virat'), b=c('UMB', 'IITM'), c=c(76, 82))
# creating data.frame new_df with columns a, b, c
new_df
# printing new_df

colnames(new_df) = colnames(stu_df)
# renaming columns of new_df as per column names of stu_df
new_df
# printing new_df


stu_df = rbind(stu_df, new_df)
# concatenating records from new_df to stu_df
stu_df
# printing stu_df

d = c('Infy', 'WIPRO', 'TCS', 'Infy', 'TATA')
# creating a vector
temp = stu_df
# copying a data.frame stu_df into temp

# add column method 1
temp[, 4] = d
# adding a vector as a new 4th column into data.frame temp
temp
# print data.frame temp

colnames(temp)[4] = 'Company'
# renaming column number4
temp
# printing data.frame temp

# removing column
temp = temp[, -4]
# removing 4th column and assigning the returned data.frame
temp
# printing data.frame temp


# add column method 2
d
# printing vector
temp = cbind(temp, Company=d)
# creating a new data.frame using column name Company
temp
# printing data.frame temp

# removing column method 2
temp = temp[, 1:3]
# removing the column4, by selecting only columns1,2,3
temp
# printing data.frame temp



# add column method 3
stu_df$Company = d
# adding new column Company using vector d
stu_df
# printing data.frame stu_df

# first function in R lang
MyCalc = function(x, y){
  z = 2 * x + y
  print(z)
}
MyCalc(3, 4)

# tax calculation function
TaxCalc = function(sal){
  tax = 0.1*sal
  message('Your tax is INR ', tax)
  message('Your take home salary is INR ', sal-tax)
}
TaxCalc(30000)



# CLI input command in R lang
TaxCalc2 = function(){
  sal = as.numeric(readline('Enter your salary '))
  tax = 0.1*sal
  message('Your tax is INR ', tax)
  message('Your take home salary is INR ', sal-tax)
}
TaxCalc2()



# conditional in R lang
TaxCalc3 = function(sal){
  if(sal<=20000){
    tax=500
  } else {
    tax = 0.1 * sal
  }
  message('Your tax is INR ', tax)
  message('Your take home salary is INR ', sal-tax)
}
TaxCalc3(12000)
TaxCalc3(30000)



# <= 20000 --- tax = 500
# > 20000 but <=50000 --- tax = 0.1 * sal
# >50000 --- tax = 0.2 * sal

# surya's soln 
TaxCalc4 = function(sal){
  if(sal<=20000){
    tax=500
  } else if(sal>20000 & sal<=50000) {
    tax = 0.1 * sal
  }
  else{
    tax = 0.2 * sal
  }
  message('Your tax is INR ', tax)
  message('Your take home salary is INR ', sal-tax)
}
TaxCalc4(12000)
TaxCalc4(25000)
TaxCalc4(30000)

# sudeep's soln 
TaxCalc41 = function(sal){
  if(sal<=20000){
    tax=500
  }
  else 
    {
      if(sal<=50000) {
        tax = 0.1 * sal
        }
      else{
          tax = 0.2 * sal
        }
    }
  message('Your tax is INR ', tax)
  message('Your take home salary is INR ', sal-tax)
}
TaxCalc41(12000)
TaxCalc41(25000)
TaxCalc41(30000)


#  ifelse(condition, yes, no) ternary operator
TaxCalc5 = function(sal){
  rate = ifelse(sal<=25000, 0.1, 0.2)
  print(rate)
}
TaxCalc5(12000)
TaxCalc5(30000)

# switch statement in R lang
TaxRate = function(client){
  rate = switch(client, G=0.05, P=0.2, E=0.1, 0.3)
  print(rate)
}
TaxRate('E')
TaxRate('G')
TaxRate('P')
TaxRate('X')









