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
	Showing recent changes within the past n days

	- Implements SELECT

	====================
*/

/*
	====================
	FEATURE #4
	Requesting a static IP address (User)

	- Implements INSERT

	====================
*/


/*
	====================
	FEATURE #5
	Approving a request for a static IP address (Network Administrator)

	- Implements INSERT/UPDATE

	====================
*/



/*
	====================
	FEATURE #6
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
		INSERT INTO CHANGELOG_DEVICE (ChangeLogDeviceID, ChangeLog_Device_date, DeviceID)
		VALUES (CHANGELOG_DEVICE_sequence.nextval, CURRENT_TIMESTAMP, 1);
 */


/*
	====================
	FEATURE #7
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
		INSERT INTO CHANGELOG_IPADDRESS (ChangeLog_IPAddressID, ChangeLog_IPAddress_date, IPAddressID)
		VALUES (CHANGELOG_IPADDRESS_sequence.nextval, CURRENT_TIMESTAMP, 1);
 */

/*
	====================
	FEATURE #8
	Adding a device
	- Implements TRIGGER/UPDATE: 
		Any updates made to the Device table is logged into the ChangeLogDevice table which contains the date the change was made, the ID of the user who performed the action, and the device affected

	====================
*/



/*
	====================
	FEATURE #9
	Adding an IP address
	- Implements TRIGGER/UPDATE: 
		Any updates made to the IP Address table is logged into the ChangeLogIPAddress table which contains the date the change was made, the ID of the user who performed the action, and the IP address affected

	====================
*/
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

/*
	====================
	FEATURE #10
	User login
	- Implements TRIGGER/UPDATE: 
		Any time a user logs in, the user’s lastLogin timestamp will be set

	====================
*/



/*
	====================
	FEATURE #11
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
	FEATURE #12
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
   n_IPAddressesAvailable IN SUBNET.IPAddressesAvailable%TYPE,
   n_RouterIPAddress in SUBNET.RouterIPAddress%TYPE,
   n_supernetid IN SUBNET.supernetid%TYPE
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
  INSERT INTO SUBNET (SubnetID, Subnet, Mask, Description, IPAddressesAvailable, RouterIPAddress, supernetid)
  VALUES (n_SubnetID, n_Subnet, n_Mask , n_Description, n_IPAddressesAvailable, n_RouterIPAddress,n_supernetid);
  add_change (n_changeid, n_change_date, n_deviceid , n_vlanid, n_subnetid, n_supernetid, n_administratorid, n_ipaddressid, n_requeststaticID);
END;


begin
	add_subnet_with_supernet (SUBNET_sequence.nextval, '192.168.5.0', '255.255.255.0', 'test subnet W/ FK', 'yes', '192.168.5.254',2,CHANGE_sequence.nextval, CURRENT_TIMESTAMP, null, null, null, 3 , null, null);
end;

/*
	====================
	FEATURE #13
	Adding a VLAN (Network Admin)

	- Implements INSERT

	====================
*/

/*
	====================
	FEATURE #14
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
	FEATURE #15
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
	FEATURE #16
	See who requested an IP address static assignment, what the static address is, and what admin created it

	- Implements SELECT

	====================
*/




/*
	====================
	Supporting Features/Functions
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
