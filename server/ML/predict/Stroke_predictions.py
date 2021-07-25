import pickle
import pandas
import numpy
from sklearn.preprocessing import MinMaxScaler

class strokeprediction:

    def __init__(self, patient):
        self.df = pandas.DataFrame(columns=['gender','age','hypertension','heart_disease','ever_married','work_type','avg_glucose_level','bmi','smoking_status','stroke'], index=[0])
    
        self.patient = patient

    def set_df(self, col, value):
        self.df[col][0] = value

    def set_defaults(self):
        self.set_df('bmi',21)
        self.set_df('avg_glucose_level',200)
        self.set_df('age', 43)
        self.set_df('heart_disease', 0)
        self.set_df('hypertension', 1)
        self.set_df('stroke', 1)
        self.set_df('work_type','Private')
        self.set_df('gender', 1)
        self.set_df('smoking_status','formerly smoked')
        self.set_df('ever_married', 'Yes')

    def make_df(self):
        self.set_defaults()
   
        scaler = MinMaxScaler() 
        cols = ['avg_glucose_level','hypertension','bmi','heart_disease','age']
        self.df[cols] = scaler.transform(self.df[cols].values)
    def predict(self):
        self.make_df()
        print(self.df)
        file = "C:\\Users\seckr\Downloads\stroke\Stroke_predict.pickle"
        model = pickle.load(open(file, 'rb'))
        print(self.df.values)
        prediction = model.predict(self.df)
        print(prediction)
        return prediction 
        