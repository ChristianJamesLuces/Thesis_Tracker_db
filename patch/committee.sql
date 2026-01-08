
-- 0. DISABLE SAFE UPDATE MODE (To allow cleanup and schema changes)
SET SQL_SAFE_UPDATES = 0;

-- =========================================================
-- PRE-REQUISITE: CLEANUP OLD DATA
-- =========================================================
DELETE FROM ResearchArchive;
DELETE FROM Submissions;
DELETE FROM DefenseEvaluations;
DELETE FROM DefensePanel;
DELETE FROM Defenses;
DELETE FROM ProposalApprovals;
DELETE FROM Proposals;

-- =========================================================
-- DEV 1: COMPREHENSIVE SCHEMA UPDATES (STRICT CONSTRAINTS)
-- =========================================================
-- A. Users & Academic Info
ALTER TABLE Courses 
    MODIFY COLUMN CourseName VARCHAR(100) NOT NULL,
    MODIFY COLUMN PrerequisiteCourseID VARCHAR(10) NULL;

ALTER TABLE FacultyDetails 
    MODIFY COLUMN FacultyType VARCHAR(20) NOT NULL;

ALTER TABLE Users 
    MODIFY COLUMN FullName VARCHAR(100) NOT NULL,
    MODIFY COLUMN Email VARCHAR(100) NOT NULL,
    MODIFY COLUMN PasswordHash VARCHAR(255) NOT NULL;

-- B. Groups & Enrollments
ALTER TABLE `Groups` 
    MODIFY COLUMN GroupCode VARCHAR(20) NOT NULL, 
    MODIFY COLUMN YearLevel INT NOT NULL;

ALTER TABLE Enrollments 
    MODIFY COLUMN SchoolYear VARCHAR(10) NOT NULL, 
    MODIFY COLUMN Semester VARCHAR(10) NOT NULL;

-- C. Proposals (Stage 1: Adviser Control)
ALTER TABLE Proposals 
    MODIFY COLUMN ResearchTitle VARCHAR(500) NOT NULL,
    MODIFY COLUMN SubmissionDate DATE NOT NULL,
    MODIFY COLUMN Deadline DATE NOT NULL, -- Changed from ADD to MODIFY
    MODIFY COLUMN Status VARCHAR(20) NOT NULL DEFAULT 'Submitted';

-- D. ProposalApprovals (Stage 2: Committee/Coordinator Review)
ALTER TABLE ProposalApprovals 
    MODIFY COLUMN ApprovalRole VARCHAR(50) NOT NULL,
    MODIFY COLUMN Status VARCHAR(20) NOT NULL DEFAULT 'Submitted',
    MODIFY COLUMN Remarks TEXT NULL; -- Changed from ADD to MODIFY

-- E. Defenses & Evaluations
ALTER TABLE Defenses 
    MODIFY COLUMN DefenseType VARCHAR(50) NOT NULL,
    MODIFY COLUMN Schedule DATETIME NOT NULL,
    MODIFY COLUMN OverallVerdict VARCHAR(20) NOT NULL DEFAULT 'Not Defended';

ALTER TABLE DefensePanel 
    MODIFY COLUMN Status VARCHAR(20) NOT NULL DEFAULT 'Pending';

ALTER TABLE DefenseEvaluations 
    MODIFY COLUMN Verdict VARCHAR(50) NOT NULL DEFAULT 'Pending',
    ADD COLUMN Remarks TEXT NULL AFTER Verdict; -- Changed from ADD to MODIFY

-- F. Submissions & Archive
ALTER TABLE Submissions 
    MODIFY COLUMN FileType VARCHAR(50) NOT NULL;

ALTER TABLE ResearchArchive 
    MODIFY COLUMN PublishedDate DATE NULL,
    MODIFY COLUMN AbstractFilePath TEXT NULL,
    MODIFY COLUMN FullManuscriptPath TEXT NULL;

-- G. Patch Specific Tables (Blocks & Committee)
-- Using CREATE TABLE IF NOT EXISTS is already safe for re-runs
CREATE TABLE IF NOT EXISTS Committee (
    CommitteeID VARCHAR(10) NOT NULL,
    UserID INT NOT NULL,
    AcademicYear VARCHAR(20) NOT NULL,
    Semester VARCHAR(20) NOT NULL,
    RoleID INT NOT NULL,
    PRIMARY KEY (CommitteeID)
);

ALTER TABLE Blocks MODIFY COLUMN BlockName VARCHAR(50) NOT NULL;

-- =========================================================
-- DEV 2: ADD THE RELATIONS
-- =========================================================
ALTER TABLE Committee ADD CONSTRAINT fk_committee_user FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE;
ALTER TABLE Committee ADD CONSTRAINT fk_committee_role FOREIGN KEY (RoleID) REFERENCES Roles(RoleID) ON DELETE RESTRICT;

-- =========================================================
-- DEV 3: SEED COMMITTEE DATA
-- =========================================================
INSERT INTO Committee (CommitteeID, UserID, AcademicYear, Semester, RoleID) VALUES
('C1', 122, '2025-2026', '1st', 6), 
('C2', 123, '2025-2026', '1st', 6), 
('C3', 124, '2025-2026', '1st', 6), 
('C4', 125, '2025-2026', '1st', 6), 
('C5', 126, '2025-2026', '1st', 6), 
('C6', 127, '2025-2026', '1st', 3);

-- =========================================================
-- DEV 4: WORKFLOW SEEDING (BLOCK 3-1 ONLY)
-- =========================================================
UPDATE Enrollments SET CourseID = 'C1', Semester = '1st' WHERE GroupID IN ('G1', 'G2', 'G3');

-- 1. PROPOSALS (Student -> Adviser)
INSERT INTO Proposals (ProposalID, EnrollmentID, ResearchTitle, SubmissionDate, Deadline, Status) VALUES 
('P1', 'E1', 'Automated Hydroponics System using IoT', '2025-09-15', '2025-09-30', 'Approved'),
('P2', 'E1', 'Smart Solar Powered Irrigation', '2025-09-01', '2025-09-30', 'Approved'),
('P3', 'E1', 'Voice Controlled Home Automation', '2025-09-05', '2025-09-30', 'Approved'),
('P4', 'E1', 'Basic Arduino Alarm System', '2025-09-10', '2025-09-30', 'Rejected'),
('P5', 'E2', 'RFID-Based Student Attendance Monitoring', '2025-09-16', '2025-09-30', 'Approved'),
('P9', 'E3', 'Traffic Density Analysis using Computer Vision', '2025-09-20', '2025-09-30', 'Submitted');

-- 2. PROPOSAL APPROVALS (Committee Check)
INSERT INTO ProposalApprovals (ApprovalID, ProposalID, ApprovedUserID, ApprovalRole, Status, Remarks) VALUES 
('A1', 'P1', 127, 'Research Coordinator', 'Approved', 'Title aligns with department goals.'),
('A2', 'P1', 123, 'Committee Member', 'Approved', 'Hardware components are feasible.'),
('A3', 'P5', 127, 'Research Coordinator', 'Approved', 'Proceed to manuscript preparation.');

-- 3. DEFENSES (MOR Title Defense)
INSERT INTO Defenses (DefenseID, EnrollmentID, ProposalID, DefenseType, Schedule, OverallVerdict) VALUES 
('D_G1_MOR', 'E1', 'P1', 'MOR Title Defense', '2025-10-25 09:00:00', 'Defended'),
('D_G2_MOR', 'E2', 'P5', 'MOR Title Defense', '2025-10-25 10:30:00', 'Defended');

-- 4. DEFENSE PANEL
INSERT INTO DefensePanel (DefenseID, PanelistUserID, Status) VALUES 
('D_G1_MOR', 123, 'Accepted'), ('D_G1_MOR', 124, 'Accepted'), ('D_G1_MOR', 125, 'Accepted'),
('D_G2_MOR', 123, 'Accepted'), ('D_G2_MOR', 125, 'Accepted'), ('D_G2_MOR', 126, 'Accepted');

-- 5. SUBMISSIONS (Files F1-F14)
INSERT INTO Submissions (FileID, ProposalID, DefenseID, FileType, FilePath, UploadedByUserID) VALUES 
('F1', 'P1', NULL, 'Proposal', '/uploads/g1_p1.pdf', 101),
('F2', 'P2', NULL, 'Proposal', '/uploads/g1_p2.pdf', 101),
('F3', 'P3', NULL, 'Proposal', '/uploads/g1_p3.pdf', 101),
('F4', 'P4', NULL, 'Proposal', '/uploads/g1_p4.pdf', 101),
('F5', 'P1', 'D_G1_MOR', 'Manuscript_MOR', '/uploads/g1_manu.pdf', 101),
('F6', 'P5', NULL, 'Proposal', '/uploads/g2_p5.pdf', 105),
('F10', 'P5', 'D_G2_MOR', 'Manuscript_MOR', '/uploads/g2_manu.pdf', 105),
('F11', 'P9', NULL, 'Proposal', '/uploads/g3_p9.pdf', 109);

SET SQL_SAFE_UPDATES = 1;
