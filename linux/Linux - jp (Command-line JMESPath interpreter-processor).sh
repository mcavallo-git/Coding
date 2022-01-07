#!/bin/bash
# ------------------------------------------------------------
#
# Install jp
#

curl -H 'Cache-Control: no-cache' -s "https://raw.githubusercontent.com/mcavallo-git/cloud-infrastructure/master/usr/local/sbin/install_jp?t=$(date +'%s.%N')" | bash;


# ------------------------------------------------------------
#
# jp - get [ one (1) key's value ]
#
echo '{"id":"1","name":"obj1","value":"val1"}' | jp -r '.name';


#
# jp - get [ one (1) key's value ] from [ each object in a top-level JSON array ]
#
JP_QUERY='.[].name';
JSON='[{"id":"1","name":"obj1","value":"val1"},{"id":"2","name":"obj2","value":"val2"}]';
echo "${JSON}" | jp -r "${JP_QUERY}";


# ------------------------------------------------------------
#
# jp - get [ multiple (N) keys' values ]
#
echo '{"id":"1","name":"obj1","value":"val1"}' | jp -r '{name:.name,value:.value}';


#
# jp - get [ multiple (N) keys' values ] from [ each object in a top-level JSON array ]
#
JP_QUERY='.[]|{value:.value,name:.name}';
JSON='[{"id":"1","name":"obj1","value":"val1"},{"id":"2","name":"obj2","value":"val2"}]';
echo "${JSON}" | jp "${JP_QUERY}";


# ------------------------------------------------------------
#
# Citation(s)
#
#   github.com  |  "GitHub - jmespath/jp: Command line interface to JMESPath - http://jmespath.org"  |  https://github.com/jmespath/jp
#
#   www.devmanuals.net  |  "How to install jp on Ubuntu 20.04 (Focal Fossa)?"  |  https://www.devmanuals.net/install/ubuntu/ubuntu-20-04-focal-fossa/installing-jp-on-ubuntu20-04.html
#
# ------------------------------------------------------------