Day 13: SVM Algorithm
================================================
Date: 17/07/2023
Topics:
------------------
	-SVM Algorithm
		-Linear
		-Kernel
	


# Support Vector Machine: SVM

    -Support Vector Machines (SVMs in short) are machine learning algorithms that are used for classification and regression purposes. 
    -SVMs are one of the powerful machine learning algorithms for classification, regression and outlier detection purposes. 
    -An SVM classifier builds a model that assigns new data points to one of the given categories. 
    -Thus, it can be viewed as a non-probabilistic binary linear classifier.

# Hyperplane
    A hyperplane is a decision boundary which separates between given set of data points having different class labels. The SVM classifier separates data points using a hyperplane with the maximum amount of margin. This hyperplane is known as the maximum margin hyperplane and the linear classifier it defines is known as the maximum margin classifier.

# Support Vectors
    Support vectors are the sample data points, which are closest to the hyperplane. These data points will define the separating line or hyperplane better by calculating margins.

# Margin
    A margin is a separation gap between the two lines on the closest data points. It is calculated as the perpendicular distance from the line to support vectors or closest data points. In SVMs, we try to maximize this separation gap so that we get maximum margin.


# Confusion Matrix: 

## True Positives (TP) 
    – True Positives occur when we predict an observation belongs to a certain class and the observation actually belongs to that class.

## True Negatives (TN) 
    – True Negatives occur when we predict an observation does not belong to a certain class and the observation actually does not belong to that class.

## False Positives (FP) 
    – False Positives occur when we predict an observation belongs to a certain class but the observation actually does not belong to that class. This type of error is called a Type I error.

## False Negatives (FN) 
    – False Negatives occur when we predict an observation does not belong to a certain class but the observation actually belongs to that class. This is a grave error and it is called Type II error.

## Precision

    Precision can be defined as the percentage of correctly predicted positive outcomes out of all the predicted positive outcomes. It can be given as the ratio of true positives (TP) to the sum of true and false positives (TP + FP).


## Recall

    Recall can be defined as the percentage of correctly predicted positive outcomes out of all the actual positive outcomes. It can be given as the ratio of true positives (TP) to the sum of true positives and false negatives (TP + FN). Recall is also called Sensitivity.

# ROC Curve
	Another tool to measure the classification model performance visually is ROC Curve. ROC Curve stands for Receiver Operating Characteristic Curve. An ROC Curve is a plot which shows the performance of a classification model at various classification threshold levels.

	The ROC Curve plots the True Positive Rate (TPR) against the False Positive Rate (FPR) at various threshold levels.

	True Positive Rate (TPR) is also called Recall. It is defined as the ratio of TP to (TP + FN).

	False Positive Rate (FPR) is defined as the ratio of FP to (FP + TN).
	
# Homework:
------------
## Problem statement:

    US department of education data on 7,535 colleges. Only a sample of the total number of columns available were used in this dataset. 
    Build the SVM model for the dataset D13data2.csv
