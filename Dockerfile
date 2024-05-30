FROM alpine

RUN apk add --no-cache git kubectl 
RUN clone --filter=blob:none --no-checkout https://github.com/darioboverio/benthos-configurations.git configmaps &&\
    cd configmaps &&\ 
    git sparse-checkout set --cone &&\ 
    git checkout main &&\
    git sparse-checkout set 4ff063ec-fcf2-4c2d-80d1-61c597a8151e/694114e0-c4a6-48bc-8cf3-a1c860e86d3f

RUN kubectl delete cm dynamic-docker-configmap &&\
    kubectl create cm dynamic-docker-configmap --from-file=4ff063ec-fcf2-4c2d-80d1-61c597a8151e/694114e0-c4a6-48bc-8cf3-a1c860e86d3f