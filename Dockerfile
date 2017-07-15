FROM        alpine:3.6
MAINTAINER  XiniX00

COPY buildbot.tac /buildbot/buildbot.tac

# Add dependencies
RUN \
    echo @testing http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    apk add --no-cache \
        git \
        sed \
        python \
        py-pip \
	    py-twisted \
        dumb-init@edge\
        tar \
        tzdata \
        curl && \
# install pip dependencies
    pip install --upgrade pip setuptools && \
    pip install buildbot-worker==0.9.9.post2 && \
    rm -r /root/.cache

# Finalize
WORKDIR /buildbot
CMD ["dumb-init", "twistd", "-ny", "buildbot.tac"]
