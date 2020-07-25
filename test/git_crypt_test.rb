#!/usr/bin/env ruby
require 'yaml'

"""
test git-crypt usage

"""
# @return True/False depending of the state of file is encrypted
def git_encrypted?(input_file)
  File.new(input_file).readpartial(10) == "\x00GITCRYPT\x00"
end


config_path = File.expand_path("../creds/config.yaml")
if git_encrypted? config_path
  print("File is encrypted...attempting to unlock...\n")
  `git-crypt unlock`
end

conf = YAML.load(open(config_path))#config_pathcreds/config.yaml'))
username = conf.dig('services', 'mongodb', 'user')
password = conf.dig('services', 'mongodb', 'password')
print("#######################################\n")
print("User: #{username}\n")
print("Password: #{password}\n")
print("#######################################\n")
print("Locking down files again...\n")
`git-crypt lock`
