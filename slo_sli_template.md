# API Service

| Category     | SLI                                                    | SLO                                                                                                         |
|--------------|--------------------------------------------------------|-------------------------------------------------------------------------------------------------------------|
| Availability | The percentage of successful requests over the last 5m | 99%                                                                                                         |
| Latency      | 90% of requests finish in these times over the last 5m | 90% of requests below 100ms                                                                                 |
| Error Budget | The remaining error budget over the 7d                 | Error budget is defined at 20%. This means that 20% of the requests can fail and still be within the budget |
| Throughput   | Successful requests per second over the last 5m        | 5 RPS indicates the application is functioning                                                              |
