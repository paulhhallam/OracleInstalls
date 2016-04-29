
OracleOSsetup
===============

This cookbook will perform a basic set up for a Red Hat 7 system for use as either:

  a) A node in a RAC cluster (11g or 12c)

  b) A single node grid installation

  c) A database installation (no grid infrastructure required).

All accounts and groups required for a full standard RAC installation are created i.e. grid oracle etc although these are obviously not necessary (or used) in all installations.

PRE COOKBOOK
============
	The file "OracleOSsetup/attributes/default.rb" will need amending to set the size of the shared memory file in gigabytes
	e.g. for a 4GB system:
	default[:system][:mem] = '4'

POST COOKBOOK
=============
1)	Complete the passwordless ssh for both oracle and grid users.
e.g. as oracle:
	ssh ambari5
		The authenticity of host 'ambari5 (192.168.0.38)' can't be established.
		ECDSA key fingerprint is af:67:6b:30:32:c5:c0:ea:01:0c:e9:6c:ae:98:70:5a.
	Are you sure you want to continue connecting (yes/no)? YES
		Warning: Permanently added 'ambari5,192.168.0.38' (ECDSA) to the list of known hosts.
		Last login: Fri Apr 29 18:32:51 2016
	exit

2) 	Reboot the system.

The cookbook 12cgrid_soft_install or oracle11g should now be followed.

