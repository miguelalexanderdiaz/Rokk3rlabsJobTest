#
# Dist docker for Rokk3rlabsJobTest
#

# Pull base image.
FROM ubuntu:16.04
USER root

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Install basic packages
RUN \
    apt-get update && \
    apt-get install -y software-properties-common && \
    apt-get install -y git tree man unzip vim wget tar bzip2 graphviz

#Download and install Anaconda python package manager
RUN cd /root && \
    wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh && \
    bash miniconda.sh -b -p .miniconda && \
    rm miniconda.sh
ENV PATH /root/.miniconda/bin:$PATH

#Install dependencies
RUN conda update conda && \
    conda install -y numpy pandas ipython jupyter matplotlib Pillow h5py graphviz
Run pip install pydot-ng

#Install tensorflow and keras (comment/uncomment the version of tensorflow you need)
RUN pip install tensorflow keras


#Clone git repository and remove unwantedfiles
RUN git clone https://github.com/miguelalexanderdiaz/Rokk3rlabsJobTest.git
RUN cd Rokk3rlabsJobTest && \
    rm *.log *.html && \
    rm -Rf test train validation

#port to serve 
EXPOSE 8888

# Define default command.
CMD ["bash"]
#CMD ["jupyter", "notebook", "--no-browser", "--ip=0.0.0.0", "--debug"]


