--Part – A
--1. Retrieve a unique genre of songs.
select distinct genre from songs
--2. Find top 2 albums released before 2010.
select top 2 album_title from albums where release_year<2010
--3. Insert Data into the Songs Table. (1245, ‘Zaroor’, 2.55, ‘Feel good’, 1005)
insert into songs values(1245,'zaroor',2.55,'feel good',1005);
select * from songs
--4. Change the Genre of the song ‘Zaroor’ to ‘Happy’
update songs set genre='happy' where song_title='zaroor'
--5. Delete an Artist ‘Ed Sheeran’
delete from artists where artist_name='ed sheeran'
--6. Add a New Column for Rating in Songs Table. [Ratings decimal(3,2)]
alter table songs add ratings decimal(3,2);
--7. Retrieve songs whose title starts with 'S'.
	select song_title from songs where song_title like 's%'
--8. Retrieve all songs whose title contains 'Everybody'.
select song_title from songs where song_title like '%everybody%'
--9. Display Artist Name in Uppercase.
select upper(artist_name) from artists
--10. Find the Square Root of the Duration of a Song ‘Good Luck’
	select sqrt(duration) from songs where song_title = 'good luck'
--11. Find Current Date.
select  GETDATE()
--12. Find the number of albums for each artist.
select count(album_id),artist_id from albums group by artist_id
--13. Retrieve the Album_id which has more than 5 songs in it.
select album_id from albums group by album_id having count(album_id)>3
--14. Retrieve all songs from the album 'Album1'. (using Subquery)
	select song_title from songs where album_id in (select album_id from albums where album_title ='album1')
--15. Retrieve all albums name from the artist ‘Aparshakti Khurana’ (using Subquery)
	select album_title from albums where artist_id =(select artist_id from artists where artist_name ='Aparshakti Khurana')
--16. Retrieve all the song titles with its album title.
	select s.song_title,a.album_title from songs s join albums a on s.album_id = a.album_id
--17. Find all the songs which are released in 2020.
select song_title from songs where album_id in(select album_id from albums where release_year=2020)
--18. Create a view called ‘Fav_Songs’ from the songs table having songs with song_id 101-105.
		create view Fav_songs as (select * from songs where song_id between 101 and 105)
--19. Update a song name to ‘Jannat’ of song having song_id 101 in Fav_Songs view.
		update Fav_songs set song_title ='jannat' where song_id=101
		select * from Fav_songs
--20. Find all artists who have released an album in 2020.
	select artist_name from artists where artist_id in (select artist_id from albums where release_year=2020)
--21. Retrieve all songs by Shreya Ghoshal and order them by duration. 
	SELECT Songs.song_title, Songs.duration
	FROM Songs
	JOIN Albums ON Songs.Album_id = Albums.Album_id
	JOIN Artists ON Albums.Artist_id = Artists.Artist_id
	WHERE Artists.Artist_name = 'Shreya Ghoshal'
	ORDER BY Songs.duration DESC;
--	Part – B
--22. Retrieve all song titles by artists who have more than one album.
select song_title from songs where album_id in(
select album_id from albums where artist_id in(
select artist_id from albums group by artist_id having count(album_id) >1))

--23. Retrieve all albums along with the total number of songs.
	select a.Album_title,count(s.song_title) from albums a join songs s on s.album_id = a.album_id group by a.Album_title
--24. Retrieve all songs and release year and sort them by release year.
select s.song_title,a.release_year from songs s join Albums a on s.Album_id = a.Album_id order by a.Release_year desc
--25. Retrieve the total number of songs for each genre, showing genres that have more than 2 songs.
select genre,count(song_title) from songs group by genre having count(song_title)>2
--26. List all artists who have albums that contain more than 3 songs.SELECT DISTINCT Artists.Artist_name
SELECT DISTINCT Artists.Artist_name
FROM Artists
JOIN Albums ON Artists.Artist_id = Albums.Artist_id
JOIN Songs ON Albums.Album_id = Songs.Album_id
GROUP BY Albums.Album_id, Artists.Artist_id, Artists.Artist_name
HAVING COUNT(Songs.Song_id) > 3;

--Part – C
--27. Retrieve albums that have been released in the same year as 'Album4'
	select album_title from albums where release_year = (select release_year from albums where album_title = 'album4');
--28. Find the longest song in each genre
select genre,max(duration) from songs group by genre
--29. Retrieve the titles of songs released in albums that contain the word 'Album' in the title.
	select song_title from songs where song_title like '%album%'
--30. Retrieve the total duration of songs by each artist where total duration exceeds 15 minutes.
select ar.artist_name,sum(s.duration) from artists ar join albums a on ar.artist_id = a.artist_id join songs s on s.album_id = a.album_id group by ar.artist_name having sum(s.duration)>15