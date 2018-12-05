#!/bin/bash


#Fonction de création des entrées 
ecrireEntree() {
  NOM=$(echo $1|tr ’[:upper:]’ ’[:lower:]’)
  COMPTEUR=$2
  PRENOM=$(echo $3|tr ’[:upper:]’ ’[:lower:]’)
  #echo "$COMPTEUR"
  MYUID=${PRENOM:0:3}${NOM:0:8}
  #echo $MYUID
  SSHA="{SSHA}"
  echo "dn: uid=${MYUID},ou=etudiants,ou=personnes,dc=iutbeziers,dc=fr"
  echo "objectClass: inetOrgPerson"
  echo "objectClass: person"
  echo "objectClass: organizationalPerson"
  echo "objectClass: posixAccount"
  echo "objectClass: shadowAccount"
  echo "objectClass: top"
  echo "cn: ${PRENOM}.${NOM}"
  echo "sn: ${PRENOM}"
  echo "givenName: ${NOM}"
  echo "uid: ${MYUID}"
  echo "uidNumber: ${COMPTEUR}"
  echo "gidNumber: ${COMPTEUR}"
  echo "homeDirectory: /home/${MYUID}"
  echo "loginShell: /bin/bash"
  echo "shadowExpire: 0"
  echo "userPassword: ${SSHA}RWK9BASh/NsGzi0k4XLRm1Xt1DoEceJvtB1h1w=="
  echo -e "mail: ${PRENOM}.${NOM}@iutbeziers.fr\n"
}

#Check $1
if [ -z $1 ]; then
	echo "Enter in first argument the list."
	exit 1
fi

#Un uid qui commence a 1050
i=1000

#pour chaque ligne
while read -r line; do
	ecrireEntree "$(echo $line | cut -d ' ' -f 2)" "$i" "$(echo $line | cut -d ' ' -f 3 | cut -d ';' -f 1)"
	((i++))
done < $1