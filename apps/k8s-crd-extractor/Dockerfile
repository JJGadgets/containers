FROM public.ecr.aws/docker/library/alpine:3.19.1

USER 0:0
RUN apk add bash=5.2.21-r0
RUN apk add catatonit=0.2.0-r0
RUN apk add kubectl=1.28.4-r0
RUN apk add python3=3.11.6-r1
RUN apk add py3-yaml=6.0.1-r1
#RUN apk add py3-pip=23.3.1-r0
#RUN pip3 install pyyaml

USER 1000:1000
WORKDIR /app
ADD --chown=1000:1000 --chmod=555 https://raw.githubusercontent.com/datreeio/CRDs-catalog/89a756e59d7c9524ff07a7408a1d6b8dae5ccce5/Utilities/crd-extractor.sh /app/crd-extractor.sh
ADD --chown=1000:1000 --chmod=555 https://raw.githubusercontent.com/yannh/kubeconform/b6728f181c177cad0fa20b45eac32aafb638ec82/scripts/openapi2jsonschema.py /app/openapi2jsonschema.py
ENV HOME=/
WORKDIR /.datree/crds
WORKDIR /.datree
# mount volumes at /.datree/crdSchemas to get final JSON schema files

ENTRYPOINT ["/usr/bin/catatonit", "--"]
CMD ["bash", "-c", "mkdir -p /.datree/crds && cp -r /app/openapi2jsonschema.py /.datree/crds/openapi2jsonschema.py && /app/crd-extractor.sh"]
