class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]

  # GET /boards
  # GET /boards.json
  def index
    @boards = Board.all
  end

  # GET /boards/1
  # GET /boards/1.json
  def show
    @board = Board.find(params[:id])
    @cups = Cup.where(board_id: @board)
  end

  # GET /boards/new
  def new
    @board = Board.new
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards
  # POST /boards.json
  def create
    @board = Board.new(board_params)

    respond_to do |format|
      if @board.save
        14.times do
          cup = Cup.create(marbles: 4, board_id: @board.id)
          if(cup.id % 7 == 0)
            cup.marbles = 0
            cup.save
          end
        end
        format.html { redirect_to @board, notice: 'Board was successfully created.' }
        format.json { render action: 'show', status: :created, location: @board }
      else
        format.html { render action: 'new' }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1
  # PATCH/PUT /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to @board, notice: 'Board was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @board.destroy
    respond_to do |format|
      format.html { redirect_to boards_url }
      format.json { head :no_content }
    end
  end

  def move
    @board = Board.find(params[:board_id])

    @cup = Cup.find(params[:cup_id])
    @marble = @cup.marbles
    @cup.marbles = 0
    @cup.save
    cup_id = @cup.id
    while @marble > 0 do
      if cup_id == 14
        cup_id = 1
      else
        cup_id += 1
      end
      cup = Cup.find(cup_id)
      cup.marbles += 1
      @marble -= 1
      cup.save
    end
    redirect_to @board
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def board_params
      params[:board]
    end

end
