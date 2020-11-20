package main

import (
	"fmt"
	"github.com/metal-stack/v"
)

func main() {
	fmt.Printf(" Version:\t%s\n Git commit:\t%s\n Built:\t\t%s\n ", v.Version, v.GitSHA1, v.BuildDate)
}
