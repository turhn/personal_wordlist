module PersonalWordlist
  module DSL
    # Evaluate of methods in `partial` blocks
    class Partial
      def initialize(personal_data, block, arg)
        fail ArgumentError if arg && block
        @block = block
        @personal_data = personal_data
        @arg = arg
      end

      def run!
        @block = proc { @arg } if @arg # For string args
        instance_eval(&@block)
      end

      # Map unknown methods to known keys of the input hash
      def method_missing(name)
        return @personal_data[name.to_sym] if @personal_data.key?(name)
        fail NoMethodError
      end
    end
  end
end
