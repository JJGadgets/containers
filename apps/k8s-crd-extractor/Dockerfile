FROM public.ecr.aws/docker/library/alpine:3.23.3@sha256:25109184c71bdad752c8312a8623239686a9a2071e8825f20acb8f2198c3f659

USER 0:0
RUN apk add bash
RUN apk add catatonit
RUN apk add kubectl
RUN apk add python3
RUN apk add py3-yaml

USER 1000:1000
WORKDIR /app
ADD --chown=1000:1000 --chmod=555 https://raw.githubusercontent.com/datreeio/CRDs-catalog/89a756e59d7c9524ff07a7408a1d6b8dae5ccce5/Utilities/crd-extractor.sh /app/crd-extractor.sh
ADD --chown=1000:1000 --chmod=555 https://raw.githubusercontent.com/yannh/kubeconform/b6728f181c177cad0fa20b45eac32aafb638ec82/scripts/openapi2jsonschema.py /app/openapi2jsonschema.py
COPY --chown=1000:1000 --chmod=555 ./apps/k8s-crd-extractor/yamlls-lsp.sh /app/yamlls-lsp.sh
ENV HOME=/
ENV CRDS_DOMAIN=localhost
WORKDIR /.datree/crds
WORKDIR /.datree
# mount volumes at /.datree/crdSchemas to get final JSON schema files

ENTRYPOINT ["/usr/bin/catatonit", "--"]
CMD ["bash", "-c", "mkdir -p /.datree/crds && cp -r /app/openapi2jsonschema.py /.datree/crds/openapi2jsonschema.py && /app/crd-extractor.sh && /app/yamlls-lsp.sh"]
