import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
import pickle
from sklearn.preprocessing import MinMaxScaler


heart_data=pd.read_csv('/Users/lenovo/Desktop/heart_predictor/framingham.csv')

print(heart_data.head())

print(heart_data.shape)

heart_data["glucose"].fillna((heart_data["glucose"].mode())[0], inplace=True)
heart_data.dropna(inplace=True)

heart_data = heart_data[heart_data['totChol']<600.0]
heart_data = heart_data[heart_data['sysBP']<295.0]

heart_data=heart_data[['sysBP','glucose','age','cigsPerDay','totChol','diaBP','prevalentHyp','male','BPMeds','diabetes','TenYearCHD']]

model = pickle.load(open('Heart_disease_predict.pkl','rb'))
prediction=model.predict([[180,99,43,0,228,110,1,0,0,0]])
print(prediction)

if(prediction[0]==0): print("No heart disease")
else: print("Heart Disease")
