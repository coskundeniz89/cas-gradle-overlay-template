CAS Gradle Overlay
============================
Generic CAS gradle war overlay to exercise the latest versions of CAS. This overlay could be freely
used as a starting template for local CAS gradle war overlays.

# Dependency
- Mental Login - Login servisineihtiyaç duymaktadır.
- Mental Authentication - Authentication Dbsine ihtiyaç duymaktadır.
- Mental User - Kullanıcı adından kullanıcı idsini getirmelidir.
- Postgresql - Authentication Dbsi

### Run postgresql before cas
<code>docker run --name cont_postgresql 
-itd -p 5432:5432 --restart always 
-e DB_NAME=authentication-dev,authentication-qa 
-e DB_USER=dbuser -e DB_PASS=12345 sameersbn/postgresql</code>

### Run authentication before cas
<code>docker run -it --name cont_authentication -p 10020:10020 
--link cont_postgresql mental/authentication</code>


### Run login before cas
<code>docker run -it --name cont_login -p 10000:10000 
--link cont_postgresql mental/login</code>


## Versions

* CAS 5.1.x

## Requirements

* JDK 1.8+

## Configuration

The `etc` directory contains the configuration files that are copied to `/etc/cas/config`  automatically.

## Adding Modules

CAS modules may be specified under the `dependencies` block of the [CAS subproject](cas/build.gradle):

```gradle
dependencies {
    compile "org.apereo.cas:cas-server-webapp-tomcat:${project.'cas.version'}@war"
    compile "org.apereo.cas:cas-server-some-module:${project.'cas.version'}"
    ...
}
```

## Build

```bash
gradlew clean build
```

## Deployment
- If you use `gradlew build`, gradle will copy [etc](etc/) folder to host machine.  
- or
- Create a keystore file `cas` under [/etc/keystore](/etc/keystore) on Linux. Use [C:/etc/keystore](/C:/etc/keystore) on Windows.
- Use the password `changeit` for both the keystore and the key/certificate entries.
- Ensure the keystore is loaded up with keys and certificates of the server.

On a successful deployment via the following methods, CAS will be available at:

* `https://server.name:10010/cas`


###### Example

Local server [https://localhost:10010/cas](https://localhost:10010/cas)

### Https Error

If you see this error on google chrome:

Your connection is not private

Attackers might be trying to steal your information from localhost (for example, passwords, messages, or credit cards). NET::ERR_CERT_COMMON_NAME_INVALID

* Browse this option  [chrome://flags/#allow-insecure-localhost](chrome://flags/#allow-insecure-localhost)

and enable.


## Executable WAR

Run the CAS web application as an executable WAR.

```bash
java -jar cas/build/libs/cas.war
```

##### Environment
`native` environment must be absolutely in spring.profiles.active variable.

If you use other environment, you must pass this variable to command
`--spring.profiles.active=native,qa`

###### Example 
<pre><code>
java -jar  cas/build/libs/cas.war --spring.profiles.active=native,qa
</code></pre>


### Or via Gradle:

```bash
# You need to check your project path into cas/build.gradle for this command
./gradlew[.bat] run
```

### Spring Boot

Run the CAS web application as an executable WAR via Spring Boot. This is most useful during development and testing.

```bash
./gradlew[.bat] bootrun
```

## External

Deploy resultant [cas/build/libs/](cas/build/libs/) to a servlet container of choice.


# Docker
### Build
You can build from docker-compose file.

<pre><code>
docker-compose build
</code></pre>
  
or 
  
<pre><code>
docker build -t mental/cas .
</code></pre>
  
### Run with compose
<pre><code>
docker-compose up
</code></pre>
##### Environment for compose
If you use other environment, you must change [docker-compose.yml](docker-compose.yml)
###### Example 
<pre><code>
    .
    .
    environment:
      SPRING_PROFILES_ACTIVE: native,qa
    .
    .
</code></pre>


### Run with command  
<pre><code>
docker run -d -p 10010:10010 mental/cas
</code></pre>

##### Environment for docker run
If you use other environment, you must pass this variable to command.
`-e SPRING_PROFILES_ACTIVE=native,qa`

###### Example 
<pre><code>
docker run -e SPRING_PROFILES_ACTIVE=native,qa -p 10010:10010 mental/cas
</code></pre>

