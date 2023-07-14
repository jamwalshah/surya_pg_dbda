# Sample code

          from matplotlib.colors import ListedColormap
          X_set, y_set = sc.inverse_transform(X_train), y_train
          X1, X2 = np.meshgrid(np.arange(start = X_set[:, 0].min() - 10, stop = X_set[:, 0].max() + 10, step = 1),
                               np.arange(start = X_set[:, 1].min() - 1000, stop = X_set[:, 1].max() + 1000, step = 1))
          plt.contourf(X1, X2, classifier.predict(sc.transform(np.array([X1.ravel(), X2.ravel()]).T)).reshape(X1.shape),
                       alpha = 0.75, cmap = ListedColormap(('blue', 'orange')))
          plt.xlim(X1.min(), X1.max())
          plt.ylim(X2.min(), X2.max())
          for i, j in enumerate(np.unique(y_set)):
              plt.scatter(X_set[y_set == j, 0], X_set[y_set == j, 1], c = ListedColormap(('red', 'green'))(i), label = j)
          plt.title('K-NN (Training set)')
          plt.xlabel('Age')
          plt.ylabel('Estimated Salary')
          plt.legend()
          plt.show()



# Dataset:
        # Assigning features and label variables
        # First Feature
        weather=['Sunny','Sunny','Overcast','Rainy','Rainy','Rainy','Overcast','Sunny','Sunny',
        'Rainy','Sunny','Overcast','Overcast','Rainy']
        # Second Feature
        temp=['Hot','Hot','Hot','Mild','Cool','Cool','Cool','Mild','Cool','Mild','Mild','Mild','Hot','Mild']
        
        # Label or target varible
        play=['No','No','Yes','Yes','Yes','No','Yes','No','Yes','Yes','Yes','Yes','Yes','No']


=================================================
# Day 9: Classification Algorithm
================================================
Date: 12/07/2023
# Topics:
------------------
	-Classification Algorithm
	-KNN
	-Naive Bayes
	
 
Meeting ID: 871 5180 5574
Passcode: 392492

# KNN Algorithm:

      -powerful algorithm
      -used for pattern recognition
      -works on the principle of distance(similarity measure)
      -stores near nearest neighbours data points
      -non-parametric algorithm
      -lazy learner algorithm
      -also called as instance based algorithm


# -Non-parametric:
  		-algorithms do not make particular assumptions about the kind of mapping function.
  		-algorithm do not accept a specific form of the mapping functions
  		-they have freedom to choose any functional form from the training dataset.
  		
		
# Homework:
------------
## Problem Statement: 

	Design the Logistic and KNN classification model to predict the play for the day.
 
![image](https://github.com/Kiranwaghmare123/PG-DBDA-Mar23/assets/72081819/00b54d16-3c84-41b4-9734-dde4a4c9d92f)

	Test cases :
 
 	1. Rainy - Mild - Normal -False -?
  	2. Sunny - Cool - High - True -?
   	3. Overcast - Cool - Normal -True - ?

# Interview Questions:
----------------------
      1. What are K Nearest Neighbour Algorithms?
      2. How does the KNN Algorithm work?
      3. Why is KNN a non-Parametric Algorithm?
      4. Does the need for a feature Scaling exit in KNN?
      5. Can the KNN algorithm be used for REgression problems?
      6. Why is the KNN Algorithm considered a "Lazy Learner"?
      7. How the categorical variables be handled in the KNN algorithm?
      8. How can the Bias-Variance Tradeoff be related to the KNN Algorithm?
      9. What is the role of the k value in the KNN algorithm?
      10. How to choose the optimal value of k in the KNN?
