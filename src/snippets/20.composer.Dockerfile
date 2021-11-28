####################################
#                                  #
#            Composer              #
#                                  #
####################################

ENV COMPOSER_HOME /tmp
ENV COMPOSER_VERSION 2.1.12

RUN curl --silent --fail --location --retry 3 --output /tmp/installer.php --url https://raw.githubusercontent.com/composer/getcomposer.org/a5874d7ceecca18772d44ed19e7da5fd267ba0a4/web/installer \
     && php -r " \
        \$signature = 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a'; \
        \$hash = hash('sha384', file_get_contents('/tmp/installer.php')); \
        if (!hash_equals(\$signature, \$hash)) { \
            unlink('/tmp/installer.php'); \
            echo 'Integrity check failed, installer is either corrupt or worse.' . PHP_EOL; \
            exit(1); \
        }" \
     && php /tmp/installer.php --no-ansi --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION} \
     && composer --ansi --version --no-interaction \
     && rm -f /tmp/installer.php
