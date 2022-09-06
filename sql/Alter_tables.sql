ALTER TABLE album 
ADD CHECK (date_part('year', release_year) > 1900);