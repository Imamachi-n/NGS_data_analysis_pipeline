#Make_directory
mkdir -p ~/software/python_path/lib/python2.7/site-packages/

#.bashrc setting
echo 'export PYTHONHOME=/usr/local' >> ~/.bashrc
echo 'export PYTHONPATH=~/software/python_path/lib/python2.7/site-packages' >> ~/.bashrc
echo 'export PATH=~/software/python_path/bin:${PYTHONHOME}/bin:${PATH}' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=~/software/python_path/lib:${LD_LIBRARY_PATH}' >> ~/.bashrc
