-- Drop tables if they exist
DROP TABLE IF EXISTS issuebook;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS rack;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS book_criteria;

-- Create rack table
CREATE TABLE rack (
    rid INT PRIMARY KEY,
    rname VARCHAR(100) NOT NULL
);

-- Create student table
CREATE TABLE student (
    sid INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    qualification VARCHAR(20)
);

-- Create book_criteria table
CREATE TABLE book_criteria (
    qualification VARCHAR(20) PRIMARY KEY,
    no_ofBook INT,
    no_ofDays INT
);

-- Create book table
CREATE TABLE book (
    bid INT PRIMARY KEY,
    bname VARCHAR(100),
    bauthor VARCHAR(100),
    bcategory VARCHAR(100),
    rid INT,
    sid INT DEFAULT 0,         -- sid can be set when book is issued
    idate DATE DEFAULT NULL,
    FOREIGN KEY (rid) REFERENCES rack(rid)
);


CREATE TABLE issuebook (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sid INT NOT NULL,
    bid INT NOT NULL,
    issue_date DATE NOT NULL,
    return_date DATE DEFAULT NULL,
    FOREIGN KEY (sid) REFERENCES student(sid),
    FOREIGN KEY (bid) REFERENCES book(bid)
);


-- Sample rack data
INSERT INTO rack (rid, rname) VALUES
(1, 'Fiction'),
(2, 'Sci-Fi'),
(3, 'Computers'),
(4, 'History'),
(5, 'Maths'),
(6, 'Commerce'),
(7, 'Arts');
-- Sample student data
INSERT INTO student (sid, name, email, qualification) VALUES
(101, 'Alice', 'alice@cbit.edu', 'UG'),
(102, 'Bob', 'bob@cbit.edu', 'PG'),
(103, 'Charlie', 'charlie@cbit.edu' , 'UG');

-- Sample book_criteria data
INSERT INTO book_criteria (qualification, no_ofBook, no_ofDays) VALUES
('UG', 3, 15),
('PG', 5, 30);

-- Sample book data
-- Corrected book inserts
INSERT INTO book (bid, bname, bauthor, bcategory, rid, sid, idate) VALUES
(201, 'Java Fundamentals', 'Herbert Schildt', 'Technology', 3, 0, NULL),
(202, 'Physics for Engineers', 'Halliday', 'Science', 2, 0, NULL),
(203, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1, 0, NULL),
(204, 'GOT', 'RR.MARTIN', 'Arts', 7, 0, NULL);



INSERT INTO issuebook (sid, bid, issue_date) VALUES (101, 204, CURDATE());
