# FOR NUMERICAL ANALYTICS
import numpy as np

# TO STORE AND PROCESS DATA IN DATAFRAME
import pandas as pd
import os

# BASIC VISUALIZATION PACKAGE
import matplotlib.pyplot as plt

# ADVANCED PLOTING
import seaborn as seabornInstance

# TRAIN TEST SPLIT
from sklearn.model_selection import train_test_split

# INTERACTIVE VISUALIZATION
import chart_studio.plotly as py 
import plotly.graph_objs as go
import plotly.express as px
from plotly.offline import download_plotlyjs, init_notebook_mode, plot, iplot
init_notebook_mode(connected=True)

import statsmodels.formula.api as stats
from statsmodels.formula.api import ols
from sklearn import datasets
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error
from discover_feature_relationships import discover

#newWHR2019 data
df_19 = pd.read_csv('newWHR2019.csv')
#df_19.describe()
#df_19.info()
usecols = ['Year','Country','Happiness_Score','Overall_Happiness_Rank','GDP_per_Capita','Family','Health','Freedom','Trust','Generosity']
df_19.drop(['Happiness_Status'],axis=1,inplace=True) 
df_19.columns = ['Year','Country','Happiness_Score','Overall_Happiness_Rank','GDP_per_Capita','Family','Health','Freedom','Trust','Generosity']

#df_19['Year'] = 2019 #add year column (IF WE HAD TO ADD 'YEAR')

df_19.head()

target = ['Top','Top-Mid', 'Low-Mid', 'Low' ]
target_n = [4, 3, 2, 1]

df_19["target"] = pd.qcut(df_19['Overall_Happiness_Rank'], len(target), labels=target)
df_19["target_n"] = pd.qcut(df_19['Overall_Happiness_Rank'], len(target), labels=target_n)

#COMBINING ALL DATA FILE TO finaldf19

# APPENDING ALL TOGETHER
finaldf19 = df_19.append([df_19])
# finaldf19.dropna(inplace = True)

#CHECKING FOR MISSING DATA
finaldf19.isnull().any()

# FILLING MISSING VALUES OF "TRUST" WITH ITS MEAN
finaldf19.Trust.fillna((finaldf19.Trust.mean()), inplace = True)
finaldf19.head(10)

# Statistical details can be seen using "describe()" function. 
# Defining an empty dataframe "DataFrame19". This dataframe includes Root Mean Squared Error (RMSE), R-squared, Adjusted R-squared, and mean of the R-squared values obtained by the k-Fold Cross-Validation, which are the essential metrics to compare different models. 
# Having an R-squared value closer to one and smaller RMSE means a better fit. 
# Filling this dataframe with the results.

evaluation = pd.DataFrame19({'Model':[],
                          'Details':[],
                          'Root Mean Squared Error (RMSE)': [],
                          'R-squared (training)': [],
                          'Adjusted R-squared (training)': [],
                          'R-squared (test)':[],
                          'Adjusted R-squared(test)':[],
                           '5-Fold Cross Validation':[]
                        })	

#How Happiness_Score is distributed.
# Relationship of different variables with Happiness_Score.
#----- "Happiness_Score vs GDP_per_Capita" using a Scatter plot. -----
px.scatter(finaldf19, x="GDP_per_Capita", y="Happiness_Score", animation_frame="Year", animation_group="Country", size="Overall_Happiness_Rank", color="Country", hover_name="Country", trendline= "ols") 
# TRAIN THE DATA SET.
train_data, test_data = train_test_split(finaldf19, train_size = 0.8, random_state = 3)
lr = LinearRegression()
X_train = np.array(train_data['GDP_per_Capita'], dtype = pd.Series).reshape(-1,1)
Y_train = np.array(train_data['Happiness_Score'], dtype = pd.Series)
lr.fit(X_train, Y_train)
# TEST DATA SET.
X_test = np.array(test_data['GDP_per_Capita'], dtype = pd.Series).reshape(-1,1)
Y_test = np.array(test_data['Happiness_Score'], dtype = pd.Series)

pred = lr.predict(X_test)

#ROOT MEAN SQUARED ERROR
rmsesm = float(format(np.sqrt(metrics.mean_squared_error(Y_test,pred)),'.3f'))
#R-SQUARED (TRAINING)
rtrsm = float(format(lr.score(X_train, Y_train),'.3f'))
#R-SQUARED (TEST)
rtesm = float(format(lr.score(X_test, Y_test),'.3f'))
cv = float(format(cross_val_score(lr,finaldf19[['GDP_per_Capita']],finaldf19['Happiness_Score'],cv=5).mean(),'.3f'))
print ("Average Score for Test Data: {:.3f}".format(Y_test.mean()))
print('Intercept: {}'.format(lr.intercept_))
print('Coefficient: {}'.format(lr.coef_))
r = evaluation.shape[0]
evaluation.loc[r] = ['Simple Linear Regression','-',rmsesm,rtrsm,'-',rtesm,'-',cv]
evaluation
#----- Chart to determine result of "Simple Regression". -----
seabornInstance.set_style(style='whitegrid')
plt.figure(figsize=(12,6))
plt.scatter(X_test,Y_test,color='blue',label="Data", s = 12)
plt.plot(X_test,lr.predict(X_test),color="red",label="Predicted Regression Line")
plt.xlabel("GDP_per_Capita", fontsize=15)
plt.ylabel("Happiness_Score", fontsize=15)
plt.xticks(fontsize=13)
plt.yticks(fontsize=13)
plt.legend()
plt.gca().spines['right'].set_visible(False)
plt.gca().spines['top'].set_visible(False)

#----- "Happiness_Score vs Family" using a Scatter plot. -----
px.scatter(finaldf19, x="Family", y="Happiness_Score", animation_frame="Year", animation_group="Country", size="Overall_Happiness_Rank", color="Country", hover_name="Country", trendline= "ols") 
# TRAIN THE DATA SET.
train_data, test_data = train_test_split(finaldf19, train_size = 0.8, random_state = 3)
lr = LinearRegression()
X_train = np.array(train_data['Family'], dtype = pd.Series).reshape(-1,1)
Y_train = np.array(train_data['Happiness_Score'], dtype = pd.Series)
lr.fit(X_train, Y_train)
# TEST DATA SET.
X_test = np.array(test_data['Family'], dtype = pd.Series).reshape(-1,1)
Y_test = np.array(test_data['Happiness_Score'], dtype = pd.Series)

pred = lr.predict(X_test)

#-----Happiness_Score vs Family-----
#----- Chart to determine result of "Simple Regression". -----
seabornInstance.set_style(style='whitegrid')
plt.figure(figsize=(12,6))
plt.scatter(X_test,Y_test,color='blue',label="Data", s = 12)
plt.plot(X_test,lr.predict(X_test),color="red",label="Predicted Regression Line")
plt.xlabel("Family", fontsize=15)
plt.ylabel("Happiness_Score", fontsize=15)
plt.xticks(fontsize=13)
plt.yticks(fontsize=13)
plt.legend()
plt.gca().spines['right'].set_visible(False)
plt.gca().spines['top'].set_visible(False)

#----- "Happiness_Score vs Health" using a Scatter plot. -----
px.scatter(finaldf19, x="Health", y="Happiness_Score", animation_frame="Year", animation_group="Country", size="Overall_Happiness_Rank", color="Country", hover_name="Country", trendline= "ols") 
# TRAIN THE DATA SET.
train_data, test_data = train_test_split(finaldf19, train_size = 0.8, random_state = 3)
lr = LinearRegression()
X_train = np.array(train_data['Health'], dtype = pd.Series).reshape(-1,1)
Y_train = np.array(train_data['Happiness_Score'], dtype = pd.Series)
lr.fit(X_train, Y_train)
# TEST DATA SET.
X_test = np.array(test_data['Health'], dtype = pd.Series).reshape(-1,1)
Y_test = np.array(test_data['Happiness_Score'], dtype = pd.Series)

pred = lr.predict(X_test)

#-----Happiness_Score vs Health-----
#----- Chart to determine result of "Simple Regression". -----
seabornInstance.set_style(style='whitegrid')
plt.figure(figsize=(12,6))
plt.scatter(X_test,Y_test,color='blue',label="Data", s = 12)
plt.plot(X_test,lr.predict(X_test),color="red",label="Predicted Regression Line")
plt.xlabel("Health", fontsize=15)
plt.ylabel("Happiness_Score", fontsize=15)
plt.xticks(fontsize=13)
plt.yticks(fontsize=13)
plt.legend()
plt.gca().spines['right'].set_visible(False)
plt.gca().spines['top'].set_visible(False)

#----- "Happiness_Score vs Freedom" using a Scatter plot. -----
px.scatter(finaldf19, x="Freedom", y="Happiness_Score", animation_frame="Year", animation_group="Country", size="Overall_Happiness_Rank", color="Country", hover_name="Country", trendline= "ols") 
# TRAIN THE DATA SET.
train_data, test_data = train_test_split(finaldf19, train_size = 0.8, random_state = 3)
lr = LinearRegression()
X_train = np.array(train_data['Freedom'], dtype = pd.Series).reshape(-1,1)
Y_train = np.array(train_data['Happiness_Score'], dtype = pd.Series)
lr.fit(X_train, Y_train)
# TEST DATA SET.
X_test = np.array(test_data['Freedom'], dtype = pd.Series).reshape(-1,1)
Y_test = np.array(test_data['Happiness_Score'], dtype = pd.Series)

pred = lr.predict(X_test)

#-----Happiness_Score vs Freedom-----
#----- Chart to determine result of "Simple Regression". -----
seabornInstance.set_style(style='whitegrid')
plt.figure(figsize=(12,6))
plt.scatter(X_test,Y_test,color='blue',label="Data", s = 12)
plt.plot(X_test,lr.predict(X_test),color="red",label="Predicted Regression Line")
plt.xlabel("Freedom", fontsize=15)
plt.ylabel("Happiness_Score", fontsize=15)
plt.xticks(fontsize=13)
plt.yticks(fontsize=13)
plt.legend()
plt.gca().spines['right'].set_visible(False)
plt.gca().spines['top'].set_visible(False)


#----- "Happiness_Score vs Generosity" using a Scatter plot. -----
px.scatter(finaldf19, x="Generosity", y="Happiness_Score", animation_frame="Year", animation_group="Country", size="Overall_Happiness_Rank", color="Country", hover_name="Country", trendline= "ols") 
# TRAIN THE DATA SET.
train_data, test_data = train_test_split(finaldf19, train_size = 0.8, random_state = 3)
lr = LinearRegression()
X_train = np.array(train_data['Generosity'], dtype = pd.Series).reshape(-1,1)
Y_train = np.array(train_data['Happiness_Score'], dtype = pd.Series)
lr.fit(X_train, Y_train)
# TEST DATA SET.
X_test = np.array(test_data['Generosity'], dtype = pd.Series).reshape(-1,1)
Y_test = np.array(test_data['Happiness_Score'], dtype = pd.Series)

pred = lr.predict(X_test)

#-----Happiness_Score vs Generosity-----
#----- Chart to determine result of "Simple Regression". -----
seabornInstance.set_style(style='whitegrid')
plt.figure(figsize=(12,6))
plt.scatter(X_test,Y_test,color='blue',label="Data", s = 12)
plt.plot(X_test,lr.predict(X_test),color="red",label="Predicted Regression Line")
plt.xlabel("Generosity", fontsize=15)
plt.ylabel("Happiness_Score", fontsize=15)
plt.xticks(fontsize=13)
plt.yticks(fontsize=13)
plt.legend()
plt.gca().spines['right'].set_visible(False)
plt.gca().spines['top'].set_visible(False)

#----- "Happiness_Score vs Trust" using a Scatter plot. -----
px.scatter(finaldf19, x="Trust", y="Happiness_Score", animation_frame="Year", animation_group="Country", size="Overall_Happiness_Rank", color="Country", hover_name="Country", trendline= "ols") 
# TRAIN THE DATA SET.
train_data, test_data = train_test_split(finaldf19, train_size = 0.8, random_state = 3)
lr = LinearRegression()
X_train = np.array(train_data['Trust'], dtype = pd.Series).reshape(-1,1)
Y_train = np.array(train_data['Happiness_Score'], dtype = pd.Series)
lr.fit(X_train, Y_train)
# TEST DATA SET.
X_test = np.array(test_data['Trust'], dtype = pd.Series).reshape(-1,1)
Y_test = np.array(test_data['Happiness_Score'], dtype = pd.Series)

pred = lr.predict(X_test)

#-----Happiness_Score vs Trust-----
#----- Chart to determine result of "Simple Regression". -----
seabornInstance.set_style(style='whitegrid')
plt.figure(figsize=(12,6))
plt.scatter(X_test,Y_test,color='blue',label="Data", s = 12)
plt.plot(X_test,lr.predict(X_test),color="red",label="Predicted Regression Line")
plt.xlabel("Trust", fontsize=15)
plt.ylabel("Happiness_Score", fontsize=15)
plt.xticks(fontsize=13)
plt.yticks(fontsize=13)
plt.legend()
plt.gca().spines['right'].set_visible(False)
plt.gca().spines['top'].set_visible(False)

#Visualise and Examine data.

# DISTRIBUTION OF ALL NUMERIC DATA
plt.rcParams['figure.figsize'] = (15, 15)
df1 = finaldf19[['GDP_per_Capita', 'Family', 'Health', 'Freedom','Generosity', 'Trust']]
h = df1.hist(bins = 25, figsize = (19,19), xlabelsize = '10', ylabelsize = '10')
seabornInstance.despine(left = True, bottom = True)
[x.title.set_size(12) for x in h.ravel()];
[x.yaxis.tick_left() for x in h.ravel()]
#SEABORNINSTANCE BARPLOT OF EACH VARIABLE
fig, axes = plt.subplots(nrows=3, ncols=2,constrained_layout=True,figsize=(10,10))
seabornInstance.barplot(x='GDP_per_Capita',y='Country',
                        data=finaldf.nlargest(10,'GDP'),
                        ax=axes[0,0],palette="Blues_r")
seabornInstance.barplot(x='Health' ,y='Country',
                        data=finaldf.nlargest(10,'Health'),
                        ax=axes[0,1],palette='Blues_r')
seabornInstance.barplot(x='Happiness_Score' ,y='Country',
                        data=finaldf.nlargest(10,'Score'),
                        ax=axes[1,0],palette='Blues_r')
seabornInstance.barplot(x='Generosity' ,y='Country',
                        data=finaldf.nlargest(10,'Generosity'),
                        ax=axes[1,1],palette='Blues_r')
seabornInstance.barplot(x='Freedom' ,y='Country',
                        data=finaldf.nlargest(10,'Freedom'),
                        ax=axes[2,0],palette='Blues_r')
seabornInstance.barplot(x='Trust' ,y='Country',
                        data=finaldf.nlargest(10,'Corruption'),
                        ax=axes[2,1],palette='Blues_r')

#Checking the Correlation Among Explanatory Variables using "PEARSON CORRELATION MATRIX".
mask = np.zeros_like(finaldf[usecols].corr(), dtype=np.bool) 
mask[np.triu_indices_from(mask)] = True
f, ax = plt.subplots(figsize=(19, 12))
plt.title('Pearson Correlation Matrix',fontsize=25)
seabornInstance.heatmap(finaldf[usecols].corr(), linewidths=0.25,vmax=0.7,square=True,cmap="Blues", linecolor='w',annot=True,annot_kws={"size":8},mask=mask,cbar_kws={"shrink": .9});



