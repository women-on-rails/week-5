class CuriositiesController< ApplicationController

  def show
  	@curiosity = Curiosity.find(params[:id])
  end

  def destroy
    @curiosity = Curiosity.find(params[:id]) # Récupère l'identifiant de la curiosité à supprimer
	@curiosity.delete                        # Supprime la curiosité dans la base de données

	redirect_to home_path             # Redirige l'utilisateur vers la vue Index
  end

end