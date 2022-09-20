class Api::V1::BoardUpdater
  def initialize(board, board_params)
    @board = board
    @board_params = board_params
  end

  def successful?
    !!@successful
  end

  def run
    ActiveRecord::Base.transaction do
      @successful = @board.update(@board_params)

      raise ActiveRecord::Rollback unless self.successful?
    end
    self
  end

  def board
    @board
  end
end