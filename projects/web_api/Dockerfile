FROM python:3.10-slim

WORKDIR /app

ENV PATH="/app/venv/bin:$PATH"
ENV PYTHONUNBUFFERED=1
ENV PORT=8080

# 系统依赖 + gsutil 支持
RUN apt-get update && apt-get install -y \
    curl unzip gnupg ca-certificates \
    lsb-release apt-transport-https python3-pip && \
    pip install --upgrade pip && pip install gsutil && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 安装 Python 项目依赖
COPY requirements.txt .
RUN python -m venv /app/venv && . /app/venv/bin/activate && pip install -r requirements.txt

# 下载模型（直接从 GCS）
RUN mkdir -p /opt/models && \
    mkdir -p /opt/layoutreader && \
    gsutil -m cp -r gs://mineru_models/models/* /opt/models/ && \
    gsutil -m cp -r gs://mineru_models/layoutreader/* /opt/layoutreader/

# 拷贝 API 文件
COPY app.py .
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

EXPOSE 8080
ENTRYPOINT ["./entrypoint.sh"]
CMD ["--host", "0.0.0.0", "--port", "8080"]
