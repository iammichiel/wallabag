CREATE TABLE wallabag_craue_config_setting (name VARCHAR(255) NOT NULL, value VARCHAR(255) DEFAULT NULL, section VARCHAR(255) DEFAULT NULL, UNIQUE INDEX UNIQ_5D9649505E237E06 (name), PRIMARY KEY(name)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE `wallabag_entry` (id INT AUTO_INCREMENT NOT NULL, user_id INT DEFAULT NULL, title LONGTEXT DEFAULT NULL, url LONGTEXT DEFAULT NULL, is_archived TINYINT(1) NOT NULL, is_starred TINYINT(1) NOT NULL, content LONGTEXT DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, mimetype LONGTEXT DEFAULT NULL, language LONGTEXT DEFAULT NULL, reading_time INT DEFAULT NULL, domain_name LONGTEXT DEFAULT NULL, preview_picture LONGTEXT DEFAULT NULL, is_public TINYINT(1) DEFAULT '0', INDEX IDX_F4D18282A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE wallabag_entry_tag (entry_id INT NOT NULL, tag_id INT NOT NULL, INDEX IDX_C9F0DD7CBA364942 (entry_id), INDEX IDX_C9F0DD7CBAD26311 (tag_id), PRIMARY KEY(entry_id, tag_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE `wallabag_config` (id INT AUTO_INCREMENT NOT NULL, user_id INT DEFAULT NULL, theme VARCHAR(255) NOT NULL, items_per_page INT NOT NULL, language VARCHAR(255) NOT NULL, rss_token VARCHAR(255) DEFAULT NULL, rss_limit INT DEFAULT NULL, reading_speed DOUBLE PRECISION DEFAULT NULL, UNIQUE INDEX UNIQ_87E64C53A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE `wallabag_tagging_rule` (id INT AUTO_INCREMENT NOT NULL, config_id INT DEFAULT NULL, rule VARCHAR(255) NOT NULL, tags LONGTEXT NOT NULL COMMENT '(DC2Type:simple_array)', INDEX IDX_2D9B3C5424DB0683 (config_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE `wallabag_tag` (id INT AUTO_INCREMENT NOT NULL, `label` LONGTEXT NOT NULL, slug VARCHAR(128) NOT NULL, UNIQUE INDEX UNIQ_4CA58A8C989D9B62 (slug), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE wallabag_oauth2_clients (id INT AUTO_INCREMENT NOT NULL, random_id VARCHAR(255) NOT NULL, redirect_uris LONGTEXT NOT NULL COMMENT '(DC2Type:array)', secret VARCHAR(255) NOT NULL, allowed_grant_types LONGTEXT NOT NULL COMMENT '(DC2Type:array)', PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE wallabag_oauth2_access_tokens (id INT AUTO_INCREMENT NOT NULL, client_id INT NOT NULL, user_id INT DEFAULT NULL, token VARCHAR(255) NOT NULL, expires_at INT DEFAULT NULL, scope VARCHAR(255) DEFAULT NULL, UNIQUE INDEX UNIQ_368A42095F37A13B (token), INDEX IDX_368A420919EB6921 (client_id), INDEX IDX_368A4209A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE wallabag_oauth2_refresh_tokens (id INT AUTO_INCREMENT NOT NULL, client_id INT NOT NULL, user_id INT DEFAULT NULL, token VARCHAR(255) NOT NULL, expires_at INT DEFAULT NULL, scope VARCHAR(255) DEFAULT NULL, UNIQUE INDEX UNIQ_20C9FB245F37A13B (token), INDEX IDX_20C9FB2419EB6921 (client_id), INDEX IDX_20C9FB24A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE wallabag_oauth2_auth_codes (id INT AUTO_INCREMENT NOT NULL, client_id INT NOT NULL, user_id INT DEFAULT NULL, token VARCHAR(255) NOT NULL, redirect_uri LONGTEXT NOT NULL, expires_at INT DEFAULT NULL, scope VARCHAR(255) DEFAULT NULL, UNIQUE INDEX UNIQ_EE52E3FA5F37A13B (token), INDEX IDX_EE52E3FA19EB6921 (client_id), INDEX IDX_EE52E3FAA76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE `wallabag_user` (id INT AUTO_INCREMENT NOT NULL, username VARCHAR(180) NOT NULL, username_canonical VARCHAR(180) NOT NULL, email VARCHAR(180) NOT NULL, email_canonical VARCHAR(180) NOT NULL, enabled TINYINT(1) NOT NULL, salt VARCHAR(255) NOT NULL, password VARCHAR(255) NOT NULL, last_login DATETIME DEFAULT NULL, locked TINYINT(1) NOT NULL, expired TINYINT(1) NOT NULL, expires_at DATETIME DEFAULT NULL, confirmation_token VARCHAR(255) DEFAULT NULL, password_requested_at DATETIME DEFAULT NULL, roles LONGTEXT NOT NULL COMMENT '(DC2Type:array)', credentials_expired TINYINT(1) NOT NULL, credentials_expire_at DATETIME DEFAULT NULL, name LONGTEXT DEFAULT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, authCode INT DEFAULT NULL, twoFactorAuthentication TINYINT(1) NOT NULL, trusted LONGTEXT DEFAULT NULL COMMENT '(DC2Type:json_array)', UNIQUE INDEX UNIQ_1D63E7E592FC23A8 (username_canonical), UNIQUE INDEX UNIQ_1D63E7E5A0D96FBF (email_canonical), UNIQUE INDEX UNIQ_1D63E7E5C05FB297 (confirmation_token), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE wallabag_annotation (id INT AUTO_INCREMENT NOT NULL, user_id INT DEFAULT NULL, entry_id INT DEFAULT NULL, text LONGTEXT NOT NULL, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, quote VARCHAR(255) NOT NULL, ranges LONGTEXT NOT NULL COMMENT '(DC2Type:array)', INDEX IDX_A7AED006A76ED395 (user_id), INDEX IDX_A7AED006BA364942 (entry_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
ALTER TABLE `wallabag_entry` ADD CONSTRAINT FK_F4D18282A76ED395 FOREIGN KEY (user_id) REFERENCES `wallabag_user` (id);
ALTER TABLE wallabag_entry_tag ADD CONSTRAINT FK_C9F0DD7CBA364942 FOREIGN KEY (entry_id) REFERENCES `wallabag_entry` (id);
ALTER TABLE wallabag_entry_tag ADD CONSTRAINT FK_C9F0DD7CBAD26311 FOREIGN KEY (tag_id) REFERENCES `wallabag_tag` (id);
ALTER TABLE `wallabag_config` ADD CONSTRAINT FK_87E64C53A76ED395 FOREIGN KEY (user_id) REFERENCES `wallabag_user` (id);
ALTER TABLE `wallabag_tagging_rule` ADD CONSTRAINT FK_2D9B3C5424DB0683 FOREIGN KEY (config_id) REFERENCES `wallabag_config` (id);
ALTER TABLE wallabag_oauth2_access_tokens ADD CONSTRAINT FK_368A420919EB6921 FOREIGN KEY (client_id) REFERENCES wallabag_oauth2_clients (id);
ALTER TABLE wallabag_oauth2_access_tokens ADD CONSTRAINT FK_368A4209A76ED395 FOREIGN KEY (user_id) REFERENCES `wallabag_user` (id);
ALTER TABLE wallabag_oauth2_refresh_tokens ADD CONSTRAINT FK_20C9FB2419EB6921 FOREIGN KEY (client_id) REFERENCES wallabag_oauth2_clients (id);
ALTER TABLE wallabag_oauth2_refresh_tokens ADD CONSTRAINT FK_20C9FB24A76ED395 FOREIGN KEY (user_id) REFERENCES `wallabag_user` (id);
ALTER TABLE wallabag_oauth2_auth_codes ADD CONSTRAINT FK_EE52E3FA19EB6921 FOREIGN KEY (client_id) REFERENCES wallabag_oauth2_clients (id);
ALTER TABLE wallabag_oauth2_auth_codes ADD CONSTRAINT FK_EE52E3FAA76ED395 FOREIGN KEY (user_id) REFERENCES `wallabag_user` (id);
ALTER TABLE wallabag_annotation ADD CONSTRAINT FK_A7AED006A76ED395 FOREIGN KEY (user_id) REFERENCES `wallabag_user` (id);
ALTER TABLE wallabag_annotation ADD CONSTRAINT FK_A7AED006BA364942 FOREIGN KEY (entry_id) REFERENCES `wallabag_entry` (id);