# Jaeger tracing

This TF module deploys a Jaeger backend that includes an Elasticsearch cluster. Also, it schedules a cron job that cleans up tracing data that is older than 4 weeks, i.e. it has a default retention period of 4 weeks.

## Chart repository

Helm chart that is used resides in Jaeger OSS project's official repository. To add the repo, run:
```bash
helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
```

Also add the Elastic Helm repo for the official Elasticsearch chart:
```bash
helm repo add elastic https://helm.elastic.co
```
