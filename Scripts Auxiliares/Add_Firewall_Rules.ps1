# verificar a necessidade dos comandos
netsh advfirewall firewall add rule name="MCM Port Forwarding 6516" description="Allow MCM Port Forwarding 6516 - INC1381981" dir=in action=Allow protocol=TCP localport=6516
netsh advfirewall firewall add rule name="MCM Port Forwarding 6516" description="Allow MCM Port Forwarding 6516 - INC1381981" dir=out action=Allow protocol=TCP localport=6516
netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=6516 connectaddress=BR00SRVAPP058R1 connectport=6516
powershell -command sc config iphlpsvc start=delayed-auto