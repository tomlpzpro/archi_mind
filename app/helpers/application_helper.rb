module ApplicationHelper
  # transforme un texte Markdown (ex: **gras**, listes) en HTML mis en forme
  def markdown(texte)
    # si le texte est vide, on renvoie une chaîne vide pour éviter une erreur
    return "" if texte.blank?

    # on configure le rendu HTML : pas de balises HTML brutes écrites par l'IA
    rendu = Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true)
    # on crée le convertisseur Markdown avec quelques options pratiques
    convertisseur = Redcarpet::Markdown.new(rendu, autolink: true, no_intra_emphasis: true)
    # on convertit le texte et on autorise le HTML produit à s'afficher
    convertisseur.render(texte).html_safe
  end
end
