# Go Concurrency

## Data Races

```go
// Sample program to show how to create race conditions in
// our programs. We don't want to do this.
package main

import (
	"fmt"
	"sync"
)

// counter is a variable incremented by all goroutines.
var counter int

func main() {

	// Number of goroutines to use.
	const grs = 2

	// wg is used to manage concurrency.
	var wg sync.WaitGroup
	wg.Add(grs)

	// Create two goroutines.
	for g := 0; g < grs; g++ {
		go func() {
			for i := 0; i < 2; i++ {

				// Capture the value of Counter.
				value := counter

				// Increment our local value of Counter.
				value++

				// fmt.Println(value)

				// Store the value back into Counter.
				counter = value
			}

			wg.Done()
		}()
	}

	// Wait for the goroutines to finish.
	wg.Wait()
	fmt.Println("Final Counter:", counter)
}
```

```
- Build and run. Output?
- Uncomment line 33. Build and run.
- GOMAXPROCS=1 ./example1  # Run on single core
- GOMAXPROCS=2 ./example1  # Run on two cores
- go build -race
  ./example1
```

Atomic 

```go
package main

import (
	"fmt"
	"sync"
	"sync/atomic"
)

// counter is a variable incremented by all goroutines.
var counter int64

func main() {

	// Number of goroutines to use.
	const grs = 2

	// wg is used to manage concurrency.
	var wg sync.WaitGroup
	wg.Add(grs)

	// Create two goroutines.
	for g := 0; g < grs; g++ {
		go func() {
			for i := 0; i < 2; i++ {
				atomic.AddInt64(&counter, 1)
				fmt.Println(counter)
			}

			wg.Done()
		}()
	}

	// Wait for the goroutines to finish.
	wg.Wait()

	// Display the final value.
	fmt.Println("Final Counter:", counter)
}
```

Mutexes

```go
package main

import (
	"fmt"
	"sync"
)

// counter is a variable incremented by all goroutines.
var counter int

// mutex is used to define a critical section of code.
var mutex sync.Mutex

func main() {

	// Number of goroutines to use.
	const grs = 2

	// wg is used to manage concurrency.
	var wg sync.WaitGroup
	wg.Add(grs)

	// Create two goroutines.
	for g := 0; g < grs; g++ {
		go func() {
			for i := 0; i < 2; i++ {

				// Only allow one goroutine through this critical section at a time.
				mutex.Lock()
				{
					// Capture the value of counter.
					value := counter

					// Increment our local value of counter.
					value++

					// Store the value back into counter.
					counter = value
				}
				mutex.Unlock()
				// Release the lock and allow any waiting goroutine through.
			}

			wg.Done()
		}()
	}

	// Wait for the goroutines to finish.
	wg.Wait()
	fmt.Printf("Final Counter: %d\n", counter)
}
```

## Channels

Example of channels.

* Receive is blocked till it gets a msg.
* Send is blocked until the msg is received.
* Received is unblocked first(by nanosec) and then send is unblocked.
* Receive and send is atomic operation.
* The two Println statements can happen in any order.

```go
func process() {
	ch := make(chan string)

	go func() {
		d := <-ch
		fmt.Println("child : recv'd signal :", d)
	}()

	time.Sleep(time.Duration(rand.Intn(500)) * time.Millisecond)
	ch <- "data"
	fmt.Println("parent : sent signal")

	time.Sleep(time.Second)
	fmt.Println("-------------------------------------------------")
}
```

Example of Buffered Channel

```go
func process() {
	children := 20
    // Use a buffered channel
	ch := make(chan string, children)

	for c := 0; c < children; c++ {
		go func(child int) {
			time.Sleep(time.Duration(rand.Intn(200)) * time.Millisecond)
			ch <- "data"
			fmt.Println("child : sent signal :", child)
		}(c)
	}

	for children > 0 {
		d := <-ch
		children--
		fmt.Println(d)
		fmt.Println("parent : recv'd signal :", children)
	}

	time.Sleep(time.Second)
	fmt.Println("-------------------------------------------------")
}
```

## Concurrency Patterns

### Wait For Task

```go
// waitForTask: In this pattern, the parent goroutine sends a signal to a
// child goroutine waiting to be told what to do.
func waitForTask() {
	ch := make(chan string)

	go func() {
		d := <-ch
		fmt.Println("child : recv'd signal :", d)
	}()

	time.Sleep(time.Duration(rand.Intn(500)) * time.Millisecond)
	ch <- "data"
	fmt.Println("parent : sent signal")

	time.Sleep(time.Second)
	fmt.Println("-------------------------------------------------")
}
```

* Receiver is blocked.
* Sender is blocked until the signal is received by the receiver.
* ONLY atomic operation is the exchange of signal b/w sender and receiver.
* Receiver gets unblocked nanoseconds before the sender.
* The two Println statements can happen in any order.
* Eg. Used in pooling
	
### Wait for Result

```go
// waitForResult: In this pattern, the parent goroutine waits for the child
// goroutine to finish some work to signal the result.
func waitForResult() {
	ch := make(chan string)

	go func() {
		time.Sleep(time.Duration(rand.Intn(500)) * time.Millisecond)
		ch <- "data"
		fmt.Println("child : sent signal")
	}()

	d := <-ch
	fmt.Println("parent : recv'd signal :", d)

	time.Sleep(time.Second)
	fmt.Println("-------------------------------------------------")
}
```

* Opposite of Wait for Task 

### Pooling 

```go
// pooling: In this pattern, the parent goroutine signals 100 pieces of work
// to a pool of child goroutines waiting for work to perform.
func pooling() {
	ch := make(chan string)

	g := runtime.GOMAXPROCS(0)
	for c := 0; c < g; c++ {
		go func(child int) {
			for d := range ch {
				fmt.Printf("child %d : recv'd signal : %s\n", child, d)
			}
			fmt.Printf("child %d : recv'd shutdown signal\n", child)
		}(c)
	}

	const work = 100
	for w := 0; w < work; w++ {
		ch <- "data"
		fmt.Println("parent : sent signal :", w)
	}

	close(ch)
	fmt.Println("parent : sent shutdown signal")

	time.Sleep(time.Second)
	fmt.Println("-------------------------------------------------")
}
```

Range over a channel for d:= range ch : 

* Block till you receive data 
* Iterate over the data retreival until the channel is closed ie close(ch) will terminate the for loop.

Pooling pattern:

* Multiple child goroutines waiting for work from the master goroutine on a single channel.
* Child goroutines exit when the channel is closed.

### Fanout 

```go
// fanOut: In this pattern, the parent goroutine creates 2000 child goroutines
// and waits for them to signal their results.
func fanOut() {
	children := 20
    // Use a buffered channel
	ch := make(chan string, children)

	for c := 0; c < children; c++ {
		go func(child int) {
			time.Sleep(time.Duration(rand.Intn(200)) * time.Millisecond)
			ch <- "data"
			fmt.Println("child : sent signal :", child)
		}(c)
	}

	for children > 0 {
		d := <-ch
		children--
		fmt.Println(d)
		fmt.Println("parent : recv'd signal :", children)
	}

	time.Sleep(time.Second)
	fmt.Println("-------------------------------------------------")
}
```

* Start a group of child goroutines that send data to the main goroutine over a buffered channel.
* 1 buffer slot per child goroutine 
* Send is not blocked and hence no latency in send.
* Receive might be blocked if there is no data in the channel. 
* If 2 sends finish at the same time, there might be blocking to send data to the channel.

### Fanout Semaphore 

```go
// fanOutSem: In this pattern, a semaphore is added to the fan out pattern
// to restrict the number of child goroutines that can be schedule to run.
func fanOutSem() {
	children := 2000
	ch := make(chan string, children)

	g := runtime.GOMAXPROCS(0)
	sem := make(chan bool, g)

	for c := 0; c < children; c++ {
		go func(child int) {
			sem <- true
			{
				t := time.Duration(rand.Intn(200)) * time.Millisecond
				time.Sleep(t)
				ch <- "data"
				fmt.Println("child : sent signal :", child)
			}
			<-sem
		}(c)
	}

	for children > 0 {
		d := <-ch
		children--
		fmt.Println(d)
		fmt.Println("parent : recv'd signal :", children)
	}

	time.Sleep(time.Second)
	fmt.Println("-------------------------------------------------")
}
```

### Cancellation 

```go
// cancellation: In this pattern, the parent goroutine creates a child
// goroutine to perform some work. The parent goroutine is only willing to
// wait 150 milliseconds for that work to be completed. After 150 milliseconds
// the parent goroutine walks away.
func cancellation() {
	duration := 150 * time.Millisecond
	ctx, cancel := context.WithTimeout(context.Background(), duration)
	defer cancel()

	ch := make(chan string, 1)

	go func() {
		time.Sleep(time.Duration(rand.Intn(200)) * time.Millisecond)
		ch <- "data"
	}()

	select {
	case d := <-ch:
		fmt.Println("work complete", d)

	case <-ctx.Done():
		fmt.Println("work cancelled")
	}

	time.Sleep(time.Second)
	fmt.Println("-------------------------------------------------")
}
```

> Channels aren't like files; you don't usually need to close them. Closing is
> only necessary when the receiver must be told there are no more values
> coming, such as to terminate a range loop

> When you are creating a Goroutine decide when and how will it end.
> Provide a way to terminate the goroutine. 

> When you create an API that has concurrency, provide to the caller a way to
> terminate the goroutine. Let the caller manage concurrency at the lowest
> level.

### Gracefully End Multiple Goroutines

```go
package main

import (
	"context"
	"fmt"
	"io"
	"net/http"
	"os"
	"os/signal"
	"sync"
	"time"
)

func main() {

	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	wg := sync.WaitGroup{}

	wg.Add(1)
	go tick(ctx, &wg)

	wg.Add(1)
	go tock(ctx, &wg)

	wg.Add(1)
	go server(ctx, &wg)

	// listen to Ctrl-C
	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt)

	// Block on the channel for Ctrl-C
	<-c
	fmt.Println("main: received Ctrl-C - shutting down")

	// tell the goroutines to stop
	fmt.Println("main: signalling goroutines to stop")
	cancel()

	// wait for the goroutines to finish
	wg.Wait()
	fmt.Println("main: all goroutines have signalled me that they have finished")
}

func tick(ctx context.Context, wg *sync.WaitGroup) {
	defer wg.Done()

	fmt.Println("tick: starting...")

	ticker := time.NewTicker(3 * time.Second)
	defer ticker.Stop()

	for {
		select {
		case now := <-ticker.C:
			fmt.Printf("tick: tick %s\n", now.UTC().Format("20060102-150405.000000000"))
		case <-ctx.Done():
			fmt.Println("tick: caller asked me to stop")
			return
		}
	}
}

func tock(ctx context.Context, wg *sync.WaitGroup) {
	defer wg.Done()

	fmt.Println("tock: starting...")

	ticker := time.NewTicker(5 * time.Second)
	defer ticker.Stop()

	for {
		select {
		case now := <-ticker.C:
			fmt.Printf("tock: tock %s\n", now.UTC().Format("20060102-150405.000000000"))
		case <-ctx.Done():
			fmt.Println("tock: caller asked me to stop")
			return
		}
	}
}

func server(ctx context.Context, wg *sync.WaitGroup) {

	r := http.NewServeMux()
	r.HandleFunc("/hello", helloHandler)

	srv := http.Server{
		Handler: r,
		Addr:    fmt.Sprintf("%s:%s", "localhost", "8080"),
	}

	// goroutine blocks on ctx.Done and then does graceful shutdown
	go func() {
		// decrement wg post shutdown
		defer wg.Done()

		<-ctx.Done()
		fmt.Println("server: received signal to stop the server")

		// Need server shutdown timeout because srv.Shutdown() waits indefinitely
		// for active connections to become idle and the shutdown. Some zombie
		// connenctions can take forever to become idle.
		SERVER_SHUTDOWN_TIMEOUT := 5 // read from config
		shutdownTimeoutCtx, cancel := context.WithTimeout(
			context.Background(),
			time.Duration(SERVER_SHUTDOWN_TIMEOUT)*time.Second,
		)

		defer func() {
			// close DB conn, redis conn etc.
			cancel()
		}()

		if err := srv.Shutdown(shutdownTimeoutCtx); err != nil {
			fmt.Printf("server: shutdown error: %v \n", err)
		}
		fmt.Println("server: successfully shutdown")
	}()

	fmt.Println("server: starting server...")
	if err := srv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
		fmt.Printf("server: cannot start server. error: %v \n", err)
	}
}

func helloHandler(w http.ResponseWriter, req *http.Request) {
	io.WriteString(w, "Hello, world!\n")
}
```

