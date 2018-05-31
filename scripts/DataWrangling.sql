-- creating foreign keys, which helps joins to run fast

alter table PBP ADD CONSTRAINT fk_pid FOREIGN KEY (pid) REFERENCES PLAYER(player); 
alter table PBP ADD CONSTRAINT fk_gid FOREIGN KEY (gid) REFERENCES GAME(gid); 
alter table PRO_BOWL ADD CONSTRAINT fk_PLAYER_ID FOREIGN KEY (PLAYER_ID) REFERENCES PLAYER(player); 

