-- SQL 1: Artist with Most Albums
SELECT Artist.Name, COUNT(Album.AlbumId) AS AlbumCount
FROM Artist
JOIN Album ON Artist.ArtistId = Album.ArtistId
GROUP BY Artist.Name
ORDER BY AlbumCount DESC
LIMIT 1;

-- SQL 2: Top Three Genres
SELECT Genre.Name, COUNT(Track.GenreId) AS GenreCount
FROM Genre
JOIN Track ON Genre.GenreId = Track.GenreId
GROUP BY Genre.Name
ORDER BY GenreCount DESC
LIMIT 3;

-- SQL 3: Tracks and Average Run Time per Media Type
SELECT MediaType.Name, COUNT(Track.TrackId) AS TrackCount, AVG(Track.Milliseconds) AS AverageRunTime
FROM MediaType
JOIN Track ON MediaType.MediaTypeId = Track.MediaTypeId
GROUP BY MediaType.Name;
