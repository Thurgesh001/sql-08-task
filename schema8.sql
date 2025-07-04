use librarydb;

DELIMITER //

CREATE PROCEDURE GetAllMembers()
BEGIN
    SELECT * FROM Members;
END //

DELIMITER ;


-- Call it:
CALL GetAllMembers();


DELIMITER //

CREATE PROCEDURE GetMemberBorrowInfo(IN mem_id INT)
BEGIN
    -- Check if the member has any borrow records
    IF EXISTS (
        SELECT 1 FROM Borrow_Records WHERE MemberID = mem_id
    ) THEN
        -- If yes, show the details
        SELECT 
            b.BorrowID, m.Name, b.BookID, b.BorrowDate, b.ReturnDate
        FROM 
            Borrow_Records b
        JOIN 
            Members m ON b.MemberID = m.MemberID
        WHERE 
            b.MemberID = mem_id;
    ELSE
        -- If not, show a message
        SELECT CONCAT('No borrow records found for Member ID: ', mem_id) AS Message;
    END IF;
END //

DELIMITER ;