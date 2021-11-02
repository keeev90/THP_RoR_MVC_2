class UserController < ApplicationController
  def show
    puts "#" * 60
    puts "Welcome controller required to GET show.html.erb from user view, with dynamic URL variable" #récupérer la valeur contenue dans l'URL - à l'endroit où on a initialisé la variable dans un GET (i.e fichier routes/rb >>> gossip/:gossip_id) - et stockée dans un hash temporaire "params",
    puts  params[:id]
    puts "#" * 60

    @user = User.find(params[:id]) #pour cibler plus vite le user concerné dans la base de donnée 
  end
end
