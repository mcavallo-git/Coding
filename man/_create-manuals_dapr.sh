if [[ 1 -eq 1 ]]; then

ARG=""; dapr --help > "${HOME}/man/dapr.help.man";
ARG="build-info"; dapr ${ARG} --help > "${HOME}/man/dapr-${ARG}.help.man";
ARG="completion"; dapr ${ARG} --help > "${HOME}/man/dapr-${ARG}.help.man";
ARG="components"; dapr ${ARG} --help > "${HOME}/man/dapr-${ARG}.help.man";
ARG="configurations"; dapr ${ARG} --help > "${HOME}/man/dapr-${ARG}.help.man";
ARG="dashboard"; dapr ${ARG} --help > "${HOME}/man/dapr-${ARG}.help.man";
ARG="help"; dapr ${ARG} --help > "${HOME}/man/dapr-${ARG}.help.man";
ARG="init"; dapr ${ARG} --help > "${HOME}/man/dapr-${ARG}.help.man";
ARG="invoke"; dapr ${ARG} --help > "${HOME}/man/dapr-${ARG}.help.man";
ARG="list"; dapr ${ARG} --help > "${HOME}/man/dapr-${ARG}.help.man";
ARG="logs"; dapr ${ARG} --help > "${HOME}/man/dapr-${ARG}.help.man";
ARG="mtls"; dapr ${ARG} --help > "${HOME}/man/dapr-${ARG}.help.man";
ARG="publish"; dapr ${ARG} --help > "${HOME}/man/dapr-${ARG}.help.man";
ARG="run"; dapr ${ARG} --help > "${HOME}/man/dapr-${ARG}.help.man";
ARG="status"; dapr ${ARG} --help > "${HOME}/man/dapr-${ARG}.help.man";
ARG="stop"; dapr ${ARG} --help > "${HOME}/man/dapr-${ARG}.help.man";
ARG="uninstall"; dapr ${ARG} --help > "${HOME}/man/dapr-${ARG}.help.man";
ARG="upgrade"; dapr ${ARG} --help > "${HOME}/man/dapr-${ARG}.help.man";

fi;