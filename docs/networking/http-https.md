# HTTP & HTTPS

// TODO: Fix the image path
![TLS Handshake](images/TLS1.2-handshake.png)

HTTP is an application layer protocol (OSI layers).

Any malicious person can snif the packets and read the data being tranmitted, eg
Credit Card numbers, passwords etc. can be read.

Can we encrypt the data and send over the wire such that only the client and the 
server can read the data?

> This is were HTTPS Protocol helps. HTTPS is an extention of HTTP protocol ie it 
> is also an Application Layer protocol. It uses TLS to encrypt the communication 
> data.

Transport Layer Security (TLS) is a cryptographic protocol designed to provide
communications security over a computer network, such as the Internet.

TLS uses asymmetric cryptography(public and private key pair) to exchange a 
session key(used for symmetric cryptography) for the session b/w the client and 
server.

> Making a TLS handshake is costly as it involves multiple trips b/w client &
> server. Newer TLS version ie TLS 1.3 reduces the number of round trips.

!!! note
    TLS 1.3 is the industry standard now.
    It uses Diffe Hellman algo for key exchange.
    It reduces the number of round trips b/w client & server.

Why not use asymmetric keys for data exchange intead of symmetric key?

Because asymmetric encryption/decryption is computationaly more intensive than
symmetric encryption/decryption.

**TLS Termination**

HTTPS or TLS is not used for server to server communication b/w servers in the 
same network(VPC) of a company. No encryption results in lower latency. HTTPS is 
terminated b/w the entry point(gateway) and the client.





[Detailed explanation by ByteByteGo](https://www.youtube.com/watch?v=j9QmMEWmcfo)

