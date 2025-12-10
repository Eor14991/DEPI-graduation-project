USE RadarLakehouseDB;
GO

---------------------------------------------------------
-- 1. vw_fact_journeys (Dynamic from JSON)
---------------------------------------------------------
CREATE OR ALTER VIEW vw_fact_journeys AS
SELECT 
    journey_id,
    plate,
    route_id,
    driver_profile,
    start_time,
    end_time,
    total_distance,
    total_violations,
    total_fines
FROM
    OPENROWSET(
        BULK 'https://radardatastoreg.dfs.core.windows.net/radardata/clean-tables/fact_journeys/*.json',
        FORMAT = 'CSV',
        FIELDQUOTE = '0x0b',
        FIELDTERMINATOR ='0x0b',
        ROWTERMINATOR = '0x0a'
    )
    WITH (
        jsonContent varchar(MAX)
    ) AS [result]
    CROSS APPLY OPENJSON(jsonContent)
    WITH (
        journey_id VARCHAR(50),
        plate VARCHAR(20),
        route_id VARCHAR(50),
        driver_profile VARCHAR(50),
        start_time DATETIME2,
        end_time DATETIME2,
        total_distance FLOAT,
        total_violations INT,
        total_fines INT
    );
GO

---------------------------------------------------------
-- 2. vw_dim_vehicles (Dynamic from JSON)
---------------------------------------------------------
CREATE OR ALTER VIEW vw_dim_vehicles AS
SELECT 
    plate,
    color,
    created_at
FROM
    OPENROWSET(
        BULK 'https://radardatastoreg.dfs.core.windows.net/radardata/clean-tables/dim_vehicles/*.json',
        FORMAT = 'CSV',
        FIELDQUOTE = '0x0b',
        FIELDTERMINATOR ='0x0b',
        ROWTERMINATOR = '0x0a'
    )
    WITH (
        jsonContent varchar(MAX)
    ) AS [result]
    CROSS APPLY OPENJSON(jsonContent)
    WITH (
        plate VARCHAR(20),
        color VARCHAR(20),
        created_at DATETIME2
    );
GO

---------------------------------------------------------
-- 3. vw_radar_logs (Dynamic from JSON)
---------------------------------------------------------
CREATE OR ALTER VIEW vw_radar_logs AS
SELECT 
    id,
    journey_id,
    plate,
    speed,
    speed_limit,
    color,
    radar_id,
    lat,
    lon,
    seat_belt,
    phone_usage,
    is_violation,
    total_fine,
    timestamp
FROM
    OPENROWSET(
        BULK 'https://radardatastoreg.dfs.core.windows.net/radardata/clean-tables/radar_logs/*.json',
        FORMAT = 'CSV',
        FIELDQUOTE = '0x0b',
        FIELDTERMINATOR ='0x0b',
        ROWTERMINATOR = '0x0a'
    )
    WITH (
        jsonContent varchar(MAX)
    ) AS [result]
    CROSS APPLY OPENJSON(jsonContent)
    WITH (
        id VARCHAR(100),
        journey_id VARCHAR(50),
        plate VARCHAR(20),
        speed INT,
        speed_limit INT,
        color VARCHAR(20),
        radar_id VARCHAR(50),
        lat FLOAT,
        lon FLOAT,
        seat_belt BIT,
        phone_usage BIT,
        is_violation BIT,
        total_fine INT,
        timestamp DATETIME2
    );
GO

---------------------------------------------------------
-- 4. vw_violations (Dynamic from JSON)
---------------------------------------------------------
CREATE OR ALTER VIEW vw_violations AS
SELECT 
    journey_id,
    plate,
    timestamp,
    reason,
    fine
FROM
    OPENROWSET(
        BULK 'https://radardatastoreg.dfs.core.windows.net/radardata/clean-tables/violations/*.json',
        FORMAT = 'CSV',
        FIELDQUOTE = '0x0b',
        FIELDTERMINATOR ='0x0b',
        ROWTERMINATOR = '0x0a'
    )
    WITH (
        jsonContent varchar(MAX)
    ) AS [result]
    CROSS APPLY OPENJSON(jsonContent)
    WITH (
        journey_id VARCHAR(50),
        plate VARCHAR(20),
        timestamp DATETIME2,
        reason VARCHAR(100),
        fine INT
    );
GO

---------------------------------------------------------
-- 5. vw_dim_routes (Static View)
---------------------------------------------------------
CREATE OR ALTER VIEW vw_dim_routes AS
SELECT * FROM (VALUES
    ('Route_1', 'Cairo-Alex Road', 120, 30.0444, 31.2357, 6),
    ('Route_2', 'Ring Road East', 100, 30.0500, 31.3000, 5),
    ('Route_3', 'Corniche Road', 80, 31.2000, 29.9167, 7),
    ('Route_4', 'Downtown Circuit', 60, 30.0333, 31.2333, 4),
    ('Route_5', 'Airport Road', 100, 30.1210, 31.4050, 5)
) AS D (route_id, route_name, speed_limit, center_lat, center_lon, radar_count);
GO

---------------------------------------------------------
-- 6. vw_dim_radars (Static View)
---------------------------------------------------------
CREATE OR ALTER VIEW vw_dim_radars AS
SELECT * FROM (VALUES
    ('Route_1_Radar_1', 'Route_1', 1, 30.014400, 31.205700),
    ('Route_1_Radar_2', 'Route_1', 2, 30.026400, 31.217700),
    ('Route_1_Radar_3', 'Route_1', 3, 30.038400, 31.229700),
    ('Route_1_Radar_4', 'Route_1', 4, 30.050400, 31.241700),
    ('Route_1_Radar_5', 'Route_1', 5, 30.062400, 31.253700),
    ('Route_1_Radar_6', 'Route_1', 6, 30.074400, 31.265700),
    ('Route_2_Radar_1', 'Route_2', 1, 30.020000, 31.270000),
    ('Route_2_Radar_2', 'Route_2', 2, 30.035000, 31.285000),
    ('Route_2_Radar_3', 'Route_2', 3, 30.050000, 31.300000),
    ('Route_2_Radar_4', 'Route_2', 4, 30.065000, 31.315000),
    ('Route_2_Radar_5', 'Route_2', 5, 30.080000, 31.330000),
    ('Route_3_Radar_1', 'Route_3', 1, 31.170000, 29.886700),
    ('Route_3_Radar_2', 'Route_3', 2, 31.180000, 29.896700),
    ('Route_3_Radar_3', 'Route_3', 3, 31.190000, 29.906700),
    ('Route_3_Radar_4', 'Route_3', 4, 31.200000, 29.916700),
    ('Route_3_Radar_5', 'Route_3', 5, 31.210000, 29.926700),
    ('Route_3_Radar_6', 'Route_3', 6, 31.220000, 29.936700),
    ('Route_3_Radar_7', 'Route_3', 7, 31.230000, 29.946700),
    ('Route_4_Radar_1', 'Route_4', 1, 30.003300, 31.203300),
    ('Route_4_Radar_2', 'Route_4', 2, 30.023300, 31.223300),
    ('Route_4_Radar_3', 'Route_4', 3, 30.043300, 31.243300),
    ('Route_4_Radar_4', 'Route_4', 4, 30.063300, 31.263300),
    ('Route_5_Radar_1', 'Route_5', 1, 30.091000, 31.375000),
    ('Route_5_Radar_2', 'Route_5', 2, 30.106000, 31.390000),
    ('Route_5_Radar_3', 'Route_5', 3, 30.121000, 31.405000),
    ('Route_5_Radar_4', 'Route_5', 4, 30.136000, 31.420000),
    ('Route_5_Radar_5', 'Route_5', 5, 30.151000, 31.435000)
) AS D (radar_id, route_id, radar_index, lat, lon);
GO

---------------------------------------------------------
-- 7. vw_system_logs (Dynamic from JSON)
---------------------------------------------------------
CREATE OR ALTER VIEW vw_system_logs AS
SELECT 
    log_level,
    message,
    details,
    timestamp
FROM
    OPENROWSET(
        BULK 'https://radardatastoreg.dfs.core.windows.net/radardata/logs/system_logs/*.json',
        FORMAT = 'CSV',
        FIELDQUOTE = '0x0b',
        FIELDTERMINATOR ='0x0b',
        ROWTERMINATOR = '0x0a'
    )
    WITH (
        jsonContent varchar(MAX)
    ) AS [result]
    CROSS APPLY OPENJSON(jsonContent)
    WITH (
        log_level VARCHAR(20),
        message NVARCHAR(MAX),
        details NVARCHAR(MAX),
        timestamp DATETIME2
    );
GO