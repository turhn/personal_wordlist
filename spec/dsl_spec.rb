require 'spec_helper'

# Puppet class with minimum requirements to test the DSL
class TestClass
  attr_accessor :current_password, :passwords

  include PersonalWordlist::DSL

  def initialize(personal_data)
    @personal_data = personal_data
    @current_password = ''
    @passwords = []
  end
end

describe 'SocialWordlist::DSL' do
  subject { TestClass.new(john_doe) }
  describe '#partial' do
    it 'should fail if block is not given' do
      expect { subject.partial }.to raise_error ArgumentError
    end
    it 'should access class variables' do
      expect do
        subject.partial do
          "#{first_name}A"
        end
      end.to change { subject.current_password }.from('').to('JohnA')
      subject.current_password = '' # Reset Current Passoword
      expect do
        subject.partial do
          "#{first_name[0]}123#{last_name[0]}xyz"
        end
      end.to change { subject.current_password }.from('').to('J123Dxyz')
    end
  end

  describe '#sequence' do
    it 'should create sequences' do
      expect do
        subject.sequence(1..3) do |n|
          "#{first_name}#{n}"
        end
      end.to change { subject.passwords }.from([]).to %w(John1 John2 John3)
    end
  end
end
