FROM ascendhub.huawei.com/public-ascendhub/ascend-pytorch:24.0.RC1-A2-1.11.0-ubuntu20.04

ARG PIP_URL="https://pypi.tuna.tsinghua.edu.cn/simple"

WORKDIR /workspace
USER root

#-------pip requirements------
COPY requirements.txt requirements.txt
RUN pip config set global.index-url ${PIP_URL}
RUN pip install -r requirements.txt
RUN rm requirements.txt

COPY model model
COPY text_embedding.py text_embedding.py
ADD run.sh run.sh

RUN echo "source /usr/local/Ascend/ascend-toolkit/set_env.sh" >> /root/.bashrc

ENTRYPOINT ["bash", "run.sh", "80", "4"]