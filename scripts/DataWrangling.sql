select * From INFORMATION_SCHEMA.COLUMNS Where column_name = 'psr';


alter table PASS ADD CONSTRAINT fk_PASS_trg FOREIGN KEY (trg) REFERENCES PLAYER(player); 
alter table PASS ADD CONSTRAINT fk_PASS_dfb FOREIGN KEY (dfb) REFERENCES PLAYER(player); 



alter table PASS_FULL modify trg varchar(7) CHARACTER SET utf8 NOT NULL;
alter table PASS_FULL modify dfb varchar(7) CHARACTER SET utf8 NOT NULL;
