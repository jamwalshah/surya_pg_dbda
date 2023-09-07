# Visualising the Training set results

    from matplotlib.colors import ListedColormap
    X_Set, Y_Set = X_train, y_train
    X1, X2 = np.meshgrid(np.arange(start = X_Set[:, 0].min() - 1, stop = X_Set[:, 0].max() + 1, step = 0.01),
                         np.arange(start = X_Set[:, 1].min() - 1, stop = X_Set[:, 1].max() + 1, step = 0.01))
    plt.contourf(X1, X2, classifier.predict(np.array([X1.ravel(), X2.ravel()]).T).reshape(X1.shape),
                 alpha = 0.75, cmap = ListedColormap(('red', 'green')))
    plt.xlim(X1.min(), X1.max())
    plt.ylim(X2.min(), X2.max())
    for i, j in enumerate(np.unique(Y_Set)):
        plt.scatter(X_Set[Y_Set == j, 0], X_Set[Y_Set == j, 1],
                    c = ListedColormap(('red', 'green'))(i), label = j)
    plt.title('Decision Tree Classifier (Training set)')
    plt.xlabel('Age')
    plt.ylabel('Estimated Salary')
    plt.legend()
    plt.show()


# Homework:
--------------
    
## Wine-Quality-Prediction:
    
            Wine certification includes physiochemical tests like determination of density, pH, alcohol quantity, fixed and volatile acidity, etc. We have a large dataset having the physiochemical test results and quality on the scale of 1 to 10 of wines of the Vinho Verde variety.Such a model can be used not only by the certification bodies but also by the wine producers to improve quality based on the physicochemical properties and by the consumers to predict the quality of wines.


# Msg: Kindly complete the application and come prepared on Monday.

    Reference: Day12_4 program
