#!/bin/bash

FUEL_LIB_PATH="./fuel-library/deployment/puppet/osnailyfacter"
SKIPPED_MODULES=(master spec ceilometer glance heat horizon ironic keystone openstack-cinder openstack-controller openstack-network roles sahara swift)

################################################################################

pushd $FUEL_LIB_PATH

MODULES_TO_MODIFY=($(ls -d modular/*/ | cut -f2 -d '/'))

for i in "${SKIPPED_MODULES[@]}"; do
  MODULES_TO_MODIFY=(${MODULES_TO_MODIFY[@]//*$i*})
done

for j in "${MODULES_TO_MODIFY[@]}"; do
  mkdir -p manifests/${j//-/_}
  cp modular/${j}/*.pp manifests/${j//-/_}
  pushd manifests/${j//-/_}
  for files in *; do
    if [[ "${files}" =~ '-' ]]
    then
      mv "${files}" $(echo ${files} | tr '-' '_')
    fi
  done
  for file in *; do
    sed -i "/MODULAR:/c\notice('MODULAR: ${j//-/_}\/${file}')" ${file}
  done
  for f in $(ls *.pp | sed 's/.pp//g'); do
    sed 's/^/  /' -i ${f}.pp
    find . -type f | xargs sed -i "s/[[:space:]]*$//"
    sed -i -e "1iclass osnailyfacter::${j//-/_}::${f} {\n" ${f}.pp && echo -e "\n}" >> $f.pp
  done
  popd
  pushd modular/${j}
  for x in *.pp; do
    xa=${x//-/_}
    xa=${xa//.pp/}
    echo -e "include ::osnailyfacter::${j//-/_}::${xa}" > ${x}
  done
  popd
done
popd
