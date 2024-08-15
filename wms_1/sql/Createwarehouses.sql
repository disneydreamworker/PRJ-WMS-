DROP TABLE LOCATION_ID;
CREATE TABLE location_id (
	location_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    city VARCHAR(50) NOT NULL,
    PRIMARY KEY(location_id)
);

INSERT INTO location_id (city) VALUES ('서울');
INSERT INTO location_id (city) VALUES ('부산');
INSERT INTO location_id (city) VALUES ('대구');
INSERT INTO location_id (city) VALUES ('인천');
INSERT INTO location_id (city) VALUES ('광주');
INSERT INTO location_id (city) VALUES ('대전');
INSERT INTO location_id (city) VALUES ('울산');
INSERT INTO location_id (city) VALUES ('경기');
INSERT INTO location_id (city) VALUES ('강원');
INSERT INTO location_id (city) VALUES ('충북');
INSERT INTO location_id (city) VALUES ('충남');
INSERT INTO location_id (city) VALUES ('전북');
INSERT INTO location_id (city) VALUES ('전남');
INSERT INTO location_id (city) VALUES ('경북');
INSERT INTO location_id (city) VALUES ('경남');
INSERT INTO location_id (city) VALUES ('제주');
INSERT INTO location_id (city) VALUES ('세종');

select * from location_id;


DROP TABLE warehouse;
CREATE TABLE warehouse (
    w_id SMALLINT UNSIGNED NOT NULL auto_increment,     -- 창고아이디 (Primary Key)
    w_name VARCHAR(50) NOT NULL,                        -- 창고명
    location VARCHAR(255) NOT NULL,                     -- 소재지
    location_id TINYINT UNSIGNED NOT NULL,              -- 주소코드 (Foreign Key)
    total_area_sqm FLOAT NOT NULL,              -- 창고총면적
    general_w_sqm FLOAT DEFAULT NULL,           -- 일반창고면적
    cold_w_sqm FLOAT DEFAULT NULL,              -- 냉동냉장창고면적
    storage_w_sqm FLOAT DEFAULT NULL,           -- 보관장소면적
    port_w_sqm FLOAT DEFAULT NULL,              -- 항만창고면적
    bonded_w_sqm FLOAT DEFAULT NULL,            -- 관세법>보세창고면적
    chemical_w_sqm FLOAT DEFAULT NULL,          -- 화학물질관리법>보관저장업면적
    food_cold_w_sqm FLOAT DEFAULT NULL,         -- 식품위생법>냉동냉장면적
    livestock_w_sqm FLOAT DEFAULT NULL,         -- 축산물위생법>축산물보관면적
    marine_cold_w_sqm FLOAT DEFAULT NULL,       -- 수산식품산업법>냉동냉장면적
    related_law ENUM('관세법', '물류시설법', '물류시설법(항만)', '수산식품산업법', '식품위생법', '축산물위생법', '화학물질관리법') NOT NULL DEFAULT '물류시설법', -- 관련법률
    handled_items VARCHAR(100) DEFAULT NULL,                -- 취급품목
    manager VARCHAR(10) NOT NULL,                      		-- 대표자 (Foreign Key)
    regi_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- 등록일
    employees_number SMALLINT NOT NULL DEFAULT 0,       -- 종업원수
    facility_equipment VARCHAR(100) NULL,       -- 시설장비현황
    contact_number VARCHAR(11) NULL,            -- 연락처
    PRIMARY KEY (w_id)
);

-- 회원의 창고관리자 아이디로 manager fk로 바꿀것

-- location_id 를 fk로 받기
alter table warehouse add constraint fk_location_id foreign key(location_id) references location_id(location_id);


drop table sub_warehouse;
create table sub_warehouse (
	sw_id smallint unsigned not null auto_increment,
    sw_type enum('물류시설법 일반창고', '물류시설법 냉동냉장',  '물류시설법 보관장소', '항만창고', '관세법 보세창고','화학물질관리법 보관저장업', '식품위생법 냉동냉장', '축산물위생법 축산물보관', '수산식품산업법 냉동냉장') not null default '물류시설법 일반창고',
    sw_area_sqm FLOAT default null,
    sw_w_sqm FLOAT default null,
    sw_height FLOAT default null,
    w_id smallint unsigned not null,
    primary key(sw_id)
);
alter table sub_warehouse add constraint fk_w_id foreign key(w_id) references warehouse(w_id);



drop table ss_warehouse;
create table ss_warehouse(
	ssw_id int unsigned not null auto_increment,
    rent_fee_6m FLOAT default null,
    rent_fee_12m FLOAT default null,
    sw_id smallint unsigned not null,
    primary key(ssw_id)
);
alter table ss_warehouse add constraint fk_sw_id foreign key(sw_id) references sub_warehouse(sw_id);
