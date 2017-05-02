/* DROP TABLES */
drop table DEPARTMENT CASCADE CONSTRAINTS;
drop table Network_Administrator CASCADE CONSTRAINTS;
drop table IPAM_User CASCADE CONSTRAINTS;
drop table Request_Static CASCADE CONSTRAINTS;
drop table DEVICE CASCADE CONSTRAINTS;
drop table CHANGELOG_DEVICE CASCADE CONSTRAINTS;
drop table SUPERNET CASCADE CONSTRAINTS;
drop table SUBNET CASCADE CONSTRAINTS;
drop table IPADDRESS CASCADE CONSTRAINTS;
drop table CHANGELOG_IPADDRESS CASCADE CONSTRAINTS;
drop table VLAN CASCADE CONSTRAINTS;
drop table AUTODISCOVERY CASCADE CONSTRAINTS;
drop table Change CASCADE CONSTRAINTS;

/* DROP SEQUENCES */
drop sequence DEPARTMENT_sequence;
drop sequence Network_Administrator_sequence;
drop sequence IPAM_User_sequence;
drop sequence Request_Static_sequence;
drop sequence DEVICE_sequence;
drop sequence CHANGELOG_DEVICE_sequence;
drop sequence SUPERNET_sequence;
drop sequence SUBNET_sequence;
drop sequence IPADDRESS_sequence;
drop sequence CHANGELOG_IPADDRESS_sequence;
drop sequence AUTODISCOVERY_sequence;
drop sequence CHANGE_sequence;

/* CREATE SEQUENCES */
CREATE SEQUENCE DEPARTMENT_sequence START WITH 1 INCREMENT BY 1; 
CREATE SEQUENCE Network_Administrator_sequence START WITH 1 INCREMENT BY 1; 
CREATE SEQUENCE IPAM_User_sequence START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Request_Static_sequence START WITH 1 INCREMENT BY 1; 
CREATE SEQUENCE DEVICE_sequence START WITH 1 INCREMENT BY 1; 
CREATE SEQUENCE CHANGELOG_DEVICE_sequence START WITH 1 INCREMENT BY 1; 
CREATE SEQUENCE SUPERNET_sequence START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SUBNET_sequence START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IPADDRESS_sequence START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE CHANGELOG_IPADDRESS_sequence START WITH 1 INCREMENT BY 1; 
CREATE SEQUENCE AUTODISCOVERY_sequence START WITH 1 INCREMENT BY 1; 
CREATE SEQUENCE CHANGE_sequence START WITH 1 INCREMENT BY 1; 

/* CREATE TABLES */
CREATE TABLE DEPARTMENT(	
  DeptID integer not null,
  Name VARCHAR(25),
  Description VARCHAR(25),
  constraint Department_PK Primary Key (DeptID)
);

CREATE TABLE Network_Administrator(
  AdministratorID integer not null,
  Password VARCHAR(25),
  AdministratorName VARCHAR(25),
  LastLogin TimeStamp,
  LastActivity TimeStamp,
  DeptID Integer,
  constraint Administrator_PK Primary Key (AdministratorID),
  constraint AdministratorName Unique (AdministratorName),
  constraint Administrator_FK1 Foreign Key (DeptID)
    REFERENCES Department(DeptID)
);
 
CREATE TABLE IPAM_User (
  UserID integer not null,
  UserName VARCHAR(25),
  Password VARCHAR(25),
  DeptID integer,
  constraint UserID_PK Primary Key (UserID),
  constraint UserName Unique (UserName),
  constraint User_FK1 Foreign Key (DeptID)
    REFERENCES Department(DeptID)
);

CREATE TABLE Request_Static (
  RequestStaticID integer not null,
  Request_Static_Date date,
  UserID integer,
  Static_IP_Address varchar(25),
  Static_MAC_Address varchar(17),
  constraint Request_Static_PK Primary Key (RequestStaticID),
  constraint Request_Static_FK1 Foreign Key (UserID)
  References IPAM_User(UserID) ON DELETE SET NULL
  );

CREATE TABLE DEVICE (
  DeviceID integer not null,
  MACAddress varchar(17),
  Hostname varchar(20),
  Description varchar(40),
  TimeFirstSeen TimeStamp,
  TimeLastSeen  TimeStamp,
  DeviceType varchar(20),
  constraint Device_PK Primary Key (DeviceID)
);

CREATE TABLE CHANGELOG_DEVICE (
  ChangeLogDeviceID integer not null,
  ChangeLog_Device_date timestamp,
  ChangeLog_User varchar(100), 
  Status varchar(15),
  Log_DeviceID integer,
  Log_MACAddress varchar(17),
  Log_Hostname varchar(20),
  Log_Description varchar(40),
  Log_TimeFirstSeen TimeStamp,
  Log_TimeLastSeen  TimeStamp,
  Log_DeviceType varchar(20),
  constraint ChangeLog_Device_PK Primary Key (ChangeLogDeviceID)
); 


CREATE TABLE SUPERNET (
  SupernetID integer not null,
  Context varchar(20),
  Description varchar(40),
  Supernet_network_address varchar(20),
  Supernet_subnet_mask varchar(20),
  constraint Supernet_PK Primary Key (SupernetID),
  CONSTRAINT chk_supernet_subnet_mask CHECK (Supernet_subnet_mask IN ('255.255.255.254','255.255.255.252','255.255.255.248','255.255.255.240','255.255.255.224','255.255.255.192','255.255.255.128','255.255.255.0','255.255.254.0','255.255.252.0','255.255.248.0','255.255.240.0'
    ,'255.255.224.0','255.255.192.0','255.255.128.0','255.255.0.0','255.254.0.0','255.252.0.0','255.248.0.0','255.240.0.0','255.224.0.0','255.192.0.0','255.128.0.0','255.0.0.0'))
);

CREATE TABLE SUBNET (
  SubnetID integer not null,
  Subnet varchar(20),
  Mask varchar(20),
  Description varchar(40),
  RouterIPAddress varchar(20),
  SupernetID integer,
  constraint Subnet_PK Primary Key (SubnetID),
  constraint Subnet_FK2 Foreign Key (SupernetID)
  references Supernet(SupernetID),
   CONSTRAINT chk_mask CHECK (Mask IN ('255.255.255.254','255.255.255.252','255.255.255.248','255.255.255.240','255.255.255.224','255.255.255.192','255.255.255.128','255.255.255.0','255.255.254.0','255.255.252.0','255.255.248.0','255.255.240.0','255.255.224.0','255.255.192.0','255.255.128.0','255.255.0.0','255.254.0.0','255.252.0.0','255.248.0.0','255.240.0.0','255.224.0.0','255.192.0.0','255.128.0.0','255.0.0.0'))

);

CREATE TABLE IPADDRESS (
  IPAddressID integer not null,
  IPAddress VARCHAR(25),
  DateFirstSeen TimeStamp,
  DateLastSeen TimeStamp,
  DeviceID integer,
  SubnetID integer,
  constraint UniqueIpaddress Unique (ipaddress),
  constraint IPAddress_PK Primary Key (IPAddressID),
  constraint IPAddress_FK2 Foreign Key (DeviceID)
    references device(DeviceID) ON DELETE CASCADE,
  constraint IPAddress_FK3 Foreign Key (SubnetID)
    references Subnet(SubnetID)
);

CREATE TABLE CHANGELOG_IPADDRESS (
  ChangeLog_IPAddressID integer not null,
  ChangeLog_IPAddress_date TimeStamp,
  ChangeLog_User varchar(100), 
  Status varchar(15),
  Log_IPAddressID integer,
  Log_IPAddress VARCHAR(25),
  Log_DateFirstSeen TimeStamp,
  Log_DateLastSeen TimeStamp,
  Log_DeviceID integer,
  Log_SubnetID integer,
  constraint ChangeLog_IPAddress_PK Primary Key (ChangeLog_IPAddressID)
);

/* There can only be 4096 total VLANs; the VLAN IDs are NOT automatically sequenced  */
CREATE TABLE VLAN (
  VLANID integer not null,
  Name varchar(20),
  Description varchar(40),
  SubnetID integer,
  constraint UniqueSubnetID Unique (SubnetID),
  constraint Vlan_PK Primary Key (VLANID),
  constraint Vlan_CK Check (vlanid > 0 and vlanid < 4095),
  constraint Vlan_FK1 Foreign Key (SubnetID)
  references Subnet(SubnetID)
);

CREATE TABLE AUTODISCOVERY (
  AUTODISCOVERY_ID integer not null,
  DiscoveryDate TimeStamp,
  DiscoveryDescription VARCHAR(60),
  IPAddressID integer,
  DeviceID integer,
  constraint Autodiscover_PK Primary Key (AUTODISCOVERY_ID),
  constraint Autodiscovery_FK1 Foreign Key (IPAddressID)
  references IPAddress(ipaddressid),
  constraint Autodiscovery_FK2 Foreign Key (DeviceID)
  references device(DeviceID)
);

CREATE TABLE Change (
  ChangeID integer not null,
  Change_Date timestamp,
  DeviceID integer,
  VLANID integer,
  SubnetID integer,
  SupernetID integer,
  AdministratorID integer,
  IPAddressID integer,
  RequestStaticID integer,
  constraint Change_PK Primary Key (ChangeID),
  constraint Change_Fk1 Foreign Key (DeviceID)
  references device(DeviceID) ON DELETE SET NULL,
  constraint Change_Fk2 Foreign Key (VlanID)
  references VLAN(VlanID) ON DELETE SET NULL,
  constraint Change_Fk3 Foreign Key (SubnetID)
  references Subnet(SubnetID) ON DELETE SET NULL,
  constraint Change_Fk4 Foreign Key (SupernetID)
  references Supernet(SupernetID) ON DELETE SET NULL,
  constraint Change_Fk5 Foreign Key (AdministratorID)
  references Network_Administrator(AdministratorID) ON DELETE SET NULL,
  constraint Change_Fk6 Foreign Key (IPAddressID)
  references Ipaddress(IPAddressID) ON DELETE SET NULL,
  constraint Change_Fk7 Foreign Key (RequestStaticID)
  references Request_Static(RequestStaticID) ON DELETE SET NULL
);



