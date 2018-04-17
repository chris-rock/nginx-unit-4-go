build/go:
	go build  -o hello hello.go

build/docker:
	docker build -t chris-rock/unit-go .