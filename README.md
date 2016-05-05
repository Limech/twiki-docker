### Description

This is Dockerfile is incomplete.

Requires the following files to be in the same folder as the Dockerfile.

* TWiki20040903.tar.gz
* httpd.conf

#### To Build
`docker build -t myhttpd .`

#### To Run
`docker run -d -p 8080:80 --name myd myhttpd`

Open Firefox to 
`http://localhost:8080/bin/view`


