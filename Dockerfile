ARG JAVA_VERSION

FROM itzg/minecraft-server:${JAVA_VERSION} AS builder

ARG SERVER_TYPE
ARG MINECRAFT_VERSION
ARG IMPL_VERSION

ENV VERSION ${IMPL_VERSION:-$MINECRAFT_VERSION}
ENV TYPE ${SERVER_TYPE}

ENV EULA TRUE

COPY ./copy_server_jar.sh /
RUN /copy_server_jar.sh && rm /copy_server_jar.sh && touch -a -m -t 200001010000.00 /server.jar

FROM itzg/minecraft-server:${JAVA_VERSION} AS runner

COPY --from=builder /server.jar /server.jar

ENV CUSTOM_SERVER /server.jar
ENV VERSION ${IMPL_VERSION:-$MINECRAFT_VERSION}
ENV TYPE CUSTOM

ENV EULA TRUE
