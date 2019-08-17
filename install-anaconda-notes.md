# Install Anaconda on CHTC

Open an interactive job with `condor_submit -i python-installation.sub` where the installation submission script transfers the Anaconda install script. 

Run:
```
bash Anaconda3-2019.07-Linux-x86_64.sh
```

When asked what path to put in, type: python

export the path so it knows to look for python in your Anaconda installation: 
```
export PATH=$(pwd)/python/bin:$PATH
```

Now you can install packages with conda
```
conda install -c conda-forge -c bioconda -c defaults prokka # will install prodigal and hmmer correctly with the right compiler along with it so don't get segmentation fault
conda install -c conda-forge biopython
```

Bring back the installation directory in a tarball:
```
tar -czvf anaconda-python.tar.gz python/
```

This takes a bit longer than the normal python tarball and installation because Anaconda comes with a bunch of extra floof. Then use this tarball to transfer when you want to use these packages. You will have to export the path as written above at the beginning of your executable to tell it where to find the specific packages/installation of Anaconda python. 
