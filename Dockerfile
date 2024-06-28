# Utiliser une image Debian comme base
FROM debian:latest

# Mettre à jour les paquets et installer les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    apt-transport-https

# Ajouter la clé GPG de CrowdSec
RUN curl -s https://packagecloud.io/install/repositories/crowdsec/crowdsec/script.deb.sh | bash

# Installer le dashboard
RUN apt-get install -y crowdsec-dashboard

# Copier le script d'entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Copier le fichier de secrets pour l'installation initiale
COPY secrets /etc/crowdsec/secrets

# Exposer le port du dashboard
EXPOSE 3000

# Définir l'entrypoint
ENTRYPOINT ["/entrypoint.sh"]
