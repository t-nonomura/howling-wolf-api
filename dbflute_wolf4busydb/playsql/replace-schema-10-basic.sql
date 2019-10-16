

/* Create Tables */

CREATE TABLE ABILITY
(
	CHARA_ID INT UNSIGNED NOT NULL COMMENT 'キャラクターID',
	VILLAGE_DAY_ID INT UNSIGNED NOT NULL COMMENT '村日付ID',
	TARGET_CHARA_ID INT UNSIGNED COMMENT '行使対象キャラID',
	ABILITY_TYPE_CODE VARCHAR(20) NOT NULL COMMENT '能力種別コード',
	REGISTER_DATETIME DATETIME NOT NULL COMMENT '登録日時',
	REGISTER_TRACE VARCHAR(64) NOT NULL COMMENT '登録トレース',
	UPDATE_DATETIME DATETIME NOT NULL COMMENT '更新日時',
	UPDATE_TRACE VARCHAR(64) NOT NULL COMMENT '更新トレース',
	PRIMARY KEY (CHARA_ID, VILLAGE_DAY_ID, ABILITY_TYPE_CODE)
) COMMENT = '能力行使';


CREATE TABLE ABILITY_TYPE
(
	ABILITY_TYPE_CODE VARCHAR(20) NOT NULL COMMENT '能力種別コード',
	ABILITY_TYPE_NAME VARCHAR(20) NOT NULL COMMENT '能力種別',
	PRIMARY KEY (ABILITY_TYPE_CODE)
) COMMENT = '能力種別';


CREATE TABLE AUTHORITY
(
	AUTHORITY_CODE VARCHAR(20) NOT NULL COMMENT '権限コード',
	AUTHORITY_NAME VARCHAR(20) NOT NULL COMMENT '権限名',
	PRIMARY KEY (AUTHORITY_CODE)
) COMMENT = '権限';


CREATE TABLE CAMP
(
	CAMP_CODE VARCHAR(20) NOT NULL COMMENT '陣営コード',
	CAMP_NAME VARCHAR(20) NOT NULL COMMENT '陣営名',
	PRIMARY KEY (CAMP_CODE)
) COMMENT = '陣営';


CREATE TABLE CHARA
(
	CHARA_ID INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'キャラクターID',
	CHARA_NAME VARCHAR(40) NOT NULL COMMENT 'キャラクター名',
	CHARA_SHORT_NAME CHAR(1) NOT NULL COMMENT 'キャラクター略称',
	CHARA_GROUP_ID INT UNSIGNED NOT NULL COMMENT 'キャラクターグループID',
	DEFAULT_JOIN_MESSAGE VARCHAR(200) COMMENT '入村時デフォルト発言',
	DEFAULT_FIRSTDAY_MESSAGE VARCHAR(200) COMMENT 'デフォルト1日目発言',
	DISPLAY_WIDTH INT UNSIGNED NOT NULL COMMENT '表示時横幅',
	DISPLAY_HEIGHT INT UNSIGNED NOT NULL COMMENT '表示時縦幅',
	REGISTER_DATETIME DATETIME NOT NULL COMMENT '登録日時',
	REGISTER_TRACE VARCHAR(64) NOT NULL COMMENT '登録トレース',
	UPDATE_DATETIME DATETIME NOT NULL COMMENT '更新日時',
	UPDATE_TRACE VARCHAR(64) NOT NULL COMMENT '更新トレース',
	PRIMARY KEY (CHARA_ID)
) COMMENT = 'キャラクター';


CREATE TABLE CHARA_GROUP
(
	CHARA_GROUP_ID INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'キャラクターグループID',
	CHARA_GROUP_NAME VARCHAR(40) NOT NULL COMMENT 'キャラクターグループ名',
	DESIGNER_ID INT UNSIGNED NOT NULL COMMENT 'デザイナーID',
	DESCRIPTION_URL TEXT COMMENT 'キャラチップURL : キャラチップの利用規約や配布サイトのURL',
	REGISTER_DATETIME DATETIME NOT NULL COMMENT '登録日時',
	REGISTER_TRACE VARCHAR(64) NOT NULL COMMENT '登録トレース',
	UPDATE_DATETIME DATETIME NOT NULL COMMENT '更新日時',
	UPDATE_TRACE VARCHAR(64) NOT NULL COMMENT '更新トレース',
	PRIMARY KEY (CHARA_GROUP_ID)
) COMMENT = 'キャラクターグループ';


CREATE TABLE CHARA_IMAGE
(
	CHARA_ID INT UNSIGNED NOT NULL COMMENT 'キャラクターID',
	FACE_TYPE_CODE VARCHAR(20) NOT NULL COMMENT '表情種別コード',
	CHARA_IMG_URL VARCHAR(100) NOT NULL COMMENT 'キャラクター画像URL',
	PRIMARY KEY (CHARA_ID, FACE_TYPE_CODE)
) COMMENT = 'キャラクター画像';


CREATE TABLE COMMIT
(
	VILLAGE_PLAYER_ID INT UNSIGNED NOT NULL COMMENT '村参加者ID',
	VILLAGE_DAY_ID INT UNSIGNED NOT NULL COMMENT '村日付ID',
	REGISTER_DATETIME DATETIME NOT NULL COMMENT '登録日時',
	REGISTER_TRACE VARCHAR(64) NOT NULL COMMENT '登録トレース',
	UPDATE_DATETIME DATETIME NOT NULL COMMENT '更新日時',
	UPDATE_TRACE VARCHAR(64) NOT NULL COMMENT '更新トレース',
	PRIMARY KEY (VILLAGE_PLAYER_ID, VILLAGE_DAY_ID)
) COMMENT = 'コミット';


CREATE TABLE DEAD_REASON
(
	DEAD_REASON_CODE VARCHAR(20) NOT NULL COMMENT '死亡理由コード',
	DEAD_REASON_NAME VARCHAR(20) NOT NULL COMMENT '死亡理由',
	PRIMARY KEY (DEAD_REASON_CODE)
) COMMENT = '死亡理由';


CREATE TABLE DESIGNER
(
	DESIGNER_ID INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'デザイナーID',
	DESIGNER_NAME VARCHAR(40) NOT NULL COMMENT 'デザイナー名',
	REGISTER_DATETIME DATETIME NOT NULL COMMENT '登録日時',
	REGISTER_TRACE VARCHAR(64) NOT NULL COMMENT '登録トレース',
	UPDATE_DATETIME DATETIME NOT NULL COMMENT '更新日時',
	UPDATE_TRACE VARCHAR(64) NOT NULL COMMENT '更新トレース',
	PRIMARY KEY (DESIGNER_ID)
) COMMENT = 'デザイナー';


CREATE TABLE FACE_TYPE
(
	FACE_TYPE_CODE VARCHAR(20) NOT NULL COMMENT '表情種別コード',
	FACE_TYPE_NAME VARCHAR(20) NOT NULL COMMENT '表情種別名',
	DISP_ORDER INT UNSIGNED NOT NULL COMMENT '並び順',
	PRIMARY KEY (FACE_TYPE_CODE)
) COMMENT = '表情種別';


CREATE TABLE MESSAGE
(
	VILLAGE_ID INT UNSIGNED NOT NULL COMMENT '村ID',
	MESSAGE_NUMBER INT UNSIGNED NOT NULL COMMENT 'メッセージ番号',
	MESSAGE_TYPE_CODE VARCHAR(20) NOT NULL COMMENT 'メッセージ種別コード',
	MESSAGE_UNIXTIMESTAMP_MILLI BIGINT UNSIGNED NOT NULL COMMENT 'メッセージUNIXタイムスタンプミリ秒',
	VILLAGE_DAY_ID INT UNSIGNED NOT NULL COMMENT '村日付ID',
	VILLAGE_PLAYER_ID INT UNSIGNED COMMENT '村参加者ID',
	TO_VILLAGE_PLAYER_ID INT UNSIGNED COMMENT '秘話相手の村参加者ID',
	PLAYER_ID INT UNSIGNED COMMENT 'プレイヤーID',
	MESSAGE_CONTENT VARCHAR(10000) NOT NULL COMMENT 'メッセージ内容',
	MESSAGE_DATETIME DATETIME NOT NULL COMMENT 'メッセージ日時',
	IS_CONVERT_DISABLE BOOLEAN NOT NULL COMMENT '変換無効か',
	FACE_TYPE_CODE VARCHAR(20) COMMENT '表情種別コード',
	REGISTER_DATETIME DATETIME NOT NULL COMMENT '登録日時',
	REGISTER_TRACE VARCHAR(64) NOT NULL COMMENT '登録トレース',
	UPDATE_DATETIME DATETIME NOT NULL COMMENT '更新日時',
	UPDATE_TRACE VARCHAR(64) NOT NULL COMMENT '更新トレース',
	PRIMARY KEY (VILLAGE_ID, MESSAGE_NUMBER, MESSAGE_TYPE_CODE)
) COMMENT = 'メッセージ';


CREATE TABLE MESSAGE_RESTRICTION
(
	VILLAGE_ID INT UNSIGNED NOT NULL COMMENT '村ID',
	SKILL_CODE VARCHAR(20) NOT NULL COMMENT '役職コード',
	MESSAGE_TYPE_CODE VARCHAR(20) NOT NULL COMMENT 'メッセージ種別コード',
	MESSAGE_MAX_NUM INT UNSIGNED NOT NULL COMMENT '最大発言回数',
	MESSAGE_MAX_LENGTH INT UNSIGNED NOT NULL COMMENT '最大文字数',
	REGISTER_DATETIME DATETIME NOT NULL COMMENT '登録日時',
	REGISTER_TRACE VARCHAR(64) NOT NULL COMMENT '登録トレース',
	UPDATE_DATETIME DATETIME NOT NULL COMMENT '更新日時',
	UPDATE_TRACE VARCHAR(64) NOT NULL COMMENT '更新トレース',
	PRIMARY KEY (VILLAGE_ID, SKILL_CODE, MESSAGE_TYPE_CODE)
) COMMENT = '発言制限 : レコードなしの場合は無制限';


CREATE TABLE MESSAGE_TYPE
(
	MESSAGE_TYPE_CODE VARCHAR(20) NOT NULL COMMENT 'メッセージ種別コード',
	MESSAGE_TYPE_NAME VARCHAR(20) NOT NULL COMMENT 'メッセージ種別名',
	PRIMARY KEY (MESSAGE_TYPE_CODE)
) COMMENT = 'メッセージ種別';


CREATE TABLE NOONNIGHT
(
	NOONNIGHT_CODE VARCHAR(20) NOT NULL COMMENT '昼夜コード',
	NOONNIGHT_NAME VARCHAR(20) NOT NULL COMMENT '昼夜名',
	DISP_ORDER INT UNSIGNED NOT NULL COMMENT '並び順',
	PRIMARY KEY (NOONNIGHT_CODE)
) COMMENT = '昼夜';


CREATE TABLE PLAYER
(
	PLAYER_ID INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'プレイヤーID',
	UID VARCHAR(100) NOT NULL UNIQUE COMMENT 'ユーザID',
	NICKNAME VARCHAR(50) NOT NULL COMMENT 'ニックネーム',
	TWITTER_USER_NAME VARCHAR(15) NOT NULL COMMENT 'twitterのusername',
	AUTHORITY_CODE VARCHAR(20) NOT NULL COMMENT '権限コード',
	IS_RESTRICTED_PARTICIPATION BOOLEAN NOT NULL COMMENT '入村制限されているか',
	REGISTER_DATETIME DATETIME NOT NULL COMMENT '登録日時',
	REGISTER_TRACE VARCHAR(64) NOT NULL COMMENT '登録トレース',
	UPDATE_DATETIME DATETIME NOT NULL COMMENT '更新日時',
	UPDATE_TRACE VARCHAR(64) NOT NULL COMMENT '更新トレース',
	PRIMARY KEY (PLAYER_ID)
) COMMENT = 'プレイヤー';


CREATE TABLE RANDOM_CONTENT
(
	RANDOM_CONTENT_ID INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ランダム変換内容ID',
	RANDOM_KEYWORD_ID INT UNSIGNED NOT NULL COMMENT 'ランダムキーワードID',
	RANDOM_MESSAGE VARCHAR(20) NOT NULL COMMENT 'ランダム変換内容文字列',
	PRIMARY KEY (RANDOM_CONTENT_ID)
) COMMENT = 'ランダム変換内容';


CREATE TABLE RANDOM_KEYWORD
(
	RANDOM_KEYWORD_ID INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ランダムキーワードID',
	KEYWORD VARCHAR(10) NOT NULL UNIQUE COMMENT 'キーワード',
	PRIMARY KEY (RANDOM_KEYWORD_ID)
) COMMENT = 'ランダムキーワード';


CREATE TABLE SKILL
(
	SKILL_CODE VARCHAR(20) NOT NULL COMMENT '役職コード',
	SKILL_NAME VARCHAR(20) NOT NULL COMMENT '役職名',
	 CAMP_CODE VARCHAR(20) NOT NULL COMMENT '陣営コード',
	DISP_ORDER INT UNSIGNED NOT NULL COMMENT '並び順',
	PRIMARY KEY (SKILL_CODE)
) COMMENT = '役職';


CREATE TABLE VILLAGE
(
	VILLAGE_ID INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '村ID',
	VILLAGE_DISPLAY_NAME VARCHAR(40) NOT NULL COMMENT '村表示名',
	CREATE_PLAYER_NAME VARCHAR(12) NOT NULL COMMENT '村作成プレイヤー名',
	VILLAGE_STATUS_CODE VARCHAR(20) NOT NULL COMMENT '村ステータスコード',
	EPILOGUE_DAY INT UNSIGNED COMMENT 'エピローグ日',
	WIN_CAMP_CODE VARCHAR(20) COMMENT '勝利陣営コード',
	REGISTER_DATETIME DATETIME NOT NULL COMMENT '登録日時',
	REGISTER_TRACE VARCHAR(64) NOT NULL COMMENT '登録トレース',
	UPDATE_DATETIME DATETIME NOT NULL COMMENT '更新日時',
	UPDATE_TRACE VARCHAR(64) NOT NULL COMMENT '更新トレース',
	PRIMARY KEY (VILLAGE_ID)
) COMMENT = '村';


CREATE TABLE VILLAGE_DAY
(
	VILLAGE_DAY_ID INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '村日付ID',
	VILLAGE_ID INT UNSIGNED NOT NULL COMMENT '村ID',
	DAY INT UNSIGNED NOT NULL COMMENT '何日目か',
	NOONNIGHT_CODE VARCHAR(20) NOT NULL COMMENT '昼夜コード',
	DAYCHANGE_DATETIME DATETIME NOT NULL COMMENT '日付更新日時',
	IS_UPDATING BOOLEAN NOT NULL COMMENT '更新中か',
	REGISTER_DATETIME DATETIME NOT NULL COMMENT '登録日時',
	REGISTER_TRACE VARCHAR(64) NOT NULL COMMENT '登録トレース',
	UPDATE_DATETIME DATETIME NOT NULL COMMENT '更新日時',
	UPDATE_TRACE VARCHAR(64) NOT NULL COMMENT '更新トレース',
	PRIMARY KEY (VILLAGE_DAY_ID)
) COMMENT = '村日付';


CREATE TABLE VILLAGE_PLAYER
(
	VILLAGE_PLAYER_ID INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '村参加者ID',
	VILLAGE_ID INT UNSIGNED NOT NULL COMMENT '村ID',
	PLAYER_ID INT UNSIGNED NOT NULL COMMENT 'プレイヤーID',
	CHARA_ID INT UNSIGNED NOT NULL COMMENT 'キャラクターID',
	SKILL_CODE VARCHAR(20) COMMENT '役職コード',
	REQUEST_SKILL_CODE VARCHAR(20) COMMENT '希望役職コード',
	SECOND_REQUEST_SKILL_CODE VARCHAR(20) COMMENT '第二希望役職コード',
	IS_DEAD BOOLEAN NOT NULL COMMENT '死亡しているか',
	IS_SPECTATOR BOOLEAN NOT NULL COMMENT '見学者か',
	DEAD_REASON_CODE VARCHAR(20) COMMENT '死亡理由コード',
	DEAD_DAY INT UNSIGNED COMMENT '何日目に死亡したか',
	IS_GONE BOOLEAN NOT NULL COMMENT '退村済みか',
	REGISTER_DATETIME DATETIME NOT NULL COMMENT '登録日時',
	REGISTER_TRACE VARCHAR(64) NOT NULL COMMENT '登録トレース',
	UPDATE_DATETIME DATETIME NOT NULL COMMENT '更新日時',
	UPDATE_TRACE VARCHAR(64) NOT NULL COMMENT '更新トレース',
	PRIMARY KEY (VILLAGE_PLAYER_ID)
) COMMENT = '村参加者';


CREATE TABLE VILLAGE_SETTING
(
	VILLAGE_ID INT UNSIGNED NOT NULL COMMENT '村ID',
	VILLAGE_SETTING_ITEM_CODE VARCHAR(100) NOT NULL COMMENT '村設定項目コード',
	VILLAGE_SETTING_TEXT VARCHAR(1000) COMMENT '村設定項目内容',
	REGISTER_DATETIME DATETIME NOT NULL COMMENT '登録日時',
	REGISTER_TRACE VARCHAR(64) NOT NULL COMMENT '登録トレース',
	UPDATE_DATETIME DATETIME NOT NULL COMMENT '更新日時',
	UPDATE_TRACE VARCHAR(64) NOT NULL COMMENT '更新トレース',
	PRIMARY KEY (VILLAGE_ID, VILLAGE_SETTING_ITEM_CODE)
) COMMENT = '村設定';


CREATE TABLE VILLAGE_SETTING_ITEM
(
	VILLAGE_SETTING_ITEM_CODE VARCHAR(100) NOT NULL COMMENT '村設定項目コード',
	VILLAGE_SETTING_ITEM_NAME VARCHAR(20) NOT NULL COMMENT '村設定項目名',
	DISP_ORDER INT UNSIGNED NOT NULL COMMENT '並び順',
	PRIMARY KEY (VILLAGE_SETTING_ITEM_CODE)
) COMMENT = '村設定項目';


CREATE TABLE VILLAGE_STATUS
(
	VILLAGE_STATUS_CODE VARCHAR(20) NOT NULL COMMENT '村ステータスコード',
	VILLAGE_STATUS_NAME VARCHAR(20) NOT NULL COMMENT '村ステータス名',
	PRIMARY KEY (VILLAGE_STATUS_CODE)
) COMMENT = '村ステータス';


CREATE TABLE VOTE
(
	CHARA_ID INT UNSIGNED NOT NULL COMMENT 'キャラクターID',
	VILLAGE_DAY_ID INT UNSIGNED NOT NULL COMMENT '村日付ID',
	VOTE_CHARA_ID INT UNSIGNED NOT NULL COMMENT '投票先キャラクターID',
	REGISTER_DATETIME DATETIME NOT NULL COMMENT '登録日時',
	REGISTER_TRACE VARCHAR(64) NOT NULL COMMENT '登録トレース',
	UPDATE_DATETIME DATETIME NOT NULL COMMENT '更新日時',
	UPDATE_TRACE VARCHAR(64) NOT NULL COMMENT '更新トレース',
	PRIMARY KEY (CHARA_ID, VILLAGE_DAY_ID)
) COMMENT = '投票';



/* Create Indexes */

CREATE INDEX IX_MESSAGE_UNIXTIMESTAMP USING BTREE ON MESSAGE (MESSAGE_UNIXTIMESTAMP_MILLI DESC);



/* Create Foreign Keys */

ALTER TABLE ABILITY
	ADD CONSTRAINT FK_ABILITY_ABILITY_TYPE FOREIGN KEY (ABILITY_TYPE_CODE)
	REFERENCES ABILITY_TYPE (ABILITY_TYPE_CODE)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE PLAYER
	ADD CONSTRAINT FK_PLAYER_AUTHORITY FOREIGN KEY (AUTHORITY_CODE)
	REFERENCES AUTHORITY (AUTHORITY_CODE)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE SKILL
	ADD CONSTRAINT FK_SKILL_CAMP FOREIGN KEY ( CAMP_CODE)
	REFERENCES CAMP (CAMP_CODE)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE VILLAGE
	ADD CONSTRAINT FK_VILLAGE_CAMP FOREIGN KEY (WIN_CAMP_CODE)
	REFERENCES CAMP (CAMP_CODE)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE ABILITY
	ADD CONSTRAINT FK_ABILITY_CHARA FOREIGN KEY (CHARA_ID)
	REFERENCES CHARA (CHARA_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE ABILITY
	ADD CONSTRAINT FK_ABILITY_CHARA_TARGET FOREIGN KEY (TARGET_CHARA_ID)
	REFERENCES CHARA (CHARA_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE CHARA_IMAGE
	ADD CONSTRAINT FK_CHARA_IMAGE_CHARA FOREIGN KEY (CHARA_ID)
	REFERENCES CHARA (CHARA_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE VILLAGE_PLAYER
	ADD CONSTRAINT FK_VILLAGE_PLAYER_CHARA FOREIGN KEY (CHARA_ID)
	REFERENCES CHARA (CHARA_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE VOTE
	ADD CONSTRAINT FK_VOTE_CHARA FOREIGN KEY (CHARA_ID)
	REFERENCES CHARA (CHARA_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE VOTE
	ADD CONSTRAINT FK_VOTE_CHARA_TO FOREIGN KEY (VOTE_CHARA_ID)
	REFERENCES CHARA (CHARA_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE CHARA
	ADD CONSTRAINT FK_CHARA_CHARA_GROUP FOREIGN KEY (CHARA_GROUP_ID)
	REFERENCES CHARA_GROUP (CHARA_GROUP_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE VILLAGE_PLAYER
	ADD CONSTRAINT FK_VILLAGE_PLAYER_DEAD_REASON FOREIGN KEY (DEAD_REASON_CODE)
	REFERENCES DEAD_REASON (DEAD_REASON_CODE)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE CHARA_GROUP
	ADD CONSTRAINT FK_CHARA_GROUP_DESIGNER FOREIGN KEY (DESIGNER_ID)
	REFERENCES DESIGNER (DESIGNER_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE CHARA_IMAGE
	ADD CONSTRAINT FK_CHARA_IMAGE_FACE_TYPE FOREIGN KEY (FACE_TYPE_CODE)
	REFERENCES FACE_TYPE (FACE_TYPE_CODE)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE MESSAGE
	ADD CONSTRAINT FK_MESSAGE_FACE_TYPE FOREIGN KEY (FACE_TYPE_CODE)
	REFERENCES FACE_TYPE (FACE_TYPE_CODE)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE MESSAGE
	ADD CONSTRAINT FK_MESSAGE_MESSAGE_TYPE FOREIGN KEY (MESSAGE_TYPE_CODE)
	REFERENCES MESSAGE_TYPE (MESSAGE_TYPE_CODE)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE MESSAGE_RESTRICTION
	ADD CONSTRAINT FK_MESSAGE_RESTRICTION_MESSAGE_TYPE FOREIGN KEY (MESSAGE_TYPE_CODE)
	REFERENCES MESSAGE_TYPE (MESSAGE_TYPE_CODE)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE VILLAGE_DAY
	ADD CONSTRAINT FK_VILLAGE_DAY_NOONNIGHT FOREIGN KEY (NOONNIGHT_CODE)
	REFERENCES NOONNIGHT (NOONNIGHT_CODE)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE MESSAGE
	ADD CONSTRAINT FK_MESSAGE_PLAYER FOREIGN KEY (PLAYER_ID)
	REFERENCES PLAYER (PLAYER_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE VILLAGE_PLAYER
	ADD CONSTRAINT FK_VILLAGE_PLAYER_PLAYER FOREIGN KEY (PLAYER_ID)
	REFERENCES PLAYER (PLAYER_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE RANDOM_CONTENT
	ADD CONSTRAINT FK_RANDOM_CONTENT_RANDOM_KEYWORD FOREIGN KEY (RANDOM_KEYWORD_ID)
	REFERENCES RANDOM_KEYWORD (RANDOM_KEYWORD_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE MESSAGE_RESTRICTION
	ADD CONSTRAINT FK_MESSAGE_RESTRICTION_SKILL FOREIGN KEY (SKILL_CODE)
	REFERENCES SKILL (SKILL_CODE)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE VILLAGE_PLAYER
	ADD CONSTRAINT FK_VILLAGE_PLAYER_SKILL FOREIGN KEY (SKILL_CODE)
	REFERENCES SKILL (SKILL_CODE)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE VILLAGE_PLAYER
	ADD CONSTRAINT FK_VILLAGE_PLAYER_SKILL_REQUEST FOREIGN KEY (REQUEST_SKILL_CODE)
	REFERENCES SKILL (SKILL_CODE)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE VILLAGE_PLAYER
	ADD CONSTRAINT FK_VILLAGE_PLAYER_SECOND_SKILL_REQ FOREIGN KEY (SECOND_REQUEST_SKILL_CODE)
	REFERENCES SKILL (SKILL_CODE)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE MESSAGE
	ADD CONSTRAINT FK_MESSAGE_VILLAGE FOREIGN KEY (VILLAGE_ID)
	REFERENCES VILLAGE (VILLAGE_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE MESSAGE_RESTRICTION
	ADD CONSTRAINT FK_MESSAGE_RESTRICTION_VILLAGE FOREIGN KEY (VILLAGE_ID)
	REFERENCES VILLAGE (VILLAGE_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE VILLAGE_DAY
	ADD CONSTRAINT FK_VILLAGE_DAY_VILLAGE FOREIGN KEY (VILLAGE_ID)
	REFERENCES VILLAGE (VILLAGE_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE VILLAGE_PLAYER
	ADD CONSTRAINT FK_VILLAGE_PLAYER_VILLAGE FOREIGN KEY (VILLAGE_ID)
	REFERENCES VILLAGE (VILLAGE_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE VILLAGE_SETTING
	ADD CONSTRAINT FK_VILLAGE_SETTINGS_VILLAGE FOREIGN KEY (VILLAGE_ID)
	REFERENCES VILLAGE (VILLAGE_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE ABILITY
	ADD CONSTRAINT FK_ABILITY_VILLAGE_DAY FOREIGN KEY (VILLAGE_DAY_ID)
	REFERENCES VILLAGE_DAY (VILLAGE_DAY_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE COMMIT
	ADD CONSTRAINT FK_COMMIT_VILLAGE_DAY FOREIGN KEY (VILLAGE_DAY_ID)
	REFERENCES VILLAGE_DAY (VILLAGE_DAY_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE MESSAGE
	ADD CONSTRAINT FK_MESSAGE_VILLAGE_DAY FOREIGN KEY (VILLAGE_DAY_ID)
	REFERENCES VILLAGE_DAY (VILLAGE_DAY_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE VOTE
	ADD CONSTRAINT FK_VOTE_VILLAGE_DAY FOREIGN KEY (VILLAGE_DAY_ID)
	REFERENCES VILLAGE_DAY (VILLAGE_DAY_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE COMMIT
	ADD CONSTRAINT FK_COMMIT_VILLAGE_PLAYER FOREIGN KEY (VILLAGE_PLAYER_ID)
	REFERENCES VILLAGE_PLAYER (VILLAGE_PLAYER_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE MESSAGE
	ADD CONSTRAINT FK_MESSAGE_VILLAGE_PLAYER FOREIGN KEY (VILLAGE_PLAYER_ID)
	REFERENCES VILLAGE_PLAYER (VILLAGE_PLAYER_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE MESSAGE
	ADD CONSTRAINT FK_MESSAGE_VILLAGE_PLAYER_TO FOREIGN KEY (TO_VILLAGE_PLAYER_ID)
	REFERENCES VILLAGE_PLAYER (VILLAGE_PLAYER_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE VILLAGE_SETTING
	ADD CONSTRAINT FK_VILLAGE_SETTING_VILLAGE_SETTING_ITEM FOREIGN KEY (VILLAGE_SETTING_ITEM_CODE)
	REFERENCES VILLAGE_SETTING_ITEM (VILLAGE_SETTING_ITEM_CODE)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE VILLAGE
	ADD CONSTRAINT FK_VILLAGE_VILLAGE_STATUS FOREIGN KEY (VILLAGE_STATUS_CODE)
	REFERENCES VILLAGE_STATUS (VILLAGE_STATUS_CODE)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



