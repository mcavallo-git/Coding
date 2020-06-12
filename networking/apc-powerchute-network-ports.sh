# ------------------------------------------------------------
#
# APC - PowerChute Networking Ports
#
# ------------------------------------------------------------

Published date:
	21 January 2020

# ------------------------------------------------------------

Issue:
	What ports are used by each component of PowerChute Business Edition

# ------------------------------------------------------------

Product Line:
	PowerChute Business Edition

# ------------------------------------------------------------

Environment:
	All supported OS

# ------------------------------------------------------------

Cause:
	Informational

# ------------------------------------------------------------

Solution:

	TCP

		2161 – Communication between Server and Agent (PowerChute 9.2.1 and below)

		2160 – Communication between Console and Server (PowerChute 6.x)

		2260 – Communication between Console and Server (PowerChute 7.x, 8.x, 9.x ending at 9.2.1)

		3052 – Agent Web UI and Logging features (PowerChute 9.2.1 and below)

		6547 – Agent Web UI (PowerChute 9.x and 10.x)
		
	UDP

		2161 – Discovery of Agents by Server (PowerChute 9.2.1 and below)

		2160 – Discovery of Servers by Console (PowerChute 9.2.1 and below)

		7846 – Business Edition SNMP Agent


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.apc.com  |  "Ports used by each component of PowerChute Business Edition."  |  https://www.apc.com/us/en/faqs/FA159597/
#
# ------------------------------------------------------------