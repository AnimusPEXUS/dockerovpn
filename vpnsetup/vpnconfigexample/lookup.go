package main

import "net"
import "fmt"
import "os"

func main() {
	names, err := net.LookupHost("google.com")
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	fmt.Println(names[0])
}
