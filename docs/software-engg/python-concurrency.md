# Python Concurrency (Multi-threading concepts)

Concepts to consider:

1. inter-thread communication: group of threads talk to each other to manage work
2. thread synchronization: only one thread should at a time
3. error handling in threads
4. i/o is shared in threads? ie all threads print to the same stdout stream?

Java has wait() and notifyAll() to enable multi-threaded problems

In computer systems, synchronization is a little more general; it refers to
relationships among events—any number of events, and any kind of relationship
(before, during, after). Eg.

1. Serialization: Event A must happen before Event B.
2. Mutual exclusion: Events A and B must not happen at the same time.

When sync problem exists?

1. Mutli threads on a single processor 
2. Multi threads(processes) on a multiple cores.

For the purpose of sync problems, both cases are same.

2 threads can serailize events by `Message Passing`. Eg.

```
Thread A (You)
1 Eat breakfast 1
2 Work 2
3 Eat lunch 3
4 Call Bob

Thread B (Bob)
1 Eat breakfast 
2 Wait for a call 
3 Eat lunch
```

Thread B waits at B.2 for a msg from Thread A.

Note: In this case, we would say that you and Bob ate lunch sequentially, because
we know the order of events, and you ate breakfast concurrently, because we don’t.

> Two events are concurrent if we cannot tell by looking at the program which
> will happen first.

Concurrent programs are often non-deterministic, which means it is not possible
to tell, by looking at the program, what will happen when it executes.

Non-determinism is one of the things that makes concurrent programs hard to
debug. A program might work correctly 1000 times in a row, and then crash on
the 1001st run, depending on the particular decisions of the scheduler. 
These kinds of bugs are almost impossible to find by testing; they can only be
avoided by careful programming.

Problem of synchronization occurs when multiple threads try to access a shared 
resource(memory location). Access patterns can be -

1. Concurrent reads: Safe as data is not changed.
2. Concurrent writes: Eg. 

    ```python
    # what is the final value of x? What value gets printed?
    Th A
    x = 5
    print(x)

    Th B
    x = 7
    ```
3. Concurrent updates:

    ```python
    Th A
    count = count + 1

    Th B
    count = count + 1
    ```
    This increment is not atomic. Infact, it generates two instructions -
    ```
    temp = count
    count = temp + 1
    ```

    The thread can be interrupted between these two instructions.

There can be multiple patterns in synchronization of threads. We will explore 
them later.

## Solving Synchronization Problems

Synchronization problems can be solved if threads can talk to each other. This 
is called `message passing`. Operating System provide a simple data structure 
called `Semaphore` to enable message passing b/w threads.

> In real life a semaphore is a system of signals used to communicate visually,
> usually with flags, lights, or some other mechanism.

A semaphore is like an integer, with three differences:

1. When you create the semaphore, you can initialize its value to any integer,
   but after that the only operations you are allowed to perform are increment
   (increase by one) and decrement (decrease by one). You cannot read the
   current value of the semaphore.

2. When a thread decrements the semaphore, if the result is negative, the
   thread blocks itself and cannot continue until another thread increments the
   semaphore.

3. When a thread increments the semaphore, if there are other threads wait-
   ing, one of the waiting threads gets unblocked.

In most programming environments, an implementation of semaphores is avail-
able as part of the programming language or the operating system. Different
implementations sometimes offer slightly different capabilities, and usually
re- quire different syntax.

In this text, I will use a simple pseudo-language to demonstrate how semaphores
work. 

```
sem = Semaphore(1)

# apis to work with semaphores 
sem.increment()
sem.decrement()

# another name of these actions 
sem.signal()
sem.wait()

# in python 
# python thinks a sem as a 'lock'
# Threads waits until it will acquire a lock 
# Thread releases a lock when the task is complete 
# Thread can release a lock even before acquiting it.
sem.release()
sem.acquire()
```

In a multi-threaded program, the sequence of statments executed by a program
in a single execution flow is called `execution path`. Each run of the 
program will, probably, follow a different execution path.


## Basic Synchronization Patterns 

### 1. Signalling 

Solves `serialization` problem: Guarantees that a section of code in one thread
will run before a section of code in another thread

```
# Guarantees that statement 1 in Th A runs before 
sem = Semaphore(0)

# Th A
statement 1
sem.signal()

Th B
sem.wait()
statement 2
```

### 2. Rendezvous

Two threads have to wait for each other to reach a common point in the 
execution path.

> This is also a serialization problem.

```
# Th A
statement a1
-- rendezvous point
statement a2

# Th B
statement b1
-- rendezvous point
statement b2
```

ie a1 and b1 both should complete, then a2 and b2 will start concurrently.
Note, a1 & b1 are executed concurrently. a2 & b2 are executed concurrently.

```
aArrived = Semaphore(0)
bArrived = Semaphore(0)

# Th A
statement a1
aArrived.signal()
bArrived.wait()
statement a2

# Th B
statement b1
bArrived.signal()
aArrived.wait()
statement b2
```

### 3. Mutual Exclusion (Mutex)

The mutex guarantees that only one thread accesses the shared variable at a
time.

A mutex is like a token that passes from one thread to another, allowing one
thread at a time to proceed.

`mutex` is a semaphore that is initialized to `1`, which means that at most a 
single thread can access the variable.
mutex can guard a piece of code, called as `critical section`, against
synchronization problems.

```
mutex = Semaphore(1)

# threaded code
mutex.wait()
    # critical section 
mutext.signal()
```

There are several other ways people sometimes talk about mutexes. In the
metaphor we have been using so far, the mutex is a token that is passed from
one thread to another.

In an alternative metaphor, we think of the critical section as a room, and
only one thread is allowed to be in the room at a time. In this metaphor,
mutexes are called 'locks', and a thread is said to lock the mutex before
entering and unlock it while exiting.

### 4. Multiplex

What if we want multiple threads to execute the critical section. Of course,
we want an upper limit on the number of threads running concurrently.

This pattern is called `multiplex`.

To allow multiple threads to run in the critical section, just initialize the
semaphore to n, which is the maximum number of threads that should be allowed.

At any time, the value of the semaphore represents the number of additional
threads that may enter. If the value is zero, then the next thread will block
until one of the threads inside exits and signals. When all threads have
exited the value of the semaphore is restored to n.

```
multiplex = Semaphore(n)

# threaded code
multiplex.wait()
    # critical section
multiplex.signal()
```


Thinking again of metaphors, in this case I find it useful to think of the
semaphore as a set of tokens (rather than a lock). As each thread invokes
wait, it picks up one of the tokens; when it invokes signal it releases one.
Only a thread that holds a token can enter the room. If no tokens are
available when a thread arrives, it waits until another thread releases one.

### Barrier

Consider the 'rendezvous' pattern above. It was shown for only two threads.
The limitation is that to solve it one thread should be aware of other threads.

How to enable rendezvous pattern for multiple threads?

This is called `Barrier`. Each running threads stops at the barrier, and waits
until all threads reach the rendezvous point.

```
mutex = Semaphore(1)
barrier = Semaphore(0)
count = 0

threaded code

rendezvous

# make count thread safe
mutex.wait()
    count = count + 1
mutex.signal()

if count == n: barrier.signal()

# block the threads
barrier.wait()
# once the condition of count == n is met, signal the waiting 
# threads to move ahead
barrier.signal()

critical poiont
```

This pattern, a `wait` and a `signal` in rapid succession, occurs often enough
that it has a name; it’s called a `turnstile`, because it allows one thread to
pass at a time, and it can be locked to bar all threads.

In its initial state (zero), the turnstile is locked. The nth thread unlocks
it and then all n threads go through.

## Classical Synchronization Problems 

> For a multi-threaded problem define the synchronization constraints first.
> It will help to define the kinds of semaphores and the critical sections.

### Producer Consumer Problem

### Readers Writers Problem

Pertains to any situation where a data structure, database, or file system is
read and modified by concurrent threads.

The synchronization constraints are:
1. Any number of readers can be in the critical section simultaneously. 
2. Writers must have exclusive access to the critical section.

### Note of Starvation of Mutex

For most concurrent applications, starvation is unacceptable, so we enforce the
requirement of `bounded waiting`, which means that the time a thread waits on a
semaphore (or anywhere else, for that matter) has to be provably finite.

In part, *starvation is the responsibility of the scheduler*. Whenever multiple
threads are ready to run, the scheduler decides which one or, on a parallel
processor, which set of threads gets to run. If a thread is never scheduled,
then it will starve, no matter what we do with semaphores.

So in order to say anything about starvation, we have to start with some
assumptions about the scheduler. If we are willing to make a strong assumption,
we can assume that the scheduler uses one of the many algorithms that can be
proven to enforce bounded waiting. If we don’t know what algorithm the
scheduler uses, then we can get by with a weaker assumption:

Property 1: if there is only one thread that is ready to run, the scheduler has
to let it run.

Property 2: if a thread is ready to run, then the time it waits until it runs
is bounded.

Property 3: if there are threads waiting on a semaphore when a thread executes
signal, then one of the waiting threads has to be woken.

Property 4: if a thread is waiting at a semaphore, then the number of threads
that will be woken before it is bounded.

A semaphore that has Property 4 is sometimes called a `strong semaphore`; one
that has only Property 3 is called a `weak semaphore`. 

With weak semaphores, the simple mutex solution is vulnerable to starvation.

### Dining Philosophers

> It's old! The Dining Philosophers Problem was proposed by Dijkstra in 1965. 
A table with five plates, five forks (or chopsticks) and a big bowl of
spaghetti. Five philosophers, who represent interacting threads, come to the
table and execute the following loop:

```python
while True: 
    think()
    get_forks() 
    eat() 
    put_forks()
```

The forks represent resources that the threads have to hold exclusively in
order to make progress. The philosophers need two forks to eat, so a hungry
philosopher might have to wait for a neighbor to put down a fork.

Assuming that the philosophers know how to think and eat, our job is to write a
version of get forks and put forks that satisfies the following constraints:

• Only one philosopher can hold a fork at a time.
• It must be impossible for a deadlock to occur.
• It must be impossible for a philosopher to starve waiting for a fork.
• It must be possible for more than one philosopher to eat at the same time.

#### Solution 1

If 4 philosophers are trying to compete for the 5 forks, deadlock is impossible.

Proof: If each philosopher takes a fork, there is one extra fork left. This fork
can be used by any of it's two neighbors. Hence, no deadlock.

```python
# left and right forks of ith philosopher
def left(i):
    return i+1

def right(i):
    return i

# Forks that be used by only one thread
forks = [Semaphore(1) for _ in range(5)]

# limit the philosophers at the table using a multiplex
multiplex = Semaphore(4)

def get_forks(i):
    multiplex.wait()  # the last thread will wait here

    forks[left(i)].wait()
    forks[right(i)].wait()

def put_forks(i):
    forks[left(i)].signal()
    forks[right(i)].signal()

    multiplex.signal() # let the waiting thread join the table and make another
                       # thread wait at the multiplex
```

This will also prevent starvation. Why? 

We assume that we are using a `strong semaphore` which has `Property 4` mentioned
above. Hence, the waiting thread will eventually get the resource.

#### Solution 2

Can the order of picking the forks prevent deadlock?

What are the conditions of a deadlock in this case?

The only deadlock condition: Each philosopher picks up the fork on the left and 
is waiting for the right fork to be available(or vice versa). This can be easily
proved via contradiction.

If we break this condition, this can help avoiding deadlock. How?

If the philosophers have at least one leftie and at least one rightie,
deadlock is impossible.

```python 
def get_forks(i):
    if i % 2 == 0:
        forks[left(i)].wait()
        forks[right(i)].wait()
    else:
        # invert the locking order
        forks[right(i)].wait()
        forks[left(i)].wait()

def put_forks(i):
    forks[left(i)].signal()
    forks[right(i)].signal()
```


## Concurrency vs Parallelism

Concurrency: 
* Two tasks are being executed, even on a single core, simultaneously ie they are
    overlapping each other. 
* CPU executes the instructions from one tasks and then
    swaps it with another task. 
*However, at an instant CPU can execute only one task.
    Here task can different processes or different threads.

Parallelism:
* Concept of a machine having multiple cores.
* Multiple processes(1 process per core) is executed parallely in real time.


## References

1. https://leetcode.com/tag/concurrency/
2. Little Book of Semaphores by Allen B Downey [link](https://greenteapress.com/semaphores/LittleBookOfSemaphores.pdf)
