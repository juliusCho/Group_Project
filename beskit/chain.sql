
/* Drop Tables */

DROP TABLE t_art_like_list CASCADE CONSTRAINTS;
DROP TABLE t_com_like_list CASCADE CONSTRAINTS;
DROP TABLE t_comment CASCADE CONSTRAINTS;
DROP TABLE t_article CASCADE CONSTRAINTS;
DROP TABLE t_chat CASCADE CONSTRAINTS;
DROP TABLE t_chat_list CASCADE CONSTRAINTS;
DROP TABLE t_friend CASCADE CONSTRAINTS;
DROP TABLE t_waiting_friend CASCADE CONSTRAINTS;
DROP TABLE t_member CASCADE CONSTRAINTS;



/* Drop Sequences */

DROP SEQUENCE seq_article;
DROP SEQUENCE seq_chat;
DROP SEQUENCE seq_cha_list;
DROP SEQUENCE seq_comment;
DROP SEQUENCE seq_friend;
DROP SEQUENCE seq_member;




/* Create Sequences */

CREATE SEQUENCE seq_article;
CREATE SEQUENCE seq_chat;
CREATE SEQUENCE seq_cha_list;
CREATE SEQUENCE seq_comment;
CREATE SEQUENCE seq_friend;
CREATE SEQUENCE seq_member;



/* Create Tables */

CREATE TABLE t_article
(
	art_no number NOT NULL,
	art_content varchar2(4000) NOT NULL,
	art_like number(5) DEFAULT 0 NOT NULL,
	art_regdate date DEFAULT sysdate NOT NULL,
	art_com_cnt number(4) DEFAULT 0 NOT NULL,
	art_pic varchar2(1000),
	mem_no number NOT NULL,
	mem_nick varchar2(20) NOT NULL,
	PRIMARY KEY (art_no)
);


CREATE TABLE t_art_like_list
(
	mem_no number NOT NULL,
	art_no number NOT NULL
);


CREATE TABLE t_chat
(
	cha_no number NOT NULL,
	cha_content varchar2(4000) NOT NULL,
	cha_regdate date DEFAULT sysdate NOT NULL,
	cha_confirm number(1) DEFAULT 0 NOT NULL,
	cha_list_no number NOT NULL,
	mem_no number NOT NULL,
	PRIMARY KEY (cha_no)
);


CREATE TABLE t_chat_list
(
	cha_list_no number NOT NULL,
	mem_no number NOT NULL,
	mem_nick varchar2(20) NOT NULL,
	cha_list_regdate date,
	cha_mate_no number NOT NULL,
	mem_pic varchar2(1000)
);


CREATE TABLE t_comment
(
	com_no number NOT NULL,
	com_content varchar2(1000) NOT NULL,
	com_regdate date DEFAULT sysdate NOT NULL,
	com_like number(5) DEFAULT 0 NOT NULL,
	art_no number NOT NULL,
	mem_no number NOT NULL,
	PRIMARY KEY (com_no)
);


CREATE TABLE t_com_like_list
(
	mem_no number NOT NULL,
	art_no number NOT NULL,
	com_no number NOT NULL
);


CREATE TABLE t_friend
(
	mem_no number NOT NULL,
	fri_no number NOT NULL
);


CREATE TABLE t_member
(
	mem_no number NOT NULL,
	mem_country number(1) NOT NULL,
	mem_gender number(1) NOT NULL,
	mem_id varchar2(20) NOT NULL,
	mem_pw varchar2(128) NOT NULL,
	mem_pwquestion varchar2(200) NOT NULL,
	mem_pwanswer varchar2(100) NOT NULL,
	mem_name varchar2(30) NOT NULL,
	mem_phone varchar2(13),
	mem_email varchar2(100) NOT NULL,
	mem_nick varchar2(20) NOT NULL,
	mem_pic varchar2(1000),
	PRIMARY KEY (mem_no)
);


CREATE TABLE t_waiting_friend
(
	mem_no number NOT NULL,
	waiting_fri_no number NOT NULL
);



/* Create Foreign Keys */

ALTER TABLE t_art_like_list
	ADD FOREIGN KEY (art_no)
	REFERENCES t_article (art_no)
	on     delete cascade
;


ALTER TABLE t_comment
	ADD FOREIGN KEY (art_no)
	REFERENCES t_article (art_no)
	on     delete cascade
;


ALTER TABLE t_com_like_list
	ADD FOREIGN KEY (art_no)
	REFERENCES t_article (art_no)
	on     delete cascade
;


ALTER TABLE t_com_like_list
	ADD FOREIGN KEY (com_no)
	REFERENCES t_comment (com_no)
	on     delete cascade
;


ALTER TABLE t_article
	ADD FOREIGN KEY (mem_no)
	REFERENCES t_member (mem_no)
	on     delete cascade
;


ALTER TABLE t_art_like_list
	ADD FOREIGN KEY (mem_no)
	REFERENCES t_member (mem_no)
	on     delete cascade
;


ALTER TABLE t_chat
	ADD FOREIGN KEY (mem_no)
	REFERENCES t_member (mem_no)
	on     delete cascade
;


ALTER TABLE t_chat_list
	ADD FOREIGN KEY (mem_no)
	REFERENCES t_member (mem_no)
	on     delete cascade
;


ALTER TABLE t_comment
	ADD FOREIGN KEY (mem_no)
	REFERENCES t_member (mem_no)
	on     delete cascade
;


ALTER TABLE t_com_like_list
	ADD FOREIGN KEY (mem_no)
	REFERENCES t_member (mem_no)
	on     delete cascade
;


ALTER TABLE t_friend
	ADD FOREIGN KEY (mem_no)
	REFERENCES t_member (mem_no)
	on     delete cascade
;


ALTER TABLE t_waiting_friend
	ADD FOREIGN KEY (mem_no)
	REFERENCES t_member (mem_no)
	on     delete cascade
;


alter table t_waiting_friend
add constraint w_friend_uk unique(mem_no, waiting_fri_no);

alter table t_friend
add constraint c_friend_uk unique(mem_no, fri_no);

alter table t_chat_list
add constraint t_chat_uk unique(cha_list_no, mem_no);
