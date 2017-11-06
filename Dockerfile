# payara-maven3-centos
#
# This image provide a base for running Payara based applications. It
# provides a base Java 8 installation and Maven 3.

FROM payara/server-full


ENV STI_SCRIPTS_PATH="/usr/local/s2i"
ENV PAYARA_ARCHIVE payara41
ENV DOMAIN_NAME domain1
ENV INSTALL_DIR /opt
ENV PAYARA_HOME ${INSTALL_DIR}/payara41/glassfish
ENV DEPLOYMENT_DIR ${INSTALL_DIR}/deploy

#LABEL io.openshift.s2i.scripts-url=image:///usr/local/s2i

RUN useradd -b /opt -m -s /bin/sh -d ${INSTALL_DIR} serveradmin && echo serveradmin:serveradmin | chpasswd

# Add configuration files, bashrc and other tweaks
COPY ./s2i/bin/ $STI_SCRIPTS_PATH

# Set the default CMD to print the usage of the language image
CMD $STI_SCRIPTS_PATH/usage

RUN mkdir ${DEPLOYMENT_DIR}
WORKDIR ${PAYARA_HOME}/bin
ADD start.sh .
RUN chmod a+x start.sh
ENTRYPOINT start.sh
USER serveradmin
EXPOSE 4848 8009 8080 8181

