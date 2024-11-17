
## iproute 临时路由, 重启失效
#ip route add 192.168.1.0/24 via 192.168.18.200
#ip route del 192.168.1.0/24 via 192.168.18.200

## mac 临时路由, 重启失效
#sudo route add -net 192.168.1.0/24 -iface Ethernet0
#sudo route add -host 192.168.1.1 -iface Ethernet0
#sudo route add -net 192.168.1.0/24 192.168.18.200
#sudo route add -host 192.168.1.1 192.168.18.200
#sudo route delete 192.168.1.0/24
#sudo route delete 192.168.1.1

## mac 永久路由, 重启有效
#networksetup -listallnetworkservices
#networksetup -getadditionalroutes Ethernet0
#networksetup -setadditionalroutes Ethernet0 192.168.1.0/24 192.168.18.200
#networksetup -setadditionalroutes Ethernet0 192.168.1.0 255.255.255.0 192.168.18.200
#networksetup -setadditionalroutes Ethernet0

## windows 临时路由, 重启失效
#route add 192.168.1.0 mask 255.255.255.0 192.168.18.200
#route change 192.168.1.0 mask 255.255.255.0 192.168.18.249
#route delete 192.168.1.0 mask 255.255.255.0

## windows 永久路由, 重启有效
#route -p add 192.168.1.0 mask 255.255.255.0 192.168.18.200
#route -p change 192.168.1.0 mask 255.255.255.0 192.168.18.249
#route -p delete 192.168.1.0 mask 255.255.255.0

