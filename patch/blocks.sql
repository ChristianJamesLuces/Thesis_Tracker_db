-- Dev1: Creation of Table 'Blocks'

CREATE TABLE Blocks (
BlockID VARCHAR(10) NOT NULL,
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
ADD COLUMN BlockID VARCHAR(10); -- Adding the new column

ALTER TABLE Users
ADD CONSTRAINT fk_users_block
FOREIGN KEY (BlockID) REFERENCES Blocks(BlockID)
ON DELETE SET NULL -- If block is deleted, user stays but has NULL block
ON UPDATE CASCADE;

-- C. UPDATE 'GROUPS' TABLE
-- Groups also belong to a Block.
ALTER TABLE `Groups`
ADD COLUMN BlockID VARCHAR(10); -- Adding the new column

ALTER TABLE `Groups`
ADD CONSTRAINT fk_groups_block
FOREIGN KEY (BlockID) REFERENCES Blocks(BlockID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- Dev3: Add the Seeds
-- 1. Insert the Section/Block definitions
INSERT INTO Blocks (BlockID, BlockName, AdviserUserID) VALUES
('2025-31', '3-1', 113), -- Assigned to Prof. Tokyo
('2025-32', '3-2', 115), -- Assigned to Prof. Clara
('2025-33', '3-3', 113), -- Assigned to Prof. Tokyo
('2025-35', '3-5', 116); -- Assigned to Prof. Sherlock

-- 2. Update existing Students with Full Names and assign them to Blocks
-- GROUP 1 (Assigned to Block 2025-31)
UPDATE Users SET FullName = 'Marcus John Villadelgado', Email = 'm.villadelgado@gmail.com', BlockID = '2025-31' WHERE UserID = 101;
UPDATE Users SET FullName = 'Angela Marie Gumarang', Email = 'a.gumarang@gmail.com', BlockID = '2025-31' WHERE UserID = 102;
UPDATE Users SET FullName = 'Christian Miguel Santos', Email = 'c.santos@gmail.com', BlockID = '2025-31' WHERE UserID = 103;
UPDATE Users SET FullName = 'Jerome Paul Sicaros', Email = 'j.sicaros@gmail.com', BlockID = '2025-31' WHERE UserID = 104;

-- GROUP 2 (Assigned to Block 2025-32)
UPDATE Users SET FullName = 'Arvin Dave Castillejos', Email = 'a.castillejos@gmail.com', BlockID = '2025-32' WHERE UserID = 105;
UPDATE Users SET FullName = 'Harold Victor Suyatno', Email = 'h.suyatno@gmail.com', BlockID = '2025-32' WHERE UserID = 106;
UPDATE Users SET FullName = 'James Robert Tayag', Email = 'j.tayag@gmail.com', BlockID = '2025-32' WHERE UserID = 107;
UPDATE Users SET FullName = 'Dominic Miguel Silvestreo', Email = 'd.silvestreo@gmail.com', BlockID = '2025-32' WHERE UserID = 108;

-- GROUP 3 (Assigned to Block 2025-33)
UPDATE Users SET FullName = 'Andrei Miguel Concepcion', Email = 'a.concepcion@gmail.com', BlockID = '2025-33' WHERE UserID = 109;
UPDATE Users SET FullName = 'Beatriz Anne Mati', Email = 'b.matiga@gmail.com', BlockID = '2025-33' WHERE UserID = 110;
UPDATE Users SET FullName = 'Renz Christian Datario', Email = 'r.datario@gmail.com', BlockID = '2025-33' WHERE UserID = 111;
UPDATE Users SET FullName = 'Elena Rose Cammarines', Email = 'e.cammarines@gmail.com', BlockID = '2025-33' WHERE UserID = 112;

-- 3. Update existing Groups to link them to their respective Blocks
UPDATE `Groups` SET BlockID = '2025-31' WHERE GroupID = 'G1';
UPDATE `Groups` SET BlockID = '2025-32' WHERE GroupID = 'G2';
UPDATE `Groups` SET BlockID = '2025-33' WHERE GroupID = 'G3';
