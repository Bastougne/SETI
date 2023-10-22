# Differential Power Analysis - Jupyter Notebook

## Setup

In order to run the exercises using Jupyter notebooks, there are some
dependencies:

### Python environment

Create a virtual environment and activate it

    virtualenv -p python3 .dpa
    source .dpa/bin/activate
    
Install jupyter kernel in virtual environment:

    ipython kernel install --user --name=.dpa
    
Install requirements in virtual environment:

    pip install --requirement requirements.txt
    jupyter nbextension enable --py widgetsnbextension

Start notebook (you may need to select the .dpa kernel in the notebook):

    jupyter notebook
    
