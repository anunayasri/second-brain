# Go Errors

1. Error are values. You are assign errors to variables, accept as function args and return from functions.
1. Error is an interface - Anything that implements the function func Error() string is an error.

Declare Errors using

```go
type NotFoundError struct {
    Name string
}

func (e *NotFoundError) Error() string { return e.Name + ": not found" }

// OR // 

err := fmt.Errorf("I am an error. %v", someVar)

// OR // 

err := errors.New("I am an error.")
```

## Comparing Errors 

```go
/* The errors.Is function compares an error to a value. */

// Similar to:
//   if err == ErrNotFound { … }
if errors.Is(err, ErrNotFound) { ... }

/* The As function tests whether an error is a specific type. */

// Similar to:
//   if e, ok := err.(*QueryError); ok { … }
var e *QueryError
// Note: *QueryError is the type of the error.
if errors.As(err, &e) { /* err is a *QueryError, and e is set to the error's value */ }
```

Wrapping Errors 

```go
if err != nil {
   // Return an error which unwraps to err.
   return fmt.Errorf("decompress %v: %w", name, err)
}
...
if errors.Is(err, ErrPermission) {...}
```

## Defer, Panic & Recover 

```go
package main

import "fmt"

func main() {
    f()
    fmt.Println("Returned normally from f.")
}

func f() {
    defer func() {
        if r := recover(); r != nil {
            fmt.Println("Recovered in f", r)
        }
    }()
    fmt.Println("Calling g.")
    g(0)
    fmt.Println("Returned normally from g.")
}

func g(i int) {
    if i > 3 {
        fmt.Println("Panicking!")
        panic(fmt.Sprintf("%v", i))
    }
    defer fmt.Println("Defer in g", i)
    fmt.Println("Printing in g", i)
    g(i + 1)
}
```

## References

1. [Panic Handling in json built-in pkg](https://github.com/golang/go/blob/master/src/encoding/json/encode.go#L284)
1. [Errors are values - The Go Programming Language](https://go.dev/blog/errors-are-values)
1. [Working with Errors in Go 1.13 - The Go Programming Language](https://go.dev/blog/go1.13-errors)
1. [Don’t just check errors, handle them gracefully](https://dave.cheney.net/2016/04/27/dont-just-check-errors-handle-them-gracefully)
1. [GopherCon 2016:  Dave Cheney - Dont Just Check Errors Handle Them Gracefully](https://www.youtube.com/watch?v=lsBF58Q-DnY)

