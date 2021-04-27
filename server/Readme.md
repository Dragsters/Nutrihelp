# How to generate server build
- download and install mongo server from [here](https://www.mongodb.com/try/download/community)
- download and install python | conda | miniconda (any one)

Note: You need to add a `.env` file to server directory, 
use `.env.example` file to create it.

### Using pip and venv
- open cmd and move to server directory

- Install and upgrade pip
  - if you face problem in mac os for installing pip, [see this](https://www.geeksforgeeks.org/how-to-install-pip-in-macos/)
```bash
# on mac/linux
python3 -m pip install --upgrade pip
# on windows
py -m pip install --upgrade pip
```
3. install virtualenv package
```bash
# on mac/linux
python3 -m pip install virtualenv
# on windows
py -m pip install virtualenv
```

4. create a new virtual env (preferred env_name = nutrihelp) 
```bash
# on mac/linux
python3 -m venv nutrihelp
# On Windows:
py -m venv nutrihelp
```

5. activate virtual env
```bash
# on mac/linux
source nutrihelp/bin/activate
# on windows
.\nutrihelp\bin\activate
```
6. installing requirements
```bash
# on mac/linux
python3 -m pip install -r requirements.txt
# on windows
py -m pip install -r requirements.txt
```
7. run flask
```bash
flask run
```
open the url to flask app provided in console.

Note : while developing, if you install a new package, run this to save it at requirements.txt
```bash
pip freeze > requirements.txt
```
