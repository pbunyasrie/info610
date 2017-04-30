/*
	====================
	FEATURE #1
	Adding a new user to the system

	- Implements INSERT

	====================

*/

create or replace PROCEDURE add_user(
	username in IPAM_User.UserName%type, 
	password in IPAM_User.Password%type, 
	department in IPAM_User.DeptID%type
) is
	x IPAM_User%rowtype;
BEGIN
	x.UserId := IPAM_User_sequence.nextval;
	x.UserName := username;
	x.Password := password;
	x.DeptID := department;
	insert into IPAM_User values x;
	dbms_output.put_line('Successfully added ' || username);
EXCEPTION
	when DUP_VAL_ON_INDEX then
		dbms_output.put_line('That username is already taken. Please choose another.');
	when others then
		dbms_output.put_line('Unknown error. The procedure requires a username, a password, and a department ID.');
END;


/*
-- Add a new user; it should be successful
BEGIN
	add_user('anewuser', 'Password1234!', 1);
END;

-- Add the same user again; we should see the error "That username is already taken. Please choose another."
BEGIN
	add_user('anewuser', 'Password1234!', 1);
END;
*/

/*
	====================
	FEATURE #2
	Removing a user from the system

	- Implements DELETE

	====================
*/

create or replace PROCEDURE delete_user(d_username IN IPAM_User.UserName%type)
is
	if_exist number; -- used to check for the existence of the user before deletion
BEGIN
	select count(*) into if_exist
	from IPAM_User
	where UserName = d_username;

	if if_exist >= 1 then
		DELETE from IPAM_User where UserName = d_username;
		dbms_output.put_line('Deleted the user named ' || d_username);
	else
		dbms_output.put_line('That username does not exist');
	end if;
END;


/*
-- Delete ppan; it should be successful
begin
	delete_user('ppan');
end;

-- Try to delete ppan again; we should see the error "That username does not exist"
begin
	delete_user('ppan');
end;
*/



/*
	====================
	FEATURE #3
	Checked to see if Ipaddress was autodisovered or added by an administrator

	- Implements SELECT

	====================
*/


create or replace procedure check_autodiscovery_ipaddress(
	n_IPAddress in ipaddress.IPAddress%type
	)
is
	if_exist number;
	if_exist_in_autodiscovery number;
BEGIN
	select count(*) into if_exist
	from ipaddress
	where IPAddress = n_IPAddress;
	if if_exist >= 1 then
		select count(*) into if_exist_in_autodiscovery
		from ipaddress, AUTODISCOVERY
		where ipaddress.ipaddressid = AUTODISCOVERY.ipaddressid
		and ipaddress.ipaddress = n_IPAddress;
		if if_exist_in_autodiscovery = 1 then
			dbms_output.put_line('The ipaddress :' || n_IPAddress || ' was autodiscovered') ;
		else
			dbms_output.put_line('The ipaddress :' || n_IPAddress || ' was added by an administrator') ;
		end if;
	else
		dbms_output.put_line('Ipaddress does not exist ' || n_IPAddress) ;
	end if;
end;

--Example: does not exist
BEGIN
check_autodiscovery_ipaddress('192.168.16.66');
END;

--Example: added by administrator
BEGIN
check_autodiscovery_ipaddress('192.168.1.4');
END;

--Example: autodiscovered Ip address
BEGIN
check_autodiscovery_ipaddress('192.168.16.2');
END;


/*
	====================
	FEATURE #4
	Requesting a static IP address (User)

	- Implements INSERT

	====================
*/

create or replace PROCEDURE requestStaticIP(
	n_user in Request_Static.UserID%type,
	n_ip in Request_Static.Static_IP_Address%type,
	n_mac in Request_Static.Static_MAC_Address%type
) is
	x Request_Static%rowtype;
	n_username IPAM_User.username%type;
BEGIN
	x.RequestStaticID := Request_Static_sequence.nextval;
	x.Request_Static_Date := CURRENT_TIMESTAMP;
	x.UserID := n_user;
	x.Static_IP_Address := n_ip;
	x.Static_MAC_Address := n_mac;
	insert into Request_Static values x;

	-- Get the username of the userID given
	select username into n_username from IPAM_user where UserID = n_user;
	dbms_output.put_line(n_username || ' requested the IP address: ' || n_ip || ', with a MAC address of: ' || n_mac);
EXCEPTION
	when others then
		dbms_output.put_line('Unknown error. The procedure requires a valid user ID, an IP address, and a MAC address.');
END;

begin
	requestStaticIP(2, '172.16.1.1', '00:B0:D0:86:BB:F7');
end;


/*
	====================
	FEATURE #5
	Automatic change log maintenance of Devices
	- Implements TRIGGER to SELECT and DELETE rows: 
		Any time the ChangeLogDevice table has more than 1000 entries, we delete the 10 oldest entries

	====================
*/
create or replace trigger ChangeLogDevice_trim AFTER insert on CHANGELOG_DEVICE declare
	ChangeLogDevice_count int;
begin
	-- Get current # of rows in CHANGELOG_DEVICE table
	select count(*) into ChangeLogDevice_count from CHANGELOG_DEVICE; 

	-- Run a delete statement to delete everything the 10 earliest rows, if we detect more than 1000 rows in the CHANGELOG_DEVICE table
	if ChangeLogDevice_count > 1000 then
		delete from CHANGELOG_DEVICE where rowid not in 
		(select rowid 
		  from (
		  select rowid, changelogdeviceid 
		    from CHANGELOG_DEVICE
		ORDER BY CHANGELOG_DEVICE.CHANGELOGDEVICEID DESC
		  )
		where rownum < 990);
	end if;
	dbms_output.put_line(ChangeLogDevice_count || ' rows in CHANGELOG_DEVICE table');
end;

/*
	Testing:
		INSERT INTO CHANGELOG_DEVICE (ChangeLogDeviceID, ChangeLog_Device_date, Log_DeviceID)
		VALUES (CHANGELOG_DEVICE_sequence.nextval, CURRENT_TIMESTAMP, 1);
 */


/*
	====================
	FEATURE #6
	Automatic change log maintenance of IP Addresses
	- Implements TRIGGER to SELECT and DELETE rows:
		Any time the ChangeLogIPAddress table has more than 1000 entries, we delete the 10 oldest entries

	====================
*/

create or replace trigger ChangeLogIPAddress_trim AFTER insert on CHANGELOG_IPADDRESS declare
	ChangeLogIPAddress_count int;
begin
	-- Get current # of rows in CHANGELOG_IPADDRESS table
	select count(*) into ChangeLogIPAddress_count from CHANGELOG_IPADDRESS; 

	-- Run a delete statement to delete everything the 10 earliest rows, if we detect more than 1000 rows in the CHANGELOG_IPADDRESS table
	if ChangeLogIPAddress_count > 1000 then
		delete from CHANGELOG_IPADDRESS where rowid not in 
		(select rowid 
		  from (
		  select rowid, ChangeLog_IPAddressID 
		    from CHANGELOG_IPADDRESS
		ORDER BY CHANGELOG_IPADDRESS.ChangeLog_IPAddressID DESC
		  )
		where rownum < 990);
	end if;
	dbms_output.put_line(ChangeLogIPAddress_count || ' rows in CHANGELOG_IPADDRESS table');
end;

/*
	Testing:
		INSERT INTO CHANGELOG_IPADDRESS (ChangeLog_IPAddressID, ChangeLog_IPAddress_date, ChangeLog_User, Status, Log_IPAddressID, Log_IPAddress, Log_DateFirstSeen, Log_DateLastSeen, Log_DeviceID, Log_SubnetID)
		VALUES (CHANGELOG_IPADDRESS_sequence.nextval, CURRENT_TIMESTAMP, 'ppan', 'Updated', 1, '192.168.1.1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 1);
 */

/*
	====================
	FEATURE #7
	Adding a device
	- Implements TRIGGER/UPDATE: 
		Any updates made to the Device table is logged into the ChangeLogDevice table which contains the date the change was made, the ID of the user who performed the action, and the device affected

	====================
*/

create or replace procedure add_device (
	n_DeviceID IN device.DeviceID%TYPE,
	n_MACAddress IN device.MACAddress%TYPE,
	n_Hostname IN device.Hostname%TYPE,
	n_Description IN device.Description%TYPE,
	n_TimeFirstSeen IN device.TimeFirstSeen%TYPE,
	n_TimeLastSeen IN device.TimeLastSeen%TYPE,
	n_DeviceType IN device.DeviceType%TYPE,
	n_changeid in change.changeid%TYPE,
	n_change_date in change.change_date%TYPE,
	n_vlanid in change.vlanid%TYPE,
	n_subnetid in change.subnetid%TYPE,
    n_supernetid in change.supernetid%TYPE,
	n_administratorid in change.administratorid%TYPE,
	n_ipaddressid in change.ipaddressid%TYPE,
	n_requeststaticID in change.requeststaticID%TYPE
)
is 
if_exist number;
BEGIN
	select count(*) into if_exist
	from device
	where MACAddress = n_MACAddress;
	if if_exist >= 1 then
		dbms_output.put_line('values aready exists in the device table ' || n_MACAddress) ;
	else
		INSERT INTO device (DeviceID, MACAddress, Hostname, Description, TimeFirstSeen, TimeLastSeen, DeviceType)
		VALUES (n_DeviceID, n_MACAddress, n_Hostname , n_Description, n_TimeFirstSeen, n_TimeLastSeen, n_DeviceType);
		dbms_output.put_line('Values added successfully to table Device ' || n_DeviceID || ' ' || n_MACAddress|| ' ' ||  n_Hostname|| ' ' || n_Description || ' ' || n_TimeFirstSeen || ' ' || n_TimeLastSeen || ' ' || n_DeviceType);
		add_change (n_changeid, n_change_date, n_deviceid , n_vlanid, n_subnetid, n_supernetid, n_administratorid, n_ipaddressid, n_requeststaticID);
	end if;
END;



CREATE OR REPLACE TRIGGER device_change
    after insert or update or delete
    ON device
    FOR EACH ROW
BEGIN
-- When user inserts new row of data into the Device Table
  if inserting then
    INSERT INTO CHANGELOG_DEVICE  (ChangeLogDeviceID, ChangeLog_Device_date, ChangeLog_User, Status, Log_DeviceID , Log_MACAddress, Log_Hostname, Log_Description, Log_TimeFirstSeen, Log_TimeLastSeen, Log_DeviceType) values (CHANGELOG_DEVICE_sequence.nextval, current_timestamp, user, 'Inserted', :new.DeviceID , :new.MACAddress, :new.Hostname, :new.Description, :new.TimeFirstSeen, :new.TimeLastSeen, :new.DeviceType);
  end if;
  -- When user deletes new row of data into the Device Table
  if deleting  then
    INSERT INTO CHANGELOG_DEVICE  (ChangeLogDeviceID, ChangeLog_Device_date, ChangeLog_User, Status, Log_DeviceID , Log_MACAddress, Log_Hostname, Log_Description, Log_TimeFirstSeen, Log_TimeLastSeen, Log_DeviceType) values (CHANGELOG_DEVICE_sequence.nextval, current_timestamp, user, 'Deleted', :old.DeviceID , :old.MACAddress, :old.Hostname, :old.Description, :old.TimeFirstSeen, :old.TimeLastSeen, :old.DeviceType);
  end if;
  -- When user updates new row of data into the Device Table
  if updating then
    INSERT INTO CHANGELOG_DEVICE  (ChangeLogDeviceID, ChangeLog_Device_date, ChangeLog_User, Status, Log_DeviceID , Log_MACAddress, Log_Hostname, Log_Description, Log_TimeFirstSeen, Log_TimeLastSeen, Log_DeviceType) values (CHANGELOG_DEVICE_sequence.nextval, current_timestamp, user, 'Updated', :new.DeviceID , :new.MACAddress, :new.Hostname, :new.Description, :new.TimeFirstSeen, :new.TimeLastSeen, :new.DeviceType);
  end if;
END;

-- verifies that add device works (successful)
begin
	add_device(device_sequence.nextval, '66:66:66:66:66:66', 'testdevice1', 'test device 1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP,'test pc', CHANGE_sequence.nextval, CURRENT_TIMESTAMP, null, null, null, 3, null, null);
end;

/*
	====================
	FEATURE #8
	Adding an IP address
	- Implements TRIGGER/UPDATE: 
		Any updates made to the IP Address table is logged into the ChangeLogIPAddress table which contains the date the change was made, the ID of the user who performed the action, and the IP address affected

	====================
*/
create or replace procedure add_ipaddress (
	n_IPAddressID IN ipaddress.IPAddressID%TYPE,
	n_IPAddress IN ipaddress.IPAddress%TYPE,
	n_DateFirstSeen IN ipaddress.DateFirstSeen%TYPE,
	n_DateLastSeen IN ipaddress.DateLastSeen%TYPE,
	n_DeviceID IN ipaddress.DeviceID%TYPE,
	n_SubnetID IN ipaddress.SubnetID%TYPE,
	n_changeid in change.changeid%TYPE,
	n_change_date in change.change_date%TYPE,
	n_vlanid in change.vlanid%TYPE,
    n_supernetid in change.supernetid%TYPE,
	n_administratorid in change.administratorid%TYPE,
	n_requeststaticID in change.requeststaticID%TYPE
)
is 
if_exist number;
BEGIN
	select count(*) into if_exist
	from ipaddress
	where IPAddress = n_IPAddress;
	if if_exist >= 1 then
		dbms_output.put_line('values already exists in the device table ' || n_IPAddress) ;
	else
		INSERT INTO ipaddress (IPAddressID, IPAddress, DateFirstSeen, DateLastSeen, DeviceID, SubnetID)
		VALUES (n_IPAddressID, n_IPAddress, n_DateFirstSeen , n_DateLastSeen, n_DeviceID, n_SubnetID);
		dbms_output.put_line('Values added successfully to table Device ' || n_IPAddressID || ' ' || n_IPAddress|| ' ' ||  n_DateFirstSeen|| ' ' || n_DateLastSeen || ' ' || n_DeviceID || ' ' || n_SubnetID );
		add_change (n_changeid, n_change_date, n_deviceid , n_vlanid, n_subnetid, n_supernetid, n_administratorid, n_ipaddressid, n_requeststaticID);
	end if;
END;





CREATE OR REPLACE TRIGGER ipaddress_Changes
    after insert or update or delete
    ON ipaddress
    FOR EACH ROW
BEGIN
-- When user inserts new row of data into IP Address
  if inserting then
    INSERT INTO changelog_ipaddress  (ChangeLog_IPAddressID, ChangeLog_IPAddress_date, ChangeLog_User, Status, Log_IPAddressID , Log_IPAddress, Log_DateFirstSeen, Log_DateLastSeen, Log_DeviceID, Log_SubnetID) values (CHANGELOG_IPADDRESS_sequence.nextval, current_timestamp, user, 'Inserted' ,:new.ipaddressid, :new.IPAddress, :new.DateFirstSeen, :new.DateLastSeen , :new.DeviceID, :new.SubnetID);
  end if;
  -- When user deletes new row of data into IP Address
  if deleting  then
    INSERT INTO changelog_ipaddress  (ChangeLog_IPAddressID, ChangeLog_IPAddress_date, ChangeLog_User, Status, Log_IPAddressID , Log_IPAddress, Log_DateFirstSeen, Log_DateLastSeen, Log_DeviceID, Log_SubnetID) values (CHANGELOG_IPADDRESS_sequence.nextval, current_timestamp, user, 'Deleted' ,:old.ipaddressid, :old.IPAddress, :old.DateFirstSeen, :old.DateLastSeen , :old.DeviceID, :old.SubnetID);
  end if;
  -- When user updates new row of data into IP Address
  if updating then
    INSERT INTO changelog_ipaddress  (ChangeLog_IPAddressID, ChangeLog_IPAddress_date, ChangeLog_User, Status, Log_IPAddressID , Log_IPAddress, Log_DateFirstSeen, Log_DateLastSeen, Log_DeviceID, Log_SubnetID) values (CHANGELOG_IPADDRESS_sequence.nextval, current_timestamp, user, 'Updated' ,:new.ipaddressid, :new.IPAddress, :new.DateFirstSeen, :new.DateLastSeen , :new.DeviceID, :new.SubnetID);
  end if;
END;

-- verifies that add ipaddress works (successful)
begin
	add_ipaddress(ipaddress_sequence.nextval, '192.168.16.99', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 8, 5, CHANGE_sequence.nextval, CURRENT_TIMESTAMP, null, null, 3, null);
end;


/*
	====================
	FEATURE #9
	Adding a supernet (Network Admin)

	- Implements INSERT

	====================
*/

create or replace procedure add_supernet (
	n_supernetid IN supernet.supernetid%TYPE,
	n_context IN supernet.context%TYPE,
	n_description IN supernet.description%TYPE,
	n_supernet_network_address IN supernet.supernet_network_address%TYPE,
	n_supernet_subnet_mask IN supernet.supernet_subnet_mask%TYPE,
	n_changeid in change.changeid%TYPE,
	n_change_date in change.change_date%TYPE,
	n_deviceid in change.deviceid%TYPE,
	n_vlanid in change.vlanid%TYPE,
	n_subnetid in change.subnetid%TYPE,
	n_administratorid in change.administratorid%TYPE,
	n_ipaddressid in change.ipaddressid%TYPE,
	n_requeststaticID in change.requeststaticID%TYPE
)
is 
if_exist number;
BEGIN
	select count(*) into if_exist
	from supernet
	where supernet_network_address = n_supernet_network_address 
	and supernet_subnet_mask = n_supernet_subnet_mask;

	if if_exist >= 1 then
		dbms_output.put_line('values aready exists in the supernet table ' || n_supernet_network_address || ' ' || n_supernet_subnet_mask);
	else
		INSERT INTO supernet (supernetid, context, description, supernet_network_address, supernet_subnet_mask)
		VALUES (n_supernetid, n_context, n_description , n_supernet_network_address, n_supernet_subnet_mask);
		dbms_output.put_line('Values added successfully to table supernet ' || n_supernetid || ' ' || n_context|| ' ' ||  n_description|| ' ' || n_supernet_network_address || ' ' || n_supernet_subnet_mask);
		add_change (n_changeid, n_change_date, n_deviceid , n_vlanid, n_subnetid, n_supernetid, n_administratorid, n_ipaddressid, n_requeststaticID);
	end if;
END;

begin
	add_supernet(SUPERNET_sequence.nextval, 'testnet', 'test supernet', '192.168.96.0', '255.255.240.0',CHANGE_sequence.nextval, CURRENT_TIMESTAMP, null, null, null, 1, null, null);
end;

-- Verify that the supernet was added, and that the change was recorded
select * from supernet where supernetid = 6;
select * from change where supernetid = 6;


/*
	====================
	FEATURE #10
	Adding a subnet (Network Admin)

	- Implements INSERT

	====================
*/

create or replace procedure add_subnet_with_no_supernet (
   	n_SubnetID IN SUBNET.SubnetID%TYPE,
   	n_Subnet IN SUBNET.Subnet%TYPE,
   	n_Mask IN SUBNET.Mask%TYPE,
   	n_Description IN SUBNET.Description%TYPE,
   	n_RouterIPAddress in SUBNET.RouterIPAddress%TYPE,
   	n_changeid in change.changeid%TYPE,
	n_change_date in change.change_date%TYPE,
	n_deviceid in change.deviceid%TYPE,
	n_vlanid in change.vlanid%TYPE,
	n_supernetid in change.supernetid%TYPE,
	n_administratorid in change.administratorid%TYPE,
	n_ipaddressid in change.ipaddressid%TYPE,
	n_requeststaticID in change.requeststaticID%TYPE
	)
is 
if_exist number;
BEGIN
select count(*) into if_exist
	from subnet
	where subnet = n_Subnet 
	and mask = n_Mask;
	if if_exist >= 1 then
		dbms_output.put_line('values aready exists in the subnet table ' || n_Subnet || ' ' || n_Mask);
	else
  		INSERT INTO SUBNET (SubnetID, Subnet, Mask, Description, RouterIPAddress)
  		VALUES (n_SubnetID, n_Subnet, n_Mask , n_Description, n_RouterIPAddress);
		add_change (n_changeid, n_change_date, n_deviceid , n_vlanid, n_subnetid, n_supernetid, n_administratorid, n_ipaddressid, n_requeststaticID);
  end if;

END;

begin
	add_subnet_with_no_supernet (SUBNET_sequence.nextval, '10.66.0.0', '255.255.255.0', 'test subnet no FK', '10.66.0.254',CHANGE_sequence.nextval, CURRENT_TIMESTAMP, null, null, null, 2 , null, null);
end;

create or replace procedure add_subnet_with_supernet (
    n_SubnetID IN SUBNET.SubnetID%TYPE,
    n_Subnet IN SUBNET.Subnet%TYPE,
    n_Mask IN SUBNET.Mask%TYPE,
    n_Description IN SUBNET.Description%TYPE,
    n_RouterIPAddress in SUBNET.RouterIPAddress%TYPE,
    n_supernetid IN SUBNET.supernetid%TYPE,
    n_changeid in change.changeid%TYPE,
	n_change_date in change.change_date%TYPE,
	n_deviceid in change.deviceid%TYPE,
	n_vlanid in change.vlanid%TYPE,
	n_change_supernetid in change.supernetid%TYPE,
	n_administratorid in change.administratorid%TYPE,
	n_ipaddressid in change.ipaddressid%TYPE,
	n_requeststaticID in change.requeststaticID%TYPE
	)
is 
if_exist number;
BEGIN
    select count(*) into if_exist
	from subnet
	where subnet = n_Subnet 
	and mask = n_Mask;
    
    
    -- First check if the subnet exists
	if if_exist >= 1 then
		dbms_output.put_line('values aready exists in the subnet table ' || n_Subnet || ' ' || n_Mask);
	else
        -- If not, create the subnet
  		INSERT INTO SUBNET (SubnetID, Subnet, Mask, Description, RouterIPAddress, supernetid)
  		VALUES (n_SubnetID, n_Subnet, n_Mask , n_Description, n_RouterIPAddress,n_supernetid);
        
        --- and add an entry into the change table
  		add_change (n_changeid, n_change_date, n_deviceid , n_vlanid, n_subnetid, n_change_supernetid, n_administratorid, n_ipaddressid, n_requeststaticID);
	end if;
END;


begin
	add_subnet_with_supernet (SUBNET_sequence.nextval, '192.168.5.0', '255.255.255.0', 'test subnet W/ FK', 'yes', 1,CHANGE_sequence.nextval, CURRENT_TIMESTAMP, null, null, null, 3 , null, null);
end;

/*
	====================
	FEATURE #11
	Adding a VLAN (Network Admin)

	- Implements INSERT

	====================
*/

create or replace procedure add_vlan (
	n_vlanid IN VLAN.VLANID%TYPE,
	n_name IN VLAN.Name%TYPE,
	n_description IN VLAN.Description%TYPE,
	n_subnetid IN VLAN.SubnetID%TYPE
)
is 
if_exist number;
BEGIN
	select count(*) into if_exist
	from VLAN
	where vlanid = n_vlanid;

	if if_exist >= 1 then
		dbms_output.put_line('VLAN ' ||  n_vlanid || ' already exists. Please choose another');
	else
		INSERT INTO VLAN (vlanid, name, description, subnetid)
		VALUES (n_vlanid, n_name, n_description , n_subnetid);
		dbms_output.put_line('Created VLAN ' || n_vlanid || ' (' || n_name || ')');
	end if;
EXCEPTION
	when DUP_VAL_ON_INDEX then
		dbms_output.put_line('That subnet is already being used. Please choose another.');
	when others then
		dbms_output.put_line('Unknown error. The procedure requires a VLAN ID, a name, a description, and a SubnetID.');
END;

begin
	add_vlan(1, 'Default VLAN', 'VLAN if no other VLAN is assigned', 1);
end;


/*
	====================
	FEATURE #12
	Removing an IP address from the system

	- Implements DELETE

	====================
*/

CREATE OR REPLACE PROCEDURE DeleteIpAddress(d_ipaddress IN ipaddress.ipaddress%TYPE)
IS
if_exist number;
BEGIN
	select count(*) into if_exist
	from ipaddress
	where ipaddress = d_ipaddress;

	if if_exist >= 1 then
		DELETE ipaddress where ipaddress = d_ipaddress;
		dbms_output.put_line('value ' || d_ipaddress || ' deleted');
	else
		dbms_output.put_line(d_ipaddress || ' value given to delete does not exist');
	end if;
END;

begin
	DeleteIpAddress('192.168.1.3');
end;

begin
	DeleteIpAddress('192.168.1.9');
end;

/*
	====================
	FEATURE #13
	Removing a device from the system based on MAC Address

	- Implements DELETE

	====================
*/

CREATE OR REPLACE PROCEDURE DeleteDevice(d_macaddress IN device.MACAddress%TYPE)
IS
if_exist number;
BEGIN
	select count(*) into if_exist
	from DEVICE
	where MACAddress = d_macaddress;

	if if_exist >= 1 then
		DELETE from device where MACAddress = d_macaddress;
		dbms_output.put_line('Deleted the device with MAC Address ' || d_macaddress);
	else
		dbms_output.put_line('Device with MAC address ' || d_macaddress || ' does not exist');
	end if;
END;

/*
-- Delete a device; it should be successful
BEGIN
	DeleteDevice('aa:aa:aa:aa:aa:aa');
END;

-- Delete the device with the same MAC Adddress again; we should see the error "Device with MAC address aa:aa:aa:aa:aa:aa should not exist"
begin
	DeleteDevice('aa:aa:aa:aa:aa:aa');
end;
*/

/*
	====================
	FEATURE #14
	See who requested an IP address static assignment, what the static address is, and what admin created it

	- Implements SELECT

	====================
*/

create or replace procedure find_static_ip_requestor(
	r_userid in request_static.userID%TYPE
	)
    is
cursor c1 is select ipam_user.username, Network_Administrator.AdministratorName, ipaddress.ipaddress, device.macaddress
from request_static, ipaddress, device, Network_Administrator, ipam_user, change
where request_static.userID = IPAM_user.userID
and change.requeststaticID = request_static.requeststaticid
and change.administratorid = Network_Administrator.administratorid
and change.ipaddressid = ipaddress.ipaddressid
and ipaddress.deviceid = device.deviceid
and request_static.UserID = r_userid;
n_username ipam_user.username%type;
n_administratorname Network_Administrator.AdministratorName%type;
n_ipaddress ipaddress.ipaddress%type;
n_macaddress device.macaddress%type;
if_exist number;
BEGIN
select count(*) into if_exist
	from request_static
	where request_static.userID = r_userid;
	if if_exist = 0 then
		dbms_output.put_line('no such userid exists' || r_userid);
	else

  open c1;
  	loop 
  		fetch c1 into n_username, n_administratorname, n_ipaddress, n_macaddress;
  		exit when c1%notfound;
  		dbms_output.put_line('Username Requesting IP Address is: ' || n_username || ' Administrator Who Added Static entry is: ' || n_administratorname || ' Ip address added is: ' || n_ipaddress || ' Mac Address of Device is: ' || n_macaddress);
  	end loop;
  close c1;
  end if;
end;
	


begin 
find_static_ip_requestor(1);
end;



/*
	====================
	FEATURE #15
	Adds an entry to the change table

	- Implements INSERT

	====================
*/

create or replace procedure add_change (
    c_changeid in change.changeid%TYPE,
	c_change_date in change.change_date%TYPE,
	c_deviceid in change.deviceid%TYPE,
	c_vlanid in change.vlanid%TYPE,
	c_subnetid in change.subnetid%TYPE,
	c_supernetid in change.supernetid%type,
	c_administratorid in change.administratorid%TYPE,
	c_ipaddressid in change.ipaddressid%TYPE,
	c_requeststaticID in change.requeststaticID%TYPE
)
is 
BEGIN
	INSERT INTO change (changeid, change_date, deviceid, vlanid, subnetid, supernetid, administratorid, ipaddressid, requeststaticID)
	VALUES (CHANGE_sequence.nextval, c_change_date, c_deviceid , c_vlanid, c_subnetid, c_supernetid, c_administratorid, c_ipaddressid, c_requeststaticID);
end;
