# Configuration file for ezservermonitor-sh

# Disk usage - Show or hide virtual mountpoints (tmpfs)
DISK_SHOW_TMPFS=true

# Service who returns WAN IP
GET_WAN_IP="http://www.ezservermonitor.com/myip"

# Hosts to ping
PING_HOSTS=("wintermute.strasse43.ch" "free.fr" "orange.fr")

# Services port number to check
# syntax : 
#   SERVICES_NAME[port_number]="label"
#   SERVICES_HOST[port_number]="localhost"
SERVICES_NAME[21]="FTP Server"
SERVICES_HOST[21]="localhost"

SERVICES_NAME[22]="SSH"
SERVICES_HOST[22]="localhost"

SERVICES_NAME[80]="Web Server"
SERVICES_HOST[80]="localhost"

SERVICES_NAME[3306]="Database"
SERVICES_HOST[3306]="localhost"

# Temperatures blocks (true for enable)
TEMP_ENABLED=false

