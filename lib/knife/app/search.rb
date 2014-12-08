require "chef/knife/search"

module Knife::App
  class Search < Chef::Knife::Search
    def initialize
      super
      configure_chef
    end

    def environments
      ['All environments'] + Chef::Environment.list.keys
    end

    def regions(query)
      regions = ['All regions']
      Chef::Search::Query.new.search(:node, query) do |node|
        regions << node.region
      end
      regions.uniq
    end
  end
end
