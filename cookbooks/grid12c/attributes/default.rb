#
# Cookbook Name:: oracle11g
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

# Settings specific to ASM setup
default[:oracle][:grid][:asm_installed] = false
default[:oracle][:grid][:discover_disks] = true
default[:oracle][:grid][:add_disks] = {}
#default[:oracle][:grid][:sd_volumes] = {0 => '',1 => '',2 => '',3 => '',4 => ''}
default[:oracle][:grid][:sd_volumes] = []
default[:oracle][:grid][:sdn_volumes] = ['/dev/sdb','/dev/sdc','/dev/sdd','/dev/sde']

default[:oracle][:grid][:install_files] = ['/media/sf_oracle_kits/12c/28092015/V46096-01_1of2_GRID.zip','/media/sf_oracle_kits/12c/28092015/V46096-01_2of2_GRID.zip']
default[:oracle][:grid][:install_dir] = "/media/sf_oracle_kits/12c/28092015/"

# Settings related to patching.
default[:oracle][:grid][:opatch_update_url] = 'https://https-server.example.localdomain/path/to/p6880880_112000_Linux-x86-64.zip'
default[:oracle][:grid][:latest_patch][:url] = 'https://https-server.example.localdomain/path/to/p16619892_112030_Linux-x86-64.zip'

