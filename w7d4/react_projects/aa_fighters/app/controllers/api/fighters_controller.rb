class Api::FightersController < ApplicationController
  def index
    render json: Fighter.all
  end

  def create
    fighter = Fighter.create!(fighter_params)
    render json: fighter
  end

  private
  def fighter_params
    params.require(:fighter).permit(:name, :power, :history)
  end
end
