# Python Recipes

## Using `f-strings`

Evaluate expressions inside f-strings.

```py 
x = 10
y = 5
print(f"The sum of {x} and {y} is {x + y}.")

# The sum of 10 and 5 is 15.
```

### String Allignment and Padding 

```py
# `name` will be alligned in a space of 10 chars
# if the value of `name` is greater than 10 chars, all the chars will be printed

# Example 1: Left-align text
name = "Alice"
print(f": {name:<10} :")

# Example 2: Center-align text
name = "Bob"
print(f": {name:^10} :")

# Example 3: Right-align text
name = "Charlie"
print(f": {name:>10} :")

name = "VeryLoooooongName"
print(f": {name:>10} :")
```

```
: Alice      :
:    Bob     :
:    Charlie :
: VeryLoooooongName :
```

#### Print headers

```py
billion = 10**9
# pads the space with the char mentioned before the alignment symbol
# pads with `=`
print(f"{' Start ':=^80}")
print(f"""This is a multiline fstring:
Billion: {billion:_}
Billion: {billion:,}
Billion: {billion:e}
	I can even preserve formatting.
		Like in this line and above.
""")
print(f"{' End ':=^80}")
```

```
==================================== Start =====================================
This is a multiline fstring:
Billion: 1_000_000_000
Billion: 1,000,000,000
Billion: 1.000000e+09
        I can even preserve formatting.
                Like in this line and above.

===================================== End ======================================
```

#### Print expressions and their values

This can be very useful in print values to logs

```py
a, b = 10, 20
print(f"{a + b = }")
print(f"{bool(a) = }")

# a + b = 30
# bool(a) = True

```

### Format numbers

```py
import math

print(f"Value of Pi: {math.pi}")

# Round the number to 2 decimal places
formatted_float = f"Rounded: {math.pi:.2f}"
print(formatted_float)

# Round the number to the nearest integer
formatted_integer = f"Integer: {math.pi:.0f}"
print(formatted_integer)

# Format the number as a percentage with no decimal places
formatted_percentage = f"Percentage: {math.pi:.0%}"
print(formatted_percentage)

# Format the number in scientific notation with 3 decimal places
formatted_scientific = f"Scientific: {math.pi:.3e}"
print(formatted_scientific)

# Format the number in general format with 4 significant digits
formatted_general = f"General: {math.pi:.4g}"
print(formatted_general)

# Format an integer as a hexadecimal number with a minimum width of 8
integer_value = 255
formatted_hex = f"Hexadecimal: {integer_value:#0{8}x}"
print(formatted_hex)

# Format an integer as a binary number with a minimum width of 8
formatted_binary = f"Binary: {integer_value:#0{8}b}"
print(formatted_binary)

n = 1234.5678
print(f"Formatted integer: {n:,.3f}")
```

```
Value of Pi: 3.141592653589793
Rounded: 3.14
Integer: 3
Percentage: 314%
Scientific: 3.142e+00
General: 3.142
Hexadecimal: 0x0000ff
Binary: 0b11111111

```

### Formatting Date and Time

[Datetime formatting directives](https://docs.python.org/3/library/datetime.html#strftime-and-strptime-format-codes)
mentioned in python docs.

```py
from datetime import datetime

now = datetime.now()

print(f"now: {now:%d-%m-%y (%H:%M:%S)}")
# %c : Locale’s appropriate date and time representation
print(f"now: {now:%c}")
```

```
now: 11-09-24 (13:51:03)
now: Wed Sep 11 13:51:03 2024
```

