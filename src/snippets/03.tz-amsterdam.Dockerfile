####################################
#                                  #
#            Timezone              #
#                                  #
####################################

ARG TZ="Europe/Amsterdam"
RUN ln -sfn /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone
RUN echo "date.timezone=$TZ" > /usr/local/etc/php/conf.d/datetime.ini
