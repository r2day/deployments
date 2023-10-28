#! /bin/bash

# 传参
repo="$1" # r2day
project="$2"  # 项目名称
tag="$3" # dev、pro
serviceName="$4" # 容器名称

# 默认拉取最新镜像
if [ "$tag" = "" ] ; then
    tag='latest'
fi

image=$repo/$project:$tag
echo "拉取docker镜像 $image"

# pull docker 镜像
docker pull "$image" || exit 1


# 容器名称, 默认以项目名命名，支持传参
app="$serviceName"
if [ "$app" == "" ] ; then
    app=`echo ${project/-/_}`
    app=$app"_app"
fi

# 停止容器
# 停止容器
containers=`docker ps | grep "$image" | awk '{print $1}'`
if [ "$containers" != "" ] ; then
    echo "停止容器 $containers"
    docker stop  "$containers"
    docker rm  "$containers"
fi

# 重启单个镜像
echo "重启镜像 $app"
#docker compose restart "$app" || exit 1
docker compose up "$app" -d || exit 1

# 删除<none>镜像
noneImage=`docker images | grep "<none>" | awk '{print $3}'`
if [ "$noneImage" != "" ] ; then
    echo "删除<none>镜像:$noneImage"
    docker rmi $noneImage
fi

echo "deploy.sh执行完毕"
