#!/bin/sh
#
# ------------------------------------------------------------

if [[ 1 -eq 1 ]]; then
  # Add user (local admin) to ESXi
  echo -e "\n""INFO:  Calling [ esxcli system account list; esxcli system permission list; ]...";
  esxcli system account list; esxcli system permission list;
  sleep 2;
  echo -e "\n";
  read -p "Enter username (to create & add as a local admin):  " -t ${READ_TIMEOUT:-60} <'/dev/tty';
  if [[ -z "${REPLY}" ]]; then
    echo -e "\n""ERROR:  Empty response received";
  else
    echo -e "\n""INFO:  Calling [ esxcli system account add -d=\"${REPLY}\" -i=\"${REPLY}\" -p -c; ]...";
    # Create a new System Account
    esxcli system account add -d="${REPLY}" -i="${REPLY}" -p -c;
    sleep 2;
    echo -e "\n""INFO:  Calling [ esxcli system permission set --id \"${REPLY}\" --role \"Admin\"; ]...";
    # Assign to the role of "Admin" to target account
    esxcli system permission set --id "${REPLY}" --role "Admin";
    sleep 2;
    echo -e "\n""INFO:  Calling [ esxcli system account list; esxcli system permission list; ]...";
    esxcli system account list; esxcli system permission list;
    sleep 2;
  fi;
  echo "";
fi;


# ------------------------------------------------------------

if [[ 0 -eq 1 ]]; then
  # Delete a system user account from ESXi:
  USERNAME_TO_DELETE="DAT_USER";
  esxcli system account remove -i "${USERNAME_TO_DELETE}";
  esxcli system account list;
fi;

# ------------------------------------------------------------
#
# > esxcli system account add --help
#
#   Usage: esxcli system account add [cmd options]
#   
#   Description:
#     add                   Create a new local user account.
#   
#   Cmd options:
#     -d|--description=<str>
#                           User description, e.g. full name.
#     -i|--id=<str>         User ID, e.g. "administrator". (required)
#     -p|--password=<str>   User password. (secret)
#                           WARNING: Providing secret values on the command line is insecure because it may be logged or preserved in history files. Instead,
#                           specify this option with no value on the command line, and enter the value on the supplied prompt.
#     -c|--password-confirmation=<str>
#                           Password confirmation. Required if password is specified. (secret)
#                           WARNING: Providing secret values on the command line is insecure because it may be logged or preserved in history files. Instead,
#                           specify this option with no value on the command line, and enter the value on the supplied prompt.
#   
# ------------------------------------------------------------
#
# Citation(s)
#
#   pubs.vmware.com  |  "vSphere Command-Line Interface Reference"  |  https://pubs.vmware.com/vsphere-50/index.jsp?topic=%2Fcom.vmware.vcli.ref.doc_50%2Fvcli-right.html
#
#   pubs.vmware.com  |  "esxcli storage Commands"  |  https://pubs.vmware.com/vsphere-50/index.jsp?topic=%2Fcom.vmware.vcli.ref.doc_50%2Fesxcli_storage.html
#
#   pubs.vmware.com  |  "esxcli system Commands"  |  https://pubs.vmware.com/vsphere-50/index.jsp?topic=%2Fcom.vmware.vcli.ref.doc_50%2Fesxcli_system.html
#
# ------------------------------------------------------------