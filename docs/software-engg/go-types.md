# Go Types

"Regardless of the language, type touches every aspect of programming syntax. A
good understand of types and pointers is critical to good programming." - Bill 

Type provides 2 important info that is imp for the programmer and the compiler.

1. The amount of memory, in bytes, to look at
2. The representation of those bytes

The Go language provides these basic numeric types:

```
Unsigned Integers
uint8, uint16, uint32, uint64

Signed Integers
int8, int16, int32, int64

Real Numbers
float32, float64

Predeclared Integers
uint, int, uintptr
```

The uint8 contains a base 10 number using one byte of memory. The value can be between 0 to 255.

The int32 contains a base 10 number using 4 bytes of memory. The value can be between -2147483648 to 2147483647.
ie 1st bit is for sign notation(+/-), rest 31 bits give the number value. -2^31 .. 0 .. (2^31-1)

The predeclared integers get mapped based on the architecture you are building
the code against. On a 64 bit OS, int will map to int64 and on a 32 bit OS, it
will be mapped to int32.

> Go uses IEEE 754 standard for presenting floats.

To determine the size of a variable use `unsafe.SizeOf()`. Eg. 
```go
type Example struct {
    BoolValue bool
    IntValue int16
    FloatValue float32
}

e := Example{
    BoolValue:  true,
    IntValue:   10,
    FloatValue: 3.141592,
}

fmt.Println(unsafe.SizeOf(e.BoolValue))     // 1. Bool = 1 byte
fmt.Println(unsafe.SizeOf(e)    // 8. 1+2+4+padding
// Read about Allignment boundary to know about padding
```

**We can only manipulate memory when we are working with a numeric type and the
assignment operator (=) is how we do it.** 
To make life easier for us, Go has created some complex types that support the
assignment operator directly. Some of these types are strings, arrays and
slices. These complex types abstract the manipulation of the underlining
numeric types that can be found in each implementation. 


## Numeric Types 

```
uint8       the set of all unsigned  8-bit integers (0 to 255)
uint16      the set of all unsigned 16-bit integers (0 to 65535)
uint32      the set of all unsigned 32-bit integers (0 to 4294967295)
uint64      the set of all unsigned 64-bit integers (0 to 18446744073709551615)

int8        the set of all signed  8-bit integers (-128 to 127)
int16       the set of all signed 16-bit integers (-32768 to 32767)
int32       the set of all signed 32-bit integers (-2147483648 to 2147483647)
int64       the set of all signed 64-bit integers (-9223372036854775808 to 9223372036854775807)

float32     the set of all IEEE-754 32-bit floating-point numbers
float64     the set of all IEEE-754 64-bit floating-point numbers

complex64   the set of all complex numbers with float32 real and imaginary parts
complex128  the set of all complex numbers with float64 real and imaginary parts

byte        alias for uint8
rune        alias for int32Ext
```

## Defined Type

The new type is called a *defined type*. It is different from any other type,
including the type it is created from.
Eg. `type Number int` (Number is composed from int)


> Go compiler does NOT cast the variables unless you explicitly ask it

```go
type int32Ext int32

func main() {
    // Cast the number 10 to a value of type Jill
    // The compiler allows the value to be assigned because the numeric type
    // is on the right side of the assignment operator. The compiler knows the
    // assignment is safe.
    var jill int32Ext = 10

    // Assign the value of jill to jack
    // ** cannot use jill (type int32Ext) as type int32 in assignment **
    // The compiler respects that jill is of type int32Ext and makes no
    // assumptions about the safeness of the assignment.
    var jack int32 = jill       // Implicit casting doesn't work even thought the memory layout is same.

    // Assign the value of jill to jack by casting
    // ** the compiler is happy **
    var jack int32 = int32(jill)    // Explicit casting

    fmt.Printf("%d\n", jack)
}
```
## Composite Types 

Composite types—
1. array
2. struct
3. pointer
4. function
5. interface
6. slice
7. map
8. channel
—may be constructed using type literals.

### Overflow Error

```go
package main

import "fmt"

func main() {

   // initializing with the maximum allowed negative decimal value
   var num float32 = -3.4E+38

   // printing the value and data type 
   fmt.Printf("Value is: %f and type is: %T\n", num, num);   

   // making the value out of range by multiply by +/-10 
   var num_n float32 = num*10
   var num_p float32 = num*-10

   // printing out new value and type
   fmt.Printf("Value is: %f and type is: %T\n", num_n, num_n);
   fmt.Printf("Value is: %f and type is: %T\n", num_p, num_p);   

}
```

### Floating Point Error(in calculation)

```go
// float64 
var n float64 = 0
for i := 0; i < 10; i++ {
   n += 0.1
}
fmt.Println(n)      // 0.9999999999999999
println(n == 1)     // false

// float32
var n float32 = 0
for i := 0; i < 10; i++ {
   n += 0.1
}
fmt.Println(n)      // 1.0000001
println(n == 1)     // false
```

> Solution: Use decimal.Decimal to avoid floating point errors.

https://docs.python.org/3/tutorial/floatingpoint.html


