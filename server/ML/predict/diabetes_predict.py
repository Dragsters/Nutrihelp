import pickle
import pandas
import numpy
from sklearn.preprocessing import StandardScaler


class DotDict():
    pass


class Diabetes:

    def __init__(self, patient):
        self.df = pandas.DataFrame(columns=['Pregnancies_1', 'Pregnancies_2', 'Pregnancies_3', 'Pregnancies_4',
                                            'BMI', 'Sleep', 'SoundSleep', 'Age_50-59', 'Age_60 or older',
                                            'Age_less than 40', 'Gender_Male', 'Family_Diabetes_yes',
                                            'PhysicallyActive_more than half an hr', 'PhysicallyActive_none',
                                            'PhysicallyActive_one hr or more', 'Smoking_yes', 'Alcohol_yes',
                                            'RegularMedicine_yes', 'JunkFood_occasionally', 'JunkFood_often',
                                            'JunkFood_very often', 'Stress_not at all', 'Stress_sometimes',
                                            'Stress_very often', 'BPLevel_low', 'BPLevel_normal', 'Pdiabetes_yes',
                                            'UriationFreq_quite often'], index=[0])
        self.patient = patient

    def set_df(self, col, value):
        self.df[col][0] = value

    def set_defaults(self):
        self.set_df('Pregnancies_1', 0)
        self.set_df('Pregnancies_2', 0)
        self.set_df('Pregnancies_3', 0)
        self.set_df('Pregnancies_4', 0)
        self.set_df('BMI', 25)
        self.set_df('Sleep', 7)
        self.set_df('SoundSleep', 0)
        self.set_df('Age_60 or older', 0)
        self.set_df('Age_50-59', 0)
        self.set_df('Age_less than 40', 0)
        self.set_df('Gender_Male', 0)
        self.set_df('Family_Diabetes_yes', 0)
        self.set_df('BPLevel_low', 0)
        self.set_df('BPLevel_normal', 1)
        self.set_df('PhysicallyActive_more than half an hr', 0)
        self.set_df('PhysicallyActive_none', 0)
        self.set_df('PhysicallyActive_one hr or more', 0)
        self.set_df('Smoking_yes', 0)
        self.set_df('Alcohol_yes', 0)
        self.set_df('RegularMedicine_yes', 0)
        self.set_df('JunkFood_occasionally', 1)
        self.set_df('JunkFood_often', 0)
        self.set_df('JunkFood_very often', 0)
        self.set_df('Stress_not at all', 0)
        self.set_df('Stress_sometimes', 1)
        self.set_df('Stress_very often', 0)
        self.set_df('Pdiabetes_yes', 0)
        self.set_df('UriationFreq_quite often', 0)

    def make_df(self):
        self.set_defaults()

        age: int = self.patient.get('age')
        if age == None or age < 40:
            self.set_df('Age_less than 40', 1)
        elif age >= 50 and age <= 59:
            self.set_df('Age_50-59', 1)
        else:
            self.set_df('Age_60 or older', 1)

        gender: str = self.patient.get('gender')
        if gender == None or gender == 'M':
            self.set_df('Gender_Male', 1)

        try:
            stats = self.patient.get('stats')
            pregnancy: int = stats.get('pregnancies')
            if pregnancy >= 1 and pregnancy <= 4:
                for i in range(1, 5):
                    p = 0 if pregnancy != i else 1
                    self.set_df('Pregnancies_' + str(i), p)
            else:
                self.set_df('Pregnancies_4', 1)

            height: float = stats.get('height')
            weight: float = stats.get('weight')
            self.set_df('BMI', weight/(height*0.0254))

            sleep: int = stats.get('sleep')
            s = 7 if sleep == None else sleep
            self.set_df('Sleep', s)

            sound_sleep: bool = stats.get('sound_sleep')
            ss = s if sound_sleep else 0
            self.set_df('SoundSleep', s)

            family_dibetes: bool = stats.get('family_diabetes')
            if family_dibetes:
                self.set_df('Family_Diabetes_yes', 1)

            bp: int = stats.get('bp')
            if bp == None or bp < 110:
                self.set_df('BPLevel_low', 1)
                self.set_df('BPLevel_normal', 0)
            elif bp > 130:
                self.set_df('BPLevel_low', 0)
                self.set_df('BPLevel_normal', 0)

            active: str = stats.get('physically_active')
            if active == 'no':
                self.set_df('PhysicallyActive_none', 1)
            elif active == 'mid':
                self.set_df('PhysicallyActive_more than half an hr', 1)
            elif active == 'high':
                self.set_df('PhysicallyActive_one hr or more', 1)

            smoke: bool = stats.get('smoke')
            s = 1 if smoke else 0
            self.set_df('Smoking_yes', s)

            alcohol: bool = stats.get('alcohol')
            a = 1 if alcohol else 0
            self.set_df('Alcohol_yes', a)

            medicine: bool = stats.get('medicine')
            m = 1 if medicine else 0
            self.set_df('RegularMedicine_yes', m)

            junk_food: str = stats.get('junk_food')
            if junk_food == 'low':
                self.set_df('JunkFood_occasionally', 0)
                self.set_df('JunkFood_often', 1)
            elif junk_food == 'mid':
                self.set_df('JunkFood_occasionally', 0)
                self.set_df('JunkFood_very often', 1)
            elif junk_food == 'high':
                self.set_df('JunkFood_occasionally', 0)

            stress: str = stats.get('stress')
            if stress == 'no':
                self.set_df('Stress_not at all', 1)
                self.set_df('Stress_sometimes', 0)
            elif stress == 'mid':
                self.set_df('Stress_sometimes', 0)
                self.set_df('Stress_very often', 1)
            elif stress == 'high':
                self.set_df('Stress_sometimes', 0)

            gestational: bool = stats.get('gestational')
            g = 1 if gestational else 0
            self.set_df('Pdiabetes_yes', g)

            urination: str = stats.get('urination')
            if urination == 'high':
                self.set_df('UriationFreq_quite often', 1)
        except:
            pass

        file = 'ML/pickles/diabetes_standardscaler.pickle'
        scaler = pickle.load(open(file, 'rb'))
        cols = ['BMI', 'Sleep', 'SoundSleep']
        self.df[cols] = scaler.transform(self.df[cols].values)

    def probability(self):
        self.make_df()
        print(self.df)
        file = 'ML/pickles/diabetes_model.pickle'
        knc_model = pickle.load(open(file, 'rb'))
        print(self.df.values)
        result = knc_model.predict_proba(self.df)
        perc = result[0][1]
        perc = (1/11 + perc) if perc < 50 else (perc-1/11)
        print('result ', perc)
        return perc*100
