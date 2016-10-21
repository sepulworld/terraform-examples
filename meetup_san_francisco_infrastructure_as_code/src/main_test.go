package main

import (
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestLoadPage(t *testing.T) {
	// Create a request to pass to our the main.handler
	req, err := http.NewRequest("GET", "/", nil)
	if err != nil {
		t.Fatal(err)
	}

	// Create a ResponseRecorder to record the response of the handler
	rr := httptest.NewRecorder()
	handler := http.HandlerFunc(handler)

	// send the reqest and response recorder to the handler and run it.
	handler.ServeHTTP(rr, req)

	// Check the status code is what we expect.
	if status := rr.Code; status != http.StatusOK {
		t.Errorf("handler returned wrong status code: got %v want %v",
			status, http.StatusOK)
	}

}
