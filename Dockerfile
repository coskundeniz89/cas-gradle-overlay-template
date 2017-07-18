FROM mental/base
#Keystore base imagein içinde var.

ADD /etc/cas /etc/cas
ADD /cas/build/libs/cas.war /app/cas.war

EXPOSE 10000
WORKDIR /app

CMD java -jar cas.war