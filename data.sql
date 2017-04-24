insert into DEPARTMENT (DeptID,Name,Description) Values (1,'IT','Information Technology');
insert into DEPARTMENT (DeptID,Name,Description) Values (2,'HR','Human Resources');
insert into DEPARTMENT (DeptID,Name,Description) Values (3,'Engineering','Application Engineering');
insert into DEPARTMENT (DeptID,Name,Description) Values (4,'Marketing','Marketing Department');
insert into DEPARTMENT (DeptID,Name,Description) Values (5,'Sales','Sales Department');

insert into Network_Administrator (AdministratorID, Password, AdministratorName, LastLogin, LastActivity, DeptID) Values (1,'Not Secure 1','ljames',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,1);
insert into Network_Administrator (AdministratorID, Password, AdministratorName, LastLogin, LastActivity, DeptID) Values (2,'Not Secure 1','jbutler',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,1);
insert into Network_Administrator (AdministratorID, Password, AdministratorName, LastLogin, LastActivity, DeptID) Values (3,'Not Secure 2','rlopez',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,2);
insert into Network_Administrator (AdministratorID, Password, AdministratorName, LastLogin, LastActivity, DeptID) Values (4,'Not Secure 4','kbryant',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,2);
insert into Network_Administrator (AdministratorID, Password, AdministratorName, LastLogin, LastActivity, DeptID) Values (5,'Not Secure 5','rallen',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,5);

insert into IPAM_User (UserID, UserName, Password, DeptID) Values (1, 'ppan', 'Not Secure 1',2);
insert into IPAM_User (UserID, UserName, Password, DeptID) Values (2, 'jbond', 'Not Secure 1',3);
insert into IPAM_User (UserID, UserName, Password, DeptID) Values (3, 'pparker', 'Not Secure 2',1);
insert into IPAM_User (UserID, UserName, Password, DeptID) Values (4, 'bgrimm', 'Not Secure 4',4);
insert into IPAM_User (UserID, UserName, Password, DeptID) Values (5, 'mmagician', 'Not Secure 5',2);

insert into Request_Static (RequestStaticID, Request_Static_Date, UserID, Static_IP_Address, Static_MAC_Address) Values (1, to_date('2017/01/01','yyyy/mm/dd'),1,'192.168.1.1','aa:aa:aa:aa:aa:aa');
insert into Request_Static (RequestStaticID, Request_Static_Date, UserID, Static_IP_Address, Static_MAC_Address) Values (2, to_date('2017/02/01','yyyy/mm/dd'),2,'192.168.1.2','bb:bb:bb:bb:bb:bb');
insert into Request_Static (RequestStaticID, Request_Static_Date, UserID, Static_IP_Address, Static_MAC_Address) Values (3, to_date('2017/03/01','yyyy/mm/dd'),3,'192.168.1.3','cc:cc:cc:cc:cc:cc');
insert into Request_Static (RequestStaticID, Request_Static_Date, UserID, Static_IP_Address, Static_MAC_Address) Values (4, to_date('2017/04/01','yyyy/mm/dd'),4,'192.168.1.4','dd:dd:dd:dd:dd:dd');
insert into Request_Static (RequestStaticID, Request_Static_Date, UserID, Static_IP_Address, Static_MAC_Address) Values (5, to_date('2017/05/01','yyyy/mm/dd'),5,'192.168.1.5','ee:ee:ee:ee:ee:ee');

insert into Device (DeviceID, MACAddress, Hostname, Description, TimeFirstSeen, TimeLastSeen, DeviceType) Values (1,'aa:aa:aa:aa:aa:aa', 'comp1', 'HR PC 1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'PC'); 
insert into Device (DeviceID, MACAddress, Hostname, Description, TimeFirstSeen, TimeLastSeen, DeviceType) Values (2,'bb:bb:bb:bb:bb:bb', 'comp2', 'HR PC 1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'PC'); 
insert into Device (DeviceID, MACAddress, Hostname, Description, TimeFirstSeen, TimeLastSeen, DeviceType) Values (3,'cc:cc:cc:cc:cc:cc', 'comp3', 'HR PC 1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'PC'); 
insert into Device (DeviceID, MACAddress, Hostname, Description, TimeFirstSeen, TimeLastSeen, DeviceType) Values (4,'dd:dd:dd:dd:dd:dd', 'comp4', 'HR PC 1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'PC'); 
insert into Device (DeviceID, MACAddress, Hostname, Description, TimeFirstSeen, TimeLastSeen, DeviceType) Values (5,'ee:ee:ee:ee:ee:ee', 'Engineer1', 'Engineer PC 1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'PC');
insert into Device (DeviceID, MACAddress, Hostname, Description, TimeFirstSeen, TimeLastSeen, DeviceType) Values (6,'11:11:11:11:11:11', 'Engineer2', 'Engineer PC 2', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'PC');
insert into Device (DeviceID, MACAddress, Hostname, Description, TimeFirstSeen, TimeLastSeen, DeviceType) Values (7,'22:22:22:22:22:22', 'Engineer3', 'Engineer PC 3', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'PC');
insert into Device (DeviceID, MACAddress, Hostname, Description, TimeFirstSeen, TimeLastSeen, DeviceType) Values (8,'33:33:33:33:33:33', 'Engineer4', 'Engineer PC 4', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'PC');
insert into Device (DeviceID, MACAddress, Hostname, Description, TimeFirstSeen, TimeLastSeen, DeviceType) Values (9,'44:44:44:44:44:44', 'Engineer5', 'Engineer PC 5', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'PC');
insert into Device (DeviceID, MACAddress, Hostname, Description, TimeFirstSeen, TimeLastSeen, DeviceType) Values (10,'55:55:55:55:55:55', 'Engineer6', 'Engineer PC 6', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'PC');

insert into Supernet (supernetID, Context, Description, Supernet_network_address, Supernet_subnet_mask) Values (1, 'SecureNET', 'Securenet Supernet', '172.16.0.0', '255.255.0.0');
insert into Supernet (supernetID, Context, Description, Supernet_network_address, Supernet_subnet_mask) Values (2, 'HrNET', 'Hr Network Supernet', '192.168.0.0', '255.255.240.0');
insert into Supernet (supernetID, Context, Description, Supernet_network_address, Supernet_subnet_mask) Values (3, 'EngineerNET', 'Engineer Network Supernet', '192.168.16.0', '255.255.240.0');
insert into Supernet (supernetID, Context, Description, Supernet_network_address, Supernet_subnet_mask) Values (4, 'SalesNET', 'Sales Network Supernet', '192.168.32.0', '255.255.240.0');
insert into Supernet (supernetID, Context, Description, Supernet_network_address, Supernet_subnet_mask) Values (5, 'ITNET', 'IT Network Supernet', '192.168.64.0', '255.255.240.0');

insert into Subnet (SubnetID, Subnet, Mask, Description, IPAddressesAvailable, RouterIPAddress, SupernetID) Values (1, '192.168.1.0', '255.255.255.0', 'HR Subnet 1','254', '192.168.1.254',2);
insert into Subnet (SubnetID, Subnet, Mask, Description, IPAddressesAvailable, RouterIPAddress, SupernetID) Values (2, '192.168.2.0', '255.255.255.0', 'HR Subnet 2','254', '192.168.1.254',2);
insert into Subnet (SubnetID, Subnet, Mask, Description, IPAddressesAvailable, RouterIPAddress, SupernetID) Values (3, '192.168.3.0', '255.255.255.0', 'HR Subnet 3','254', '192.168.1.254',2);
insert into Subnet (SubnetID, Subnet, Mask, Description, IPAddressesAvailable, RouterIPAddress, SupernetID) Values (4, '192.168.4.0', '255.255.255.0', 'HR Subnet 4','254', '192.168.1.254',2);
insert into Subnet (SubnetID, Subnet, Mask, Description, IPAddressesAvailable, RouterIPAddress, SupernetID) Values (5, '192.168.16.0', '255.255.255.0', 'Engineer Subnet 1' ,'254', '192.168.1.254',3);


insert into IPAddress (IPAddressID, IPAddress, DateFirstSeen, DateLastSeen, DeviceID, SubnetID) Values (1,'192.168.1.1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1); 
insert into IPAddress (IPAddressID, IPAddress, DateFirstSeen, DateLastSeen, DeviceID, SubnetID) Values (2,'192.168.1.2', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 2, 1); 
insert into IPAddress (IPAddressID, IPAddress, DateFirstSeen, DateLastSeen, DeviceID, SubnetID) Values (3,'192.168.1.3', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 3, 1); 
insert into IPAddress (IPAddressID, IPAddress, DateFirstSeen, DateLastSeen, DeviceID, SubnetID) Values (4,'192.168.1.4', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 4, 1); 
insert into IPAddress (IPAddressID, IPAddress, DateFirstSeen, DateLastSeen, DeviceID, SubnetID) Values (5,'192.168.16.1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 5, 5);
insert into IPAddress (IPAddressID, IPAddress, DateFirstSeen, DateLastSeen, DeviceID, SubnetID) Values (6,'192.168.16.1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 6, 5);
insert into IPAddress (IPAddressID, IPAddress, DateFirstSeen, DateLastSeen, DeviceID, SubnetID) Values (7,'192.168.16.1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 7, 5);
insert into IPAddress (IPAddressID, IPAddress, DateFirstSeen, DateLastSeen, DeviceID, SubnetID) Values (8,'192.168.16.1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 8, 5);
insert into IPAddress (IPAddressID, IPAddress, DateFirstSeen, DateLastSeen, DeviceID, SubnetID) Values (9,'192.168.16.1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 9, 5);
insert into IPAddress (IPAddressID, IPAddress, DateFirstSeen, DateLastSeen, DeviceID, SubnetID) Values (10,'192.168.16.1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 10, 5);

insert into VLAN (VLANID, Name, Description, SubnetID) Values (1111, 'HR_1', 'HR Subnet 1', 1);
insert into VLAN (VLANID, Name, Description, SubnetID) Values (1112, 'HR_2', 'HR Subnet 1', 2);
insert into VLAN (VLANID, Name, Description, SubnetID) Values (1113, 'HR_3', 'HR Subnet 1', 3);
insert into VLAN (VLANID, Name, Description, SubnetID) Values (1114, 'HR_4', 'HR Subnet 1', 4);
insert into VLAN (VLANID, Name, Description, SubnetID) Values (1115, 'Engineer_1', 'Engineer Subnet 1', 5);

insert into AUTODISCOVERY (AUTODISCOVERY_ID, DiscoveryDate, DiscoveryDescription, ipaddressid, DeviceID) values (1, CURRENT_TIMESTAMP, 'Discovery of new Device and Ipaddress', 6, 6);
insert into AUTODISCOVERY (AUTODISCOVERY_ID, DiscoveryDate, DiscoveryDescription, ipaddressid, DeviceID) values (2, CURRENT_TIMESTAMP, 'Discovery of new Ipaddress', 7, null );
insert into AUTODISCOVERY (AUTODISCOVERY_ID, DiscoveryDate, DiscoveryDescription, ipaddressid, DeviceID) values (3, CURRENT_TIMESTAMP, 'Discovery of new Device', null, 7);
insert into AUTODISCOVERY (AUTODISCOVERY_ID, DiscoveryDate, DiscoveryDescription, ipaddressid, DeviceID) values (4, CURRENT_TIMESTAMP, 'Discovery of new Device and Ipaddress', 8, 8);
insert into AUTODISCOVERY (AUTODISCOVERY_ID, DiscoveryDate, DiscoveryDescription, ipaddressid, DeviceID) values (5, CURRENT_TIMESTAMP, 'Discovery of new Device and Ipaddress', 9, 9);
insert into AUTODISCOVERY (AUTODISCOVERY_ID, DiscoveryDate, DiscoveryDescription, ipaddressid, DeviceID) values (6, CURRENT_TIMESTAMP, 'Discovery of new Device and Ipaddress', 10, 10);

insert into change (changeID, Change_Date, DeviceID, VlanID, SubnetID, supernetID, AdministratorID, IPAddressID, RequestStaticID) values (1, CURRENT_TIMESTAMP, 1,null,null,null,1,null,null);
insert into change (changeID, Change_Date, DeviceID, VlanID, SubnetID, supernetID, AdministratorID, IPAddressID, RequestStaticID) values (2, CURRENT_TIMESTAMP, null,1111,1,1,2,1,null);
insert into change (changeID, Change_Date, DeviceID, VlanID, SubnetID, supernetID, AdministratorID, IPAddressID, RequestStaticID) values (3, CURRENT_TIMESTAMP, null,null,null,null,3,null,1);
insert into change (changeID, Change_Date, DeviceID, VlanID, SubnetID, supernetID, AdministratorID, IPAddressID, RequestStaticID) values (4, CURRENT_TIMESTAMP, null,null,null,null,4,null,2);
insert into change (changeID, Change_Date, DeviceID, VlanID, SubnetID, supernetID, AdministratorID, IPAddressID, RequestStaticID) values (5, CURRENT_TIMESTAMP, null,null,null,null,5,null,3);
insert into change (changeID, Change_Date, DeviceID, VlanID, SubnetID, supernetID, AdministratorID, IPAddressID, RequestStaticID) values (6, CURRENT_TIMESTAMP, null,null,null,null,1,null,4);
insert into change (changeID, Change_Date, DeviceID, VlanID, SubnetID, supernetID, AdministratorID, IPAddressID, RequestStaticID) values (7, CURRENT_TIMESTAMP, null,null,null,null,2,null,5);
insert into change (changeID, Change_Date, DeviceID, VlanID, SubnetID, supernetID, AdministratorID, IPAddressID, RequestStaticID) values (8, CURRENT_TIMESTAMP, 2 ,1112,2,2,3,2,null);
insert into change (changeID, Change_Date, DeviceID, VlanID, SubnetID, supernetID, AdministratorID, IPAddressID, RequestStaticID) values (9, CURRENT_TIMESTAMP, null,null,3,3,4,null,null);
insert into change (changeID, Change_Date, DeviceID, VlanID, SubnetID, supernetID, AdministratorID, IPAddressID, RequestStaticID) values (10, CURRENT_TIMESTAMP, 3,1113,null,null,5,3,null);
insert into change (changeID, Change_Date, DeviceID, VlanID, SubnetID, supernetID, AdministratorID, IPAddressID, RequestStaticID) values (11, CURRENT_TIMESTAMP, 4,1114,4,4,1,4,null);
insert into change (changeID, Change_Date, DeviceID, VlanID, SubnetID, supernetID, AdministratorID, IPAddressID, RequestStaticID) values (12, CURRENT_TIMESTAMP, 5,1115,5,5,2,5,null);
