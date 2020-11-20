####################################
#                                  #
#     Install Dutch Language       #
#                                  #
####################################

RUN apt-get update && apt-get install -y locales

# enable localisation and generates localisation files
RUN sed -i -e 's/# nl_NL.UTF-8 UTF-8/nl_NL.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
