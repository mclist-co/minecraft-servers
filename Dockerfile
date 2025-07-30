ARG JAVA_VERSION

FROM itzg/minecraft-server:${JAVA_VERSION} AS builder

ARG SERVER_TYPE
ARG MINECRAFT_VERSION

ENV VERSION=$MINECRAFT_VERSION
ENV TYPE=${SERVER_TYPE}

ENV EULA=TRUE

RUN curl -o /BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

COPY ./copy_server_jar.sh /
RUN /copy_server_jar.sh
RUN touch -a -m -t 200001010000.00 /server.jar

FROM itzg/minecraft-server:${JAVA_VERSION} AS runner

# only needed to set the version of the custom server
ARG MINECRAFT_VERSION

COPY --from=builder /server.jar /server.jar

ENV CUSTOM_SERVER=/server.jar
ENV VERSION=$MINECRAFT_VERSION
ENV TYPE=CUSTOM

ENV EULA=TRUE
