CREATE TABLE etl_log(

load_id SERIAL PRIMARY KEY,

load_timestamp TIMESTAMP,

table_name VARCHAR(50),

records_loaded INT
);