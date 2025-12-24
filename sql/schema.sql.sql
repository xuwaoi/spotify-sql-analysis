CREATE TABLE tracks (
    track_id TEXT,
    track_name TEXT,
    track_number INT,
    track_popularity INT,
    explicit BOOLEAN,

    artist_name TEXT,
    artist_popularity INT,
    artist_followers BIGINT,
    artist_genres TEXT,

    album_id TEXT,
    album_name TEXT,
    album_release_date DATE,
    album_total_tracks INT,
    album_type TEXT,

    track_duration_min NUMERIC(5,2)
);