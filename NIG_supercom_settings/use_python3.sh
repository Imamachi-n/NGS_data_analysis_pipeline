###python3###
wget https://www.python.org/ftp/python/3.5.0/Python-3.5.0.tgz
tar zxvf Python-3.5.0.tgz
cd Python-3.5.0
./configure --prefix=$HOME/software/Python3.5.0
make
make install

###virtualenv###
wget https://pypi.python.org/packages/source/v/virtualenv/virtualenv-13.1.2.tar.gz#md5=b989598f068d64b32dead530eb25589a
tar zxvf virtualenv-13.1.2
cd virtualenv-13.1.2
~/software/Python3.5.0/bin/python3.5 virtualenv.py PythonVE_3_5

###use_python3###
export PYTHONHOME=~/software/Python3.5.0
export PYTHONPATH=~/software/Python3.5.0/lib/python3.5

###use_virtualenv###
cd mypythonVE
. bin/activate

deactivate #exit

###python_modules###
pip install --install-option="--prefix=~/software/python_path" ${MODULE_NAME}

