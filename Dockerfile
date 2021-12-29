# Base image for Docker, in this sample Docker the model requires a python3.6 base image
FROM python:3.6
# requirements.txt - the dependencies, libraries needed for the model code to work
# train.csv - this file (train.csv) is provided to the model code by the platform, this is a sample from the    # original data uploaded which can be used
# by model code for training the model
RUN pip install --upgrade pip
COPY requirements.txt train.csv ./

# installs the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# copy all your model code to the local directory, this is needed for the platform to be able to use your   
# model code, and in this sample we are using 3 files. The developer can include all his code/files.
COPY model.py runmodel.py savemodel.py  ./

# This sample code (savemodel.py) here trains the model and saves it,
# Developer can run his code in place of savemodel.py, it uses ‘train.csv’ (hard coded) to train the model.
RUN python savemodel.py

# Command to execute when image loads, this loads the saved model and prints the prediction to the    
# console. The prediction count is provided as a parameter to your code. The code should print prediction output to the console in csv format.
ENTRYPOINT ["python","runmodel.py"]
CMD ["forecast"]
