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
INSERT INTO Blocks (BlockID, BlockName, AdviserUserID) VALUES
('2025-31', '3-1', 101),
('2025-32', '3-2', 106),
('2025-33', '3-3', 102),
('2025-14', '1-4', 108),
('2025-35', '3-5', 105),
('2025-46', '4-6', 109),
('2025-17', '1-7', 112);