# CONTRIBUTING

## Testing

### Unit Tests

Standard go tests are considered to be unit tests.

Execute unit tests with: `make unit-tests`, or together with integration tests via: `make test` or `make
tests`.

### Integration Tests

Convention:

1. Test name ends with `_integration`.
1. Contains a condition to skip when unit tests are executed.

Example:

```go
// Test_xxx_integration verifies function xxx is working as expected.
func Test_xxx_integration(t *testing.T) {
    if testing.Short() {
        t.Skip("skipping integration test")
    }
    // TODO Write Test.
}
```

Execute integration tests with: `make integration-tests`, or together with unit tests via: `make test` or `make tests`.