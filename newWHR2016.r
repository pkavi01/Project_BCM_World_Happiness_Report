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

#----- newWHR2016 data (dbo.newRaw_WHR_2016 - Project_BCM) -----
df_16 = pd.read_csv('newWHR2016.csv')
#df_16.describe()
#df_16.info()
usecols = ['Year','Country','Happiness_Score','Overall_Happiness_Rank','GDP_per_Capita','Family','Health','Freedom','Trust','Generosity']
df_16.drop(['Happiness_Status','Lower_Confidence_Interval','Upper_Confidence_Interval','Dystopia'],axis=1,inplace=True) 
df_16.columns = ['Year','Country','Happiness_Score','Overall_Happiness_Rank','GDP_per_Capita','Family','Health','Freedom','Trust','Generosity']

#df_16['Year'] = 2016 #add year column - (IF WE HAD TO ADD 'YEAR')

df_16.head()

target = ['Top','Top-Mid', 'Low-Mid', 'Low' ]
target_n = [4, 3, 2, 1]

df_16["target"] = pd.qcut(df_16['Overall_Happiness_Rank'], len(target), labels=target)
df_16["target_n"] = pd.qcut(df_16['Overall_Happiness_Rank'], len(target), labels=target_n)


#COMBINING ALL DATA FILE TO finaldf16

# APPENDING ALL TOGETHER
finaldf16 = df_16.append([df_16,df_17,df_18,df_19])
# finaldf16.dropna(inplace = True)

#CHECKING FOR MISSING DATA
finaldf16.isnull().any()

# FILLING MISSING VALUES OF "TRUST" WITH ITS MEAN
finaldf16.Trust.fillna((finaldf16.Trust.mean()), inplace = True)
finaldf16.head(10)

# Statistical details can be seen using "describe()" function. 
# Defining an empty dataframe "DataFrame16". This dataframe includes Root Mean Squared Error (RMSE), R-squared, Adjusted R-squared, and mean of the R-squared values obtained by the k-Fold Cross-Validation, which are the essential metrics to compare different models. 
# Having an R-squared value closer to one and smaller RMSE means a better fit. 
# Filling this dataframe with the results.

evaluation = pd.DataFrame16({'Model':[],
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
px.scatter(finaldf16, x="GDP_per_Capita", y="Happiness_Score", animation_frame="Year", animation_group="Country", size="Overall_Happiness_Rank", color="Country", hover_name="Country", trendline= "ols") 


# --- TRAIN THE DATA SET. ---

train_data, test_data = train_test_split(finaldf16, train_size = 0.8, random_state = 3)
lr = LinearRegression()
X_train = np.array(train_data['GDP_per_Capita'], dtype = pd.Series).reshape(-1,1)
Y_train = np.array(train_data['Happiness_Score'], dtype = pd.Series)
lr.fit(X_train, Y_train)
# TEST DATA SET.
X_test = np.array(test_data['GDP_per_Capita'], dtype = pd.Series).reshape(-1,1)
Y_test = np.array(test_data['Happiness_Score'], dtype = pd.Series)

pred = lr.predict(X_test)


# --- ROOT MEAN SQUARED ERROR ---

rmsesm = float(format(np.sqrt(metrics.mean_squared_error(Y_test,pred)),'.3f'))
#R-SQUARED (TRAINING)
rtrsm = float(format(lr.score(X_train, Y_train),'.3f'))
#R-SQUARED (TEST)
rtesm = float(format(lr.score(X_test, Y_test),'.3f'))
cv = float(format(cross_val_score(lr,finaldf16[['GDP_per_Capita']],finaldf16['Happiness_Score'],cv=5).mean(),'.3f'))
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

px.scatter(finaldf16, x="Family", y="Happiness_Score", animation_frame="Year", animation_group="Country", size="Overall_Happiness_Rank", color="Country", hover_name="Country", trendline= "ols") 
# TRAIN THE DATA SET.
train_data, test_data = train_test_split(finaldf16, train_size = 0.8, random_state = 3)
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

px.scatter(finaldf16, x="Health", y="Happiness_Score", animation_frame="Year", animation_group="Country", size="Overall_Happiness_Rank", color="Country", hover_name="Country", trendline= "ols") 
# TRAIN THE DATA SET.
train_data, test_data = train_test_split(finaldf16, train_size = 0.8, random_state = 3)
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

px.scatter(finaldf16, x="Freedom", y="Happiness_Score", animation_frame="Year", animation_group="Country", size="Overall_Happiness_Rank", color="Country", hover_name="Country", trendline= "ols") 

# --- TRAIN THE DATA SET.---

train_data, test_data = train_test_split(finaldf16, train_size = 0.8, random_state = 3)
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

px.scatter(finaldf16, x="Generosity", y="Happiness_Score", animation_frame="Year", animation_group="Country", size="Overall_Happiness_Rank", color="Country", hover_name="Country", trendline= "ols") 

# -- TRAIN THE DATA SET. --

train_data, test_data = train_test_split(finaldf16, train_size = 0.8, random_state = 3)
lr = LinearRegression()
X_train = np.array(train_data['Generosity'], dtype = pd.Series).reshape(-1,1)
Y_train = np.array(train_data['Happiness_Score'], dtype = pd.Series)
lr.fit(X_train, Y_train)

# --- TEST DATA SET. ---
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

px.scatter(finaldf16, x="Trust", y="Happiness_Score", animation_frame="Year", animation_group="Country", size="Overall_Happiness_Rank", color="Country", hover_name="Country", trendline= "ols") 

# --- TRAIN THE DATA SET. ----
train_data, test_data = train_test_split(finaldf16, train_size = 0.8, random_state = 3)
lr = LinearRegression()
X_train = np.array(train_data['Trust'], dtype = pd.Series).reshape(-1,1)
Y_train = np.array(train_data['Happiness_Score'], dtype = pd.Series)
lr.fit(X_train, Y_train)

# --- TEST DATA SET. ---
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


# ----- Visualise and Examine data. ----- 

# DISTRIBUTION OF ALL NUMERIC DATA
plt.rcParams['figure.figsize'] = (15, 15)
df1 = finaldf16[['GDP_per_Capita', 'Family', 'Health', 'Freedom','Generosity', 'Trust']]
h = df1.hist(bins = 25, figsize = (16,16), xlabelsize = '10', ylabelsize = '10')
seabornInstance.despine(left = True, bottom = True)
[x.title.set_size(12) for x in h.ravel()];
[x.yaxis.tick_left() for x in h.ravel()]


#--- WORLD MAP - Happiness Score across the World by Year ---
Happiness_Score = dict(type = 'choropleth', 
           locations = finaldf16['Country'],
           locationmode = 'country names',
           z = finaldf16['Happiness_Score'], 
           text = finaldf16['Country'],
           colorscale = 'Blues_',
           autocolorscale=False,
           reversescale=True,
           marker_line_color='darkgray',
           marker_line_width=0.5)
layout = dict(title = 'Happiness Score across the World', 
             geo = dict(showframe = False, 
                       projection = {'type': 'equirectangular'}))
world_map_16 = go.Figure(data = [Happiness_Score], layout=layout)
iplot(world_map_16)


# ----- SEABORNINSTANCE BARPLOT OF EACH VARIABLE ----- 

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


#--- Checking the Correlation Among Explanatory Variables using "PEARSON CORRELATION MATRIX". ---

mask = np.zeros_like(finaldf[usecols].corr(), dtype=np.bool) 
mask[np.triu_indices_from(mask)] = True
f, ax = plt.subplots(figsize=(16, 12))
plt.title('Pearson Correlation Matrix',fontsize=25)
seabornInstance.heatmap(finaldf[usecols].corr(), linewidths=0.25,vmax=0.7,square=True,cmap="Blues", linecolor='w',annot=True,annot_kws={"size":8},mask=mask,cbar_kws={"shrink": .9});


#--- Visualising hidden relationships in data. ---

classifier_overrides = set()
df16_results = discover.discover(finaldf.drop(['target', 'target_n'],axis=1).sample(frac=1), classifier_overrides)


# ----- Using heat maps to visualise how features are clustered / vary over space. -----

fig, ax = plt.subplots(ncols=2,figsize=(24, 8))

seabornInstance.heatmap(df16_results.pivot(index = 'target', columns = 'feature', values = 'Happiness_Score').fillna(1).loc[finaldf.drop(['target', 'target_n'],axis = 1).columns,finaldf.drop(['target', 'target_n'],axis = 1).columns], annot=True, center = 0, ax = ax[0], vmin = -1, vmax = 1, cmap = "Blues")

seabornInstance.heatmap(df_results.pivot(index = 'target', columns = 'feature', values = 'score').fillna(1).loc[finaldf.drop(
                             ['target', 'target_n'],axis=1).columns,finaldf.drop(['target', 'target_n'],axis=1).columns], annot=True, center=0, ax=ax[1], vmin=-0.25, vmax=1, cmap="Blues_r")
plt.plot()


# ----- Creating a Model having all features. ----- 

# --- MULTIPLE LINEAR REGRESSION 1 ---

train_data_dm,test_data_dm = train_test_split(finaldf16,train_size = 0.8,random_state=3)
independent_var = ['GDP_per_Capita','Family','Health','Freedom','Generosity','Trust']
complex_model_1 = LinearRegression()
complex_model_1.fit(train_data_dm[independent_var],train_data_dm['Happiness_Score'])
print('Intercept: {}'.format(complex_model_1.intercept_))
print('Coefficients: {}'.format(complex_model_1.coef_))
print('Happiness_Score = ',np.round(complex_model_1.intercept_,4),
      '+',np.round(complex_model_1.coef_[0],4),'∗ Family',
      '+',np.round(complex_model_1.coef_[1],4),'* GDP_per_Capita', 
      '+',np.round(complex_model_1.coef_[2],4),'* Health',
      '+',np.round(complex_model_1.coef_[3],4),'* Freedom',
       '+',np.round(complex_model_1.coef_[4],4),'* Generosity',
      '+',np.round(complex_model_1.coef_[5],4),'* Trust')

pred = complex_model_1.predict(test_data_dm[independent_var])
rmsecm = float(format(np.sqrt(metrics.mean_squared_error(test_data_dm['Happiness_Score'],pred)),'.3f'))

rtrcm = float(format(complex_model_1.score(train_data_dm[independent_var],train_data_dm['Happiness_Score']),'.3f'))
artrcm = float(format(adjustedR2(complex_model_1.score(train_data_dm[independent_var], train_data_dm['Happiness_Score']),train_data_dm.shape[0],len(independent_var)),'.3f'))

rtecm = float(format(complex_model_1.score(test_data_dm[independent_var],test_data_dm['Happiness_Score']),'.3f'))
artecm = float(format(adjustedR2(complex_model_1.score(test_data_dm[independent_var],test_data['Happiness_Score']),test_data_dm.shape[0],len(independent_var)),'.3f'))
cv = float(format(cross_val_score(complex_model_1,finaldf16[independent_var],finaldf16['Happiness_Score'],cv=5).mean(),'.3f'))
r = evaluation.shape[0]
evaluation.loc[r] = ['Multiple Linear Regression-1','selected features',rmsecm,rtrcm,artrcm,rtecm,artecm,cv]
evaluation.sort_values(by = '5-Fold Cross Validation', ascending=False)

