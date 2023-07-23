# Install:
---------

    !pip install -U imbalanced-learn
    conda install -c conda-forge imbalanced-learn
    conda install -c glemaitre imbalanced-learn
    !pip install imblearn
    conda install -c conda-forge imbalanced-learn

    
# Unsupervised Outlier Detection:
---------------------------------
    -Now that we have processed our data, we can begin deploying our machine learning algorithms. We will use the following techniques:

# Local Outlier Factor (LOF):
-------------------------------

    -The anomaly score of each sample is called Local Outlier Factor. It measures the local deviation of density of a given sample with respect to its neighbors. It is local in that the anomaly score depends on how isolated the object is with respect to the surrounding neighborhood.

# Isolation Forest Algorithm:
-----------------------------

    -The IsolationForest ‘isolates’ observations by randomly selecting a feature and then randomly selecting a split value between the maximum and minimum values of the selected feature.

    -Since recursive partitioning can be represented by a tree structure, the number of splittings required to isolate a sample is equivalent to the path length from the root node to the terminating node.

    -This path length, averaged over a forest of such random trees, is a measure of normality and our decision function.

    -Random partitioning produces noticeably shorter paths for anomalies. Hence, when a forest of random trees collectively produce shorter path lengths for particular samples, they are highly likely to be anomalies.
