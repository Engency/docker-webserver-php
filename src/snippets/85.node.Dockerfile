####################################
#                                  #
#              Node                #
#                                  #
#     Install nvm / npm / node     #
#     node version: 14.15.1        #
#     nvm version: 0.37.2          #
#     npm version: 6.14.8          #
#                                  #
####################################

# nvm environment variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 14.15.1
ENV NVM_VERSION 0.37.2

# install nvm, node and npm
RUN mkdir $NVM_DIR \
     && curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v$NVM_VERSION/install.sh | bash \
     && /bin/bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION && nvm alias default $NODE_VERSION  && nvm use default"

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
