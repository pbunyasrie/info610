-- 11. INSERT: Adding a supernet (Network Admin)

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
  VALUES (c_changeid, c_change_date, c_deviceid , c_vlanid, c_subnetid, c_supernetid, c_administratorid, c_ipaddressid, c_requeststaticID);
 end;


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
	   n_requeststaticID in change.requeststaticID%TYPE)
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
add_supernet(6, 'testnet', 'test supernet', '192.168.96.0', '255.255.240.0',13, CURRENT_TIMESTAMP, null, null, null, 1, null, null);
end;

select * from supernet
where supernetid = 6

select * from change
where supernetid =6

-- 12. INSERT: Adding a subnet (Network Admin)

  create or replace procedure add_subnet_with_no_supernet (
	   n_SubnetID IN SUBNET.SubnetID%TYPE,
	   n_Subnet IN SUBNET.Subnet%TYPE,
	   n_Mask IN SUBNET.Mask%TYPE,
	   n_Description IN SUBNET.Description%TYPE,
	   n_RouterIPAddress in SUBNET.RouterIPAddress%TYPE)
is 
BEGIN
  INSERT INTO SUBNET (SubnetID, Subnet, Mask, Description, RouterIPAddress)
  VALUES (n_SubnetID, n_Subnet, n_Mask , n_Description, n_RouterIPAddress);
END;

begin
add_subnet_with_no_supernet (6, '10.66.0.0', '255.255.255.0', 'test subnet no FK', '10.66.0.254');

end;

select * from SUBNET
where subnetid = 6;


  create or replace procedure add_subnet_with_supernet (
	   n_SubnetID IN SUBNET.SubnetID%TYPE,
	   n_Subnet IN SUBNET.Subnet%TYPE,
	   n_Mask IN SUBNET.Mask%TYPE,
	   n_Description IN SUBNET.Description%TYPE,
	   n_IPAddressesAvailable IN SUBNET.IPAddressesAvailable%TYPE,
	   n_RouterIPAddress in SUBNET.RouterIPAddress%TYPE,
	   n_supernetid IN SUBNET.supernetid%TYPE)
is 
BEGIN
  INSERT INTO SUBNET (SubnetID, Subnet, Mask, Description, IPAddressesAvailable, RouterIPAddress, supernetid)
  VALUES (n_SubnetID, n_Subnet, n_Mask , n_Description, n_IPAddressesAvailable, n_RouterIPAddress,n_supernetid);
END;


begin
add_subnet_with_supernet (7, '192.168.5.0', '255.255.255.0', 'test subnet W/ FK', 'yes', '192.168.5.254',2);
end;

select * from SUBNET
where subnetid = 7;

-- 14. DELETE: Removing an IP address from the system

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


