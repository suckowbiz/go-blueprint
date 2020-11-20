# go-blueprint

This repository contains files and directories to set up a new golang project. It already has configuration in place
to:

- support `go mod`
- separate unit from integration tests: `make unit-tests`, `make integration-tess` (See `./CONTRIBUTE.md`)
- build the go binary: `make binary`
- apply maintenance and quality checks: `make lint`, `make update-check`