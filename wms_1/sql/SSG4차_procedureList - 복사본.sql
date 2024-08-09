
-- 재고 관리 프로시저


delimiter //

CREATE PROCEDURE `selectAdminStock`(out t_category varchar(20),out i_category varchar(20),out s_category varchar(20)
,out pname varchar(30),out WID int, out wname varchar(15),out address_city varchar(10),out quantity int)
begin 
select p.t_category, p.i_category, p.s_category, p.pname, w.WID, w.wname, w.address_city, s.quantity 
    from stock s natural join product p join warehouse w on w.WID = s.WID;
end //
delimiter ;


delimiter //

CREATE PROCEDURE `selectUserStock`(
    IN in_UID INT
)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur_pid, cur_wid INT;
    DECLARE total_receipt_quantity, total_release_quantity, stock_quantity INT;
    DECLARE cur_product CURSOR FOR
        SELECT DISTINCT PID, WID FROM receipt WHERE UID = in_UID;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
                    
    -- Create temporary table to store stock information
    CREATE TEMPORARY TABLE IF NOT EXISTS tmp_stock (
        PID INT,
        WID INT,
        quantity INT
    );
                    
    OPEN cur_product;
                    
    read_loop: LOOP
        FETCH cur_product INTO cur_pid, cur_wid;
        IF done THEN
            LEAVE read_loop;
        END IF;
                    
        -- Calculate total receipt quantity for the current product
        SELECT COALESCE(SUM(p_quantity), 0) INTO total_receipt_quantity
        FROM receipt
        WHERE UID = in_UID AND PID = cur_pid AND WID = cur_wid and approval = 1;
                    
        -- Calculate total release quantity for the current product
        SELECT COALESCE(SUM(p_quantity), 0) INTO total_release_quantity
        FROM `release`
        WHERE UID = in_UID AND PID = cur_pid AND WID = cur_wid;
                    
        -- Calculate stock quantity
        SET stock_quantity = total_receipt_quantity - total_release_quantity;
                    
        -- Insert non-zero stock quantity into temporary table
        IF stock_quantity > 0 THEN
            INSERT INTO tmp_stock (PID, WID, quantity)
            VALUES (cur_pid, cur_wid, stock_quantity);
        END IF;
    END LOOP;
                    
    CLOSE cur_product;
                    
    -- Select the stock information from the temporary table
    SELECT
        p.t_category,
        p.i_category,
        p.s_category,
        p.pname,
        s.WID,
        w.wname,
        w.address_city,
        s.quantity
    FROM
        tmp_stock s
    JOIN
        product p ON s.PID = p.PID
    JOIN
        warehouse w ON s.WID = w.WID;
                    
    -- Drop temporary table
    DROP TEMPORARY TABLE IF EXISTS tmp_stock;
END  //
delimiter ;




-- 입고 트리거 프로시저
drop trigger update_stock_quantity_trigger;

DELIMITER //
CREATE TRIGGER update_stock_quantity_trigger
AFTER UPDATE ON receipt
FOR EACH ROW
BEGIN
    IF NEW.approval = 1 AND OLD.approval != 1 THEN
        -- stock 테이블의 quantity 업데이트
        UPDATE stock
        SET quantity = quantity + NEW.p_quantity
        WHERE PID = NEW.PID;

        -- stock에 해당 PID가 없는 경우 INSERT
        INSERT INTO stock (SID, PID, quantity, WID)
        SELECT NULL, NEW.PID, NEW.p_quantity, NEW.WID
        WHERE NOT EXISTS (
            SELECT 1 FROM stock WHERE PID = NEW.PID
        );
    END IF;
END //
DELIMITER ;

-- DROP TRIGGER update_stock_quantity_trigger;
DELIMITER //

CREATE TRIGGER update_using_capacity_trigger 
AFTER UPDATE ON receipt 
FOR EACH ROW 
BEGIN 
    DECLARE product_use_capacity DECIMAL(10, 2); 
    IF NEW.approval = 1 AND OLD.approval != 1 THEN 
        SET product_use_capacity = (SELECT useCapacity FROM product WHERE PID = NEW.PID); 
        UPDATE warehouse 
        SET usingCapacity = usingCapacity + (NEW.p_quantity * product_use_capacity) 
        WHERE WID = NEW.WID; 
        IF (SELECT usingCapacity FROM warehouse WHERE WID = NEW.WID) > 
           (SELECT totalCapacity FROM warehouse WHERE WID = NEW.WID) THEN 
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Using capacity exceeds total capacity'; 
        END IF; 
    END IF; 
END; //

DELIMITER ;

DELIMITER //
CREATE TRIGGER update_reverse_using_capacity_trigger
AFTER UPDATE ON receipt
FOR EACH ROW
BEGIN
    DECLARE product_use_capacity DECIMAL(10, 2);
    IF NEW.approval = 0 AND OLD.approval != 0 THEN
        SET product_use_capacity = (SELECT useCapacity FROM product WHERE PID = NEW.PID);
        UPDATE warehouse
        SET usingCapacity = usingCapacity - (NEW.p_quantity * product_use_capacity)
        WHERE WID = NEW.WID;
        IF (SELECT usingCapacity FROM warehouse WHERE WID = NEW.WID) > (SELECT totalCapacity FROM warehouse WHERE WID = NEW.WID) THEN
            SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Using capacity exceeds total capacity';
        END IF;
    END IF;
END //
DELIMITER ;

-- 출고

delimiter //
CREATE PROCEDURE `your_stock_trigger_procedure`(IN release_id INT)
BEGIN
    DECLARE stock_quantity_diff INT;

    -- 출고 승인이 되었을 때만 실행
    IF (SELECT approval FROM ssglandersretail.release WHERE Rel_ID = release_id) = 1 THEN
        -- 변경 전과 변경 후의 출고 수량 차이 계산
        SET stock_quantity_diff = (
            SELECT s.quantity - r.p_quantity
            FROM ssglandersretail.stock s
            JOIN ssglandersretail.release r ON s.PID = r.PID AND s.WID = r.WID
            WHERE r.Rel_ID = release_id
        );

        -- stock 테이블의 재고 수량 업데이트
        UPDATE ssglandersretail.stock
        SET quantity = stock_quantity_diff
        WHERE PID IN (SELECT PID FROM ssglandersretail.release WHERE Rel_ID = release_id) 
        AND WID IN (SELECT WID FROM ssglandersretail.release WHERE Rel_ID = release_id);
    END IF;
END //

delimiter ;



delimiter //
CREATE  PROCEDURE `update_usingcapacity_after_approval`(IN release_id INT)
BEGIN
    DECLARE product_capacity INT;
    DECLARE released_quantity INT;

    -- 출고 승인일 때만 실행
    IF (SELECT approval FROM `release` WHERE Rel_ID = release_id) = 1 THEN
        -- 출고 테이블에서 출고된 수량 가져오기
        SELECT p_quantity INTO released_quantity FROM `release` WHERE Rel_ID = release_id;

        -- 출고된 상품의 용량 가져오기
        SELECT usecapacity INTO product_capacity
        FROM product
        WHERE PID = (SELECT PID FROM `release` WHERE Rel_ID = release_id);

        -- Warehouse 테이블의 usingcapacity 업데이트
        UPDATE warehouse w
        SET usingcapacity = usingcapacity - (released_quantity * product_capacity)
        WHERE WID = (SELECT WID FROM `release` WHERE Rel_ID = release_id);
    END IF;
END //
delimiter ;


-- 재무 트리거

delimiter // 
CREATE TRIGGER approvalcharge AFTER UPDATE ON receipt
FOR EACH ROW
BEGIN
    IF NEW.approval = 1 AND OLD.approval = 0 THEN
        INSERT INTO finance (fdate, amount, rec_id, ftype) 
        VALUES (NEW.rec_date, NEW.p_quantity * (SELECT w.charge FROM warehouse w WHERE w.WID = NEW.WID), NEW.Rec_ID, 0);
    END IF;
END //
delimiter ;

delimiter // 
CREATE TRIGGER approvalcost AFTER UPDATE ON receipt
FOR EACH ROW
BEGIN
    IF NEW.approval = 1 AND OLD.approval = 0 THEN
        INSERT INTO finance (fdate, amount, rec_id, ftype) 
        VALUES (NEW.rec_date, NEW.p_quantity * (SELECT w.cost FROM warehouse w WHERE w.WID = NEW.WID), NEW.Rec_ID, 1);
    END IF;
END //
delimiter ;



delimiter // 
CREATE TRIGGER deletechargecost AFTER UPDATE ON receipt
FOR EACH ROW
BEGIN
    IF NEW.approval = 0 AND OLD.approval = 1 THEN
        DELETE FROM finance WHERE rec_id = OLD.Rec_ID;
    END IF;
END //
delimiter ;

