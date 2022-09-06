-- название и год выхода альбомов, вышедших в 2018 году
SELECT title, release_year FROM album 
WHERE date_part('year', release_year) = 2018
ORDER BY release_year
LIMIT 20;

-- название и продолжительность самого длительного трека
SELECT name, duration FROM track t
WHERE duration = (SELECT max(duration) FROM track t2);

-- название треков, продолжительность которых не менее 3.5 минуты;
SELECT name FROM track t 
WHERE duration >= 210
ORDER BY duration 
LIMIT 20;

-- названия сборников, вышедших в период с 2018 по 2020 год включительно;
SELECT title FROM collection c 
WHERE date_part('year', release_year) >= 2018 AND date_part('year', release_year) <= 2020
ORDER BY title  
LIMIT 20;

-- исполнители, чье имя состоит из 1 слова
SELECT alias FROM musician m 
WHERE alias SIMILAR TO '\S+'
ORDER BY alias  
LIMIT 20;

-- название треков, которые содержат слово "мой"/"my"
SELECT name FROM track
WHERE lower(name) LIKE '%my%' OR lower(name) LIKE '%мой%'
ORDER BY name  
LIMIT 20;
