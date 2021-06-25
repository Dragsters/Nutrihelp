import pickle
import pandas
import numpy
from sklearn.preprocessing import MinMaxScaler

class HeartDisease:

    def __init__(self, patient):
        self.df = pandas.DataFrame(columns=['sysBP','glucose','age',
                                            'cigsPerDay','totChol','diaBP',
                                            'prevalentHyp','male','BPMeds',
                                            'diabetes','TenYearCHD'], index=[0])
    
        self.patient = patient

    def set_df(self, col, value):
        self.df[col][0] = value

    def set_defaults(self):
        self.set_df('sysBP',180)
        self.set_df('glucose',99)
        self.set_df('age', 43)
        self.set_df('cigsPerDay', 0)
        self.set_df('totChol', 228)
        self.set_df('diaBP', 110)
        self.set_df('prevalentHyp',1)
        self.set_df('male', 0)
        self.set_df('BPMeds', 0)
        self.set_df('diabetes', 0)

     def make_df(self):
        self.set_defaults()
   
        scaler = MinMaxScaler() 
        cols = ['sysBP','glucose','age','totChol','diaBP']
        self.df[cols] = scaler.transform(self.df[cols].values)

     def predict(self):
        self.make_df()
        print(self.df)
        file = 'ML/pickles/Heart_disease_predict.pickle' 
        model = pickle.load(open(file, 'rb'))
        print(self.df.values)
        prediction = model.predict(self.df)
        print(prediction)
        return prediction 
        
