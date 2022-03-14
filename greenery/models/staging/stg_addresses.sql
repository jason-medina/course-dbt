CREATE TABLE addresses (
  -- UUID for each unique address on platform
  address_id VARCHAR(256) PRIMARY KEY,
  -- The first few lines of the address
  address VARCHAR(8192),
  -- The zipcode of the address
  zipcode INTEGER,
  -- state this delivery address is based in
  state VARCHAR(256),
  -- country this delivery address is based in
  country VARCHAR(256)
);