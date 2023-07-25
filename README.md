# deployments

<!-- 不同的渠道选择不同的分支 -->

## 部署方式

```
git clone https://github.com/r2day/deployments
```

## 选择不同的分支

- dev 表示开发环境
- test 测试环境
- release 正式环境

以下以开发环境为例子

```
git --branch <branchname> <url>
git checkout dev
```

## 该repo 涉及到用户配置密钥，因此只能短时授权git

```
cd <app>
docker compose up -d
docker compose ps
docker compose down

```