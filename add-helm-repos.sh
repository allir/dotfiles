#!/usr/bin/env bash
set -euo pipefail

if ! command -v helm &> /dev/null; then
    echo "helm not found, skipping helm repos setup"
    exit 0
fi

# Helm Repos
helm repo add bitnami               https://charts.bitnami.com/bitnami
helm repo add hashicorp             https://helm.releases.hashicorp.com
helm repo add argo                  https://argoproj.github.io/argo-helm
helm repo add jetstack              https://charts.jetstack.io
helm repo add dex                   https://charts.dexidp.io
helm repo add cilium                https://helm.cilium.io/
helm repo add prometheus-community  https://prometheus-community.github.io/helm-charts
helm repo add grafana               https://grafana.github.io/helm-charts
