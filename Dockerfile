# payara-maven3-centos
#
# This image provide a base for running Payara based applications. It
# provides a base Java 8 installation and Maven 3.

FROM payara/server-full

# Add configuration files, bashrc and other tweaks
COPY ./s2i/bin/ $STI_SCRIPTS_PATH

# Set the default CMD to print the usage of the language image
CMD $STI_SCRIPTS_PATH/usage