package main

import (
    "fmt"
    "net/http"
    "os/exec"
    "log"
    "github.com/aws/aws-sdk-go/aws/client"
    "github.com/aws/aws-sdk-go/aws/session"
    "github.com/aws/aws-sdk-go/aws/ec2metadata"
)

type EC2Metadata struct {
   *client.Client
}

func handler(w http.ResponseWriter, r *http.Request) {
    out, err := exec.Command("/bin/hostname", "-f").Output()
    if err != nil {
        log.Fatal(err)
    }
    sess, err := session.NewSession()
    svc := ec2metadata.New(sess)
    resp, err := svc.GetMetadata("ami-id")
    if err != nil {
	    fmt.Println(err)
	    return
    }
    fmt.Fprintf(w, "AWS EC2 instance: %s", out)
    fmt.Fprintf(w, "AWS AMI: %s", resp)
}

func main() {
    http.HandleFunc("/", handler)
    http.ListenAndServe(":8000", nil)
}
