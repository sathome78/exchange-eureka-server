FROM java:8
VOLUME /tmp
ARG APP_PATH=/eureka
ARG ENVIRONMENT

RUN mkdir -p eureka
COPY ./target/eureka.jar ${APP_PATH}/eureka.jar
RUN echo ${ENVIRONMENT}
COPY ./target/config/${ENVIRONMENT}/application.yml ${APP_PATH}/application.yml

ARG CONFIG_FILE_PATH="-Dspring.config.location="${ENVIRONMENT}"/application.yml"

WORKDIR ${APP_PATH}

EXPOSE 8080
CMD java -jar eureka.jar CONFIG_FILE_PATH
