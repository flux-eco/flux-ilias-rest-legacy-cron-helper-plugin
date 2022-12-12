FROM php:8.2-cli-alpine AS build

RUN (mkdir -p /flux-php-backport && cd /flux-php-backport && wget -O - https://github.com/fluxfw/flux-php-backport/releases/download/v2022-12-12-2/flux-php-backport-v2022-12-12-2-build.tar.gz | tar -xz --strip-components=1)

COPY . /build/flux-ilias-rest-legacy-cron-helper-plugin

RUN /flux-php-backport/bin/php-backport.php /build/flux-ilias-rest-legacy-cron-helper-plugin FluxIliasRestApi\\Libs\\FluxLegacyEnum

FROM scratch

COPY --from=build /build /
