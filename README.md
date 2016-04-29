
OracleInstalls
===============
The cookbooks included (being written as of 20/04/2016) are:

1) oracleOSsetup

This cookbook will perform a basic set up for a Red Hat 7 system for use as either:

  a) A node in a RAC cluster (11g or 12c)

  b) A single node grid installation

  c) A database installation (no grid infrastructure required).

After completing the setup of the user accounts, groups kernel parameters etc the system will require a reboot.

All accounts and groups required for a full standard RAC installation are created i.e. grid oracle etc although these are obviously not necessary (or used) in all installations.

The file attributes/default.rb will need amending to set the size of the shared memory file in gigabytes
e.g.
default[:system][:mem] = '4'


