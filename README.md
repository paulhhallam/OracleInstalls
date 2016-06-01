Oracle 11g database, 12c database
=================================
and 12c Grid Installations
==========================
This set of cookbooks are here to provide a method of installing various different oracle database configurations on RedHat Linux 7.

I am using a set of 4 Oracle Virtual Box VM's with disks configured for use by ASM.
These instructions will not (not at the moment anyway) describe the setup of the VM's or the disk volumes.

Hosts
=====
Ambari1 is the Chef client, Git hub and Jenkins host.

Ambari2 is the Chef Server.

Ambari5 is one node that will either be a standalone database or part of a RAC cluster (depending upon which recipe you want to use).

Ambari6 is the second node in the oracle RAC cluster.

One important point to note is that due to discrepancies between the different versions of Oracle Virtual Box, Oracle 12c and numerous examples of how to install VBox ASM volumes on linux, any ASM volumes should be mounted as RW, not NOSUID in fstab.

i.e. 
	FAILS: LABEL=U01 /u01 auto nosuid,nodev,nofail,x-gvfs-show 0 0

	WORKS: LABEL=U01 /u01 auto rw                              0 0
	

The cookbooks
=============
oracleOSsetup

grid12c

oracle11g

oracle11gdb

oracle12c

oracle12cdb

COOKBOOK: oracleOSsetup
=======================
A script to complete a basic host setup in preparation for an oracle install. 

Prerequisites: None

RECIPE: oracle_user_config

	Set up the yum repositories, system, patches etc.
	
	Set up the user accounts and groups regardless of the oracle version to be installed i.e. all accounts and groups for a 12c installation are installed. 
	
	Set all passwords to "Changeme3".
	
	Set the ulimits and limits.d values.
	
	Basic setup of ssh for oracle and grid users.
	
	Create the oracle .
	
	Create the oracle base directories.

RECIPE: deps_install

	Install the oracle-rdbms-server=-12cR1-preinstall package, the oracleasm drivers and the cvuqdisk package.
	
	Update the OS using "yum update -y"

RECIPE: kernel_params

	Create swapfs.
	
	Ensure /u01 with the correct settings is in fstab.
	
	Configure sysctl, ntpd and avhi.

COOKBOOK: oracle11g
===================
A single node Database Enterprise Edition (11.2.0.4.0) software only install.

Prerequisites: oracleOSsetup

RECIPE: oracle_users_profile

	Sets up the oracle (and grid) users bash profiles from templates.

RECIPE: dbbin

	Fix of ora_inventory if an oracle client was installed.
	Creates oracle directories.
	
	Unzips the oracle media files.
	
	Installs Oracle 11g database software.
	
	Configures listener and sqlnet files.
	
	Sets up automatic startup.
	
COOKBOOK: oracle11gdb
=====================
11g Database creation on a single node 11g system.

Prerequisites: oracleOSsetup, oracle11g

RECIPE: createdb

	Checks a database hasn't already been created.
	
	Uses DBCA to perform a silent db creation.
	
	Sets up the oracle (and grid) users bash profiles from templates.
	
	Modify the listener parameters.
	
	Sets up DBCONTROL.
	
	Modify tnsnames and restart the listener.
	
COOKBOOK: oracle12c
===================
A single node Database Enterprise Edition (12.1.0.2) software only install.

Prerequisites: oracleOSsetup

RECIPE: oracle_users_profiles

	Sets up the oracle and grid bash users profiles.

RECIPE: dbbin

	Fix of ora_inventory if an oracle client was installed.
	
	Creates oracle directories.
	
	Unzips the oracle media files.
	
	Installs Oracle 12c database software. 
	
	Configures listener and sqlnet files.
	
	Sets up automatic startup.
	
COOKBOOK: oracle12cdb
=====================
12c database creation on a single node 12c system.

Prerequisites: oracleOSsetup, oracle12c

RECIPE: createdb

	Creates oracle directories.
	
	Unzips the oracle media files.
	
	Installs Oracle 11g database software.
	
	Configures listener and sqlnet files.
	
	Sets up automatic startup.
	
	Configures Block Change Tracking.
	
COOKBOOK: grid12c
=================

Prerequisites: None

RECIPE: oracleOSsetup::oracle_user_config

RECIPE: oracleOSsetup::deps_install

RECIPE: oracleOSsetup::kernel_params

RECIPE: oracle12c::oracle_users_profiles

RECIPE: asm_setup

	Configure the ASM drivers.
	
	Find sd devices that are not partitioned.
	
	Create a single partition on the devices identified.
	
	Run oracleasm createdisk for each device.

RECIPE: gridbin

	Create the oracle base, grid  etc directories
	
	Unzip the grid software package.
	
	Run runcluvfy on the system.
	
At this point we could stop and check the output from runcluvfy to ensure everything is setup correctly.

	Install the grid software using a response file from templates.
	
	




MORE TO FOLLOW
===============

