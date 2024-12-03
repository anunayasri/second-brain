# Programming Languages

// TODO
1. Compiled vs interpreted languages. 
    - Java is an interpreted language, like python.
    - Language spec vs it's compiler. C++, python has multiple compilers.
    - What is .pyc files in python if it is interpreted.
1. GCC and Clang. LLVM.
1. Compilers Crash Course
1. What is JIT?
1. Compiler optimisations.

**Choosing the right language can have massive effects**

Example of reducing infra cost by shifting from Ruby to Go.
[how-we-went-from-30-servers-to-2/](https://blog.iron.io/how-we-went-from-30-servers-to-2/)
They went from 30 prod servers to 2 servers. 💰

> After we rolled out our Go version, we reduced our server count to two and we
> really only had two for redundancy. They were barely utilized, it was almost
> as if nothing was running on them. Our CPU utilization was less than 5% and
> the entire process started up with only a few hundred KB's of memory (on
> startup) vs our Rails apps which were ~50MB (on startup).

!!! note
    Writing efficient code(code with mechanical sympathy) in any language will
    give higher performance benefits than shifting to a different language, ie 
    for the same functionality python code can run faster than the rust code.
