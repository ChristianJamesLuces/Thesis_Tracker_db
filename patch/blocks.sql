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

