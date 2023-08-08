FROM ubuntu:20.04

SHELL ["/bin/bash", "-c"]

#時刻設定
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#キーボード設定
# ENV DEBIAN_FRONTEND=noninteractive

##aptアップグレード&設定
RUN apt update -y
RUN apt upgrade -y

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get -y install locales && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8

#Python
RUN apt-get install -y python3.9
RUN apt-get install -y python3-pip
RUN apt-get install -y nano

ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9
ENV TERM xterm

#Python　パッケージインストール
RUN pip install --upgrade pip
RUN pip install -U "setuptools<58"

# ベーシックなPythonライブラリ
RUN pip install numpy
RUN pip install pandas
RUN pip install scikit-learn
RUN pip install matplotlib
RUN pip install seaborn
RUN pip install jupyterlab

# 特徴量エンジニアリングで使用
RUN pip install xfeat

# lightgbmでの予測モデル構築時に使用
RUN pip install optuna
RUN pip install lightgbm

# 時系列分析の際に使用（K-Shape etc）
RUN pip install tslearn

# EDAの際に使用
RUN pip install pandas-profiling

#  scikit-learnでモデル構築した際のハイパーパラメータの探索時に使用
RUN pip install scikit-optimize