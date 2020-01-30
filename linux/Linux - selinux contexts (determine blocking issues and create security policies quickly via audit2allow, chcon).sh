# ------------------------------------------------------------
#
# Selinux (RHEL Distros - RedHat, CentOS, etc.)
#  |
#  |-->  Troubleshooting security blockages & adding new security contexts
#
# ------------------------------------------------------------
#
# INSTALLING PRE-REQUISITE TOOLS
#
yum -y install policycoreutils-python selinux-policy-doc setroubleshoot-server;


# ------------------------------------------------------------
#
# INSPECTING SELINUX BLOCKAGES
#

#
# Show a description of why selinux blocked a given module
#    |--> audit2allow - generate SELinux policy allow/dontaudit rules from logs of denied operations
#             -a | --all                                 Read input from audit and message log, conflicts with -i
#             -m <modulename> | --module <modulename>    Generate module/require output <modulename>
#             -w | --why                                 Translates SELinux audit messages into a description of why the access was denied
#
audit2allow --all --module nginx --why;

#
# View the current security-context of a target file/directory
#
ls -Z "/var/cache/jenkins/war/images/";

#
# View the filepath(s) which have the "httpd_sys_content_t" security context applied to them
#
semanage fcontext -l | grep httpd_sys_content_t;

#
# View all available policies
#
man httpd_selinux;


# ------------------------------------------------------------
#
# TEMPORARY/TESTING SELINUX CHANGES (resets after reboots)
#

#
# Ex) TEMPORARILY add the "httpd_sys_content_t" security (selinux) context to path "/var/cache/jenkins/war/images/"
#      |--> Allows read-only access to files within a target directory (intended for web server read-only access)
#             |--> httpd_sys_content_t
#                    Use this type for static web content, such as .html files used by a static website
#                    Files labeled with this type are accessible (read only) to httpd and scripts executed by httpd
#                    By default, files and directories labeled with this type cannot be written to or modified by httpd or other processes
#                    Note that by default, files created in or copied into /var/www/html/ are labeled with the httpd_sys_content_t type
#
chcon -R -t httpd_sys_content_t "/var/cache/jenkins/war/images/";


# ------------------------------------------------------------
#
# PERMANENT/PERSISTENT SELINUX CHANGES (persists through reboots)
#   |
#   |--> Policies are stored within "/etc/selinux/targeted/contexts/files/"
#

#
# Ex) PERMANENTLY add the "httpd_sys_content_t" security (selinux) context to path "/var/cache/jenkins/war/images/"
#
semanage fcontext -a -t httpd_sys_content_t "/var/cache/jenkins/war/images/";


# ------------------------------------------------------------
#
# Citation(s)
#
#   access.redhat.com  |  "2.2. Types Red Hat Enterprise Linux 6 | Red Hat Customer Portal"  |  https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/managing_confined_services/sect-managing_confined_services-the_apache_http_server-types
#
#   access.redhat.com  |  "5.6. SELinux Contexts – Labeling Files Red Hat Enterprise Linux 6 | Red Hat Customer Portal"  |  https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/security-enhanced_linux/sect-security-enhanced_linux-working_with_selinux-selinux_contexts_labeling_files
#
#   access.redhat.com  |  "5.6.2. Persistent Changes: semanage fcontext Red Hat Enterprise Linux 6 | Red Hat Customer Portal"  |  https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/security-enhanced_linux/sect-security-enhanced_linux-selinux_contexts_labeling_files-persistent_changes_semanage_fcontext
#
#   stackoverflow.com  |  "installation - Why does Nginx return a 403 even though all permissions are set properly? - Stack Overflow"  |  https://stackoverflow.com/a/26228135
#
#   www.getpagespeed.com  |  "Nginx SELinux Configuration - GetPageSpeed"  |  https://www.getpagespeed.com/server-setup/nginx/nginx-selinux-configuration
#
# ------------------------------------------------------------