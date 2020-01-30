
# ------------------------------------------------------------
#
# audit2allow - generate SELinux policy allow/dontaudit rules from logs of denied operations
#
# audit2why - translates SELinux audit messages into a description of why the access was denied (audit2allow -w)
#
# ...
#
#       -a | --all
#              Read input from audit and message log, conflicts with -i
#
#       -m <modulename> | --module <modulename>
#              Generate module/require output <modulename>
#
#       -w | --why
#              Translates SELinux audit messages into a description of why the access was denied
#
# ...
#
# ------------------------------------------------------------

#
# Troubleshoot web-server access & selinux possibly blocking it
#
audit2allow --all --module nginx --why;


# ------------------------------------------------------------

#
# Allow read-only access to files within a target directory (intended for web server read-only access)
#

chcon -R -t httpd_sys_content_t "/var/cache/jenkins/war/images/";

#
# httpd_sys_content_t
#   Use this type for static web content, such as .html files used by a static website
#   Files labeled with this type are accessible (read only) to httpd and scripts executed by httpd
#   By default, files and directories labeled with this type cannot be written to or modified by httpd or other processes
#   Note that by default, files created in or copied into /var/www/html/ are labeled with the httpd_sys_content_t type
#


# ------------------------------------------------------------
#
# Citation(s)
#
#   access.redhat.com  |  "2.2. Types Red Hat Enterprise Linux 6 | Red Hat Customer Portal"  |  https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/managing_confined_services/sect-managing_confined_services-the_apache_http_server-types
#
#   access.redhat.com  |  "5.6. SELinux Contexts – Labeling Files Red Hat Enterprise Linux 6 | Red Hat Customer Portal"  |  https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/security-enhanced_linux/sect-security-enhanced_linux-working_with_selinux-selinux_contexts_labeling_files
#
#   stackoverflow.com  |  "installation - Why does Nginx return a 403 even though all permissions are set properly? - Stack Overflow"  |  https://stackoverflow.com/a/26228135
#
#   www.getpagespeed.com  |  "Nginx SELinux Configuration - GetPageSpeed"  |  https://www.getpagespeed.com/server-setup/nginx/nginx-selinux-configuration
#
# ------------------------------------------------------------