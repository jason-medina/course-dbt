CREATE TABLE events(
  -- UUID of each unique event on the platform
  event_id VARCHAR(256) PRIMARY KEY,
  -- UUID of each browsing session on the platform which can contain many events
  session_id VARCHAR(256),
  -- UUID of the user that this event is associated with
  user_id VARCHAR(256) REFERENCES users(user_id),
  -- URL that the event happened on
  page_url VARCHAR(4096),
  -- Timestamp of the event
  created_at TIMESTAMP,
  -- Type of event
  event_type VARCHAR(128),
  -- If the event is specific to an order (mostly used for checkout)
  order_id VARCHAR(256) REFERENCES orders(order_id),
  -- If the event is specific to a product
  product_id VARCHAR(256) REFERENCES products(product_id)
);