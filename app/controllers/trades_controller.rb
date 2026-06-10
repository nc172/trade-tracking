class TradesController < ApplicationController
  before_action :authenticate_user!

  def index
    @trades = current_user.trades.order(entry_time: :desc)
  end

  def show
    @trade = current_user.trades.find(params[:id])
  end
end