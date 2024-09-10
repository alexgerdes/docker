
```
buildx create --name mybuilder --bootstrap --use
```

```
docker buildx build --builder mybuilder --platform linux/amd64,linux/arm64 -t agerdes/intro-fp:latest -t agerdes/intro-fp:ht24 -f intro-fp.docker . --push
```
