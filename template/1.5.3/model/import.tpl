import (
	"context"
	"fmt"
	{{if .time}}"time"{{end}}
	{{if .containsDbSql}}"database/sql"{{end}}
	"gogs.al8l.com/bineanshi/mwhale-common/gormc"
	"github.com/zeromicro/go-zero/core/stores/cache"
	"gorm.io/gorm"
)
