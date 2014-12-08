require "chef/knife/ssh"

module Knife::App
  class Ssh < Chef::Knife::Ssh
    def initialize
      super
      configure_chef
    end
  end
end
