#
# Cookbook Name:: grid12c
# Recipe:: asm_setup
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
# IF ASM is not already installed
#
if !node[:oracle][:grid][:asm_installed]
#
# Configure ASM driver
#
  bash "configure_asm" do
    code <<-EOH2
      /etc/init.d/oracleasm configure << EOF
grid
oinstall
y
y
EOF
      /usr/sbin/oracleasm init
      /etc/init.d/oracleasm scandisks
      /etc/init.d/oracleasm listdisks
    EOH2
# was using asmdba
  end
  node.default[:oracle][:grid][:asm_installed] = true
end
#
# Do we have to find and partition all devices
#

#node.run_state['disks'] = 0
###node.set[:oracle][:grid][:discover_disks] = true
diskk=0
file_names=[]
diskcount=0

if node[:oracle][:grid][:discover_disks]
  ruby_block "get unused sd devices" do
    block do
      files1 = Dir["/dev/sd?"]
      files1.each do |file_name|
        puts "\n"
#       if the device has not been partitioned (e.g. no sdb1) then we can use it as an asm volume 
        if Dir.glob("#{file_name}?").empty?
#         add to the sd volumes list
          file_names.push("#{file_name}")
#         puts "##2 Need to #{diskcount} fdisk #{file_names} ## \n"
          diskcount=diskcount+1
        end
      end
    node.set[:oracle][:grid][:sd_volumes] = file_names
    end
  end

#  node.run_state['disks'] = diskcount
#  puts "DISKCOUNT7 == #{node[:oracle][:grid][:sd_volumes].length}"

  node[:oracle][:grid][:sd_volumes].each do | dn |
    puts "### now fdisk #{dn} ### \n"
    bash "create_partitions" do
      code <<-EOH3
      fdisk #{dn} << EOF
n
p
1


w
EOF
      EOH3
    end
  end

  diskk = 0
  node[:oracle][:grid][:sd_volumes].each do | dn |
    puts "### now create asm disk #{dn} ### \n"
    execute "create asm disks" do
      command "/usr/sbin/oracleasm createdisk disk#{diskk} #{dn}1"
    end
  diskk = diskk + 1
end
#
  node.set[:oracle][:grid][:discover_disks] = false
end

