# hello app
- To build the image run: `docker build -t <your_tag>` .
- To run locally: `docker run -p <local_unused_port>:80 <your_tag>`


## Assumptions - Future work
- I have used ECS with Fargate as it seemed the easiest way to setup a single container service. I changed from sqlite to RDS mysql because having 3 replicas would mean each of the containers would be running its own DB which would defeat the purpose.
The mysql DB requires an intial setup: creating a DB, the user the app will be using and  granting that user privileges on the DB.
- This setup is passing terraform validate locally. The initial plan was to test using localstack, but not all resources are available.
- I have split the resources as I saw fit hoping they are self explanatory by filename, this can always be challenged.
- Assuming this works for one environment, we can either replicate it for another one, or refactor using DRY principles and separate only by environments passing the variables for each.
- As I have not been in a purely dev role so far, I have used an in-memory DB for the initial run of the app which is not ideal. Also, I have never written tests so this will be future work I'm afraid.
- Given the 3 replicas and the healthcheck, when changing the version tag variable, applying terraform will trigger a rolling update.
