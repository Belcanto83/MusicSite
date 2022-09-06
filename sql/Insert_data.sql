------------------------------- ЖАНРЫ -------------------------------
-- Заполняем таблицу "Genre"
INSERT INTO genre (name) VALUES 
	('Поп'),
	('Диско'),
	('Хип-хоп');

-- SELECT * FROM generate_series(2,4);

INSERT INTO genre (name) VALUES
	('Рок'),
	('Джаз');

------------------------------- МУЗЫКАНТЫ -------------------------------
-- Заполняем таблицу "Musician"
INSERT INTO musician (alias) VALUES 
	('Nina Nesbitt'),
	('Oxxxymiron'),
	('Полина Гагарина'),
	('ДДТ'),
	('Louis Armstrong');

INSERT INTO musician (alias) VALUES 
	('Haliene'),
	('Queen'),
	('Norah Jones');

INSERT INTO musician (alias) VALUES 
	('Ranji');

INSERT INTO musician (alias) VALUES 
	('Schokk');

------------------------------- АЛЬБОМЫ -------------------------------
-- Заполняем таблицу "Album"
-- Альбом исполнителя "Nina Nesbitt"
-- Альбом "The Moments I'm Missing" принадлежит 2 исполнителям: Nina Nesbitt и Ranji
INSERT INTO album (title, release_year) VALUES 
	(E'The Moments I\'m Missing', '2019-10-05');

INSERT INTO album (title, release_year) VALUES 
	(E'Modern Love EP', '2016-01-23');

INSERT INTO album (title, release_year) VALUES 
	('The Sun Will Come up, The Seasons Will Change & The Flowers Will Fall', '2019-09-03');

-- Альбомы исполнителя ДДТ
INSERT INTO album (title, release_year) VALUES 
	(E'Творчество в пустоте', '2021-08-14'),
	(E'Галя ходи', '2018-10-05');

-- Альбомы исполнителя Oxxxymiron
-- Альбом "То густо, то пусто" принадлежит 2 исполнителям: Oxxxymiron и Schokk
INSERT INTO album (title, release_year) VALUES 
	(E'То густо, то пусто', '2011-04-18'),
	(E'Красота и Уродство', '2021-03-14');

-- Альбомы исполнителя Schokk
INSERT INTO album (title, release_year) VALUES 
	('PARA', '2018-09-20');

-- Альбомы исполнителя Полина Гагарина
INSERT INTO album (title, release_year) VALUES 
	('Шоу «Обезоружена»', '2019-01-19');

-- Альбомы исполнителя Queen
INSERT INTO album (title, release_year) VALUES 
	('Queen Rock Montreal', '2007-07-08'),
	('Queen Forever', '2014-03-18');

-- Альбомы исполнителя Louis Armstrong
INSERT INTO album (title, release_year) VALUES 
	('At The Crescendo, Vol. 1', '2022-01-25'),
	('Lonesome Road', '2022-11-28');

-- Альбомы исполнителя Norah Jones
INSERT INTO album (title, release_year) VALUES 
	('I Dream Of Christmas', '2021-03-05');

------------------------------- ТРЕКИ -------------------------------
-- Треки исполнителя Nina Nesbitt
INSERT INTO track (name, duration, album_id) VALUES 
	('The Moments I’m Missing', 184, 3),
	('Chewing Gum', 199, 7),
	('Take You To Heaven', 239, 7),
	('Sacred', 157, 10),
	('Somebody Special', 200, 10),
	('Love Letter', 214, 10);

-- Треки исполнителя Oxxxymiron
INSERT INTO track (name, duration, album_id) VALUES 
	('То густо, то пусто', 214, 8),
	('Vasco da Gama', 289, 8),
	('Хоп-механика', 138, 9);

-- Треки исполнителя ДДТ
INSERT INTO track (name, duration, album_id) VALUES 
	('Муха', 556, 4),
	('Борщевик', 307, 4),
	('Альтернатива', 269, 5),
	('Уездный город', 197, 5);

-- Треки исполнителя Полина Гагарина
INSERT INTO track (name, duration, album_id) VALUES 
	('Intro', 206, 12),
	('Стану солнцем', 305, 12);

-- Треки исполнителя Schokk
INSERT INTO track (name, duration, album_id) VALUES 
	('Жанр', 141, 11),
	('Если б кто-то знал', 194, 11);

-- Треки исполнителя Queen
INSERT INTO track (name, duration, album_id) VALUES 
	('We Will Rock You', 186, 13),
	('Save Me', 254, 13),
	('Let Me In Your Heart Again', 275, 14);

-- Треки исполнителя Louis Armstrong
INSERT INTO track (name, duration, album_id) VALUES 
	('My Bucket’s Got A Hole In It', 184, 15),
	('Lazy River', 260, 15);

-- Треки исполнителя Norah Jones
INSERT INTO track (name, duration, album_id) VALUES 
	(E'Christmas Don\'t Be Late', 160, 17),
	(E'You\'re Not Alone', 232, 17);

------------------------------- СБОРНИКИ -------------------------------
INSERT INTO collection (title, release_year) VALUES 
	('Танцевальный марафон', '2021-10-15'),
	('Русский рэп', '2022-01-18'),
	('Легенды рока', '2020-05-14');

-------------------------- СОЕДИНИТЕЛЬНЫЕ ТАБЛИЦЫ (связь "многие ко многим") --------------------------
-- Музыканты & Жанры
INSERT INTO musiciangenre (genre_id, musician_id) VALUES 
	(1, 1),
	(1, 3),
	(1, 6),
	(1, 7),
	(1, 10),
	(2, 1),
	(2, 6),
	(2, 10),
	(3, 2),
	(3, 11),
	(4, 4),
	(4, 7),
	(5, 5),
	(5, 8);

-- Музыканты & Альбомы
INSERT INTO musicianalbum (musician_id, album_id) VALUES 
	(1, 3),
	(1, 7),
	(1, 10),
	(2, 8),
	(2, 9),
	(3, 12),
	(4, 4),
	(4, 5),
	(5, 15),
	(5, 16),
	(7, 13),
	(7, 14),
	(8, 17),
	(10, 3),
	(11, 8),
	(11, 11);

-- Сборники & Треки
INSERT INTO collectiontrack (collection_id, track_id) VALUES 
	(1, 1),
	(1, 2),
	(1, 3),
	(1, 4),
	(1, 5),
	(1, 6),
	(1, 15),
	(1, 18),
	(1, 23),
	(1, 24),
	(2, 7),
	(2, 8),
	(2, 9),
	(3, 11),
	(3, 12),
	(3, 13),
	(3, 18),
	(3, 19),
	(3, 20);
