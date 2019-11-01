class Hint

  def infiltrate_computer
	h = "\n\n"
	h += "____________________________________________________________________________________________________________________________________________________________________________________\n\n".colorize(:light_black)
    h += "💡 Conseil : Pour rentrer dans le système, il faut rajouter ton identifiant dans la liste des utilisateurs autorisés !\n".colorize(:light_black)
    h += "   Pour cela, édite le fichier ".colorize(:light_black) + "autorisations".colorize(:light_yellow) + " et rajoute ton identifiant !".colorize(:light_black)
    h += "\n\n".colorize(:light_black)
  end

  def rewrite_firstname(name)
	h = "\n\n"
	h += "____________________________________________________________________________________________________________________________________________________________________________________\n\n".colorize(:light_black)
	h += "💡  Maintenant que tu as ajouté ton identifiant (#{name}) à la liste des utilisateurs autorisés, tu peux le retaper pour rentrer dans le système !".colorize(:light_black)
	h += "\n____________________________________________________________________________________________________________________________________________________________________________________\n\n".colorize(:light_black)
  end

  def after_authorized
	h = "\n\n"
	h += "____________________________________________________________________________________________________________________________________________________________________________________\n\n".colorize(:light_black)
    h += "💡  Maintenant que tu as infiltré l'ordinateur du voleur, tu vas pouvoir commencer à regarder ce qu'il s'y passe.\n".colorize(:light_black)
    h += "    Voyons ce qu'il y a dans le dossier où tu es...".colorize(:light_black)
    h += "\n\n".colorize(:light_black)
  end

  def after_ls
    h = "\n\n"
    h += "____________________________________________________________________________________________________________________________________________________________________________________\n\n".colorize(:light_black)
    h += "💡  Comme tu peux le voir, il y a des choses dans le dossier.\n".colorize(:light_black)
    h += "    Les noms sont en gras et sont précédés d'un icône 🗂  , ça veut dire que ce sont d'autres dossiers. Regarde, il y a un dossier avec ton nom !\n".colorize(:light_black)
    h += "    Ça veut dire que le voleur a des informations sur toi... Il vaut mieux aller rectifier ça tout de suite, va dans ton dossier pour faire ça.\n".colorize(:light_black)
    h += "\n\n".colorize(:light_black)
  end

  def after_cd
    h = "\n\n".colorize(:light_black)
    h += "____________________________________________________________________________________________________________________________________________________________________________________\n\n".colorize(:light_black)
    h += "💡  Maintenant que tu es dans ton dossier, tu peux voir que ton identifiant est écrit au niveau du prompt ($>)\n".colorize(:light_black)
    h += "    Ca veut dire que tu es bien dans ton dossier. Voyons maintenant ce qu'il y a dedans en se servant de la commande ".colorize(:light_black) + "ls".colorize(:light_yellow) + " .".colorize(:light_black)
    h += "\n____________________________________________________________________________________________________________________________________________________________________________________\n\n".colorize(:light_black)
  end

  def after_enter_user
    h = "\n\n"
    h += "____________________________________________________________________________________________________________________________________________________________________________________\n\n".colorize(:light_black)
    h += "💡  Tu peux voir que ce qu'il y a à l'interieur de ce dossier sont des fichiers, car il y a l'icône 📄  devant.\n".colorize(:light_black)
    h += "    Voyons ce que contient le fichier ".colorize(:light_black) + "prochaine-analyse".colorize(:light_yellow) + " !".colorize(:light_black)
    h += "\n\n".colorize(:light_black)
  end

  def after_cat
	h = "\n\n"
	h += "____________________________________________________________________________________________________________________________________________________________________________________\n\n".colorize(:light_black)
    h += "💡  Regarde juste en haut, c'est le contenu du fichier `prochaine-analyse`\n".colorize(:light_black)
    h += "   Tu peux remarquer que l'ordinateur du voleur prévoit une analyse te concernant... Ça n'a pas l'air très très bon... Mieux vaut annuler ça tout de suite et supprimer ce fichier !".colorize(:light_black)
    h += "\n\n".colorize(:light_black)
  end

  def after_rm
	h = "\n\n"
	h += "____________________________________________________________________________________________________________________________________________________________________________________\n\n".colorize(:light_black)
    h += "💡  Super, maintenant que ce fichier a bien été supprimé, intéressons-nous au deuxième ( derniere-analyse ). Affiche le contenu de ce fichier avec la commande ".colorize(:light_black) + "cat\n".colorize(:light_yellow)
    h += "    Si tu ne sais plus ce qu'il y a dans le dossier où tu es, rappelle-toi que tu peux toujours faire la commande ".colorize(:light_black) + "ls".colorize(:light_yellow)
    h += "\n\n".colorize(:light_black)
  end

  def after_cat_user
	h = "\n\n"
	h += "____________________________________________________________________________________________________________________________________________________________________________________\n\n".colorize(:light_black)
    h += "💡  Il semblerait que le voleur ait récolté beaucoup d'informations personnelles sur toi. Supprime ce fichier aussi avec la commande ".colorize(:light_black) + "rm".colorize(:light_yellow)
    h += "\n\n".colorize(:light_black)
  end

  def after_failed_rm
	h = "\n\n"
	h += "____________________________________________________________________________________________________________________________________________________________________________________\n\n".colorize(:light_black)
    h += "💡  On ne peut pas supprimer ce fichier. Il faut l'éditer en mettant de fausses informations pour induire le voleur en erreur !\n".colorize(:light_black)
    h += "    Remplace ce qu'il y a après les '=' !".colorize(:light_black)
    h += "\n\n".colorize(:light_black)
  end

  def after_edit_analyse
	h = "\n\n"
	h += "____________________________________________________________________________________________________________________________________________________________________________________\n\n".colorize(:light_black)
    h += "💡  Super, tu es maintenant intraçable sur le système informatique du voleur de diamants".colorize(:light_black)
    h += " et libre de te déplacer où tu veux.\n Tu vas pouvoir commencer à démasquer le coupable du vol de diamants et ses associés...\n".colorize(:light_black)
    h += "    Pour voir ce que tu peux faire, tape la commande ".colorize(:light_black) + "aide".colorize(:light_yellow) + ". ".colorize(:light_black)
    h += "\n\n".colorize(:light_black)
  end
end

class HelpCommands

  def edit file=nil
    file = file || "autorisations"
    h = "💻 Commandes :\n".colorize(:light_black)
    h += "   Pour éditer un fichier, tape la commande ".colorize(:light_black) + "edit".colorize(:light_yellow) + " et le nom du fichier\n".colorize(:light_black)
    h += "   que tu veux éditer derrière. Par exemple :\n".colorize(:light_black)
	h += "   edit #{file}".colorize(:light_yellow).italic
	h += "\n____________________________________________________________________________________________________________________________________________________________________________________\n\n\n".colorize(:light_black)
  end

  def after_authorized
    h = "💻 Commandes :\n".colorize(:light_black)
    h += "   Pour voir ce qu'il y a dans le dossier où tu es, tu peux taper la commande ".colorize(:light_black) + "ls".colorize(:light_yellow) + "\n"
    h += "   Par exemple :\n".colorize(:light_black)
	h += "   ls".colorize(:light_yellow).italic
	h += "\n____________________________________________________________________________________________________________________________________________________________________________________\n\n\n".colorize(:light_black)
  end

  def after_ls
    h = "💻 Commandes :\n".colorize(:light_black)
    h += "   Pour aller dans un dossier, il faut utiliser la commande ".colorize(:light_black) + "cd".colorize(:light_yellow) + " avec le nom du dossier juste après.\n".colorize(:light_black)
    h += "   Par exemple :\n".colorize(:light_black)
    h += "   cd #{$current_user.slug}".colorize(:light_yellow).italic
    h += "\n____________________________________________________________________________________________________________________________________________________________________________________\n\n\n".colorize(:light_black)
  end

  def after_cd

  end

  def after_enter_user file=nil
    file = file || "fichier"
    h = "💻 Commandes :\n".colorize(:light_black)
    h += "   Pour afficher le contenu d'un fichier à l'écran, tape la commande ".colorize(:light_black) + "cat".colorize(:light_yellow) + " suivi du nom du fichier.\n".colorize(:light_black)
    h += "   Par exemple :\n".colorize(:light_black)
    h += "   cat #{file}".colorize(:light_yellow).italic
    h += "\n______________________________________________________________________________________________________________________________________________________________________________________________\n\n\n".colorize(:light_black)
  end

  def after_cat file=nil
    file = file || "fichier"
    h = "💻 Commandes :\n".colorize(:light_black)
    h += "   Pour supprimer un fichier, tape la commande ".colorize(:light_black) + "rm".italic + " suivi du nom du fichier.\n".colorize(:light_black)
    h += "   Par exemple :\n".colorize(:light_black)
    h += "   rm #{file}".colorize(:light_yellow).italic
    h += "\n____________________________________________________________________________________________________________________________________________________________________________________\n\n\n".colorize(:light_black)
  end

  def after_edit_analyse
    h = "💻 Commandes :\n".colorize(:light_black)
    h += "   La commande ".colorize(:light_black) + "aide".colorize(:light_yellow) + " te permet de lister toutes les commandes que tu peux utiliser\n".colorize(:light_black)
    h += "   et de t'expliquer tout ce que tu peux faire.\n".colorize(:light_black)
    h += "   Rappelle-toi des commandes que tu as déjà vu : ls, cat, edit, rm, cd\n".colorize(:light_black)
    h += "   Quand tu rentres dans un nouveau dossier, n'hésite pas à taper ".colorize(:light_black) + "ls".colorize(:light_yellow) + " pour voir tout ce qu'il contient !".colorize(:light_black)
    h += "\n____________________________________________________________________________________________________________________________________________________________________________________\n\n\n".colorize(:light_black)
  end
end
