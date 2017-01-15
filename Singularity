# Note this is provided solely for reference purposes
# current tests are not run using this version
# This works to autobuild container with Singularity version >= 2.2
# Tests were run using container built and executed with 2.1.2 using commands in
# commands-to-generate-container.md

Bootstrap: docker
From: ubuntu:trusty

%runscript
	conda list | tail -n+3 | awk '{print $1, $2, "Anaconda"}' > /tmp/temp.info
	find /Software/brew/Cellar -maxdepth 2 -print | sed 's|/Software/brew/Cellar||g' | sed 's|^/||' | grep "/" | sed 's|/|\t|' | sort | awk '{print $1, $2, "Homebrew"}'>> /tmp/temp.info
	rtg version | head -1 | awk '{print $2, $5, "User_Install"}' >> /tmp/temp.info
	column -t /tmp/temp.info | sort -u --ignore-case
	rm /tmp/temp.info

%post
        apt-get update
        apt-get install -y wget unzip
	mkdir /scratch /share /local-scratch /Software
	chmod 777 /Software
	apt-get install -y apt-transport-https build-essential cmake curl libsm6 libxrender1 libfontconfig1 wget vim git unzip python-setuptools ruby
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 51716619E084DAB9
	echo "deb https://cloud.r-project.org/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list
	apt-get update
	apt-get install -y r-base-dev gdebi-core
	apt-get clean
	useradd -m singularity
	su -c 'cd /Software && git clone https://github.com/Linuxbrew/brew.git' singularity
	su -c '/Software/brew/bin/brew install bsdmainutils parallel util-linux' singularity
	su -c '/Software/brew/bin/brew tap homebrew/science' singularity
	su -c '/Software/brew/bin/brew install art bwa samtools' singularity
	su -c 'rm -r $(/Software/brew/bin/brew --cache)' singularity
	su -c 'cd /Software && wget http://repo.continuum.io/archive/Anaconda3-4.1.1-Linux-x86_64.sh' singularity
	su -c 'cd /Software && bash Anaconda3-4.1.1-Linux-x86_64.sh -b -p /Software/anaconda3' singularity
	su -c 'cd /Software && rm Anaconda3-4.1.1-Linux-x86_64.sh' singularity
	su -c '/Software/anaconda3/bin/conda update -y conda' singularity
	su -c '/Software/anaconda3/bin/conda update -y anaconda' singularity
	su -c '/Software/anaconda3/bin/conda config --add channels bioconda' singularity
	su -c '/Software/anaconda3/bin/conda install -y --channel bioconda kallisto' singularity
	su -c '/Software/anaconda3/bin/conda clean -y --all' singularity
	su -c 'cd /Software && wget --no-check-certificate https://github.com/RealTimeGenomics/rtg-core/releases/download/3.6.2/rtg-core-non-commercial-3.6.2-linux-x64.zip' singularity
	su -c 'cd /Software && unzip rtg-core-non-commercial-3.6.2-linux-x64.zip' singularity
	echo "n" | /Software/rtg-core-non-commercial-3.6.2/rtg --version
