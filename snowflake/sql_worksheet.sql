CREATE OR REPLACE TABLE song_data (
    song_id STRING NOT NULL,          -- Unique identifier for the song
    song_name STRING,                 -- Name of the song
    duration_ms NUMBER,               -- Duration of the song in milliseconds
    url STRING,                       -- URL link to the song
    popularity NUMBER,                -- Popularity score of the song
    song_added TIMESTAMP_NTZ,         -- Timestamp for when the song was added
    album_id STRING,                  -- ID of the album the song belongs to
    artist_id STRING                  -- ID of the artist of the song
);

CREATE OR REPLACE TABLE albums (
    album_id STRING NOT NULL,     -- Unique identifier for the album
    name STRING,                  -- Name of the album
    release_date DATE,            -- Release date of the album
    total_tracks NUMBER,          -- Total number of tracks in the album
    url STRING                    -- URL link to the album
);

CREATE OR REPLACE TABLE artists (
    artist_id STRING NOT NULL,      -- Unique identifier for the artist
    artist_name STRING,             -- Name of the artist
    external_url STRING             -- External URL link to the artist's profile
);

CREATE OR REPLACE FILE FORMAT my_csv_format 
    TYPE = 'CSV' 
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'    -- Handles fields with quotes
    SKIP_HEADER = 1                       -- Skips the header row
    NULL_IF = ('\\N', 'NULL', '')         -- Specifies how to handle NULL values
    EMPTY_FIELD_AS_NULL = TRUE            -- Treats empty fields as NULL
    FIELD_DELIMITER = ',';                -- Specifies comma as the field delimiter

CREATE OR REPLACE STAGE songs_stage
  URL='s3://snowflaketutorialparv/transformed_data/songs_data/'
  CREDENTIALS=(AWS_KEY_ID='<aws_key_id>' AWS_SECRET_KEY='<aws_secret_key>')
  ENCRYPTION=(TYPE='AWS_SSE_KMS' KMS_KEY_ID = 'aws/key')
  FILE_FORMAT = my_csv_format;

CREATE OR REPLACE STAGE artist_stage
  URL='s3://snowflaketutorialparv/transformed_data/artist_data/'
  CREDENTIALS=(AWS_KEY_ID='<aws_key_id>' AWS_SECRET_KEY='<aws_secret_key>')
  ENCRYPTION=(TYPE='AWS_SSE_KMS' KMS_KEY_ID = 'aws/key')
  FILE_FORMAT = my_csv_format;

CREATE OR REPLACE STAGE album_stage
  URL='s3://snowflaketutorialparv/transformed_data/album_data/'
  CREDENTIALS=(AWS_KEY_ID='<aws_key_id>' AWS_SECRET_KEY='<aws_secret_key>')
  ENCRYPTION=(TYPE='AWS_SSE_KMS' KMS_KEY_ID = 'aws/key')
  FILE_FORMAT = my_csv_format;

CREATE PIPE songs_pipe
  AUTO_INGEST = TRUE
  AS
    COPY INTO SONG_DATA
      FROM (SELECT * FROM @songs_stage)
      FILE_FORMAT = my_csv_format;

CREATE PIPE artist_pipe
  AUTO_INGEST = TRUE
  AS
    COPY INTO ARTISTS
      FROM (SELECT * FROM @artist_stage)
      FILE_FORMAT = my_csv_format;

CREATE PIPE album_pipe
  AUTO_INGEST = TRUE
  AS
    COPY INTO ALBUMS
      FROM (SELECT * FROM @album_stage)
      FILE_FORMAT = my_csv_format;


SHOW PIPES;

SELECT * FROM SONG_DATA;
