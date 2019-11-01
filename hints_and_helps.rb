class Hint

  def infiltrate_computer
    h = "\n\n"
    h += "💡 Conseil : Pour rentrer dans le système, il faut rajouter ton identifiant dans la liste des utilisateurs autorisés !\n".colorize(:cyan)
    h += "   Pour cela, édite le fichier ".colorize(:cyan) + "autorisations".colorize(:light_yellow) + " et rajoute ton identifiant !".colorize(:cyan)
    h += "\n-----------\n".colorize(:cyan)
  end

  def rewrite_firstname(name)
    h = "\n\n"
    h += "💡  Maintenant que tu as ajouté ton identifiant (#{name}) à la liste des utilisateurs autorisés, tu peux le retaper pour rentrer dans le système !".colorize(:cyan)
    h += "\n-----------\n\n".colorize(:cyan)
  end

  def after_authorized
    h = "\n\n"
    h += "💡  Maintenant que tu as infiltré l'ordinateur du voleur, tu vas pouvoir commencer à regarder ce qu'il s'y passe.\n".colorize(:cyan)
    h += "    Voyons ce qu'il y a dans le dossier où tu es..".colorize(:cyan)
    h += "\n-----------\n\n".colorize(:cyan)
  end

  def after_ls
    h = "\n\n"
    h += "___________________________________________________________________________________________________________________________________________________\n\n".colorize(:cyan)
    h += "💡  Comme tu peux le voir, il y a des choses dans le dossier.\n".colorize(:cyan)
    h += "    Les noms sont en gras et sont précédés d'un icône 🗂  , ça veut dire que ce sont d'autres dossiers. Regarde, il y a un dossier avec ton nom !\n".colorize(:cyan)
    h += "    Ça veut dire que le voleur a des informations sur toi... Il vaut mieux aller rectifier ça tout de suite, va dans ton dossier pour faire ça.\n".colorize(:cyan)
    h += "___________________________________________________________________________________________________________________________________________________\n\n".colorize(:cyan)
  end

  def after_cd
    h = "\n\n".colorize(:cyan)
    h += "___________________________________________________________________________________________________________________________________________________\n\n".colorize(:cyan)
    h += "💡  Maintenant que tu es dans ton dossier, tu peux voir que ton identifiant est écrit au niveau du prompt ($>)\n".colorize(:cyan)
    h += "    Ca veut dire que tu es bien dans ton dossier. Voyons maintenant ce qu'il y a dedans en se servant de la commande ".colorize(:cyan) + "ls".colorize(:light_yellow) + " .".colorize(:cyan)
    h += "___________________________________________________________________________________________________________________________________________________\n\n".colorize(:cyan)
  end

  def after_enter_user
    h = "\n\n"
    h += "___________________________________________________________________________________________________________________________________________________\n\n".colorize(:cyan)
    h += "💡  Tu peux voir que ce qu'il y a à l'interieur de ce dossier sont des fichiers, car il y a l'icône 📄  devant.\n".colorize(:cyan)
    h += "    Voyons ce que contient le fichier ".colorize(:cyan) + "prochaine-analyse".colorize(:light_yellow) + " !".colorize(:cyan)
    h += "\n-----------\n".colorize(:cyan)
  end

  def after_cat
    h = "\n\n"
    h += "💡  Regarde juste en haut, c'est le contenu du fichier `prochaine-analyse`\n".colorize(:cyan)
    h += "   Tu peux remarquer que l'ordinateur du voleur prévoit une analyse te concernant... Ça n'a pas l'air très très bon... Mieux vaut annuler ça tout de suite et supprimer ce fichier !".colorize(:cyan)
    h += "\n-----------\n\n".colorize(:cyan)
  end

  def after_rm
    h = "\n\n"
    h += "💡  Super, maintenant que ce fichier a bien été supprimé, intéressons-nous au deuxième ( derniere-analyse ). Affiche le contenu de ce fichier avec la commande ".colorize(:cyan) + "cat\n".colorize(:light_yellow)
    h += "    Si tu ne sais plus ce qu'il y a dans le dossier où tu es, rappelle-toi que tu peux toujours faire la commande ".colorize(:cyan) + "ls".colorize(:light_yellow)
    h += "\n-----------\n\n".colorize(:cyan)
  end

  def after_cat_user
    h = "\n\n"
    h += "💡  Il semblerait que le voleur ait récolté beaucoup d'informations personnelles sur toi. Supprime ce fichier aussi avec la commande ".colorize(:cyan) + "rm".colorize(:light_yellow)
    h += "\n-----------\n\n".colorize(:cyan)
  end

  def after_failed_rm
    h = "\n\n"
    h += "💡  On ne peut pas supprimer ce fichier. Il faut l'éditer en mettant de fausses informations pour induire le voleur en erreur !\n".colorize(:cyan)
    h += "    Remplace ce qu'il y a après les '=' !".colorize(:cyan)
    h += "\n-----------\n\n".colorize(:cyan)
  end

  def after_edit_analyse
    h = "\n\n"
    h += "💡  Super, tu es maintenant intraçable sur le système informatique du voleur de diamants".colorize(:cyan)
    h += " et libre de te déplacer où tu veux.\n Tu vas pouvoir commencer à démasquer le coupable du vol de diamants et ses associés...\n".colorize(:cyan)
    h += "    Pour voir ce que tu peux faire, tape la commande ".colorize(:cyan) + "aide".colorize(:light_yellow) + ". ".colorize(:cyan)
    h += "\n-----------\n\n".colorize(:cyan)
  end
end

class HelpCommands

  def edit file=nil
    file = file || "autorisations"
    h = "💻 Commandes :\n".colorize(:cyan)
    h += "   Pour éditer un fichier, tape la commande ".colorize(:cyan) + "edit".colorize(:light_yellow) + " et le nom du fichier\n".colorize(:cyan)
    h += "   que tu veux éditer derrière. Par exemple :\n".colorize(:cyan)
    h += "   edit #{file}".colorize(:light_yellow).italic
    h += "\n\n\n"
  end

  def after_authorized
    h = "💻 Commandes :\n".colorize(:cyan)
    h += "   Pour voir ce qu'il y a dans le dossier où tu es, tu peux taper la commande ".colorize(:cyan) + "ls".colorize(:light_yellow) + "\n"
    h += "   Par exemple :\n".colorize(:cyan)
    h += "   ls".colorize(:light_yellow).italic
    h += "\n\n\n"
  end

  def after_ls
    h = "💻 Commandes :\n".colorize(:cyan)
    h += "   Pour aller dans un dossier, il faut utiliser la commande ".colorize(:cyan) + "cd".colorize(:light_yellow) + " avec le nom du dossier juste après.\n".colorize(:cyan)
    h += "   Par exemple :\n".colorize(:cyan)
    h += "   cd #{$current_user.slug}".colorize(:light_yellow).italic
    h += "\n\n\n"
  end

  def after_cd

  end

  def after_enter_user file=nil
    file = file || "fichier"
    h = "💻 Commandes :\n".colorize(:cyan)
    h += "   Pour afficher le contenu d'un fichier à l'écran, tape la commande ".colorize(:cyan) + "cat".colorize(:light_yellow) + " suivi du nom du fichier.\n".colorize(:cyan)
    h += "   Par exemple :\n".colorize(:cyan)
    h += "   cat #{file}".colorize(:light_yellow).italic
    h += "\n___________________________________________________________________________________________________________________________________________________\n\n".colorize(:cyan)
    h += "\n\n\n"
  end

  def after_cat file=nil
    file = file || "fichier"
    h = "💻 Commandes :\n".colorize(:cyan)
    h += "   Pour supprimer un fichier, tape la commande ".colorize(:cyan) + "rm".italic + " suivi du nom du fichier.\n".colorize(:cyan)
    h += "   Par exemple :\n".colorize(:cyan)
    h += "   rm #{file}".colorize(:light_yellow).italic
    h += "\n\n\n"
  end

  def after_edit_analyse
    h = "💻 Commandes :\n".colorize(:cyan)
    h += "   La commande #{'aide'.italic} te permet de lister toutes les commandes que tu peux utiliser\n".colorize(:cyan)
    h += "   et de t'expliquer tout ce que tu peux faire.\n".colorize(:cyan)
    h += "   Rappelle-toi des commandes que tu as déjà vu : ls, cat, edit, rm, cd\n".colorize(:cyan)
    h += "   Quand tu rentres dans un nouveau dossier, n'hésite pas à taper #{'ls'.italic} pour voir tout ce qu'il contient !".colorize(:cyan)
    h += "\n\n\n"
  end
end
