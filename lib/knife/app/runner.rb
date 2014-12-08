module Knife::App
  class Runner
    def initialize
      config = YAML.load_file('.knife-app.yml')
      search = Search.new
    end

    def select_mode
      modes = ['single node', 'multiple nodes']
      select("Select option for nodes search:", modes)
    end

    def select_environment
      select('Specify node environment:', search.environments)
    end

    def select_region
      select('Specify node region:', search.regions)
    end

    private
      def select(question, options)
        puts question
        options.each_with_index do |mode, index|
          puts "#{index + 1}) #{mode}"
        end
        choice = gets.to_i - 1
        if choice < options.size && choice > 0
          system 'clear' or system 'cls'
          puts "=> #{options[choice]}"
          return choice
        else
          system 'clear' or system 'cls'
          puts "Option #{choice} doesn't exist"
          return select(question, options)
        end
      end
  end
end
