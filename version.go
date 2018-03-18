package main

import (
	"fmt"
)

// Version of project
var (
	Version = "0.1.0"
)

func getVersion() string {
	return fmt.Sprintf("Version: %v\n", Version)
}
