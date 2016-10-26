class CuriositiesController< ApplicationController

  def show
  	@curiosity = Curiosity.find(params[:id])
  end

end