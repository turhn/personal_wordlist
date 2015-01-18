require 'spec_helper'

describe 'PersonalWordlist' do
  context 'when everything is fine' do
    it 'should work with multiple partial DSLs' do
      passwords = PersonalWordlist.generate(john_doe) do
        partial { "#{first_name[0..1]}" }
        partial { '123' }
        partial { "#{last_name[0]}" }
      end
      expect(passwords.first).to eq 'Jo123D'
    end

    it 'should combine sequences and partials' do
      passwords = PersonalWordlist.generate(john_doe) do
        sequence(1..5) do |n|
          partial { n.to_s }
          partial { first_name[0] }
        end
      end
      expect(passwords).to eq %w(1J 2J 3J 4J 5J)
    end

    it 'should combine multiple sequences' do
      passwords = PersonalWordlist.generate(john_doe) do
        sequence(125..250) do |n|
          partial { first_name.downcase }
          partial { n.to_s }
          partial { last_name[0].upcase }
        end
        sequence(1960..2000) do |n|
          partial { last_name.downcase }
          partial { n.to_s }
        end
        partial do
          'Test Password'
        end
      end
      expect(passwords.count).to eq 168
    end
  end

  context 'when something went wrong' do
    it 'gives an error when method is not recognized in DSL' do
      expect do
        PersonalWordlist.generate(john_doe) do
          sequence(1..10) do |n|
            partial { n.to_s + undefined_field }
          end
        end
      end.to raise_error NoMethodError
    end
  end
end
