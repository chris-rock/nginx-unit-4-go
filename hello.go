package main

import (
	"net/http"
	"nginx/unit"
)

func sayHello(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Hello World"))
}

func main() {
	http.HandleFunc("/", sayHello)

	// instead of http.ListenAndServe(":8080", nil)
	if err := unit.ListenAndServe(":8080", nil); err != nil {
		panic(err)
	}
}
