# How to generate server build
- download and install mongo server from [here](https://www.mongodb.com/try/download/community)
- download and install python | conda | miniconda (any one)

Note: You need to add a `.env` file to server directory, 
use `.env.example` file to create it.

<details> <summary><strong>1. Using pip and venv</strong></summary>
  
- Open cmd and move to server directory

- Install and upgrade pip
  - if you face problem in mac os for installing pip, [see this](https://www.geeksforgeeks.org/how-to-install-pip-in-macos/)
```bash
# on mac/linux
python3 -m pip install --upgrade pip
# on windows
py -m pip install --upgrade pip
```
- Install virtualenv package
```bash
# on mac/linux
python3 -m pip install virtualenv
# on windows
py -m pip install virtualenv
```

- Create a new virtual env (preferred env_name = nutrihelp) 
```bash
# on mac/linux
python3 -m venv env
# On Windows:
py -m venv env
```

- Activate virtual env
```bash
# on mac/linux
source env/bin/activate
# on windows
.\env\bin\activate
```
- Installing requirements
```bash
# on mac/linux
python3 -m pip install -r requirements.txt
# on windows
py -m pip install -r requirements.txt
```
- Run flask
```bash
flask run
```
open the url to flask app provided in console.
</details>

<details><summary> <strong> 2. using conda and pip</strong></summary>
  
1. Open cmd and move to server directory
2. Create new env
```bash
conda create --name nutrihelp pip
```
3. Activate that env
```bash
conda deactivate  # run if base env is active.
conda activate nutrihelp
```
4. Install requirements
```bash
 pip install -r requirements.txt
```
  
5. Run flask
```bash
flask run
```
open the url to flask app provided in console.
</details>

Note : while developing, if you install a new package, run this to save it at requirements.txt
```bash
pip freeze > requirements.txt
```
