# Infrastructure

## AWS Zones
us-east-2 and us-west-1

## Servers and Clusters

### Table 1.1 Summary
| Asset                     | Purpose                                     | Size     | Qty | HA                                                      | DR                                                                              |
|---------------------------|---------------------------------------------|----------|-----|---------------------------------------------------------|---------------------------------------------------------------------------------|
| EC2 instance              | Running the app                             | t3.micro | 1   | Increase the instance number from 1 to 3 in us-east-2   | Deploy 3 instances in us-west-1                                                 |
| SSH keys                  | Administering the EC2 instances             |          | 1   |                                                         | Have a SSH key in us-west-1                                                     |
| GitHub repo               | Storing the code                            |          | 1   |                                                         |                                                                                 |
| RDS cluster               | Backend database                            | 1 node   | 1   | Increase the node number from 1 to 2 in us-east-2       | Have a replicated database and perform a failover on the database in us-west-1  |
| Network load balancer     | Improve monitoring stack availability       |          | 1   | Deploy in multi-AZs in us-east-2                        | Deploy in multi-AZs in us-west-1                                                |
| Application load balancer | Improve app availability                    |          | 0   | Deploy in multi-AZs in us-east-2 and perform a failover | Deploy in multi-AZs in us-west-1 and perform a failover                         |
| Kubernetes cluster        | Monitoring stack                            | 1 node   | 1   | Deploy in multi-AZs in us-east-2                        | Deploy in multi-AZs in us-west-1                                                |
| Grafana and Prometheus    | Monitoring platform                         |          | 1   |                                                         |                                                                                 |
| VPC                       | Launch AWS resources into a virtual network |          | 1   | Deploy in multi-AZs in us-east-2                        | Deploy in multi-AZs in us-west-1                                                |
| S3                        | Storing terraform data                      |          | 1   |

### Descriptions
- 1 EC2 instances running the app
- 1 SSH keys for administering the EC2 instances
- 1 GitHub repo for storing the Terraform code
- 1 backend database running on 1 Amazon RDS nodes for the app
- 1 load balancer for the grafana stack
- 1 Kubernetes cluster for monitoring stack
- 1 monitoring platform (Grafana and Prometheus) for the app
- 1 VPC to launch AWS resources in a private network
- 1 S3 bucket to store the terraform data


## DR Plan
### Pre-Steps:
Ensure the infrastructure is set up and working in the DR site.

## Steps:
1. Create a application load balancer and point DNS to the load balancer. This way you can have multiple instances behind 1 IP in a region. During a failover scenario, you would fail over the single DNS entry at your DNS provider to point to the DR site. This is much more intelligent than pointing to a single instance of a web server.
2. Have a replicated database and perform a failover on the database. While a backup is good and necessary, it is time-consuming to restore from backup. In this DR step, you would have already configured replication and would perform the database failover. Ideally, your application would be using a generic CNAME DNS record and would just connect to the DR instance of the database.
