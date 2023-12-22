# AWS Windows Server 2019 on Seperate LAN 
we chose to use a Amazon web Service for the Virtual private cloud and EC2 instance. These two options enable us to spin up a windows server online with a connection on the cloud attached. The cloud allows the Windows server to connect anywhere in the world through a virtual private network that is tunneled to our pfsense route. Below is the configurations for the Virtual Private Cloud, the Virtual Private network, and the EC2 instance (Windows Server) 
## VPC
- IPv4 CIDR: 10.0.0.0/16
### subnets: 
- IPv4 CIDR: 10.0.0.0/24
- Auto-assign public IPv4 address
### Internet Gateways
- project igw
### route tables - public-rtb
#### routes 
- 0.0.0.0/0 - internet gateway
- 10.0.0.0/16 - local
- 172.16.0.0/16 - virtual gateway
### security groups - sg public
- inbound rules - IPv4 - all traffic - source (home computers IP address/32)
- inbound rules - IPv4 - all traffic - source (virtual gateway)
- outbound rules - IPv4 - all traffic - destination (0.0.0.0/0)
### customer gateways
- custgat - type(ipsec.1) - ipaddress(home computers IP address/32) 
### Virtual private gateways
- vprivgat - type(ipsec.1) - VPC(vpc created)
### VPN 
- attached created 
- cgw
- vpgw
- routing static 
- local IPv4 network CIDR 172.16.0.0/16(virtual gateway)
- remote IPv4 network CIDR 10.0.0.0/16(vpc)
- (static routes tab) assign the 172.16.0.0/16 virtual gateway

- public IP: 3.141.249.247 
- subnet: 10.0.0.0/16 

## EC2 - Instances
- t2.micro 
- previously created security group
- windows server 2019
- security key created
- powershell command to allow icmp after boot "New-NetFirewallRule -DisplayName "Allow ICMPv4-In" -Protocol ICMPv4 -IcmpType 8 -Enabled True -Direction Inbound -Action Allow"


---
# Endpoints
Our endpoints are configured according to the departments Sales and Marketing, Research and Development, and Future Expansion. Each endpoint is has a Windows 10 Operating system to communicate with the Windows server. The router for choice is pfsense. The pfsense has a vpn tunneling capability to allow communication from the server to the endpoints. We set up the endpoints to each connect to different network adapters to signify different Virtual Networks in each department. Below is the configuration for the machines.
## Virtual Box
### pfsense
- Network adapter1: BridgedAdapter, eno1
- Network adapter2: Internal Network, SandM (VLAN 20)
- Network adapter1: Internal Network, RandD (VLAN 30)
- Network adapter1: Internal Network, FE (VLAN 40)
### Windows 10 endpoint(Sales and Marketing)
- Processor: 1
- Network adapter: Internal Network, SandM
### Windows 10 endpoint(Research and Development)
- Processor: 1
- Network adapter: Internal Network, RandD
### Windows 10 endpoint(Future Exansion)
- Processor: 1
- Network adapter: Internal Network, FE
---
# pfsense
## VPN IPSec tunnel
### Phase 1
- ID 1
- IKEv1
- Remote Gateway: AWS-WAN-3.141.249.247(or marcus's) 
- Auth: Mutual PSK
- P1 Protocol: AES (128 bits)
- P1 transforms: SHA1
- P1 DH-Group: 2 
- P1 description: awsvpn(or marcus's)
### Phase 2 
- ID 1
- Mode: Tunnel
- Network-Local Subnet: 172.16.0.0/16(subnets the vm's are using)
- Remote Subnet: 10.0.0.0/16(AWS server)
- P2 protocol: ESP
- P2 transforms: AES (128 bits)
- P2 Auth: SHA1
- P2 Description: phase2

## Interfaces - Interface Assignments
- WAN: em0
- SalesandMarketing: em1
- ResearchandDevelopment: em2
- FutureExpansion: em3

## Services - DHCP Server
### SALESANDMARKETING
- Enable DHCP server on SALESANDMARKETING interface
- subnet: 172.16.20.0/24
- subnet range: 172.16.20.1 - 172.16.20.254
- subent pool: 172.16.20.50 - 172.16.20.200
### RESEARCHANDDEVELOPMENT
- Enable DHCP server on RESEARCHANDDEVELOPMENT interface
- subnet: 172.16.30.0/24
- subnet range: 172.16.30.1 - 172.16.30.254
- subent pool: 172.16.30.50 - 172.16.30.200
### FUTUREEXPANSION
- Enable DHCP server on FUTUREEXPANSION interface
- subnet: 172.16.40.0/24
- subnet range: 172.16.40.1 - 172.16.40.254
- subent pool: 172.16.40.50 - 172.16.40.200

## Firewall - Rules
Firewalls provide the security division between the networks so there is no communication between machines in different departments while still allowing communcication between the server and endpoints. Below is the firewall configurations.
### SALESANDMARKETING 
- 4 rules(5 if antilockout rule is counted)
#### rule 1 
- block 
- Interface: SALESANDMARKETING
- Address family: IPv4
- Protocol: any
- source: SALESANDMARKETING subnets
- destination: FUTUREEXPANSION subnets
#### rule 2
- block 
- Interface: SALESANDMARKETING
- Address family: IPv4
- Protocol: any
- source: SALESANDMARKETING subnets
- destination: RESEARCHANDDEVELOPMENT subnets
#### rule 3
- pass
- Interface: SALESANDMARKETING
- Address family: IPv4
- Protocol: any
- source: SALESANDMARKETING subnets
- destination: any
#### rule 4 
- pass 
- Interface: SALESANDMARKETING
- Address family: IPv6
- Protocol: any
- source: SALESANDMARKETING subnets
- destination: any
---
### RESEARCHANDDEVELOPMENT 
- 4 rules(5 if antilockout rule is counted)
#### rule 1 
- block 
- Interface: RESEARCHANDDEVELOPMENT
- Address family: IPv4
- Protocol: any
- source: RESEARCHANDDEVELOPMENT subnets
- destination: SALESANDMARKETING subnets
#### rule 2
- block 
- Interface: RESEARCHANDDEVELOPMENT
- Address family: IPv4
- Protocol: any
- source: RESEARCHANDDEVELOPMENT subnets
- destination: FUTUREEXPANSION subnets
#### rule 3
- pass
- Interface: RESEARCHANDDEVELOPMENT
- Address family: IPv4
- Protocol: any
- source: RESEARCHANDDEVELOPMENT subnets
- destination: any
#### rule 4 
- pass 
- Interface: RESEARCHANDDEVELOPMENT
- Address family: IPv6
- Protocol: any
- source: RESEARCHANDDEVELOPMENT subnets
- destination: any
---
### FUTUREEXPANSION 
- 4 rules(5 if antilockout rule is counted)
#### rule 1 
- block 
- Interface: FUTUREEXPANSION
- Address family: IPv4
- Protocol: any
- source: FUTUREEXPANSION subnets
- destination: SALESANDMARKETING subnets
#### rule 2
- block 
- Interface: FUTUREEXPANSION
- Address family: IPv4
- Protocol: any
- source: FUTUREEXPANSION subnets
- destination: RESEARCHANDDEVELOPMENT subnets
#### rule 3
- pass
- Interface: FUTUREEXPANSION
- Address family: IPv4
- Protocol: any
- source: FUTUREEXPANSION subnets
- destination: any
#### rule 4 
- pass 
- Interface: FUTUREEXPANSION
- Address family: IPv6
- Protocol: any
- source: FUTUREEXPANSION subnets
- destination: any