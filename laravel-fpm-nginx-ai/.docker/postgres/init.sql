-- PostgreSQL initialization script
-- This runs when the container is first created

-- Enable useful extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Create additional schemas if needed (optional)
-- CREATE SCHEMA IF NOT EXISTS app;

-- Grant privileges (if additional users are needed)
-- GRANT ALL PRIVILEGES ON DATABASE jav TO jav;
