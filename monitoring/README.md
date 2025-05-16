# 📊 Monitoring Stack with Grafana, Prometheus, Loki, and Promtail

This project sets up a full monitoring and logging stack using **Docker Compose**. It includes:

- **Grafana** – Beautiful dashboards for metrics and logs.
- **Prometheus** – Collects and stores time-series metrics.
- **Loki** – Stores logs for efficient searching.
- **Promtail** – Ships logs from local files to Loki.

---

## 📁 Folder Structure

```
monitoring
├── docker-compose.yml
├── loki
│   └── config.yaml
├── prometheus
│   └── prometheus.yml
├── promtail
│   └── config.yaml
└── README.md
```

