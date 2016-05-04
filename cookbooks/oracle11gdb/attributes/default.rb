#
# Cookbook Name:: oracle11gdb
# Attributes::default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Hash of DBs to create; the keys are the DBs' names, the values are Booleans,
# with true indicating the DB has already been created and should be skipped
# by createdb.rb. We don't create any DBs by default, hence the attribute's
# value is set to an empty Hash.
default[:oracle11gdb][:rdbms][:dbs11g] = {'db1' => false,'db2' => false}
# The directory under which we install the DBs.
default[:oracle11gdb][:rdbms][:dbs11g_root] = "/oradata"

# Local emConfiguration
# Attributes for the local database dbcontrol for all databases.
default[:oracle11gdb][:rdbms][:dbconsole][:emconfig] = true
default[:oracle11gdb][:rdbms][:dbconsole][:sysman_pw] = 'sysman_pw_goes_here'
default[:oracle11gdb][:rdbms][:dbconsole][:notification_email] = 'foo@bar.inet'
default[:oracle11gdb][:rdbms][:dbconsole][:outgoing_mail] = 'mailhost'
