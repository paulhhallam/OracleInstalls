The set of recipes in this cookbook are here to provide a means to install various different oracle database configurations opn RedHat Linux 7.

I am using a set of Oracle Virtual Box VM's with disks configured for use by ASM.
These instructions will not (not at the moment anyway) describe the setup of the VM's or the disk volumes.

One important point to note is that due to discrepancies between the different versions of Oracle Virtual Box, Oracle 12c and numerous examples of how to install ASM volumes on linux, any ASM volumes should be mounted as RW, not NOSUID in fstab.
e.g. 
  FAILS LABEL=U01 /u01 auto nosuid,nodev,nofail,x-gvfs-show 0 0
  WORKS LABEL=U01 /u01 auto rw                              0 0

In these cookbooks
Ambari1 is the Chef client, Git hub and Jenkins host.
Ambari2 is the Chef Server.
Ambari5 is one node that will either be a standalone database or part of a RAC cluster (depending upon which recipe you want to use).
Ambari6 is the second node in the oracle RAC cluster.

The cookbooks :
oracleOSsetup
grid12c
oracle11g
oracle11gdb
oracle12c
oracle12cdb

COOKBOOK: oracleOSsetup

A script to complete a basic host setup in preparation for an oracle install. 

This script will 

RECIPE: oracle_user_config

	1) Set up the yum repositories, system, patches etc.

	2) Set up the user accounts and groups regardless of the oracle version to be installed i.e. all accounts and groups for a 12c installation are installed. 

	3) Set all passwords to "Changeme3".

	4) Set the ulimits and limits.d values.

	5) Basic setup of ssh for oracle and grid users.

	6) Create the oracle .

	7) Create the oracle base directories.

RECIPE: deps_install

	8) Install the oracle-rdbms-server=-12cR1-preinstall package, the oracleasm drivers and the cvuqdisk package.

	9) Update the OS using "yum update -y"

RECIPE: kernel_params

	10) Create swapfs

	11) Ensure /u01 with the correct settings is in fstab.

	12) Configure sysctl, ntpd and avhi

COOKBOOK: oracle11g

A single node Database Enterprise Edition (11.2.0.4.0) software only install.

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

11g Database creation on a single node 11g system.

RECIPE: createdb

	Checks a database hasn't already been created.
	Uses DBCA to perform a silent db creation.
	Sets up the oracle (and grid) users bash profiles from templates.
	Modify the listener parameters.
	Sets up DBCONTROL.
	Modify tnsnames and restart the listener.
	
COOKBOOK: oracle12c

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

RECIPE: createdb
	Creates oracle directories.
	Unzips the oracle media files.
	Installs Oracle 11g database software.
	Configures listener and sqlnet files.
	Sets up automatic startup.
	Configures BCT.
	
COOKBOOK: grid12c

RECIPE:


MORE TO FOLLOW
===============

