FROM mental/jre
#Keystore base imagein içinde var.

ADD /etc/cas /etc/cas
ADD /cas/build/libs/cas.war /app/cas.war

EXPOSE 10010
WORKDIR /app

CMD java -jar cas.war