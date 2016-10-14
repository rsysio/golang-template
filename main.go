package main

import "fmt"

var (
	Version string
	Build   string
	GitHash string
)

//export PrintVersion
func PrintVersion() {
	fmt.Println("---------------------------------------------------")
	fmt.Printf("Version: %s\n", Version)
	fmt.Printf("Build: %s\n", Build)
	fmt.Printf("GitHash: %s\n", GitHash)
	fmt.Println("---------------------------------------------------")
}

func main() {
	fmt.Println("golang template")
}
