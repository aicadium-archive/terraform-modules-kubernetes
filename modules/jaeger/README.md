# Jaeger tracing

This TF module deploys a Jaeger backend that includes an Elasticsearch cluster. Also, it schedules a cron job that cleans up tracing data that is older than 4 weeks, i.e. it has a default retention period of 4 weeks.
