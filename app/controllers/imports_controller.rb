class ImportsController < ApplicationController
  before_action :authenticate_user!

  def new
    @import = current_user.imports.new
  end

  def create
    @import = current_user.imports.new(import_params)
    @import.status = "pending"

    if @import.save
      Imports::TradovateCsvParser.new(@import).call
      redirect_to @import, notice: "File uploaded and parsed successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @import = current_user.imports.find(params[:id])
  end

  private

  def import_params
    params.require(:import).permit(:source_platform, :file)
  end
end