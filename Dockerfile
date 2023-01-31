FROM php:8.2-cli-alpine AS build

COPY bin/install-libraries.sh /build/flux-ilias-rest-legacy-cron-helper-plugin-build/libs/flux-ilias-rest-legacy-cron-helper-plugin/bin/install-libraries.sh
RUN /build/flux-ilias-rest-legacy-cron-helper-plugin-build/libs/flux-ilias-rest-legacy-cron-helper-plugin/bin/install-libraries.sh

COPY . /build/flux-ilias-rest-legacy-cron-helper-plugin-build/libs/flux-ilias-rest-legacy-cron-helper-plugin

RUN /build/flux-ilias-rest-legacy-cron-helper-plugin-build/libs/flux-ilias-rest-legacy-cron-helper-plugin/bin/php-backport.sh

RUN cp -L -R /build/flux-ilias-rest-legacy-cron-helper-plugin-build/libs/flux-ilias-rest-legacy-cron-helper-plugin /build/flux-ilias-rest-legacy-cron-helper-plugin && rm -rf /build/flux-ilias-rest-legacy-cron-helper-plugin/bin && rm -rf /build/flux-ilias-rest-legacy-cron-helper-plugin-build

FROM scratch

COPY --from=build /build /
