class VisuelMailer < ApplicationMailer
  # Envoie la proposition (mail HTML) au client
  def proposition(chat, email_destinataire)
    # la discussion concernée
    @chat = chat
    # le projet lié, pour afficher son nom dans le mail
    @projet = chat.project
    # on envoie le mail au client, avec un sujet
    mail(to: email_destinataire, subject: "Proposition de votre architecte — #{@projet.title}")
  end
end
