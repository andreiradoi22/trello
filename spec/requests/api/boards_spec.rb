require 'rails_helper'

RSpec.describe Board, type: :request do
  describe 'Controller.Board' do
    let(:board1) {FactoryBot.create :board}

    context 'validates field using fixtures' do
      it 'board must exist' do
        expect(board1).to be_valid
      end

      it 'board must notbe valid' do
         board1.title = nil
         expect(board1).to_not be_valid
       end
    end
  end
end