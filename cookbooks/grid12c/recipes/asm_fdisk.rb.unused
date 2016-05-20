#
# Cookbook Name:: grid12c
# Recipe:: asm_fdisk
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
execute "list_sd_disks" do
  puts "A DISKS DISKS DISKS DISKS \n"
  node.default[:oracle][:grid][:sd_volumes].each do |devnam|
     puts "DISK IS #{devnam}"
  end
  action :nothing
end
puts "B DISKS DISKS DISKS DISKS \n"

#
# initialise the partitions
#
  diskcount = 0
  node[:oracle][:grid][:sd_volumes].each do |devname|
    bash "create_partitions" do
      code <<-EOH3
      fdisk #{devname} << EOF
n
p


w
EOF
      EOH3
    end
    puts "SHOULD BE FDISKing #{devname}"
    node.default[:oracle][:grid][:sd_volumes] = "#{node[:oracle][:grid][:sd_volumes]}1"
#    command "usr/sbin/oracleasm createdisk disk#{diskcount} #{devname}1"
    diskcount = diskcount + 1
  end
