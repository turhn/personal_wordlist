require 'personal_wordlist/version'
require 'personal_wordlist/dsl'

##
# A wordlist generator. Uses simple DSL to define password generation rules.
module PersonalWordlist
  class PersonalWordlistError < StandardError; end
  class InvalidTemplateError < PersonalWordlistError; end

  class << self
    include PersonalWordlist::DSL

    attr_reader :current_password

    ##
    # PersonalWorlList.password
    def generate(personal_data, &block)
      fail ArgumentError unless block_given?

      # Set class variables
      @personal_data = personal_data
      @block = block
      @current_password = ''
      @passwords = []

      result = instance_eval(&block)

      # Ensure that result is always an Array
      result.instance_of?(Array) ? @passwords = result : @passwords << result
    end
  end
end
