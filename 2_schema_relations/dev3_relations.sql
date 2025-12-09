-- 1. ProposalApprovals Relations
ALTER TABLE ProposalApprovals
ADD CONSTRAINT fk_approvals_proposal
FOREIGN KEY (ProposalID) REFERENCES Proposals(ProposalID) ON DELETE CASCADE;

ALTER TABLE ProposalApprovals
ADD CONSTRAINT fk_approvals_user
FOREIGN KEY (ApproverUserID) REFERENCES Users(UserID) ON DELETE RESTRICT;


-- 2. Defenses Relations
ALTER TABLE Defenses
ADD CONSTRAINT fk_defenses_enrollment
FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID) ON DELETE CASCADE;

ALTER TABLE Defenses
ADD CONSTRAINT fk_defenses_proposal
FOREIGN KEY (ProposalID) REFERENCES Proposals(ProposalID) ON DELETE CASCADE;


-- 3. DefensePanel Relations
ALTER TABLE DefensePanel
ADD CONSTRAINT fk_panel_defense
FOREIGN KEY (DefenseID) REFERENCES Defenses(DefenseID) ON DELETE CASCADE;

ALTER TABLE DefensePanel
ADD CONSTRAINT fk_panel_user
FOREIGN KEY (PanelistUserID) REFERENCES Users(UserID) ON DELETE CASCADE;


-- 4. DefenseEvaluations Relations
ALTER TABLE DefenseEvaluations
ADD CONSTRAINT fk_eval_defense
FOREIGN KEY (DefenseID) REFERENCES Defenses(DefenseID) ON DELETE CASCADE;

ALTER TABLE DefenseEvaluations
ADD CONSTRAINT fk_eval_user
FOREIGN KEY (PanelistUserID) REFERENCES Users(UserID) ON DELETE RESTRICT;


-- 5. Submissions Relations
ALTER TABLE Submissions
ADD CONSTRAINT fk_submissions_proposal
FOREIGN KEY (ProposalID) REFERENCES Proposals(ProposalID) ON DELETE SET NULL;

ALTER TABLE Submissions
ADD CONSTRAINT fk_submissions_defense
FOREIGN KEY (DefenseID) REFERENCES Defenses(DefenseID) ON DELETE SET NULL;

ALTER TABLE Submissions
ADD CONSTRAINT fk_submissions_user
FOREIGN KEY (UploadedByUserID) REFERENCES Users(UserID) ON DELETE RESTRICT;


-- 6. ResearchArchive Relations
ALTER TABLE ResearchArchive
ADD CONSTRAINT fk_archive_proposal
FOREIGN KEY (ProposalID) REFERENCES Proposals(ProposalID) ON DELETE CASCADE;