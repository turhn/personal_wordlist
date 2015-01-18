require 'personal_wordlist/dsl/partial'
require 'personal_wordlist/dsl/sequence'

module PersonalWordlist
  # DSL Syntax Methods
  module DSL
    def partial(&block)
      fail ArgumentError unless block_given?
      @current_password += Partial.new(@personal_data, block).run!
    end

    def sequence(range, &block)
      fail ArgumentError unless block_given?
      @passwords.concat Sequence.new(@personal_data, block, range).run!
    end

    # Map unknown methods to known keys of the input hash
    def method_missing(name)
      return @personal_data[name.to_sym] if @personal_data.key?(name)
      fail NoMethodError
    end
  end
end
