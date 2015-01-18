require 'spec_helper'

describe PersonalWordlist do
  describe '.password' do
    it 'must have a block given' do
      expect do
        PersonalWordlist.generate(john_doe)
      end.to raise_error ArgumentError
    end
    it 'should be an array' do
      passwords = PersonalWordlist.generate(john_doe) do
      end
      expect(passwords).to be_kind_of(Array)
    end
  end
end
