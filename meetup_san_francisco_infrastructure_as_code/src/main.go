package main

import (
    "fmt"
    "net/http"
    "os/exec"
    "log"
)

func handler(w http.ResponseWriter, r *http.Request) {
    out, err := exec.Command("/bin/hostname", "-f").Output()
    if err != nil {
        log.Fatal(err)
    }
    fmt.Fprintf(w, "AWS EC2 instance: %s", out)
}

func main() {
    http.HandleFunc("/", handler)
    http.ListenAndServe(":8000", nil)
}
