package main

import (
    "bytes"
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
    Ami      string
    Body     []byte
    Hostname string 
}

func loadPage(filename string) (*Page, error) {
    //filename := "index.html"
    cmd := exec.Command("/bin/hostname", "-f")
    var out bytes.Buffer
    cmd.Stdout = &out
    err := cmd.Run()
    if err != nil {
        log.Fatal(err)
    }
    body, err := ioutil.ReadFile(filename)
    if err != nil {
        return nil, err
    }
    return &Page{Body: body, Hostname: out.String()}, nil
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
}

func main() {
    http.HandleFunc("/", handler)
    http.ListenAndServe(":8000", nil)
}
