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
## Get and unzip the Oracle Grid binaries.
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
asmdba
y
y
EOF
      /usr/sbin/oracleasm init
      /etc/init.d/oracleasm scandisks
      /etc/init.d/oracleasm listdisks
    EOH2
  end
end

#
# Do we have to find and partition all devices
#
if node[:oracle][:grid][:discover_disks]
#  ruby_block "get sd devices" do
#    block do
#      Dir.glob('/dev/sd*').select{ |e| File.file? e }
#    end
#  end
  ruby_block "get unused sd devices" do
    block do
      files1 = Dir["/dev/sd?"]
      files1.each do |file_name|
        puts "\n"
#       if the device has not been partitioned (e.g. no sdb1) then we can use it as an asm volume 
        if Dir.glob("#{file_name}?").empty?
#         add to the sd volumes list
          puts "Need to fdisk #{file_name}"
          node[:oracle][:grid][:sd_volumes].new = "#{file_name}"
        end
      end
    end
  end
#
# initialise the partitions
#
  bash "create partitions" do
    diskcount=0
    node[:oracle][:grid][:sd_volumes].each do |devname|
      code <<-EOH2
        fdisk #{devname} << EOF
n
p


w
EOF
    EOH2
    node[:oracle][:grid][:sd_volumes] = "#{node[:oracle][:grid][:sd_volumes]}1"
    usr/sbin/oracleasm createdisk disk#{diskcount} #{devname}1
    diskcount = diskcount + 1
    end
  end
# add disks to asm

end

bash 'touch_a_a' do
  user "grid"
  group "oinstall"
  cwd "#{node[:oracle][:grid][:install_dir]}"
  code "touch a.a"
ignore_failure true
end

