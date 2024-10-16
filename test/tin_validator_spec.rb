require 'rspec'
require_relative '../app/validators/tin_validator'

RSpec.describe TINValidator do
  context 'with Australian ABN' do
    it 'validates a valid ABN' do
      validator = TINValidator.new('AU', '10120000004')
      result = validator.validate
      expect(result[:valid]).to eq(true)
      expect(result[:formatted_tin]).to eq('10 120 000 004')
    end

    it 'returns an error for an invalid ABN' do
      validator = TINValidator.new('AU', '123')
      result = validator.validate
      expect(result[:valid]).to eq(false)
      expect(result[:errors]).to include('Invalid format or length for AU')
    end
  end

  context 'with Canadian GST' do
    it 'validates a valid GST' do
      validator = TINValidator.new('CA', '123456789RT0001')
      result = validator.validate
      expect(result[:valid]).to eq(true)
    end
  end
end
