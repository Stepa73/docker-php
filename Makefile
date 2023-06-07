build:
	docker buildx build --platform linux/amd64,linux/arm64 --push -t gazimazi/php82:$(v) .
