
SELECT * FROM tracks;

-- 1. Топ-10 самых популярных треков
SELECT track_name, artist_name, track_popularity FROM tracks 
ORDER BY track_popularity DESC
LIMIT 10;

--2. Влиение мата на популрность треков 
SELECT explicit, ROUND(AVG(track_popularity),2) as avg_popularity FROM tracks 
GROUP BY explicit;
--Наличие мата в песнях в малой степени влияет на популярность трека

--3. Самые популярные треки по популярности и по подписчикам
SELECT track_name, artist_name, artist_followers, track_popularity FROM tracks 
ORDER BY track_popularity DESC;
--Наблюдения:
--Лидеры по популярности и по подписчикам не всегда совпадают, значит, популярность трека
--и база подписчиков - связанные, но не одинаковые параметры

--4. Средняя длительность треков 
SELECT ROUND(AVG(track_duration_min), 2) as avg_duration FROM tracks;

--5. Самые короткие и самые длинные треки 
SELECT track_name, track_duration_min FROM tracks 
ORDER BY track_duration_min ASC 
LIMIT 5;

SELECT track_name, track_duration_min FROM tracks 
ORDER BY track_duration_min DESC
LIMIT 5;

--6.  Популярность по типу альбома
SELECT album_type, ROUND(AVG(track_popularity),2) AS avg_popularity
FROM tracks
GROUP BY album_type
ORDER BY avg_popularity DESC
-- Треки из альбомов более популярны, чем синглы и сборники

--7. ABC-анализ артистов по количеству фолловеров
WITH artist_followers AS (
    SELECT
        artist_name,
        SUM(artist_followers) AS total_followers
    FROM tracks
    GROUP BY artist_name
),
ranked_artists AS (
    SELECT
        artist_name,
        total_followers,
        SUM(total_followers) OVER (ORDER BY total_followers DESC)
        / SUM(total_followers) OVER () AS cumulative_share
    FROM artist_followers
)
SELECT
    artist_name,
    total_followers,
    ROUND(cumulative_share, 4) AS cumulative_share,
    CASE
        WHEN cumulative_share <= 0.80 THEN 'A'
        WHEN cumulative_share <= 0.95 THEN 'B'
        ELSE 'C'
    END AS abc_class
FROM ranked_artists
ORDER BY total_followers DESC;
-- Класс A включает небольшое количество артистов (например, Drake, Coldplay, Beyoncé),
-- которые формируют основную часть аудитории Spotify
-- Класс B — артисты со средним вкладом
-- Класс C — длинный хвост артистов с минимальным влиянием
