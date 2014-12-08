require "yaml"
require "knife/app/runner"
require "knife/app/version"
require "knife/app/search"
require "knife/app/ssh"

module Knife
  module App
    MODES = [:single_node, :multiple_nodes]

    def self.run
      Runner.new
    end

    def self.select_mode
      puts "Select option for nodes search:"
      MODES.each_with_index do |mode, index|
        puts "#{index + 1}) #{mode}"
      end
      choice = gets.to_i - 1
      system "clear" or system "cls"
      puts "=> #{MODES[choice]}"
      self.send(MODES[choice])
    end

    def self.multiple_nodes
      select_environment
      select_region
    end

    def self.select_environment
      puts "Specify node environment:"
      environments = ['All environments'] + Chef::Environment.list.keys
      environments.each_with_index do |environment, index|
        puts "#{index + 1}) #{environment}"
      end
      choice = gets.to_i - 1
      system "clear" or system "cls"
      puts "=> #{environments[choice]}"
      @query += " AND chef_environment:#{environments[choice]}" if choice > 0
    end

    def self.select_region
      puts "Specify node region:"
      regions = ['All regions']
      Chef::Search::Query.new.search(:node, @query) do |node|
        regions << node.region
      end
      regions.uniq.each_with_index do |region, index|
        puts "#{index + 1}) #{region}"
      end
      choice = gets.to_i - 1
      system "clear" or system "cls"
      puts "=> #{regions[choice]}"
      @query += " AND region:#{regions[choice]}" if choice > 0
    end

    def self.single_node
      puts "Specify node:"
      # Search for nodes
      index = 1
      Chef::Search::Query.new.search(:node, @query) do |node|
        puts node_template(node, index)
        index += 1
      end
      z = Chef::Knife::Ssh.new
      z.configure_chef
      puts z.config
    end

    def ssh
      Chef::Knife::Ssh.run
    end

    def self.node_template(node, index)
<<eos
#{index}) Node Name:   #{node.name}
   Environment: #{node.environment}
   FQDN:        #{node.fqdn}
   IP:          #{node.ipaddress}
   Roles:       #{node.roles}
eos
    end
  end
end