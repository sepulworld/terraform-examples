package main

import (
    "html/template"
    "net/http"
    "io/ioutil"
    "os/exec"
    "log"
    "github.com/aws/aws-sdk-go/aws/client"
    "github.com/aws/aws-sdk-go/aws/session"
    "github.com/aws/aws-sdk-go/aws/ec2metadata"
)

type EC2Metadata struct {
   *client.Client
}

type Page struct {
    Ami string
    Body  []byte
    Hostname []byte 
}

func loadPage(title string) (*Page, error) {
    filename := title + ".html"
    hostname, err := exec.Command("/bin/hostname", "-f").Output()
    if err != nil {
        log.Fatal(err)
    }
    body, err := ioutil.ReadFile(filename)
    if err != nil {
        return nil, err
    }
    return &Page{Ami: title, Body: body, Hostname: hostname}, nil
}

func handler(w http.ResponseWriter, r *http.Request) {
    sess, err := session.NewSession()
    svc := ec2metadata.New(sess)
    ami, err := svc.GetMetadata("ami-id")
    p, err := loadPage("index.html")
    if err != nil {
	    p = &Page{Ami: ami}
    }
    t, _ := template.ParseFiles("index.html")
    t.Execute(w, p)
    //fmt.Fprintf(w, "AWS EC2 instance: %s", hostname)
    //fmt.Fprintf(w, "AWS AMI: %s", ami)
}

func main() {
    http.HandleFunc("/", handler)
    http.ListenAndServe(":8000", nil)
}
