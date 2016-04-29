# See https://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "paul"
client_key               "#{current_dir}/paul.pem"
validation_client_name   "moluccan-validator"
validation_key           "#{current_dir}/moluccan-validator.pem"
chef_server_url          "https://ambari2/organizations/moluccan"
cookbook_path            ["~/Desktop/OracleInstalls/cookbooks"]
