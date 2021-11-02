class GossipController < ApplicationController

  def index # Méthode qui récupère tous les potins et les envoie à la view index (index.html.erb) pour affichage
    puts "#" * 60
    puts "Home controller required to GET index.html.erb from home view"
    puts "#" * 60

    @gossips = Gossip.all #transmettre les données de la table gossips à la view (sous forme d'array de hashs)
  end

  def show # Méthode qui récupère le potin concerné et l'envoie à la view show (show.html.erb) pour affichage
    puts "#" * 60
    puts "Gossip controller required to GET show.html.erb from gossip view, with dynamic URL variable"
    puts  params[:id] #idem que params["gossip_id"] >>> récupérer la valeur contenue dans l'URL - à l'endroit où on a initialisé la variable dans un GET (i.e fichier routes/rb >>> gossip/:gossip_id) - stockée dans un hash temporaire "params" {"gossip_id"=>"valeur_dans_URL"} 
    puts "#" * 60

    @gossip = Gossip.find(params[:id]) #pour cibler le gossip concerné dans la base de donnée 
  end

  def new # Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
    @gossip = Gossip.new #pour éviter une method error sur les alerts (don't work ???!) https://stackoverflow.com/questions/40192004/ruby-on-rails-undefined-method-errors-for-nilnilclass
  end

  def create
    # Méthode qui créé un potin à partir du contenu du formulaire de new.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params (ton meilleur pote)
    # Une fois la création faite, on redirige généralement vers la méthode show (pour afficher le potin créé)
    puts "#" * 60
    puts "Ceci est le contenu de params :"
    puts params
    puts "#" * 60

    @gossip = Gossip.new(title: params[:gossip_title], content: params[:gossip_content], user_id: 101) # création d'un nouveau gossip avec les données obtenues à partir du formulaire, associé au user "Anonymous" dont l'id est 101 > cf en console User.find_by(first_name: "Anonymous")

    # doc Ruby pour redirect_to et render : https://guides.rubyonrails.org/layouts_and_rendering.html#using-render
    # doc pour Flash messages : https://www.rubyguides.com/2019/11/rails-flash-messages/
    if @gossip.save # essaie de sauvegarder en base @gossip
      redirect_to root_path
      flash[:success] = "Le Gossip a bien été créé."  # si ça marche, il redirige vers la page d'index du site, en passant par la route sélectionnée, donc ton app repart sur un controller, sa méthode, etc.
    else
      flash[:warning] = @gossip.errors.full_messages
      render :new # sinon, il render directement la view new (qui est celle sur laquelle on est déjà) tout en gardant les variables disponibles (notamment @gossip)

      puts "#" * 60
      puts "Ceci est le contenu de params :"
      puts @gossip.errors.full_messages
      puts "#" * 60
    end
  end

  def edit
    # Méthode qui récupère le potin concerné et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition
  end

  def update
    # Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params
    # Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher le potin modifié)
  end

  def destroy
    # Méthode qui récupère le potin concerné et le détruit en base
    # Une fois la suppression faite, on redirige généralement vers la méthode index (pour afficher la liste à jour)
  end

end
