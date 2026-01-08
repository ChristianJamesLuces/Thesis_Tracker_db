-- =========================================================
-- MASTER SCRIPT: BLOCKS, GROUPS, AND SEEDS
-- Covers: Dev1 (Table), Dev2 (Relations), Dev3 (Seeds & Expansion)
-- =========================================================

-- Dev1: Creation of Table 'Blocks'
CREATE TABLE Blocks (
    BlockID VARCHAR(15) NOT NULL,
    BlockName VARCHAR(50) NOT NULL,
    AdviserUserID INT NOT NULL,
    PRIMARY KEY (BlockID)
);

-- DEV 2: Add the Relations
-- ---------------------------------------------------------

-- A. CONNECT BLOCKS TO USERS (Faculty Adviser)
-- We need to make sure the AdviserUserID in Blocks is a real User.
ALTER TABLE Blocks
ADD CONSTRAINT fk_blocks_adviser
FOREIGN KEY (AdviserUserID) REFERENCES Users(UserID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- B. UPDATE 'USERS' TABLE
-- Students belong to a Block, add the column and the link.
ALTER TABLE Users 
ADD COLUMN BlockID VARCHAR(10); 

ALTER TABLE Users
ADD CONSTRAINT fk_users_block
FOREIGN KEY (BlockID) REFERENCES Blocks(BlockID)
ON DELETE SET NULL -- If block is deleted, user stays but has NULL block
ON UPDATE CASCADE;

-- C. UPDATE 'GROUPS' TABLE
-- Groups also belong to a Block.
ALTER TABLE `Groups`
ADD COLUMN BlockID VARCHAR(10); 

ALTER TABLE `Groups`
ADD CONSTRAINT fk_groups_block
FOREIGN KEY (BlockID) REFERENCES Blocks(BlockID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- Dev3: Add the Seeds
-- ---------------------------------------------------------

-- 1. PRE-REQUISITE: Insert the Advisers (Users) FIRST
-- We must do this before creating Blocks, or the Foreign Key will fail.
DELETE FROM FacultyDetails WHERE UserID = 113; -- Cleanup old coordinator

INSERT IGNORE INTO Users (UserID, SchoolID, FullName, Email, BirthDate, PasswordHash) VALUES
-- The Advisers (Must exist for Blocks to work)
(122, '2010-00010-FA-0', 'Prof. James Moriarty', 'moriarty@gmail.com', NULL, '$2y$10$dummyhash'),
(123, '2010-00011-FA-0', 'Prof. Severus Snape', 'snape@gmail.com', NULL, '$2y$10$dummyhash'),
(124, '2010-00012-FA-0', 'Prof. Minerva McGonagall', 'minerva@gmail.com', NULL, '$2y$10$dummyhash'),
(125, '2010-00013-FA-0', 'Prof. Remus Lupin', 'lupin@gmail.com', NULL, '$2y$10$dummyhash'),
(126, '2010-00014-FA-0', 'Prof. Rubeus Hagrid', 'hagrid@gmail.com', NULL, '$2y$10$dummyhash'),
(127, '2010-00015-FA-0', 'Prof. Albus Dumbledore', 'albus@gmail.com', NULL, '$2y$10$dummyhash'),

-- Other Regular Faculty
(118, '2010-00005-FA-0', 'Prof. John Watson', 'watson@gmail.com', NULL, '$2y$10$dummyhash'),
(119, '2010-00006-FA-0', 'Prof. Mycroft Holmes', 'mycroft@gmail.com', NULL, '$2y$10$dummyhash'),
(120, '2010-00007-FA-0', 'Prof. Greg Lestrade', 'lestrade@gmail.com', NULL, '$2y$10$dummyhash'),
(121, '2010-00008-FA-0', 'Prof. Martha Hudson', 'hudson@gmail.com', NULL, '$2y$10$dummyhash'),
(128, '2010-00016-FA-0', 'Prof. Pomona Sprout', 'sprout@gmail.com', NULL, '$2y$10$dummyhash'),
(129, '2010-00017-FA-0', 'Prof. Filius Flitwick', 'flitwick@gmail.com', NULL, '$2y$10$dummyhash'),
(130, '2010-00018-FA-0', 'Prof. Horace Slughorn', 'slughorn@gmail.com', NULL, '$2y$10$dummyhash');

-- 2. Insert User Roles
INSERT IGNORE INTO UserRoles (UserID, RoleID) VALUES 
(122, 2), (122, 6), -- Moriarty
(123, 2), (123, 6), -- Snape
(124, 2), (124, 6), -- McGonagall
(125, 2), (125, 6), -- Lupin
(126, 2), (126, 6), -- Hagrid
(127, 2), (127, 6), -- Dumbledore
(118, 2), (119, 2), (120, 2), (121, 2), (128, 2), (129, 2), (130, 2);

-- 3. Insert Faculty Details (For Pure Faculty Only)
INSERT IGNORE INTO FacultyDetails (FacultyDetailID, UserID, FacultyType) VALUES 
('F5', 118, 'Part-Time'), ('F6', 119, 'Full-Time'), ('F7', 120, 'Part-Time'), 
('F8', 121, 'Full-Time'), ('F9', 128, 'Full-Time'), ('F10', 129, 'Part-Time'), 
('F11', 130, 'Full-Time');

-- 4. Insert the Section/Block definitions (NOW SAFE)
INSERT INTO Blocks (BlockID, BlockName, AdviserUserID) VALUES
('2025-31', '3-1', 122), -- Moriarty
('2025-32', '3-2', 123), -- Snape
('2025-33', '3-3', 124), -- McGonagall
('2025-34', '3-4', 125), -- Lupin
('2025-35', '3-5', 126), -- Hagrid
('2025-36', '3-6', 127); -- Dumbledore

-- 5. Update existing Students (101-112) to Block 3-1
UPDATE Users SET FullName = 'Marcus John Villadelgado', Email = 'm.villadelgado@gmail.com', BlockID = '2025-31' WHERE UserID = 101;
UPDATE Users SET FullName = 'Angela Marie Gumarang', Email = 'a.gumarang@gmail.com', BlockID = '2025-31' WHERE UserID = 102;
UPDATE Users SET FullName = 'Christian Miguel Santos', Email = 'c.santos@gmail.com', BlockID = '2025-31' WHERE UserID = 103;
UPDATE Users SET FullName = 'Jerome Paul Sicaros', Email = 'j.sicaros@gmail.com', BlockID = '2025-31' WHERE UserID = 104;

UPDATE Users SET FullName = 'Arvin Dave Castillejos', Email = 'a.castillejos@gmail.com', BlockID = '2025-31' WHERE UserID = 105;
UPDATE Users SET FullName = 'Harold Victor Suyatno', Email = 'h.suyatno@gmail.com', BlockID = '2025-31' WHERE UserID = 106;
UPDATE Users SET FullName = 'James Robert Tayag', Email = 'j.tayag@gmail.com', BlockID = '2025-31' WHERE UserID = 107;
UPDATE Users SET FullName = 'Dominic Miguel Silvestreo', Email = 'd.silvestreo@gmail.com', BlockID = '2025-31' WHERE UserID = 108;

UPDATE Users SET FullName = 'Andrei Miguel Concepcion', Email = 'a.concepcion@gmail.com', BlockID = '2025-31' WHERE UserID = 109;
UPDATE Users SET FullName = 'Beatriz Anne Mati', Email = 'b.matiga@gmail.com', BlockID = '2025-31' WHERE UserID = 110;
UPDATE Users SET FullName = 'Renz Christian Datario', Email = 'r.datario@gmail.com', BlockID = '2025-31' WHERE UserID = 111;
UPDATE Users SET FullName = 'Elena Rose Cammarines', Email = 'e.cammarines@gmail.com', BlockID = '2025-31' WHERE UserID = 112;

-- 6. Update existing Groups (G1-G3) to Block 3-1
-- CRITICAL: Update Block AND Adviser (to Moriarty - 122)
UPDATE `Groups` SET BlockID = '2025-31', AdviserUserID = 122 WHERE GroupID IN ('G1', 'G2', 'G3');

-- Update the separate GroupAdvisers table for G1-G3
DELETE FROM GroupAdvisers WHERE GroupID IN ('G1', 'G2', 'G3');
INSERT INTO GroupAdvisers (GroupID, AdviserUserID) VALUES ('G1', 122), ('G2', 122), ('G3', 122);


-- =========================================================
-- EXPANSION: BLOCKS 3-2 TO 3-6 (NEW DATA)
-- =========================================================

-- 7. Insert New Groups (G4 - G18)
INSERT INTO `Groups` (GroupID, GroupCode, YearLevel, AdviserUserID, BlockID) VALUES 
-- Block 3-2 (Snape - 123)
('G4', '3201', 3, 123, '2025-32'), ('G5', '3202', 3, 123, '2025-32'), ('G6', '3203', 3, 123, '2025-32'),
-- Block 3-3 (McGonagall - 124)
('G7', '3301', 3, 124, '2025-33'), ('G8', '3302', 3, 124, '2025-33'), ('G9', '3303', 3, 124, '2025-33'),
-- Block 3-4 (Lupin - 125)
('G10', '3401', 3, 125, '2025-34'), ('G11', '3402', 3, 125, '2025-34'), ('G12', '3403', 3, 125, '2025-34'),
-- Block 3-5 (Hagrid - 126)
('G13', '3501', 3, 126, '2025-35'), ('G14', '3502', 3, 126, '2025-35'), ('G15', '3503', 3, 126, '2025-35'),
-- Block 3-6 (Dumbledore - 127)
('G16', '3601', 3, 127, '2025-36'), ('G17', '3602', 3, 127, '2025-36'), ('G18', '3603', 3, 127, '2025-36');

-- 8. Insert New Students (Users 201-260)
INSERT INTO Users (UserID, SchoolID, FullName, Email, BirthDate, BlockID, PasswordHash) VALUES
-- Block 3-2 (Snape)
(201, '2022-00201-ST-0', 'Draco Malfoy', 'draco@gmail.com', '2004-06-05', '2025-32', '$2y$10$dummyhash'), 
(202, '2022-00202-ST-0', 'Vincent Crabbe', 'crabbe@gmail.com', '2004-02-14', '2025-32', '$2y$10$dummyhash'),
(203, '2022-00203-ST-0', 'Gregory Goyle', 'goyle@gmail.com', '2004-03-22', '2025-32', '$2y$10$dummyhash'),
(204, '2022-00204-ST-0', 'Pansy Parkinson', 'pansy@gmail.com', '2004-08-11', '2025-32', '$2y$10$dummyhash'),
(205, '2022-00205-ST-0', 'Blaise Zabini', 'blaise@gmail.com', '2004-11-09', '2025-32', '$2y$10$dummyhash'), 
(206, '2022-00206-ST-0', 'Theodore Nott', 'theo@gmail.com', '2004-12-21', '2025-32', '$2y$10$dummyhash'),
(207, '2022-00207-ST-0', 'Daphne Greengrass', 'daphne@gmail.com', '2005-01-15', '2025-32', '$2y$10$dummyhash'),
(208, '2022-00208-ST-0', 'Millicent Bulstrode', 'millicent@gmail.com', '2004-05-02', '2025-32', '$2y$10$dummyhash'),
(209, '2022-00209-ST-0', 'Marcus Flint', 'flint@gmail.com', '2003-09-24', '2025-32', '$2y$10$dummyhash'), 
(210, '2022-00210-ST-0', 'Adrian Pucey', 'adrian@gmail.com', '2003-10-18', '2025-32', '$2y$10$dummyhash'),
(211, '2022-00211-ST-0', 'Terence Higgs', 'terence@gmail.com', '2003-07-07', '2025-32', '$2y$10$dummyhash'),
(212, '2022-00212-ST-0', 'Flora Carrow', 'flora@gmail.com', '2004-04-30', '2025-32', '$2y$10$dummyhash'),

-- Block 3-3 (McGonagall)
(213, '2022-00213-ST-0', 'Hermione Granger', 'hermione@gmail.com', '2004-09-19', '2025-33', '$2y$10$dummyhash'), 
(214, '2022-00214-ST-0', 'Harry Potter', 'harry@gmail.com', '2004-07-31', '2025-33', '$2y$10$dummyhash'),
(215, '2022-00215-ST-0', 'Ron Weasley', 'ron@gmail.com', '2004-03-01', '2025-33', '$2y$10$dummyhash'),
(216, '2022-00216-ST-0', 'Neville Longbottom', 'neville@gmail.com', '2004-07-30', '2025-33', '$2y$10$dummyhash'),
(217, '2022-00217-ST-0', 'Dean Thomas', 'dean@gmail.com', '2004-12-10', '2025-33', '$2y$10$dummyhash'), 
(218, '2022-00218-ST-0', 'Seamus Finnigan', 'seamus@gmail.com', '2004-05-15', '2025-33', '$2y$10$dummyhash'),
(219, '2022-00219-ST-0', 'Lavender Brown', 'lavender@gmail.com', '2004-02-09', '2025-33', '$2y$10$dummyhash'),
(220, '2022-00220-ST-0', 'Parvati Patil', 'parvati@gmail.com', '2004-04-12', '2025-33', '$2y$10$dummyhash'),
(221, '2022-00221-ST-0', 'Oliver Wood', 'oliver@gmail.com', '2003-01-20', '2025-33', '$2y$10$dummyhash'), 
(222, '2022-00222-ST-0', 'Fred Weasley', 'fred@gmail.com', '2003-04-01', '2025-33', '$2y$10$dummyhash'),
(223, '2022-00223-ST-0', 'George Weasley', 'george@gmail.com', '2003-04-01', '2025-33', '$2y$10$dummyhash'),
(224, '2022-00224-ST-0', 'Angelina Johnson', 'angelina@gmail.com', '2003-10-25', '2025-33', '$2y$10$dummyhash'),

-- Block 3-4 (Lupin)
(225, '2022-00225-ST-0', 'Cedric Diggory', 'cedric@gmail.com', '2003-09-24', '2025-34', '$2y$10$dummyhash'), 
(226, '2022-00226-ST-0', 'Hannah Abbott', 'hannah@gmail.com', '2004-08-01', '2025-34', '$2y$10$dummyhash'),
(227, '2022-00227-ST-0', 'Susan Bones', 'susan@gmail.com', '2004-07-15', '2025-34', '$2y$10$dummyhash'),
(228, '2022-00228-ST-0', 'Justin Finch-Fletchley', 'justin@gmail.com', '2004-11-30', '2025-34', '$2y$10$dummyhash'),
(229, '2022-00229-ST-0', 'Ernie Macmillan', 'ernie@gmail.com', '2004-05-18', '2025-34', '$2y$10$dummyhash'), 
(230, '2022-00230-ST-0', 'Zacharias Smith', 'zacharias@gmail.com', '2004-09-02', '2025-34', '$2y$10$dummyhash'),
(231, '2022-00231-ST-0', 'Leanne Diggory', 'leanne@gmail.com', '2004-02-28', '2025-34', '$2y$10$dummyhash'),
(232, '2022-00232-ST-0', 'Wayne Hopkins', 'wayne@gmail.com', '2004-06-12', '2025-34', '$2y$10$dummyhash'),
(233, '2022-00233-ST-0', 'Nymphadora Tonks', 'tonks@gmail.com', '2002-05-11', '2025-34', '$2y$10$dummyhash'), 
(234, '2022-00234-ST-0', 'Edward Lupin', 'edward@gmail.com', '2008-04-14', '2025-34', '$2y$10$dummyhash'),
(235, '2022-00235-ST-0', 'Newton Scamander', 'newt@gmail.com', '2004-02-24', '2025-34', '$2y$10$dummyhash'),
(236, '2022-00236-ST-0', 'Theseus Scamander', 'theseus@gmail.com', '2003-08-08', '2025-34', '$2y$10$dummyhash'),

-- Block 3-5 (Hagrid)
(237, '2022-00237-ST-0', 'Luna Lovegood', 'luna@gmail.com', '2005-02-13', '2025-35', '$2y$10$dummyhash'), 
(238, '2022-00238-ST-0', 'Cho Chang', 'cho@gmail.com', '2003-11-09', '2025-35', '$2y$10$dummyhash'),
(239, '2022-00239-ST-0', 'Padma Patil', 'padma@gmail.com', '2004-04-12', '2025-35', '$2y$10$dummyhash'),
(240, '2022-00240-ST-0', 'Marietta Edgecombe', 'marietta@gmail.com', '2003-08-17', '2025-35', '$2y$10$dummyhash'),
(241, '2022-00241-ST-0', 'Michael Corner', 'michael@gmail.com', '2004-06-25', '2025-35', '$2y$10$dummyhash'), 
(242, '2022-00242-ST-0', 'Terry Boot', 'terry@gmail.com', '2004-03-14', '2025-35', '$2y$10$dummyhash'),
(243, '2022-00243-ST-0', 'Anthony Goldstein', 'anthony@gmail.com', '2004-11-22', '2025-35', '$2y$10$dummyhash'),
(244, '2022-00244-ST-0', 'Lisa Turpin', 'lisa@gmail.com', '2004-12-05', '2025-35', '$2y$10$dummyhash'),
(245, '2022-00245-ST-0', 'Gilderoy Lockhart', 'lockhart@gmail.com', '2004-01-26', '2025-35', '$2y$10$dummyhash'), 
(246, '2022-00246-ST-0', 'Filius Flitwick', 'student_filius@gmail.com', '2004-10-17', '2025-35', '$2y$10$dummyhash'),
(247, '2022-00247-ST-0', 'Sybill Trelawney', 'sybill@gmail.com', '2004-03-09', '2025-35', '$2y$10$dummyhash'),
(248, '2022-00248-ST-0', 'Quirinus Quirrell', 'quirrell@gmail.com', '2003-09-26', '2025-35', '$2y$10$dummyhash'),

-- Block 3-6 (Dumbledore)
(249, '2022-00249-ST-0', 'Alastor Moody', 'moody@gmail.com', '2003-05-05', '2025-36', '$2y$10$dummyhash'), 
(250, '2022-00250-ST-0', 'Kingsley Shacklebolt', 'kingsley@gmail.com', '2003-01-19', '2025-36', '$2y$10$dummyhash'),
(251, '2022-00251-ST-0', 'Nymphadora Tonks', 'tonks_auror@gmail.com', '2003-12-14', '2025-36', '$2y$10$dummyhash'),
(252, '2022-00252-ST-0', 'Rufus Scrimgeour', 'rufus@gmail.com', '2003-02-28', '2025-36', '$2y$10$dummyhash'),
(253, '2022-00253-ST-0', 'Sirius Black', 'sirius@gmail.com', '2003-11-03', '2025-36', '$2y$10$dummyhash'), 
(254, '2022-00254-ST-0', 'James Potter', 'james@gmail.com', '2003-03-27', '2025-36', '$2y$10$dummyhash'),
(255, '2022-00255-ST-0', 'Lily Potter', 'lily@gmail.com', '2003-01-30', '2025-36', '$2y$10$dummyhash'),
(256, '2022-00256-ST-0', 'Peter Pettigrew', 'peter@gmail.com', '2003-08-15', '2025-36', '$2y$10$dummyhash'),
(257, '2022-00257-ST-0', 'Tom Riddle', 'voldemort@gmail.com', '2003-12-31', '2025-36', '$2y$10$dummyhash'), 
(258, '2022-00258-ST-0', 'Bellatrix Lestrange', 'bellatrix@gmail.com', '2003-04-18', '2025-36', '$2y$10$dummyhash'),
(259, '2022-00259-ST-0', 'Lucius Malfoy', 'lucius@gmail.com', '2003-09-09', '2025-36', '$2y$10$dummyhash'),
(260, '2022-00260-ST-0', 'Narcissa Malfoy', 'narcissa@gmail.com', '2003-10-06', '2025-36', '$2y$10$dummyhash');

-- 9. Insert Group Members (Defining Leaders and Members)
INSERT INTO GroupMembers (GroupID, StudentUserID, GroupRole) VALUES 
-- BLOCK 3-2 (Snape)
('G4', 201, 'Leader'), ('G4', 202, 'Member'), ('G4', 203, 'Member'), ('G4', 204, 'Member'),
('G5', 205, 'Leader'), ('G5', 206, 'Member'), ('G5', 207, 'Member'), ('G5', 208, 'Member'),
('G6', 209, 'Leader'), ('G6', 210, 'Member'), ('G6', 211, 'Member'), ('G6', 212, 'Member'),

-- BLOCK 3-3 (McGonagall)
('G7', 213, 'Leader'), ('G7', 214, 'Member'), ('G7', 215, 'Member'), ('G7', 216, 'Member'),
('G8', 217, 'Leader'), ('G8', 218, 'Member'), ('G8', 219, 'Member'), ('G8', 220, 'Member'),
('G9', 221, 'Leader'), ('G9', 222, 'Member'), ('G9', 223, 'Member'), ('G9', 224, 'Member'),

-- BLOCK 3-4 (Lupin)
('G10', 225, 'Leader'), ('G10', 226, 'Member'), ('G10', 227, 'Member'), ('G10', 228, 'Member'),
('G11', 229, 'Leader'), ('G11', 230, 'Member'), ('G11', 231, 'Member'), ('G11', 232, 'Member'),
('G12', 233, 'Leader'), ('G12', 234, 'Member'), ('G12', 235, 'Member'), ('G12', 236, 'Member'),

-- BLOCK 3-5 (Hagrid)
('G13', 237, 'Leader'), ('G13', 238, 'Member'), ('G13', 239, 'Member'), ('G13', 240, 'Member'),
('G14', 241, 'Leader'), ('G14', 242, 'Member'), ('G14', 243, 'Member'), ('G14', 244, 'Member'),
('G15', 245, 'Leader'), ('G15', 246, 'Member'), ('G15', 247, 'Member'), ('G15', 248, 'Member'),

-- BLOCK 3-6 (Dumbledore)
('G16', 249, 'Leader'), ('G16', 250, 'Member'), ('G16', 251, 'Member'), ('G16', 252, 'Member'),
('G17', 253, 'Leader'), ('G17', 254, 'Member'), ('G17', 255, 'Member'), ('G17', 256, 'Member'),
('G18', 257, 'Leader'), ('G18', 258, 'Member'), ('G18', 259, 'Member'), ('G18', 260, 'Member');

-- 10. Insert Group Advisers
INSERT INTO GroupAdvisers (GroupID, AdviserUserID) VALUES 
('G4', 123), ('G5', 123), ('G6', 123),     -- Snape
('G7', 124), ('G8', 124), ('G9', 124),     -- McGonagall
('G10', 125), ('G11', 125), ('G12', 125),  -- Lupin
('G13', 126), ('G14', 126), ('G15', 126),  -- Hagrid
('G16', 127), ('G17', 127), ('G18', 127);  -- Dumbledore

-- 11. Insert Enrollments
INSERT INTO Enrollments (EnrollmentID, GroupID, CourseID, SchoolYear, Semester) VALUES 
('E4', 'G4', 'C1', '2025-2026', '2nd'),
('E5', 'G5', 'C1', '2025-2026', '2nd'),
('E6', 'G6', 'C1', '2025-2026', '2nd'),
('E7', 'G7', 'C1', '2025-2026', '2nd'),
('E8', 'G8', 'C1', '2025-2026', '2nd'),
('E9', 'G9', 'C1', '2025-2026', '2nd'),
('E10', 'G10', 'C1', '2025-2026', '2nd'),
('E11', 'G11', 'C1', '2025-2026', '2nd'),
('E12', 'G12', 'C1', '2025-2026', '2nd'),
('E13', 'G13', 'C1', '2025-2026', '2nd'),
('E14', 'G14', 'C1', '2025-2026', '2nd'),
('E15', 'G15', 'C1', '2025-2026', '2nd'),
('E16', 'G16', 'C1', '2025-2026', '2nd'),
('E17', 'G17', 'C1', '2025-2026', '2nd'),
('E18', 'G18', 'C1', '2025-2026', '2nd');
