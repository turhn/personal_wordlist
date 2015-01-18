module PersonalWordlist
  module DSL
    # Creates sequences within given patterns
    class Sequence
      include PersonalWordlist::DSL

      def initialize(personal_data, block, range)
        @block = block
        @personal_data = personal_data
        @current_password = ''
        @range = range || (0..1)
      end

      def run!
        passwords = []
        @range.to_a.each do |n|
          # Reset the state of current_password
          @current_password = ''
          passwords << instance_exec(n, &@block)
        end
        passwords
      end
    end
  end
end
