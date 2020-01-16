
###  https://wiki.jenkins.io/display/JENKINS/Distributed+builds

### !!! Use file @ [ /var/lib/jenkins/secrets/jenkins.slaves.JnlpSlaveAgentProtocol.secret ]

https://SERVER_URL/jnlpJars/slave.jar

https://SERVER_URL/computer/NODE_NAME/slave-agent.jnlp

$WorkingDir="C:\Jenkins\"; Set-Location "${WorkingDir}"; java -jar agent.jar -jnlpUrl https://SERVER_URL/computer/NODE_NAME/slave-agent.jnlp -auth "USER:PASS" -workDir "${WorkingDir}" -noCertificateCheck;


$WorkingDir="C:\Jenkins\"; Set-Location "${WorkingDir}"; java -jar agent.jar -jnlpUrl https://SERVER_URL/computer/NODE_NAME/slave-agent.jnlp -auth "USER:PASS" -workDir "${WorkingDir}" -noCertificateCheck;

### -secret jenkins.slaves.JnlpSlaveAgentProtocol.secret
### -secret 123asd123asd0...


# ------------------------------------------------------------

$WorkingDir="C:\Jenkins\"; Set-Location "${WorkingDir}"; `
java `
-jar slave.jar `
-connectTo SERVER_URL:443 `
-jnlpUrl https://SERVER_URL/computer/NODE_NAME/slave-agent.jnlp `
-jnlpCredentials USER:PASS `
-auth USER:PASS `
-workDir "${WorkingDir}" `
-noCertificateCheck `
;

# ------------------------------------------------------------

https://SERVER_URL/computer/NODE_NAME/slave-agent.jnlp


java -jar jenkins-cli.jar -s https://SERVER_URL help


curl -I https://SERVER_URL/computer/<SLAVE>/slave-agent.jnlp


curl -I https://SERVER_URL/tcpSlaveAgentListener/


cd "C:\Jenkins"; java -jar agent.jar -jnlpUrl http://SERVER_URL:8080/computer/NODE_NAME/slave-agent.jnlp


<# ------------------------------------------------------------
java -jar agent.jar [options...]
 -agentLog (-slaveLog) FILE      : Local agent error log destination (overrides
                                   workDir)
 -auth user:pass                 : If your Jenkins is security-enabled, specify
                                   a valid user name and password.
 -cert VAL                       : Specify additional X.509 encoded PEM
                                   certificates to trust when connecting to
                                   Jenkins root URLs. If starting with @ then
                                   the remainder is assumed to be the name of
                                   the certificate file to read.
 -connectTo HOST:PORT            : make a TCP connection to the given host and
                                   port, then start communication.
 -cp (-classpath) PATH           : add the given classpath elements to the
                                   system classloader.
 -failIfWorkDirIsMissing         : Fails the initialization if the requested
                                   workDir or internalDir are missing ('false'
                                   by default) (default: false)
 -help                           : Show this help message (default: false)
 -internalDir VAL                : Specifies a name of the internal files
                                   within a working directory ('remoting' by
                                   default) (default: remoting)
 -jar-cache DIR                  : Cache directory that stores jar files sent
                                   from the master
 -jnlpCredentials USER:PASSWORD  : HTTP BASIC AUTH header to pass in for making
                                   HTTP requests.
 -jnlpUrl URL                    : instead of talking to the master via
                                   stdin/stdout, emulate a JNLP client by
                                   making a TCP connection to the master.
                                   Connection parameters are obtained by
                                   parsing the JNLP file.
 -loggingConfig FILE             : Path to the property file with
                                   java.util.logging settings
 -noKeepAlive                    : Disable TCP socket keep alive on connection
                                   to the master. (default: false)
 -noReconnect                    : Doesn't try to reconnect when a
                                   communication fail, and exit instead
                                   (default: false)
 -proxyCredentials USER:PASSWORD : HTTP BASIC AUTH header to pass in for making
                                   HTTP authenticated proxy requests.
 -secret HEX_SECRET              : Agent connection secret to use instead of
                                   -jnlpCredentials.
 -tcp FILE                       : instead of talking to the master via
                                   stdin/stdout, listens to a random local
                                   port, write that port number to the given
                                   file, then wait for the master to connect to
                                   that port.
 -text                           : encode communication with the master with
                                   base64. Useful for running agent over 8-bit
                                   unsafe protocol like telnet
 -version                        : Shows the version of the remoting jar and
                                   then exits (default: false)
 -workDir FILE                   : Declares the working directory of the
                                   remoting instance (stores cache and logs by
                                   default)
------------------------------------------------------------ #>


# ------------------------------------------------------------
#
# Citation(s)
#
#   wiki.jenkins.io  |  "Distributed builds - Jenkins - Jenkins Wiki"  |  https://wiki.jenkins.io/display/JENKINS/Distributed+builds
#
# ------------------------------------------------------------