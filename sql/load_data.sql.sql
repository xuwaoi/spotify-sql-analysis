\copy tracks
FROM 'spotify_clean.csv'
WITH (FORMAT csv, HEADER, DELIMITER ',');
