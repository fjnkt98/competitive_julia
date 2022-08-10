FROM julia:1.4

SHELL ["/bin/bash", "-c"]

ARG UID=1000
ARG USERNAME="julian"
ARG PASSWORD="julian"

RUN apt-get update \
    && apt-get install -y \
    sudo \
    curl \
    ssh \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -u ${UID} --groups sudo ${USERNAME} && \
    echo ${USERNAME}:${PASSWORD} | chpasswd
RUN echo "Defaults visiblepw" >> /etc/sudoers \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN git config --global user.name fjnkt98
RUN git config --global user.email fjnkt98@gmail.com

USER ${UID}
ENV HOME=/home/${USERNAME}
WORKDIR ${HOME}

COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
CMD ["/bin/bash"]