require 'rails_helper'

RSpec.describe Column, type: :request do
  describe 'Controller.Column' do
    let(:column1) {FactoryBot.create :column}

    context 'validates field using fixtures' do
      it 'column must exist' do
        expect(column1).to be_valid
      end

      it 'column must notbe valid' do
        column1.title = nil
         expect(column1).to_not be_valid
       end
    end
  end
end