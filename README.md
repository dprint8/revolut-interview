# hello app
- To build the image run: `docker build -t <your_tag>` .
- To run locally: `docker run -p <local_unused_port>:80 <your_tag>`


## Assumptions - Future work
- This setup is passing terraform validate locally. The initial plan was to test using localstack, but not all resources are available.
- I have split the resources as I saw fit hoping they are self explanatory by filename, this can always be challenged.
- Assuming this works for dev/one environment, we can either replicate it for production, or refactor using DRY principles and separate only by environments passing the variables for each.
