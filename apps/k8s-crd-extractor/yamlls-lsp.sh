#!/usr/bin/env bash
export SCHEMALIST=$(find /.datree/crdSchemas -type f -not -path "/.datree/crdSchemas/master-standalone/*" | sed -e "s/\/.datree\/crdSchemas/https\:\/\/${CRDS_DOMAIN:=localhost}")
echo '{"oneOf":[' > /.datree/crdSchemas/yamlls-lsp.json
for i in ${SCHEMALIST}; do
  SCHEMAREF_START='  {"$ref": "'
  SCHEMAREF_END='"},'
  echo "${SCHEMAREF_START}${i}${SCHEMAREF_END}" >> /.datree/crdSchemas/yamlls-lsp.json
done
echo ']}' >> /.datree/crdSchemas/yamlls-lsp.json
