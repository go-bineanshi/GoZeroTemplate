import (
	"context"
	"github.com/go-bineanshi/CommonTool/gormc"
	{{if .containsDbSql}}"database/sql"{{end}}
	{{if .time}}"time"{{end}}

	"gorm.io/gorm"
)
