def faker_analyse user
  f = "adresse = #{user[:address]}\n"
  f += "telephone = #{user[:phone]}\n"
  f += "age = #{user[:age]}\n"
  f += "numero de carte bleue = #{user[:code_cb]}\n"
  f += "groupe sanguin = #{user[:blood]}\n"
  f += "activer les cameras = oui\n"
end

def new_user_class user
  klass = class_exists?("User#{user[:name].camelize}")
  return klass if klass
  t1 = Time.now
  t2 = Time.parse("2019-11-16 14:40:34")
  klass_name = "User#{user[:name].camelize}"
  klass = Class.new(User) do
    class_variable_set(:@@age, user[:age])
    class_variable_set(:@@blood, user[:blood])
    class_variable_set(:@@code_cb, user[:code_cb])
    define_method :initialize do
      @camera_activated = true
      @analized = true
      @parent_dir = $users_dir
      @name = user[:name]
      @slug = user[:name].downcase
      @parent_dir = $analyses_dir
      @list = [
        {name: "Prochaine analyse", slug: "prochaine-analyse", removable: true, locked: false, content: "Prochaine analyse: #{rand(t1..t2)}", kind: :file, editable: true},
        {name: "Dernière analyse", slug: 'derniere-analyse', removable: false, locked: false, content: faker_analyse(user), kind: :file, editable: true}
      ]
      @path = user[:name].downcase
    end
  end
  Object.const_set(klass_name, klass)
end


def populate_users
  users = [
    {:name=>"Clement", :blood=>"B+", :code_cb=>"7465848869808880", :age=>11, :address=>"5399 Passage Mouffetard - 49560 - Toulouse", :phone=>"06 38 06 96 61"},
    {:name=>"Camille", :blood=>"B-", :code_cb=>"8566768483867886", :age=>14, :address=>"7 Avenue des Saussaies - 10771 - Vénissieux", :phone=>"+33 715578086"},
    {:name=>"Mathis", :blood=>"A-", :code_cb=>"8268847766847577", :age=>11, :address=>"9 Passage Marcadet - 02568 - Calais", :phone=>"0637543907"},
    {:name=>"Maxime", :blood=>"A-", :code_cb=>"7783886765887790", :age=>12, :address=>"184 Rue Lepic - 87271 - Dunkerque14", :phone=>"+33 723935723"},
    {:name=>"Lucas", :blood=>"AB-", :code_cb=>"6687748872766972", :age=>16, :address=>"968 Allée, Voie Saint-Denis - 26250 - Rueil-Malmaison", :phone=>"+33 631138718"},
    {:name=>"Sarah", :blood=>"B+", :code_cb=>"7988737190886773", :age=>11, :address=>"377 Boulevard de la Harpe - 04407 - Metz", :phone=>"+33 7 42 28 13 02"},
    {:name=>"Maelys", :blood=>"A-", :code_cb=>"8490856968818478", :age=>13, :address=>"86 Allée, Voie de Presbourg - 11827 - Angers", :phone=>"0798225212"},
    {:name=>"Lena", :blood=>"A-", :code_cb=>"7089806984906671", :age=>16, :address=>"5 Avenue des Francs-Bourgeois - 69473 - Champigny-sur-Marne", :phone=>"06 59 10 20 70"},
    {:name=>"Chloe", :blood=>"A-", :code_cb=>"6882667171687075", :age=>14, :address=>"9 Impasse de Richelieu - 51546 - Saint-Étienne", :phone=>"06 64 57 88 48"},
    {:name=>"Arthur", :blood=>"A+", :code_cb=>"7180656968816767", :age=>15, :address=>"6935 Quai de la Harpe - 71145 - Neuilly-sur-Seine", :phone=>"06 42 47 79 24"},
    {:name=>"Manon", :blood=>"A-", :code_cb=>"7769687468846583", :age=>13, :address=>"7701 Impasse La Boétie - 67107 - Rueil-Malmaison", :phone=>"0688143715"},
    {:name=>"Leo", :blood=>"A+", :code_cb=>"8578707067867577", :age=>12, :address=>"726 Impasse des Saussaies - 55514 - Beauvais", :phone=>"+33 783208673"},
    {:name=>"Nathan", :blood=>"A+", :code_cb=>"8789888277767779", :age=>11, :address=>"795 Place de la Chaussée-d'Antin - 77597 - Pau", :phone=>"+33 6 10 39 93 27"},
    {:name=>"Matheo", :blood=>"B+", :code_cb=>"7169716783666784", :age=>12, :address=>"4487 Avenue Joubert - 77614 - Amiens", :phone=>"+33 6 21 86 20 50"},
    {:name=>"Yanis", :blood=>"AB-", :code_cb=>"6981737677746772", :age=>11, :address=>"35 Allée, Voie des Rosiers - 06278 - Paris", :phone=>"+33 773725871"},
    {:name=>"Romane", :blood=>"AB-", :code_cb=>"6684737977737590", :age=>15, :address=>"7452 Boulevard de l'Odéon - 77482 - Pessac", :phone=>"0781581512"},
    {:name=>"Gabriel", :blood=>"A-", :code_cb=>"8588877486798767", :age=>11, :address=>"48 Passage Royale - 25692 - Nantes", :phone=>"+33 736809709"},
    {:name=>"Ines", :blood=>"AB-", :code_cb=>"7584747465657882", :age=>16, :address=>"82 Allée, Voie Monsieur-le-Prince - 84411 - Perpignan", :phone=>"+33 764210925"},
    {:name=>"Emma", :blood=>"AB-", :code_cb=>"7883717085908465", :age=>11, :address=>"3885 Allée, Voie Molière - 25045 - Angers", :phone=>"+33 633316433"},
    {:name=>"Louise", :blood=>"A+", :code_cb=>"6866756967767384", :age=>11, :address=>"5 Allée, Voie des Francs-Bourgeois - 63551 - Sarcelles", :phone=>"+33 7 72 07 33 90"},
    {:name=>"Louna", :blood=>"AB-", :code_cb=>"8185757290877470", :age=>13, :address=>"58 Rue des Grands Augustins - 81383 - Antibes", :phone=>"06 18 59 99 33"},
    {:name=>"Hugo", :blood=>"AB+", :code_cb=>"9086778270896867", :age=>16, :address=>"97 Place de Solférino - 43290 - Versailles", :phone=>"+33 658747499"},
    {:name=>"Raphael", :blood=>"O-", :code_cb=>"9089828389787285", :age=>14, :address=>"1 Avenue Pastourelle - 19533 - Metz", :phone=>"+33 630574483"},
    {:name=>"Jules", :blood=>"AB+", :code_cb=>"6966738981776969", :age=>14, :address=>"97 Impasse de la Ferronnerie - 14394 - Valence", :phone=>"0673661562"},
    {:name=>"Zoe", :blood=>"B+", :code_cb=>"7979676888908989", :age=>11, :address=>"470 Quai des Panoramas - 35258 - Sarcelles", :phone=>"07 17 22 24 12"},
    {:name=>"Noah", :blood=>"O+", :code_cb=>"7782828581657388", :age=>14, :address=>"2 Place Joubert - 43664 - Aix-en-Provence", :phone=>"06 54 65 47 63"},
    {:name=>"Theo", :blood=>"B-", :code_cb=>"8884848667777386", :age=>16, :address=>"2517 Avenue Monsieur-le-Prince - 02857 - Troyes", :phone=>"+33 6 81 62 33 11"},
    {:name=>"Tom", :blood=>"AB+", :code_cb=>"7884838784847986", :age=>16, :address=>"18 Passage Montorgueil - 71484 - Amiens", :phone=>"0656420677"},
    {:name=>"Louis", :blood=>"B+", :code_cb=>"7565757685908383", :age=>14, :address=>"402 Impasse La Boétie - 10866 - Le Havre", :phone=>"+33 7 99 26 26 26"},
    {:name=>"Eva", :blood=>"AB-", :code_cb=>"7775898778798089", :age=>15, :address=>"360 Avenue de Paris - 66089 - Bordeaux", :phone=>"06 35 62 86 15"},
    {:name=>"Lola", :blood=>"A-", :code_cb=>"7486698266667689", :age=>14, :address=>"5488 Quai Saint-Séverin - 16438 - Le Havre", :phone=>"+33 685608832"},
    {:name=>"Anais", :blood=>"B-", :code_cb=>"8874717869668685", :age=>12, :address=>"8917 Allée, Voie Montorgueil - 12633 - Troyes", :phone=>"+33 714169604"},
    {:name=>"Clara", :blood=>"O+", :code_cb=>"6873678486678166", :age=>11, :address=>"61 Passage Adolphe Mille - 67798 - Montreuil", :phone=>"+33 692021456"},
    {:name=>"Lea", :blood=>"AB+", :code_cb=>"8374897573808587", :age=>12, :address=>"7 Passage de Provence - 57791 - Montauban", :phone=>"+33 6 12 79 03 05"},
    {:name=>"Timeo", :blood=>"B+", :code_cb=>"7077737876666987", :age=>16, :address=>"949 Avenue Joubert - 91126 - Saint-Pierre", :phone=>"0613413426"},
    {:name=>"Lilou", :blood=>"A-", :code_cb=>"8783886672907969", :age=>12, :address=>"1 Rue Bonaparte - 57718 - Saint-Étienne", :phone=>"0780292924"},
    {:name=>"Enzo", :blood=>"AB-", :code_cb=>"7976858288828579", :age=>11, :address=>"5892 Quai de Montmorency - 39069 - Neuilly-sur-Seine", :phone=>"07 81 48 21 83"},
    {:name=>"Lina", :blood=>"AB+", :code_cb=>"8769678090798780", :age=>11, :address=>"8 Boulevard La Boétie - 11871 - Toulouse", :phone=>"+33 7 84 97 96 41"},
    {:name=>"Ethan", :blood=>"A+", :code_cb=>"8974758968876871", :age=>15, :address=>"6 Rue Bonaparte - 36604 - Vitry-sur-Seine", :phone=>"+33 6 20 99 81 32"},
    {:name=>"Jade", :blood=>"O-", :code_cb=>"6565847482757487", :age=>15, :address=>"37 Passage Dauphine - 23494 - Antibes", :phone=>"+33 6 92 21 77 14"}
  ]
  users.each do |user|
    new_user_class(user)
  end
end
