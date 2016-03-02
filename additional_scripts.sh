# FOR INCLUDE
find manifests/ -name '*.pp' | xargs sed -i "s/include\ /include ::/g"
find manifests/ -name '*.pp' | xargs sed -i "s/::::/::/g"

# FOR CLASSES
find manifests/ -name '*.pp' | xargs sed -i "s/class {'/class { '/g"
find manifests/ -name '*.pp' | xargs sed -i "s/class { '/class { '::/g"
find manifests/ -name '*.pp' | xargs sed -i "s/class { '::::/class { '::/g"

find manifests/ -name '*.pp' | xargs sed -i "s/Class\['/Class\['::/g"
find manifests/ -name '*.pp' | xargs sed -i "s/Class\['::::/Class\['::/g"
