CREATE TABLE promos (
  -- Each unique promocode on platform
  promo_id VARCHAR(256) PRIMARY KEY,
  -- Absolute dollar amount that is given off with the code
  discount INTEGER,
  -- Is the promo code active or disabled
  status VARCHAR(128)
);