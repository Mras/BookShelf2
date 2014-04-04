/* Delete the tables if they already exist */
drop table if exists Book;
drop table if exists Author;
drop table if exists Wrote;
drop table if exists Publisher;
drop table if exists BookFormats;

/* Create the schema for tables */
CREATE TABLE BookFormats(BFORMAT VARCHAR(40) PRIMARY KEY);
CREATE TABLE Publisher(ID INTEGER PRIMARY KEY AUTOINCREMENT,PUBLISHER VARCHAR(255));
CREATE TABLE Book(ISBN BIGINT(13) PRIMARY KEY, TITLE VARCHAR(255) NOT NULL, EDITION VARCHAR(50),PRICE DECIMAL(10,2),LANGCODE VARCHAR(3),PAGES SMALLINT NOT NULL,BFORMAT VARCHAR(40),PUBID INTEGER,PUBDATE DATE,REMARK VARCHAR(255),FOREIGN KEY(BFORMAT) REFERENCES BookFormats(BFORMAT),FOREIGN KEY(PUBID) REFERENCES Publisher(ID)); 
CREATE TABLE Author(ID INTEGER PRIMARY KEY AUTOINCREMENT, FIRSTNAME VARCHAR(100),LASTNAME VARCHAR(100), MIDDLENAME VARCHAR(100), CHECK(NOT((FIRSTNAME is null) and (LASTNAME is null) and (MIDDLENAME is null))));   /* all three cannot be null at the same time */ 
CREATE TABLE Wrote(aID INTEGER,ISBN BIGINT(13),PRIMARY KEY (aID,ISBN),FOREIGN KEY(aID) REFERENCES Author(ID),FOREIGN KEY(ISBN) REFERENCES Book(ISBN));

/* Populate the tables with data */
insert into BookFormats values('Paperback');
insert into BookFormats values('Hardcover');
insert into BookFormats values('Kindle Edition');
insert into BookFormats values('Audible Audio Edition');
insert into BookFormats values('HTML');
insert into BookFormats values('PDF');
insert into BookFormats values('Audio CD');
insert into BookFormats values('Board Book');
insert into BookFormats values('Audio Cassette');
insert into BookFormats values('Calendar');
insert into BookFormats values('School Binding');
insert into BookFormats values('MP3 CD');
insert into BookFormats values('Audiobooks');

insert into Publisher values(null,'Scribner');
insert into Publisher values(null,'Square Fish');
insert into Publisher values(null,'Simon & Schuster');
insert into Publisher values(null,'Ace Trade');
insert into Publisher values(null,'Dover Publications');
insert into Publisher values(null,'Everyman''s Library');
insert into Publisher values(null,'HMH Books for Young Readers');
insert into Publisher values(null,'Farrar');

insert into Author values(null,'Frank','McCourt',null);
insert into Author values(null,'Ray','Bradbury',null);
insert into Author values(null,'George','Selden',null);
insert into Author values(null,'Charles','Dickens',null);
insert into Author values(null,'Frank','Herbert',null);
insert into Author values(null,'Marcus','Buckingham',null);
insert into Author values(null,'Curt','Coffman',null);
insert into Author values(null,'Vladimir','Nabokov','Vladimirovich');
insert into Author values(null,'Antoine','Saint-Exupery','de');

insert into Book 
select 9780547978840,'The Little Prince','Reprint edition',5.64,'ENU',112,'Paperback',id,'March 5, 2013','Unique and universal'
from Publisher 
where PUBLISHER='HMH Books for Young Readers';

insert into Book 
select 9780679410430,'Lolita','Reissue edition',17.19,'ENU',376,'Hardcover',id,'March 9, 1993','Nabokov''s triumph'
from Publisher 
where PUBLISHER='Everyman''s Library';

insert into Book 
select 9780684842677,'Angela''s Ashes: A Memoir','1St Edition',13.14,'ENU',368,'Paperback',id,'May 25, 1999','An Irish-American Memoir'
from Publisher 
where PUBLISHER='Scribner';

insert into Book 
select 9780312367558,'A Wrinkle in Time','Madeleine L''Engle''s Time Quintet edition',4.92,'ENU',320,'Paperback',id,'May 1, 2007','The 60s kids classic'
from Publisher 
where PUBLISHER='Square Fish';

insert into Book 
select 9781451673319,'Fahrenheit 451','Reissue edition',7.95,'ENU',249,'Paperback',id,'January 10, 2012','"It was a pleasure to burn."'
from Publisher 
where PUBLISHER='Simon & Schuster';

insert into Book 
select 9780441013593,'Dune','40 Anniversary edition',12.08,'ENU',544,'Paperback',id,'August 2, 2005','A science fiction classic'
from Publisher 
where PUBLISHER='Ace Trade';

insert into Book 
select 9780486415864,'Great Expectations','Unabridged edition',3.04,'ENU',384,'Paperback',id,'August 1, 2001','Dickens'' best novel'
from Publisher 
where PUBLISHER='Dover Publications';

insert into Book 
select 9780374316501,'The Cricket in Times Square','1st edition',13.92,'ENU',144,'Hardcover',id,'January 1, 1960',null 
from Publisher 
where PUBLISHER='Farrar';

insert into Book 
select 9780684852867,'First, Break All the Rules: What the World''s Greatest Managers Do Differently','1 edition',18.08,'ENU',255,'Hardcover',id,'May 5, 1999',null 
from Publisher 
where PUBLISHER='Simon & Schuster';

insert into Wrote 
select ID,9780547978840 
from Author 
where Author.LASTNAME='Saint-Exupery';

insert into Wrote 
select ID,9780679410430 
from Author 
where Author.LASTNAME='Nabokov';

insert into Wrote 
select ID,9780684842677 
from Author 
where Author.LASTNAME='McCourt';

insert into Wrote 
select ID,9780312367558 
from Author 
where Author.LASTNAME='L''Engle';

insert into Wrote 
select ID,9781451673319 
from Author 
where Author.LASTNAME='Bradbury';

insert into Wrote 
select ID,9780441013593 
from Author 
where Author.LASTNAME='Herbert';

insert into Wrote 
select ID,9780486415864 
from Author 
where Author.LASTNAME='Dickens';

insert into Wrote 
select ID,9780374316501 
from Author 
where Author.LASTNAME='Selden';

insert into Wrote 
select ID,9780684852867 
from Author 
where Author.LASTNAME='Buckingham';

insert into Wrote 
select ID,9780684852867 
from Author 
where Author.LASTNAME='Coffman';

CREATE VIEW SUMMARY
(select Book.title,Author.FIRSTNAME,Author.MIDDLENAME,Author.LASTNAME,Book.price 
from Book,Author,Wrote 
where Author.id=Wrote.aID and Book.ISBN=Wrote.ISBN;)
