package main

import (
	"github.com/fatih/color"
	"github.com/gin-gonic/gin"
)

func main() {
	gin.SetMode(gin.ReleaseMode)
	r := gin.Default()

	r.GET("/", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "hello world",
		})
	})

	color.Green("Server started at --> http://0.0.0.0:8000/")
	r.Run(":8000")
}
