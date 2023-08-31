build-php82:
	docker buildx build --platform linux/amd64,linux/arm64 --push -t gazimazi/php82:$(v) php82
build-php80:
	docker buildx build --platform linux/amd64,linux/arm64 --push -t gazimazi/php80:$(v) php80
build-php80-apache:
	docker build --push -t gazimazi/php:80-apache php80/apache
