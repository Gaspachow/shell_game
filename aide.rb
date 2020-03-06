class HelpCommand
    def edit
        ret = %q(
                                            __________________
                                          .-'  \ _.-''-._ /  '-.
                                        .-/\   .'.      .'.   /\-.
                                      _'/  \.'   '.  .'   './  \'_
                                      :======:======::======:======:
                                      '. '.  \     ''     /  .' .'
                                        '. .  \   :  :   /  . .'
                                          '.'  \  '  '  /  '.'
                                            ':  \:    :/  :'
                                              '. \    / .'
                                                '.\  /.'
                                                  '\/'
        
        
                  ).colorize(:light_blue)
        ret += %q(                                AIDE).colorize(:light_green)
        ret += "\n                                                  q pour quitter".colorize(:light_green)
        ret += %q(

          Tu trouveras ici des informations qui t'aideront pendant toute l'enquête.
          
          En première partie, tu trouveras des indications sur les étapes à effectuer pour retrouver le voleur et le diamant.
          
          En dernière partie, tu trouveras la liste des commnandes importantes que tu pourras utiliser.)
          ret += "\n\n    I / LES ETAPES\n"

          ret += "        - Aller dans le dossier #{"securite".colorize(:green)}, récupérer puis changer le mot de passe de l\'utilisateur #{"root".colorize(:green)}.\n\n"
          
          ret += "        - Aller dans le dossier #{"associes".colorize(:green)} et envoyer un mail aux collaborateurs du voleur pour les rassembler à un rendez-vous avec la police.\n\n"
          
          ret += "        - Aller dans le dossier #{"admin".colorize(:green)} et récupérer le mot de passe qui permettra d'accéder à la gestion de l'ordinateur du voleur.\n\n"
          
          ret += "        - Accéder à la partie #{"gestion du système".colorize(:green)} avec la commande #{"admin".colorize(:green)} et localiser où le voleur se cache avec le diamant, pour enfin envoyer sa position à la police.\n\n"
          ret += %Q(    II / LES COMMANDES

          Utilisation des commandes :
        
               ==================================================================
              |      commande + paramètre1 + ...(paramètre2 + paramètre3)...    |
               ==================================================================
        
        
          -> #{"alfred".colorize(:green)} : Demande à 4LFR3D de te donner des indices sur ce qui devrait être fait dans ce dossier.
        
          -> #{"cat".colorize(:green)} : affiche le contenu du fichier passé en paramètre.
          
          -> #{"ls".colorize(:green)} : affiche l\'ensemble des fichiers contenus dans le dossier courant.

            * Si l'option " -a" est donnée en paramètre, tous les fichiers du repertoire
              indiqué vont s\'afficher, ainsi que les fichiers et dossiers cachés.

          -> #{"cd".colorize(:green)} : change le dossier courant pour aller dans le
              dossier passé en paramètre.

            * Si le chemin " .." est donné en paramètre, le nouveau dossier
              sera le répertoire le répertoire précédent.

          -> #{"edit".colorize(:green)} : ouvre l\'éditeur de texte pour permettre la modification du
                fichier passé en paramètre.

        ->  #{"* Pour enregistrer, il faut faire Control + x.".colorize(:red)}

          -> #{"admin".colorize(:green)} : permet d\'acceder à l\'espace sécurisé de gestion du systeme.

          -> #{"rm".colorize(:green)} : supprime le fichier passé en paramètre.

          -> #{"aide".colorize(:green)} : ouvre le centre d\'aide.

          -> #{"chmod".colorize(:green)} : modifie les permissions d\'accès au fichier indiqué.

            * Utilise la commande #{"chmod +r".colorize(:green)} pour te donner les droits de lecture du fichier.

          -> #{"mail".colorize(:green)} : envoie un email au destinataire spécifié en paramètre

          -> #{"status".colorize(:green)} : donne l\'état de sécurité de l\'ordinateur (ne fonctionne que dans la partie gestion de l\'ordinateur.)

          -> #{"localiser".colorize(:green)} : tente de localiser le voleur du diamant (ne fonctionne que dans la partie gestion de l\'ordinateur.))
    end
end
