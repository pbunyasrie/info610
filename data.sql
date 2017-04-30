insert into DEPARTMENT (DeptID,Name,Description) Values (DEPARTMENT_sequence.nextval,'IT','Information Technology');
insert into DEPARTMENT (DeptID,Name,Description) Values (DEPARTMENT_sequence.nextval,'HR','Human Resources');
insert into DEPARTMENT (DeptID,Name,Description) Values (DEPARTMENT_sequence.nextval,'Engineering','Application Engineering');
insert into DEPARTMENT (DeptID,Name,Description) Values (DEPARTMENT_sequence.nextval,'Marketing','Marketing Department');
insert into DEPARTMENT (DeptID,Name,Description) Values (DEPARTMENT_sequence.nextval,'Sales','Sales Department');

insert into Network_Administrator (AdministratorID, Password, AdministratorName, LastLogin, LastActivity, DeptID) Values (Network_Administrator_sequence.nextval,'Not Secure 1','ljames',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,1);
insert into Network_Administrator (AdministratorID, Password, AdministratorName, LastLogin, LastActivity, DeptID) Values (Network_Administrator_sequence.nextval,'Not Secure 1','jbutler',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,1);
insert into Network_Administrator (AdministratorID, Password, AdministratorName, LastLogin, LastActivity, DeptID) Values (Network_Administrator_sequence.nextval,'Not Secure 2','rlopez',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,2);
insert into Network_Administrator (AdministratorID, Password, AdministratorName, LastLogin, LastActivity, DeptID) Values (Network_Administrator_sequence.nextval,'Not Secure 4','kbryant',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,2);
insert into Network_Administrator (AdministratorID, Password, AdministratorName, LastLogin, LastActivity, DeptID) Values (Network_Administrator_sequence.nextval,'Not Secure 5','rallen',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,5);

insert into IPAM_User (UserID, UserName, Password, DeptID) Values (IPAM_User_sequence.nextval, 'ppan', 'Not Secure 1',2);
insert into IPAM_User (UserID, UserName, Password, DeptID) Values (IPAM_User_sequence.nextval, 'jbond', 'Not Secure 1',3);
insert into IPAM_User (UserID, UserName, Password, DeptID) Values (IPAM_User_sequence.nextval, 'pparker', 'Not Secure 2',1);
insert into IPAM_User (UserID, UserName, Password, DeptID) Values (IPAM_User_sequence.nextval, 'bgrimm', 'Not Secure 4',4);
insert into IPAM_User (UserID, UserName, Password, DeptID) Values (IPAM_User_sequence.nextval, 'mmagician', 'Not Secure 5',2);

insert into Request_Static (RequestStaticID, Request_Static_Date, UserID, Static_IP_Address, Static_MAC_Address) Values (Request_Static_sequence.nextval, to_date('2017/01/01','yyyy/mm/dd'),1,'192.168.1.1','aa:aa:aa:aa:aa:aa');
insert into Request_Static (RequestStaticID, Request_Static_Date, UserID, Static_IP_Address, Static_MAC_Address) Values (Request_Static_sequence.nextval, to_date('2017/02/01','yyyy/mm/dd'),2,'192.168.1.2','bb:bb:bb:bb:bb:bb');
insert into Request_Static (RequestStaticID, Request_Static_Date, UserID, Static_IP_Address, Static_MAC_Address) Values (Request_Static_sequence.nextval, to_date('2017/03/01','yyyy/mm/dd'),3,'192.168.1.3','cc:cc:cc:cc:cc:cc');
insert into Request_Static (RequestStaticID, Request_Static_Date, UserID, Static_IP_Address, Static_MAC_Address) Values (Request_Static_sequence.nextval, to_date('2017/04/01','yyyy/mm/dd'),4,'192.168.1.4','dd:dd:dd:dd:dd:dd');
insert into Request_Static (RequestStaticID, Request_Static_Date, UserID, Static_IP_Address, Static_MAC_Address) Values (Request_Static_sequence.nextval, to_date('2017/05/01','yyyy/mm/dd'),5,'192.168.1.5','ee:ee:ee:ee:ee:ee');

insert into Device (DeviceID, MACAddress, Hostname, Description, TimeFirstSeen, TimeLastSeen, DeviceType) Values (DEVICE_sequence.nextval,'aa:aa:aa:aa:aa:aa', 'comp1', 'HR PC 1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'PC'); 
insert into Device (DeviceID, MACAddress, Hostname, Description, TimeFirstSeen, TimeLastSeen, DeviceType) Values (DEVICE_sequence.nextval,'bb:bb:bb:bb:bb:bb', 'comp2', 'HR PC 1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'PC'); 
insert into Device (DeviceID, MACAddress, Hostname, Description, TimeFirstSeen, TimeLastSeen, DeviceType) Values (DEVICE_sequence.nextval,'cc:cc:cc:cc:cc:cc', 'comp3', 'HR PC 1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'PC'); 
insert into Device (DeviceID, MACAddress, Hostname, Description, TimeFirstSeen, TimeLastSeen, DeviceType) Values (DEVICE_sequence.nextval,'dd:dd:dd:dd:dd:dd', 'comp4', 'HR PC 1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'PC'); 
insert into Device (DeviceID, MACAddress, Hostname, Description, TimeFirstSeen, TimeLastSeen, DeviceType) Values (DEVICE_sequence.nextval,'ee:ee:ee:ee:ee:ee', 'Engineer1', 'Engineer PC 1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'PC');
insert into Device (DeviceID, MACAddress, Hostname, Description, TimeFirstSeen, TimeLastSeen, DeviceType) Values (DEVICE_sequence.nextval,'11:11:11:11:11:11', 'Engineer2', 'Engineer PC 2', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'PC');
insert into Device (DeviceID, MACAddress, Hostname, Description, TimeFirstSeen, TimeLastSeen, DeviceType) Values (DEVICE_sequence.nextval,'22:22:22:22:22:22', 'Engineer3', 'Engineer PC 3', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'PC');
insert into Device (DeviceID, MACAddress, Hostname, Description, TimeFirstSeen, TimeLastSeen, DeviceType) Values (DEVICE_sequence.nextval,'33:33:33:33:33:33', 'Engineer4', 'Engineer PC 4', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'PC');
insert into Device (DeviceID, MACAddress, Hostname, Description, TimeFirstSeen, TimeLastSeen, DeviceType) Values (DEVICE_sequence.nextval,'44:44:44:44:44:44', 'Engineer5', 'Engineer PC 5', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'PC');
insert into Device (DeviceID, MACAddress, Hostname, Description, TimeFirstSeen, TimeLastSeen, DeviceType) Values (DEVICE_sequence.nextval,'55:55:55:55:55:55', 'Engineer6', 'Engineer PC 6', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'PC');

INSERT INTO CHANGELOG_DEVICE (ChangeLogDeviceID, ChangeLog_Device_date, Log_DeviceID) VALUES (CHANGELOG_DEVICE_sequence.nextval, CURRENT_TIMESTAMP, 1);
INSERT INTO CHANGELOG_DEVICE (ChangeLogDeviceID, ChangeLog_Device_date, Log_DeviceID) VALUES (CHANGELOG_DEVICE_sequence.nextval, CURRENT_TIMESTAMP, 2);
INSERT INTO CHANGELOG_DEVICE (ChangeLogDeviceID, ChangeLog_Device_date, Log_DeviceID) VALUES (CHANGELOG_DEVICE_sequence.nextval, CURRENT_TIMESTAMP, 3);
INSERT INTO CHANGELOG_DEVICE (ChangeLogDeviceID, ChangeLog_Device_date, Log_DeviceID) VALUES (CHANGELOG_DEVICE_sequence.nextval, CURRENT_TIMESTAMP, 4);
INSERT INTO CHANGELOG_DEVICE (ChangeLogDeviceID, ChangeLog_Device_date, Log_DeviceID) VALUES (CHANGELOG_DEVICE_sequence.nextval, CURRENT_TIMESTAMP, 5);

insert into Supernet (supernetID, Context, Description, Supernet_network_address, Supernet_subnet_mask) Values (SUPERNET_sequence.nextval, 'SecureNET', 'Securenet Supernet', '172.16.0.0', '255.255.0.0');
insert into Supernet (supernetID, Context, Description, Supernet_network_address, Supernet_subnet_mask) Values (SUPERNET_sequence.nextval, 'HrNET', 'Hr Network Supernet', '192.168.0.0', '255.255.240.0');
insert into Supernet (supernetID, Context, Description, Supernet_network_address, Supernet_subnet_mask) Values (SUPERNET_sequence.nextval, 'EngineerNET', 'Engineer Network Supernet', '192.168.16.0', '255.255.240.0');
insert into Supernet (supernetID, Context, Description, Supernet_network_address, Supernet_subnet_mask) Values (SUPERNET_sequence.nextval, 'SalesNET', 'Sales Network Supernet', '192.168.32.0', '255.255.240.0');
insert into Supernet (supernetID, Context, Description, Supernet_network_address, Supernet_subnet_mask) Values (SUPERNET_sequence.nextval, 'ITNET', 'IT Network Supernet', '192.168.64.0', '255.255.240.0');

insert into Subnet (SubnetID, Subnet, Mask, Description, RouterIPAddress, SupernetID) Values (SUBNET_sequence.nextval, '192.168.1.0', '255.255.255.0', 'HR Subnet 1', '192.168.1.254',2);
insert into Subnet (SubnetID, Subnet, Mask, Description, RouterIPAddress, SupernetID) Values (SUBNET_sequence.nextval, '192.168.2.0', '255.255.255.0', 'HR Subnet 2', '192.168.1.254',2);
insert into Subnet (SubnetID, Subnet, Mask, Description, RouterIPAddress, SupernetID) Values (SUBNET_sequence.nextval, '192.168.3.0', '255.255.255.0', 'HR Subnet 3', '192.168.1.254',2);
insert into Subnet (SubnetID, Subnet, Mask, Description, RouterIPAddress, SupernetID) Values (SUBNET_sequence.nextval, '192.168.4.0', '255.255.255.0', 'HR Subnet 4', '192.168.1.254',2);
insert into Subnet (SubnetID, Subnet, Mask, Description, RouterIPAddress, SupernetID) Values (SUBNET_sequence.nextval, '192.168.16.0', '255.255.255.0', 'Engineer Subnet 1' , '192.168.1.254',3);


insert into IPAddress (IPAddressID, IPAddress, DateFirstSeen, DateLastSeen, DeviceID, SubnetID) Values (IPADDRESS_sequence.nextval,'192.168.1.1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1); 
insert into IPAddress (IPAddressID, IPAddress, DateFirstSeen, DateLastSeen, DeviceID, SubnetID) Values (IPADDRESS_sequence.nextval,'192.168.1.2', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 2, 1); 
insert into IPAddress (IPAddressID, IPAddress, DateFirstSeen, DateLastSeen, DeviceID, SubnetID) Values (IPADDRESS_sequence.nextval,'192.168.1.3', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 3, 1); 
insert into IPAddress (IPAddressID, IPAddress, DateFirstSeen, DateLastSeen, DeviceID, SubnetID) Values (IPADDRESS_sequence.nextval,'192.168.1.4', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 4, 1); 
insert into IPAddress (IPAddressID, IPAddress, DateFirstSeen, DateLastSeen, DeviceID, SubnetID) Values (IPADDRESS_sequence.nextval,'192.168.16.1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 5, 5);
insert into IPAddress (IPAddressID, IPAddress, DateFirstSeen, DateLastSeen, DeviceID, SubnetID) Values (IPADDRESS_sequence.nextval,'192.168.16.2', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 6, 5);
insert into IPAddress (IPAddressID, IPAddress, DateFirstSeen, DateLastSeen, DeviceID, SubnetID) Values (IPADDRESS_sequence.nextval,'192.168.16.3', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 7, 5);
insert into IPAddress (IPAddressID, IPAddress, DateFirstSeen, DateLastSeen, DeviceID, SubnetID) Values (IPADDRESS_sequence.nextval,'192.168.16.4', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 8, 5);
insert into IPAddress (IPAddressID, IPAddress, DateFirstSeen, DateLastSeen, DeviceID, SubnetID) Values (IPADDRESS_sequence.nextval,'192.168.16.5', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 9, 5);
insert into IPAddress (IPAddressID, IPAddress, DateFirstSeen, DateLastSeen, DeviceID, SubnetID) Values (IPADDRESS_sequence.nextval,'192.168.16.6', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 10, 5);

INSERT INTO CHANGELOG_IPADDRESS (ChangeLog_IPAddressID, ChangeLog_IPAddress_date, ChangeLog_User, Status, Log_IPAddressID, Log_IPAddress, Log_DateFirstSeen, Log_DateLastSeen, Log_DeviceID, Log_SubnetID) VALUES (CHANGELOG_IPADDRESS_sequence.nextval, CURRENT_TIMESTAMP, 'ppan', 'Updated', 1, '192.168.1.1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1);
INSERT INTO CHANGELOG_IPADDRESS (ChangeLog_IPAddressID, ChangeLog_IPAddress_date, ChangeLog_User, Status, Log_IPAddressID, Log_IPAddress, Log_DateFirstSeen, Log_DateLastSeen, Log_DeviceID, Log_SubnetID) VALUES (CHANGELOG_IPADDRESS_sequence.nextval, CURRENT_TIMESTAMP, 'ljames', 'Updated', 1, '192.168.1.1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1);
INSERT INTO CHANGELOG_IPADDRESS (ChangeLog_IPAddressID, ChangeLog_IPAddress_date, ChangeLog_User, Status, Log_IPAddressID, Log_IPAddress, Log_DateFirstSeen, Log_DateLastSeen, Log_DeviceID, Log_SubnetID) VALUES (CHANGELOG_IPADDRESS_sequence.nextval, CURRENT_TIMESTAMP, 'rallen', 'Updated', 1, '192.168.1.1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1);
INSERT INTO CHANGELOG_IPADDRESS (ChangeLog_IPAddressID, ChangeLog_IPAddress_date, ChangeLog_User, Status, Log_IPAddressID, Log_IPAddress, Log_DateFirstSeen, Log_DateLastSeen, Log_DeviceID, Log_SubnetID) VALUES (CHANGELOG_IPADDRESS_sequence.nextval, CURRENT_TIMESTAMP, 'kbryant', 'Updated', 1, '192.168.1.1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1);


insert into VLAN (VLANID, Name, Description, SubnetID) Values (1111, 'HR_1', 'VLAN used for a HR subnet', 1);
insert into VLAN (VLANID, Name, Description, SubnetID) Values (1112, 'HR_2', 'VLAN used for a HR subnet', 2);
insert into VLAN (VLANID, Name, Description, SubnetID) Values (1113, 'HR_3', 'VLAN used for a HR subnet', 3);
insert into VLAN (VLANID, Name, Description, SubnetID) Values (1114, 'HR_4', 'VLAN used for a HR subnet', 4);
insert into VLAN (VLANID, Name, Description, SubnetID) Values (1115, 'Engineer_1', 'VLAN used for an Engineer subnet', 5);

insert into AUTODISCOVERY (AUTODISCOVERY_ID, DiscoveryDate, DiscoveryDescription, ipaddressid, DeviceID) values (AUTODISCOVERY_sequence.nextval, CURRENT_TIMESTAMP, 'Discovery of new Device and Ipaddress', 6, 6);
insert into AUTODISCOVERY (AUTODISCOVERY_ID, DiscoveryDate, DiscoveryDescription, ipaddressid, DeviceID) values (AUTODISCOVERY_sequence.nextval, CURRENT_TIMESTAMP, 'Discovery of new Ipaddress', 7, null );
insert into AUTODISCOVERY (AUTODISCOVERY_ID, DiscoveryDate, DiscoveryDescription, ipaddressid, DeviceID) values (AUTODISCOVERY_sequence.nextval, CURRENT_TIMESTAMP, 'Discovery of new Device', null, 7);
insert into AUTODISCOVERY (AUTODISCOVERY_ID, DiscoveryDate, DiscoveryDescription, ipaddressid, DeviceID) values (AUTODISCOVERY_sequence.nextval, CURRENT_TIMESTAMP, 'Discovery of new Device and Ipaddress', 8, 8);
insert into AUTODISCOVERY (AUTODISCOVERY_ID, DiscoveryDate, DiscoveryDescription, ipaddressid, DeviceID) values (AUTODISCOVERY_sequence.nextval, CURRENT_TIMESTAMP, 'Discovery of new Device and Ipaddress', 9, 9);
insert into AUTODISCOVERY (AUTODISCOVERY_ID, DiscoveryDate, DiscoveryDescription, ipaddressid, DeviceID) values (AUTODISCOVERY_sequence.nextval, CURRENT_TIMESTAMP, 'Discovery of new Device and Ipaddress', 10, 10);

insert into change (changeID, Change_Date, DeviceID, VlanID, SubnetID, supernetID, AdministratorID, IPAddressID, RequestStaticID) values (CHANGE_sequence.nextval, CURRENT_TIMESTAMP, 1,null,null,null,1,null,null);
insert into change (changeID, Change_Date, DeviceID, VlanID, SubnetID, supernetID, AdministratorID, IPAddressID, RequestStaticID) values (CHANGE_sequence.nextval, CURRENT_TIMESTAMP, null,1111,1,1,2,1,1);
insert into change (changeID, Change_Date, DeviceID, VlanID, SubnetID, supernetID, AdministratorID, IPAddressID, RequestStaticID) values (CHANGE_sequence.nextval, CURRENT_TIMESTAMP, null,null,null,null,4,null,2);
insert into change (changeID, Change_Date, DeviceID, VlanID, SubnetID, supernetID, AdministratorID, IPAddressID, RequestStaticID) values (CHANGE_sequence.nextval, CURRENT_TIMESTAMP, null,null,null,null,5,null,3);
insert into change (changeID, Change_Date, DeviceID, VlanID, SubnetID, supernetID, AdministratorID, IPAddressID, RequestStaticID) values (CHANGE_sequence.nextval, CURRENT_TIMESTAMP, null,null,null,null,1,null,4);
insert into change (changeID, Change_Date, DeviceID, VlanID, SubnetID, supernetID, AdministratorID, IPAddressID, RequestStaticID) values (CHANGE_sequence.nextval, CURRENT_TIMESTAMP, null,null,null,null,2,null,5);
insert into change (changeID, Change_Date, DeviceID, VlanID, SubnetID, supernetID, AdministratorID, IPAddressID, RequestStaticID) values (CHANGE_sequence.nextval, CURRENT_TIMESTAMP, 2 ,1112,2,2,3,2,null);
insert into change (changeID, Change_Date, DeviceID, VlanID, SubnetID, supernetID, AdministratorID, IPAddressID, RequestStaticID) values (CHANGE_sequence.nextval, CURRENT_TIMESTAMP, null,null,3,3,4,null,null);
insert into change (changeID, Change_Date, DeviceID, VlanID, SubnetID, supernetID, AdministratorID, IPAddressID, RequestStaticID) values (CHANGE_sequence.nextval, (TO_TIMESTAMP('05-MAR-17 10.31.19', 'DD-MON-YY HH.MI.SS')), 3,1113,null,null,5,3,null);
insert into change (changeID, Change_Date, DeviceID, VlanID, SubnetID, supernetID, AdministratorID, IPAddressID, RequestStaticID) values (CHANGE_sequence.nextval, (TO_TIMESTAMP('03-MAR-17 10.31.19', 'DD-MON-YY HH.MI.SS')), 4,1114,4,4,1,4,null);
insert into change (changeID, Change_Date, DeviceID, VlanID, SubnetID, supernetID, AdministratorID, IPAddressID, RequestStaticID) values (CHANGE_sequence.nextval, (TO_TIMESTAMP('03-MAR-17 10.31.19', 'DD-MON-YY HH.MI.SS')), 5,1115,5,5,2,5,null);

