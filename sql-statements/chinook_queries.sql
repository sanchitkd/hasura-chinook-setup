-- SQL 1: Artist with Most Albums
chinook=# SELECT "artist"."name", COUNT("album"."album_id") AS album_count FROM "album" JOIN "artist" ON "album"."artist_id" = "artist"."artist_id" GROUP BY "artist"."name" ORDER BY album_count DESC LIMIT 1;
    name     | album_count
-------------+-------------
 Iron Maiden |          21
(1 row)

chinook=#

-- SQL 2: Top Three Genres
chinook=# SELECT genre.name, COUNT(track.genre_id) AS genreCount FROM genre JOIN track ON genre.genre_id = track.genre_id GROUP BY genre.name ORDER BY genreCount DESC LIMIT 3;
 name  | genrecount
-------+------------
 Rock  |       1297
 Latin |        579
 Metal |        374
(3 rows)

chinook=#

-- SQL 3: Tracks and Average Run Time per Media Type
chinook=# SELECT media_type.name, COUNT(track.track_id) AS trackCount, AVG(track.milliseconds) AS AverageRunTime FROM media_type JOIN track ON media_type.media_type_id = track.media_type_id GROUP BY media_type.name;
            name             | trackcount |    averageruntime
-----------------------------+------------+----------------------
 AAC audio file              |         11 |  276506.909090909091
 Protected MPEG-4 video file |        214 | 2342940.425233644860
 MPEG audio file             |       3034 |  265574.288727752142
 Protected AAC audio file    |        237 |  281723.873417721519
 Purchased AAC audio file    |          7 |  260894.714285714286
(5 rows)

chinook=#
