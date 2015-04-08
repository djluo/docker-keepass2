# run firefox
#
FROM       docker.xlands-inc.com/baoyu/debian
MAINTAINER djluo <dj.luo@baoyugame.com>

ADD http://sourceforge.net/projects/keepass/files/Translations%202.x/2.19/SimplifiedChinese-2.19.zip/download /cn.zip
RUN export http_proxy="http://172.17.42.1:8080/" \
    && export DEBIAN_FRONTEND=noninteractive     \
    && apt-get update  \
    && apt-get install -y keepass2 unzip \
    && apt-get install -y ttf-wqy-zenhei \
    && unzip /cn.zip \
    && mv /SimplifiedChinese.lngx /usr/lib/keepass2/ \
    && apt-get purge -y unzip \
    && apt-get clean \
    && unset http_proxy DEBIAN_FRONTEND \
    && localedef -c -i zh_CN -f UTF-8 zh_CN.UTF-8 \
    && localedef -c -i en_US -f UTF-8 en_US.UTF-8

ADD        ./entrypoint.pl /entrypoint.pl
ENTRYPOINT ["/entrypoint.pl"]
CMD        ["/usr/bin/keepass2"]
