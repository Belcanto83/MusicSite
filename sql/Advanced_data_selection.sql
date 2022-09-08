-- ПРОДВИНУТАЯ ВЫБОРКА ДАННЫХ. ОБЪЕДИНЕНИЕ ТАБЛИЦ. АГРЕГИРУЮЩИЕ ФУНКЦИИ, ГРУППИРОВКА ДАННЫХ. ВЛОЖЕННЫЕ SELECT-ЗАПРОСЫ

-- 1. количество исполнителей в каждом жанре
SELECT g.name, count(*) m_count FROM genre g 
JOIN musiciangenre m ON g.id = m.genre_id 
GROUP BY g.name
ORDER BY m_count DESC;

-- 2. количество треков, вошедших в альбомы 2019-2020 годов
SELECT count(*) FROM track t 
JOIN album a ON t.album_id = a.id 
WHERE date_part('year', a.release_year) BETWEEN 2019 AND 2020;

-- 3. средняя продолжительность треков по каждому альбому
SELECT a.title, round(avg(duration)) avg_dur FROM track t 
JOIN album a ON a.id = t.album_id 
GROUP BY a.title
ORDER BY avg_dur DESC;

-- Пустые альбомы, без треков (просто для справки)
--SELECT a.title, round(avg(duration)) avg_dur FROM track t 
--RIGHT JOIN album a ON a.id = t.album_id 
--WHERE t.album_id IS NULL 
--GROUP BY a.title
--ORDER BY avg_dur DESC;

-- 4. все исполнители, которые не выпустили альбомы в 2020 году
SELECT DISTINCT m.alias FROM musician m 
JOIN musicianalbum ma ON m.id = ma.musician_id 
JOIN album a ON a.id = ma.album_id 
WHERE date_part('year', a.release_year) <> 2020
ORDER BY m.alias;

-- 5. названия сборников, в которых присутствует конкретный исполнитель (выберите сами).
-- Можно ли создать ИНДЕКС (вспомогат. соед. таблицу "collection-musician"), чтобы уменьшить число JOIN ???
SELECT DISTINCT c.title FROM collection c 
JOIN collectiontrack ct ON ct.collection_id = c.id 
JOIN track t ON t.id = ct.track_id 
JOIN album a ON a.id = t.album_id 
JOIN musicianalbum ma ON ma.album_id = t.album_id 
JOIN musician m ON m.id = ma.musician_id 
WHERE lower(m.alias) LIKE '%queen%'
ORDER BY c.title;

-- 6. название альбомов, в которых присутствуют исполнители более 1 жанра
-- Решим с помощью одного вложенного select-запроса

-- альбомы в которых присутствует более 1 исполнителя (просто для справки)
--SELECT DISTINCT a.title, count(a.id) FROM album a 
--JOIN musicianalbum ma ON ma.album_id = a.id 
--JOIN musiciangenre mg ON mg.musician_id = ma.musician_id  
--GROUP BY a.title, genre_id
--HAVING count(a.title) > 1
--ORDER BY a.title; 

-- 6.1. все исполнители более 1 жанра (внутренний select-запрос, для проверки)
--SELECT distinct m.id FROM musician m 
--JOIN musiciangenre mg ON mg.musician_id = m.id 
--GROUP BY m.id 
--HAVING count(*) > 1; 

-- 6.2. название альбомов, в которых присутствуют исполнители более 1 жанра (результирующий ВЛОЖЕННЫЙ select-запрос)
-- находим альбомы, в которых присутствуют исполнители из 1-го (см. запрос выше) вложенного select-запроса
SELECT DISTINCT a.title FROM album a 
JOIN musicianalbum ma ON ma.album_id = a.id 
WHERE ma.musician_id IN (
	SELECT DISTINCT m.id FROM musician m 
	JOIN musiciangenre mg ON mg.musician_id = m.id 
	GROUP BY m.id 
	HAVING count(*) > 1
)
ORDER BY a.title;

-- 7. наименование треков, которые не входят в сборники
SELECT t.name FROM track t 
LEFT JOIN collectiontrack ct ON ct.track_id = t.id 
WHERE ct.collection_id IS NULL 
ORDER BY t.name;

-- 8. исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько)
SELECT m.alias FROM musician m 
JOIN musicianalbum ma ON ma.musician_id = m.id 
JOIN album a ON a.id = ma.album_id 
JOIN track t ON t.album_id = a.id 
WHERE t.duration = (SELECT min(t.duration) FROM track t)
ORDER BY m.alias;

-- 9. название альбомов, содержащих наименьшее количество треков
-- Решим с помощью одного вложенного select-запроса

-- 9.0. найдем количество треков в каждом альбоме (просто для справки)
SELECT a.title, count(*) FROM album a 
JOIN track t ON t.album_id = a.id 
GROUP BY a.title
ORDER BY count(*);

-- 9.1. найдем минимальное число треков (СКАЛЯРНАЯ величина) в альбомах (внутренний select-запрос, для проверки)
SELECT min(arr) FROM UNNEST(array(
	SELECT count(*) FROM album a 
	JOIN track t ON t.album_id = a.id 
	GROUP BY a.title
)) AS arr;

-- 9.2. результирующий ВЛОЖЕННЫЙ select-запрос
-- выберем только те альбомы, где число треков равно минимальному значению из вложенного select-запроса
SELECT a.title FROM album a 
JOIN track t ON t.album_id = a.id 
GROUP BY a.title
HAVING count(*) = (
	SELECT min(arr) FROM UNNEST(array(
		SELECT count(*) FROM album a 
		JOIN track t ON t.album_id = a.id 
		GROUP BY a.title
	)) AS arr
)
ORDER BY a.title;

-- 9.2a. второй (более элегантный) способ с вложенным select-запросом
SELECT a.title FROM album a 
JOIN track t ON t.album_id = a.id 
GROUP BY a.title
HAVING count(*) <= ALL(
	SELECT count(*) FROM album a 
	JOIN track t ON t.album_id = a.id 
	GROUP BY a.title
)
ORDER BY a.title;
