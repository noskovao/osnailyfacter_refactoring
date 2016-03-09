# FOR INCLUDE
find . -name '*.pp' | xargs sed -i "s/include\ /include ::/g"
find . -name '*.pp' | xargs sed -i "s/::::/::/g"

# FOR CLASSES
find . -name '*.pp' | xargs sed -i "s/class {'/class { '/g"
find . -name '*.pp' | xargs sed -i "s/class { '/class { '::/g"
find . -name '*.pp' | xargs sed -i "s/class { '::::/class { '::/g"

find . -name '*.pp' | xargs sed -i "s/Class\['/Class\['::/g"
find . -name '*.pp' | xargs sed -i "s/Class\['::::/Class\['::/g"

# Replace two new lines
find . -name '*.pp' | xargs sed -i ":a;/^$/N;/\n$/{D;ba}"
