#!/usr/bin/env bash
set -euo pipefail

. /app/venv/bin/activate

PORT="${PORT:-8080}"  # 默认8080，如果 Cloud Run 提供，就覆盖

echo "🟢 Starting MinerU API..."
echo "🔧 Listening on 0.0.0.0:${PORT}"
echo "💡 Uvicorn command: uvicorn app:app --host 0.0.0.0 --port ${PORT}"

exec uvicorn app:app --host 0.0.0.0 --port "${PORT}" --log-level debug
