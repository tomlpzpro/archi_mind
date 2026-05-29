# db/seeds.rb

puts "Nettoyage..."
# On detruit d abord les enfants, puis on remonte vers les parents
# destroy_all (et pas delete_all) declenche les dependent: :destroy et nettoie les images
Message.destroy_all
Furniture.destroy_all
Chat.destroy_all
Project.destroy_all
User.destroy_all

PROJECT_IDEAS = [
  { title: "Salon scandinave",      description: "Salon lumineux, tons clairs et bois naturel." },
  { title: "Chambre cosy",          description: "Chambre principale chaleureuse, ambiance feutree." },
  { title: "Bureau industriel",     description: "Bureau a domicile style loft, metal et bois brut." },
  { title: "Cuisine ouverte",       description: "Cuisine moderne ouverte sur sejour, finitions mates." },
  { title: "Salle a manger boheme", description: "Salle a manger eclectique, mix de matieres et couleurs." },
  { title: "Studio parisien",       description: "Studio 25m2, optimisation de chaque espace." },
  { title: "Loft new-yorkais",      description: "Grand espace ouvert, briques apparentes, esprit warehouse." },
  { title: "Chambre d enfant",      description: "Chambre enfant ludique et evolutive, tons pastel." },
  { title: "Terrasse vegetale",     description: "Amenagement exterieur cosy, plantes et mobilier outdoor." },
  { title: "Entree minimaliste",    description: "Hall d entree epure, fonctionnel et accueillant." },
  { title: "Salle de bain spa",     description: "Zen, materiaux naturels et lumiere tamisee." },
  { title: "Dressing sur-mesure",   description: "Rangements modulables et optimises." },
  { title: "Coin lecture",          description: "Espace cosy avec fauteuil et bibliotheque." },
  { title: "Atelier creatif",       description: "Grand plan de travail et rangements." },
  { title: "Suite parentale",       description: "Chambre + dressing + salle de bain en enfilade." }
]

FURNITURE_IDEAS = [
  { title: "Canape lin ecru",        description: "3 places, 220cm, pieds bois clair, tissu lin lave." },
  { title: "Table basse chene",      description: "Ronde 90cm, chene massif huile, finition mate." },
  { title: "Lit velours sauge",      description: "Double 160cm, tete capitonnee velours vert sauge." },
  { title: "Bureau metal noir",      description: "140cm, structure metal noir et plateau bois recycle." },
  { title: "Ilot central blanc",     description: "200cm, laque blanc mat, plan de travail marbre." },
  { title: "Table travertin",        description: "Ovale 220cm, pied central, plateau travertin beige." },
  { title: "Lit mezzanine",          description: "Bois clair 140cm avec bureau integre, hauteur 200cm." },
  { title: "Bibliotheque atelier",   description: "220cm, metal noir et etageres bois, style verriere." },
  { title: "Lit cabane enfant",      description: "90cm, bois naturel, toit triangulaire et guirlande." },
  { title: "Salon de jardin rotin",  description: "Rotin synthetique gris anthracite, coussins deperlants." },
  { title: "Fauteuil moutarde",      description: "Fauteuil club velours cotele moutarde, pieds laiton." },
  { title: "Console d entree",       description: "120cm, metal noir et plateau bois, tablette basse." },
  { title: "Buffet noyer cannage",   description: "180cm, noyer massif, portes cannees naturelles." },
  { title: "Etagere modulable",      description: "Bois et acier brut, hauteur 180cm, modules ajustables." },
  { title: "Suspension osier",       description: "Osier tresse naturel diametre 60cm, douille laiton." },
  { title: "Chaise bouclette",       description: "Scandinave, bois clair et assise bouclette creme." },
  { title: "Pouf cuir cognac",       description: "Marocain rond, cuir cognac patine fait main." },
  { title: "Vasque pierre",          description: "Pierre naturelle claire sur meuble suspendu noyer." },
  { title: "Penderie laquee",        description: "Sur-mesure 240x200cm, laque gris perle mat." },
  { title: "Tapis berbere",          description: "Laine 200x300cm, motif geometrique ecru et noir." }
]

MESSAGES_SAMPLES = [
  "Salut, j aimerais une idee de meuble pour mon salon.",
  "Je cherche quelque chose dans des tons clairs.",
  "Voici une suggestion adaptee a ton projet.",
  "Tu peux me proposer une alternative plus coloree ?",
  "Quelles dimensions tu envisages ?",
  "Plutot 220cm de large idealement.",
  "Et niveau materiaux, tu preferes bois ou metal ?",
  "Bois clair, ambiance naturelle.",
  "Parfait, voici une option qui correspond.",
  "J adore, on garde celle-la.",
  "Tu as une variante en velours ?",
  "Pour rester dans le meme esprit, je te propose autre chose."
]

puts "Users..."
emails = %w[claire marc sophie thomas lea julien emma nicolas camille antoine tom]
users = emails.map { |user_name| User.create!(email: "#{user_name}@archi.com", password: "password123") }

puts "Projects, Furnitures, Chats, Messages..."
project_pool   = PROJECT_IDEAS.shuffle
furniture_pool = FURNITURE_IDEAS.shuffle
p_idx, f_idx = 0, 0

users.each do |user|
  user_projects = rand(2..3).times.map do
    idea = project_pool[p_idx % project_pool.size]
    p_idx += 1
    Project.create!(user: user, **idea)
  end

  rand(4..6).times do
    project   = user_projects.sample
    furn_idea = furniture_pool[f_idx % furniture_pool.size]
    f_idx += 1

    # On cree d abord le chat : il a juste besoin du projet
    chat = Chat.create!(project: project, title: "Recherche : #{furn_idea[:title]}")
    # Puis le meuble, qui lui a besoin du projet ET du chat (c est lui qui porte chat_id)
    Furniture.create!(project: project, chat: chat, **furn_idea)

    rand(3..8).times do |i|
      role = i.even? ? "user" : "assistant"
      Message.create!(chat: chat, title: MESSAGES_SAMPLES.sample, role: role)
    end
  end
end

puts "Seed OK : #{User.count} users, #{Project.count} projects, #{Furniture.count} furnitures, #{Chat.count} chats, #{Message.count} messages"
