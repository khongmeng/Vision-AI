FROM pytorch/pytorch:2.2.2-cuda12.1-cudnn8-runtime

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /workspace

# System deps for OpenCV, matplotlib rendering, notebook export
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    pandoc \
    ffmpeg \
    libglib2.0-0 libsm6 libxext6 libxrender1 \
    fonts-dejavu-core \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

EXPOSE 8888

CMD ["bash"]

