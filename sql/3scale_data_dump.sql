-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: system
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `access_tokens`
--

DROP TABLE IF EXISTS `access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `access_tokens` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `owner_id` bigint NOT NULL,
  `scopes` text COLLATE utf8mb3_bin,
  `value` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `name` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `permission` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_value_auth_tokens_of_user` (`value`,`owner_id`),
  KEY `idx_auth_tokens_of_user` (`owner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access_tokens`
--

LOCK TABLES `access_tokens` WRITE;
/*!40000 ALTER TABLE `access_tokens` DISABLE KEYS */;
INSERT INTO `access_tokens` VALUES (1,1,'---\n- account_management\n','nD0D317O','APIcast','ro',NULL,'2024-08-16 20:05:20','2024-08-16 20:05:20'),(2,1,'---\n- account_management\n','AoBzQ9Jl','Master Token','rw',NULL,'2024-08-16 20:05:20','2024-08-16 20:05:20'),(3,2,'---\n- cms\n- finance\n- account_management\n- stats\n- policy_registry\n','GbFl8GL6a7DQKcho','Administration','rw',2,'2024-08-16 20:05:20','2024-08-16 20:05:20'),(4,1,'---\n- account_management\n','8f222e4da6d45cf10141cc826812ab919e9143a832504741b216ec2f91c4253e','OIDC Synchronization Token','ro',NULL,'2024-08-16 20:07:50','2024-08-16 20:07:50'),(5,3,'---\n- account_management\n','4d7eb1531dfc9bf3513c65a564f5ab85134dcd788ac3a83d5d6190d4c660e82d','OIDC Synchronization Token','ro',2,'2024-08-16 20:07:50','2024-08-16 20:07:50'),(6,1,'---\n- account_management\n','1ad27273c4697a630283714225db4cd0604e213563f1f48f976c207feb4c3e16','OIDC Synchronization Token','ro',NULL,'2024-08-16 20:07:50','2024-08-16 20:07:50'),(7,1,'---\n- account_management\n','5d799eb6c78b2325edd7580bb916804eddaed321841564daad635cc3fa4f5088','OIDC Synchronization Token','ro',NULL,'2024-08-16 20:07:50','2024-08-16 20:07:50'),(8,6,'---\n- account_management\n','de50d04c726f47c1ecaa176834792df6338be451398b89336664999e603c8d9e','OIDC Synchronization Token','ro',4,'2024-08-16 20:12:25','2024-08-16 20:12:25'),(9,6,'---\n- cms\n- finance\n- account_management\n- stats\n- policy_registry\n','f1dcf5f09fe82043da924386d58743bb291c42e12bfad58f35a834434e9562ad','RHDH Token','rw',4,'2024-08-16 20:52:09','2024-08-16 20:52:09');
/*!40000 ALTER TABLE `access_tokens` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `access_tokens_tenant_id` BEFORE INSERT ON `access_tokens` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM users WHERE id = NEW.owner_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_name` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `org_legaladdress` varchar(255) COLLATE utf8mb3_bin DEFAULT '',
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `provider` tinyint(1) DEFAULT '0',
  `buyer` tinyint(1) DEFAULT '0',
  `country_id` bigint DEFAULT NULL,
  `provider_account_id` bigint DEFAULT NULL,
  `domain` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `telephone_number` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `site_access_code` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `credit_card_partial_number` varchar(4) COLLATE utf8mb3_bin DEFAULT NULL,
  `credit_card_expires_on` date DEFAULT NULL,
  `credit_card_auth_code` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `master` tinyint(1) DEFAULT NULL,
  `billing_address_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `billing_address_address1` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `billing_address_address2` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `billing_address_city` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `billing_address_state` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `billing_address_country` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `billing_address_zip` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `billing_address_phone` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `org_legaladdress_cont` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `state_region` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `paid` tinyint(1) DEFAULT '0',
  `paid_at` datetime DEFAULT NULL,
  `signs_legal_terms` tinyint(1) DEFAULT '1',
  `timezone` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `delta` tinyint(1) NOT NULL DEFAULT '1',
  `from_email` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `primary_business` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `business_category` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `zip` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `extra_fields` text COLLATE utf8mb3_bin,
  `vat_code` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `fiscal_code` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `vat_rate` decimal(20,2) DEFAULT NULL,
  `invoice_footnote` text COLLATE utf8mb3_bin,
  `vat_zero_text` text COLLATE utf8mb3_bin,
  `default_account_plan_id` bigint DEFAULT NULL,
  `default_service_id` bigint DEFAULT NULL,
  `credit_card_authorize_net_payment_profile_token` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `self_domain` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `s3_prefix` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `prepared_assets_version` int DEFAULT NULL,
  `sample_data` tinyint(1) DEFAULT NULL,
  `proxy_configs_file_size` int DEFAULT NULL,
  `proxy_configs_updated_at` datetime DEFAULT NULL,
  `proxy_configs_content_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `proxy_configs_file_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `support_email` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `finance_support_email` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `billing_address_first_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `billing_address_last_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `email_all_users` tinyint(1) DEFAULT '0',
  `partner_id` bigint DEFAULT NULL,
  `proxy_configs_conf_file_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `proxy_configs_conf_content_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `proxy_configs_conf_file_size` int DEFAULT NULL,
  `proxy_configs_conf_updated_at` datetime DEFAULT NULL,
  `hosted_proxy_deployed_at` datetime DEFAULT NULL,
  `po_number` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `state_changed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_accounts_on_domain` (`domain`),
  UNIQUE KEY `index_accounts_on_master` (`master`),
  UNIQUE KEY `index_accounts_on_self_domain` (`self_domain`),
  KEY `index_accounts_on_default_service_id` (`default_service_id`),
  KEY `index_accounts_on_domain_and_state_changed_at` (`domain`,`state_changed_at`),
  KEY `index_accounts_on_provider_account_id_and_created_at` (`provider_account_id`,`created_at`),
  KEY `index_accounts_on_provider_account_id_and_state` (`provider_account_id`,`state`),
  KEY `index_accounts_on_provider_account_id` (`provider_account_id`),
  KEY `index_accounts_on_self_domain_and_state_changed_at` (`self_domain`,`state_changed_at`),
  KEY `index_accounts_on_state_and_state_changed_at` (`state`,`state_changed_at`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'Master Account','','2024-08-16 20:05:17','2024-08-16 20:05:19',0,0,NULL,1,'master.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com',NULL,'',NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'approved',0,NULL,1,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,NULL,NULL,1,'master.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com','master-account',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-08-16 20:05:18'),(2,'Provider Name','','2024-08-16 20:05:20','2024-08-16 20:07:48',1,0,NULL,1,'3scale.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com',NULL,'18d2bcc357',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'approved',0,NULL,1,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,6,NULL,NULL,2,'3scale-admin.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com','provider-name',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-08-16 20:05:20'),(3,'Developer','','2024-08-16 20:07:49','2024-08-16 20:07:51',0,1,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'approved',0,NULL,1,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-08-16 20:07:51'),(4,'Demo Organization','','2024-08-16 20:12:24','2024-08-16 20:12:48',1,0,NULL,1,'demo-organization.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com',NULL,'620dbf6214',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'approved',0,NULL,1,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,10,NULL,NULL,4,'demo-organization-admin.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com','demo-organization',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-08-16 20:12:25'),(5,'Developer','','2024-08-16 20:12:49','2024-08-16 20:12:50',0,1,NULL,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'approved',0,NULL,1,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-08-16 20:12:50');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `accounts_tenant_id` BEFORE INSERT ON `accounts` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.buyer THEN
  SET NEW.tenant_id = NEW.provider_account_id;
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` bigint NOT NULL,
  `timestamp` datetime NOT NULL,
  `state` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `cinstance_id` bigint NOT NULL,
  `utilization` decimal(6,2) NOT NULL,
  `level` int NOT NULL,
  `alert_id` bigint NOT NULL,
  `message` text COLLATE utf8mb3_bin,
  `tenant_id` bigint DEFAULT NULL,
  `service_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_alerts_on_alert_id_and_account_id` (`alert_id`,`account_id`),
  KEY `index_alerts_with_service_id` (`account_id`,`service_id`,`state`,`cinstance_id`),
  KEY `index_alerts_on_cinstance_id` (`cinstance_id`),
  KEY `index_alerts_on_timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `alerts_tenant_id` BEFORE INSERT ON `alerts` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM accounts WHERE id = NEW.account_id AND (NOT master OR master is NULL));

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `api_docs_services`
--

DROP TABLE IF EXISTS `api_docs_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_docs_services` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` bigint DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `body` longtext COLLATE utf8mb3_bin,
  `description` text COLLATE utf8mb3_bin,
  `published` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `system_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `base_path` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `swagger_version` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `skip_swagger_validations` tinyint(1) DEFAULT '0',
  `service_id` bigint DEFAULT NULL,
  `discovered` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_api_docs_services_on_account_id` (`account_id`),
  KEY `fk_rails_e4d18239f1` (`service_id`),
  CONSTRAINT `fk_rails_e4d18239f1` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_docs_services`
--

LOCK TABLES `api_docs_services` WRITE;
/*!40000 ALTER TABLE `api_docs_services` DISABLE KEYS */;
INSERT INTO `api_docs_services` VALUES (1,2,2,'Echo','{\n  \"openapi\": \"3.0.0\",\n  \"info\": {\n    \"version\": \"1.0.0\",\n    \"title\": \"Echo API\",\n    \"description\": \"A sample echo API\"\n  },\n  \"paths\": {\n    \"/\": {\n      \"get\": {\n        \"description\": \"Echo API with no parameters\",\n        \"operationId\": \"echo_no_params\",\n        \"parameters\": [\n          {\n            \"name\": \"user_key\",\n            \"in\": \"query\",\n            \"description\": \"Your API access key\",\n            \"required\": true,\n            \"x-data-threescale-name\": \"user_keys\",\n            \"schema\": {\n              \"type\": \"string\"\n            }\n          }\n        ],\n        \"responses\": {\n          \"200\": {\n            \"description\": \"response\",\n            \"content\": {\n              \"application/json\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ResponseModel\"\n                }\n              },\n              \"application/xml\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ResponseModel\"\n                }\n              },\n              \"text/xml\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ResponseModel\"\n                }\n              },\n              \"text/html\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ResponseModel\"\n                }\n              }\n            }\n          },\n          \"default\": {\n            \"description\": \"unexpected error\",\n            \"content\": {\n              \"application/json\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ErrorModel\"\n                }\n              },\n              \"application/xml\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ErrorModel\"\n                }\n              },\n              \"text/xml\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ErrorModel\"\n                }\n              },\n              \"text/html\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ErrorModel\"\n                }\n              }\n            }\n          }\n        }\n      }\n    },\n    \"/{echo}\": {\n      \"get\": {\n        \"description\": \"Echo API with parameters\",\n        \"operationId\": \"echo_with_params\",\n        \"parameters\": [\n          {\n            \"name\": \"echo\",\n            \"in\": \"path\",\n            \"description\": \"The string to be echoed\",\n            \"required\": true,\n            \"schema\": {\n              \"type\": \"string\"\n            }\n          },\n          {\n            \"name\": \"user_key\",\n            \"in\": \"query\",\n            \"description\": \"Your API access key\",\n            \"required\": true,\n            \"x-data-threescale-name\": \"user_keys\",\n            \"schema\": {\n              \"type\": \"string\"\n            }\n          }\n        ],\n        \"responses\": {\n          \"200\": {\n            \"description\": \"response\",\n            \"content\": {\n              \"application/json\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ResponseModel\"\n                }\n              },\n              \"application/xml\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ResponseModel\"\n                }\n              },\n              \"text/xml\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ResponseModel\"\n                }\n              },\n              \"text/html\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ResponseModel\"\n                }\n              }\n            }\n          },\n          \"default\": {\n            \"description\": \"unexpected error\",\n            \"content\": {\n              \"application/json\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ErrorModel\"\n                }\n              },\n              \"application/xml\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ErrorModel\"\n                }\n              },\n              \"text/xml\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ErrorModel\"\n                }\n              },\n              \"text/html\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ErrorModel\"\n                }\n              }\n            }\n          }\n        }\n      }\n    }\n  },\n  \"servers\": [\n    {\n      \"url\": \"http://echo-api.3scale.net/\"\n    }\n  ],\n  \"components\": {\n    \"schemas\": {\n      \"ResponseModel\": {\n        \"type\": \"object\",\n        \"required\": [\n          \"method\",\n          \"path\",\n          \"args\",\n          \"headers\"\n        ],\n        \"properties\": {\n          \"method\": {\n            \"type\": \"string\"\n          },\n          \"path\": {\n            \"type\": \"string\"\n          },\n          \"args\": {\n            \"type\": \"string\"\n          },\n          \"headers\": {\n            \"type\": \"object\"\n          }\n        }\n      },\n      \"ErrorModel\": {\n        \"type\": \"object\",\n        \"required\": [\n          \"code\",\n          \"message\"\n        ],\n        \"properties\": {\n          \"code\": {\n            \"type\": \"integer\",\n            \"format\": \"int32\"\n          },\n          \"message\": {\n            \"type\": \"string\"\n          }\n        }\n      }\n    }\n  }\n}\n',NULL,1,'2024-08-16 20:07:52','2024-08-16 20:07:52','echo','http://echo-api.3scale.net/','3.0',0,2,NULL),(2,4,4,'Echo','{\n  \"openapi\": \"3.0.0\",\n  \"info\": {\n    \"version\": \"1.0.0\",\n    \"title\": \"Echo API\",\n    \"description\": \"A sample echo API\"\n  },\n  \"paths\": {\n    \"/\": {\n      \"get\": {\n        \"description\": \"Echo API with no parameters\",\n        \"operationId\": \"echo_no_params\",\n        \"parameters\": [\n          {\n            \"name\": \"user_key\",\n            \"in\": \"query\",\n            \"description\": \"Your API access key\",\n            \"required\": true,\n            \"x-data-threescale-name\": \"user_keys\",\n            \"schema\": {\n              \"type\": \"string\"\n            }\n          }\n        ],\n        \"responses\": {\n          \"200\": {\n            \"description\": \"response\",\n            \"content\": {\n              \"application/json\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ResponseModel\"\n                }\n              },\n              \"application/xml\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ResponseModel\"\n                }\n              },\n              \"text/xml\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ResponseModel\"\n                }\n              },\n              \"text/html\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ResponseModel\"\n                }\n              }\n            }\n          },\n          \"default\": {\n            \"description\": \"unexpected error\",\n            \"content\": {\n              \"application/json\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ErrorModel\"\n                }\n              },\n              \"application/xml\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ErrorModel\"\n                }\n              },\n              \"text/xml\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ErrorModel\"\n                }\n              },\n              \"text/html\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ErrorModel\"\n                }\n              }\n            }\n          }\n        }\n      }\n    },\n    \"/{echo}\": {\n      \"get\": {\n        \"description\": \"Echo API with parameters\",\n        \"operationId\": \"echo_with_params\",\n        \"parameters\": [\n          {\n            \"name\": \"echo\",\n            \"in\": \"path\",\n            \"description\": \"The string to be echoed\",\n            \"required\": true,\n            \"schema\": {\n              \"type\": \"string\"\n            }\n          },\n          {\n            \"name\": \"user_key\",\n            \"in\": \"query\",\n            \"description\": \"Your API access key\",\n            \"required\": true,\n            \"x-data-threescale-name\": \"user_keys\",\n            \"schema\": {\n              \"type\": \"string\"\n            }\n          }\n        ],\n        \"responses\": {\n          \"200\": {\n            \"description\": \"response\",\n            \"content\": {\n              \"application/json\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ResponseModel\"\n                }\n              },\n              \"application/xml\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ResponseModel\"\n                }\n              },\n              \"text/xml\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ResponseModel\"\n                }\n              },\n              \"text/html\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ResponseModel\"\n                }\n              }\n            }\n          },\n          \"default\": {\n            \"description\": \"unexpected error\",\n            \"content\": {\n              \"application/json\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ErrorModel\"\n                }\n              },\n              \"application/xml\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ErrorModel\"\n                }\n              },\n              \"text/xml\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ErrorModel\"\n                }\n              },\n              \"text/html\": {\n                \"schema\": {\n                  \"$ref\": \"#/components/schemas/ErrorModel\"\n                }\n              }\n            }\n          }\n        }\n      }\n    }\n  },\n  \"servers\": [\n    {\n      \"url\": \"http://echo-api.3scale.net/\"\n    }\n  ],\n  \"components\": {\n    \"schemas\": {\n      \"ResponseModel\": {\n        \"type\": \"object\",\n        \"required\": [\n          \"method\",\n          \"path\",\n          \"args\",\n          \"headers\"\n        ],\n        \"properties\": {\n          \"method\": {\n            \"type\": \"string\"\n          },\n          \"path\": {\n            \"type\": \"string\"\n          },\n          \"args\": {\n            \"type\": \"string\"\n          },\n          \"headers\": {\n            \"type\": \"object\"\n          }\n        }\n      },\n      \"ErrorModel\": {\n        \"type\": \"object\",\n        \"required\": [\n          \"code\",\n          \"message\"\n        ],\n        \"properties\": {\n          \"code\": {\n            \"type\": \"integer\",\n            \"format\": \"int32\"\n          },\n          \"message\": {\n            \"type\": \"string\"\n          }\n        }\n      }\n    }\n  }\n}\n',NULL,1,'2024-08-16 20:12:50','2024-08-16 20:12:50','echo','http://echo-api.3scale.net/','3.0',0,3,NULL),(3,4,4,'Product Family 1','{\r\n  \"openapi\": \"3.0.1\",\r\n  \"info\": {\r\n    \"title\": \"People API\",\r\n    \"description\": \"API for managing people\",\r\n    \"version\": \"1.0.0\"\r\n  },\r\n  \"paths\": {\r\n    \"/people\": {\r\n      \"get\": {\r\n        \"summary\": \"Get a list of people\",\r\n        \"responses\": {\r\n          \"200\": {\r\n            \"description\": \"A list of people\",\r\n            \"content\": {\r\n              \"application/json\": {\r\n                \"schema\": {\r\n                  \"type\": \"array\",\r\n                  \"items\": {\r\n                    \"$ref\": \"#/components/schemas/Person\"\r\n                  }\r\n                }\r\n              }\r\n            }\r\n          }\r\n        }\r\n      },\r\n      \"post\": {\r\n        \"summary\": \"Create a new person\",\r\n        \"requestBody\": {\r\n          \"description\": \"Person object that needs to be added\",\r\n          \"required\": true,\r\n          \"content\": {\r\n            \"application/json\": {\r\n              \"schema\": {\r\n                \"$ref\": \"#/components/schemas/Person\"\r\n              }\r\n            }\r\n          }\r\n        },\r\n        \"responses\": {\r\n          \"201\": {\r\n            \"description\": \"Person created\",\r\n            \"content\": {\r\n              \"application/json\": {\r\n                \"schema\": {\r\n                  \"$ref\": \"#/components/schemas/Person\"\r\n                }\r\n              }\r\n            }\r\n          }\r\n        }\r\n      }\r\n    },\r\n    \"/people/{id}\": {\r\n      \"get\": {\r\n        \"summary\": \"Get a person by ID\",\r\n        \"parameters\": [\r\n          {\r\n            \"name\": \"id\",\r\n            \"in\": \"path\",\r\n            \"required\": true,\r\n            \"schema\": {\r\n              \"type\": \"string\"\r\n            },\r\n            \"description\": \"ID of the person to retrieve\"\r\n          }\r\n        ],\r\n        \"responses\": {\r\n          \"200\": {\r\n            \"description\": \"Person object\",\r\n            \"content\": {\r\n              \"application/json\": {\r\n                \"schema\": {\r\n                  \"$ref\": \"#/components/schemas/Person\"\r\n                }\r\n              }\r\n            }\r\n          },\r\n          \"404\": {\r\n            \"description\": \"Person not found\"\r\n          }\r\n        }\r\n      },\r\n      \"put\": {\r\n        \"summary\": \"Update a person by ID\",\r\n        \"parameters\": [\r\n          {\r\n            \"name\": \"id\",\r\n            \"in\": \"path\",\r\n            \"required\": true,\r\n            \"schema\": {\r\n              \"type\": \"string\"\r\n            },\r\n            \"description\": \"ID of the person to update\"\r\n          }\r\n        ],\r\n        \"requestBody\": {\r\n          \"description\": \"Person object that needs to be updated\",\r\n          \"required\": true,\r\n          \"content\": {\r\n            \"application/json\": {\r\n              \"schema\": {\r\n                \"$ref\": \"#/components/schemas/Person\"\r\n              }\r\n            }\r\n          }\r\n        },\r\n        \"responses\": {\r\n          \"200\": {\r\n            \"description\": \"Person updated\",\r\n            \"content\": {\r\n              \"application/json\": {\r\n                \"schema\": {\r\n                  \"$ref\": \"#/components/schemas/Person\"\r\n                }\r\n              }\r\n            }\r\n          },\r\n          \"404\": {\r\n            \"description\": \"Person not found\"\r\n          }\r\n        }\r\n      },\r\n      \"delete\": {\r\n        \"summary\": \"Delete a person by ID\",\r\n        \"parameters\": [\r\n          {\r\n            \"name\": \"id\",\r\n            \"in\": \"path\",\r\n            \"required\": true,\r\n            \"schema\": {\r\n              \"type\": \"string\"\r\n            },\r\n            \"description\": \"ID of the person to delete\"\r\n          }\r\n        ],\r\n        \"responses\": {\r\n          \"204\": {\r\n            \"description\": \"Person deleted\"\r\n          },\r\n          \"404\": {\r\n            \"description\": \"Person not found\"\r\n          }\r\n        }\r\n      }\r\n    }\r\n  },\r\n  \"components\": {\r\n    \"schemas\": {\r\n      \"Person\": {\r\n        \"type\": \"object\",\r\n        \"properties\": {\r\n          \"id\": {\r\n            \"type\": \"string\",\r\n            \"example\": \"123\"\r\n          },\r\n          \"firstName\": {\r\n            \"type\": \"string\",\r\n            \"example\": \"John\"\r\n          },\r\n          \"lastName\": {\r\n            \"type\": \"string\",\r\n            \"example\": \"Doe\"\r\n          },\r\n          \"email\": {\r\n            \"type\": \"string\",\r\n            \"example\": \"john.doe@example.com\"\r\n          },\r\n          \"age\": {\r\n            \"type\": \"integer\",\r\n            \"example\": 30\r\n          }\r\n        }\r\n      }\r\n    }\r\n  }\r\n}\r\n','',1,'2024-08-16 20:22:31','2024-08-16 20:22:31','product_family_1',NULL,'3.0',0,4,NULL);
/*!40000 ALTER TABLE `api_docs_services` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `api_docs_services_tenant_id` BEFORE INSERT ON `api_docs_services` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.account_id <> master_id THEN
  SET NEW.tenant_id = NEW.account_id;
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `application_keys`
--

DROP TABLE IF EXISTS `application_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_keys` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `application_id` bigint NOT NULL,
  `value` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_application_keys_on_application_id_and_value` (`application_id`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_keys`
--

LOCK TABLES `application_keys` WRITE;
/*!40000 ALTER TABLE `application_keys` DISABLE KEYS */;
/*!40000 ALTER TABLE `application_keys` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `application_keys_tenant_id` BEFORE INSERT ON `application_keys` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM cinstances WHERE id = NEW.application_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ar_internal_metadata`
--

DROP TABLE IF EXISTS `ar_internal_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ar_internal_metadata`
--

LOCK TABLES `ar_internal_metadata` WRITE;
/*!40000 ALTER TABLE `ar_internal_metadata` DISABLE KEYS */;
INSERT INTO `ar_internal_metadata` VALUES ('environment','production','2024-08-16 20:05:16.141117','2024-08-16 20:05:16.141117'),('schema_sha1','7eb72cded032d9183a5d2254aae0a13bd925950c','2024-08-16 20:05:16.151936','2024-08-16 20:05:16.151936');
/*!40000 ALTER TABLE `ar_internal_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audits`
--

DROP TABLE IF EXISTS `audits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audits` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `auditable_id` bigint DEFAULT NULL,
  `auditable_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `user_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `username` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `action` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `version` int DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `provider_id` bigint DEFAULT NULL,
  `kind` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `audited_changes` mediumtext COLLATE utf8mb3_bin,
  `comment` text COLLATE utf8mb3_bin,
  `associated_id` int DEFAULT NULL,
  `associated_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `remote_address` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `request_uuid` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_audits_on_action` (`action`),
  KEY `associated_index` (`associated_type`,`associated_id`),
  KEY `index_audits_on_auditable_id_and_auditable_type_and_version` (`auditable_id`,`auditable_type`,`version`),
  KEY `auditable_index` (`auditable_type`,`auditable_id`,`version`),
  KEY `index_audits_on_created_at` (`created_at`),
  KEY `index_audits_on_kind` (`kind`),
  KEY `index_audits_on_provider_id` (`provider_id`),
  KEY `index_audits_on_request_uuid` (`request_uuid`),
  KEY `user_index` (`user_id`,`user_type`),
  KEY `index_audits_on_version` (`version`)
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audits`
--

LOCK TABLES `audits` WRITE;
/*!40000 ALTER TABLE `audits` DISABLE KEYS */;
INSERT INTO `audits` VALUES (1,1,'Account',NULL,NULL,NULL,'update',1,'2024-08-16 20:07:48',NULL,1,'Account','---\nstate_changed_at:\n- \n- \'2024-08-16T20:05:18Z\'\n',NULL,NULL,NULL,NULL,'4649d96e-7f60-4518-ad90-7ed0a378d01b'),(2,1,'User',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:48',NULL,1,'User','---\nusername: master\nemail: \ncreated_at: \'2024-08-16T20:05:18Z\'\nremember_token: \nremember_token_expires_at: \nactivation_code: d3c9c53c0d773775205c23b04d223241ae9da69e\nactivated_at: \nstate: pending\nrole: admin\nlost_password_token: \naccount_id: 1\nfirst_name: \nlast_name: \nsignup_type: minimal\njob_role: \nemail_verification_code: \ntitle: \nextra_fields: {}\ntenant_id: \nlost_password_token_generated_at: \n',NULL,NULL,NULL,NULL,'a8601a1e-f7df-4776-854b-170287aef2d3'),(3,1,'Account',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:48',NULL,1,'Account','---\norg_name: Master Account\norg_legaladdress: \'\'\ncreated_at: \'2024-08-16T20:05:17Z\'\nprovider: false\nbuyer: false\ncountry_id: \nprovider_account_id: \ndomain: master.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com\ntelephone_number: \nsite_access_code: \'\'\ncredit_card_partial_number: \ncredit_card_expires_on: \ncredit_card_auth_code: \nmaster: true\nbilling_address_name: \nbilling_address_address1: \nbilling_address_address2: \nbilling_address_city: \nbilling_address_state: \nbilling_address_country: \nbilling_address_zip: \nbilling_address_phone: \norg_legaladdress_cont: \ncity: \nstate_region: \nstate: created\npaid: false\npaid_at: \nsigns_legal_terms: true\ntimezone: \ndelta: true\nfrom_email: \nprimary_business: \nbusiness_category: \nzip: \nextra_fields: {}\nvat_code: \nfiscal_code: \nvat_rate: \ninvoice_footnote: \nvat_zero_text: \ndefault_account_plan_id: \ndefault_service_id: \ncredit_card_authorize_net_payment_profile_token: \ntenant_id: 1\nself_domain: master.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com\ns3_prefix: master-account\nprepared_assets_version: \nsample_data: \nsupport_email: \nfinance_support_email: \nbilling_address_first_name: \nbilling_address_last_name: \nemail_all_users: false\npartner_id: \nhosted_proxy_deployed_at: \npo_number: \nstate_changed_at: \n',NULL,NULL,NULL,NULL,'33903624-610d-4de4-aff4-de5f185c56ac'),(4,1,'Service',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:48',NULL,1,'Service','---\naccount_id: 1\nname: Master Service\ndescription: \ntxt_support: \ncreated_at: \'2024-08-16T20:05:18Z\'\nlogo_file_name: \nlogo_content_type: \nlogo_file_size: \nstate: incomplete\nintentions_required: false\nterms: \nbuyers_manage_apps: true\nbuyers_manage_keys: true\ncustom_keys_enabled: true\nbuyer_plan_change_permission: request\nbuyer_can_select_plan: false\nnotification_settings: \ndefault_application_plan_id: \ndefault_service_plan_id: \ntenant_id: \nsystem_name: master_service\nbackend_version: \'1\'\nmandatory_app_key: true\nbuyer_key_regenerate_enabled: true\nsupport_email: \nreferrer_filters_required: false\ndeployment_option: hosted\nkubernetes_service_link: \n',NULL,NULL,NULL,NULL,'c50e44f5-66fe-47bc-bec1-053ab8884d18'),(5,1,'Account',NULL,NULL,NULL,'update',1,'2024-08-16 20:07:48',NULL,1,'Account','---\nprovider_account_id:\n- \n- 1\n',NULL,NULL,NULL,NULL,'c9da97f1-5383-4829-aea7-9737f8695ad5'),(6,1,'User',NULL,NULL,NULL,'update',1,'2024-08-16 20:07:48',NULL,1,'User','---\nactivation_code:\n- d3c9c53c0d773775205c23b04d223241ae9da69e\n- \nactivated_at:\n- \n- \'2024-08-16T20:05:18Z\'\nstate:\n- pending\n- active\n',NULL,NULL,NULL,NULL,'7ac581dc-ce01-4df4-a486-c0469e96c803'),(7,1,'Account',NULL,NULL,NULL,'update',2,'2024-08-16 20:07:48',NULL,1,'Account','---\ndefault_account_plan_id:\n- \n- 3\n',NULL,NULL,NULL,NULL,'67ff0f23-a103-4573-9f3f-996156c9c542'),(8,1,'Service',NULL,NULL,NULL,'update',1,'2024-08-16 20:07:48',NULL,1,'Service','---\ndefault_service_plan_id:\n- \n- 1\n',NULL,NULL,NULL,NULL,'4f77fb7b-ed81-475f-bd51-c5f3c505a8b8'),(9,1,'Account',NULL,NULL,NULL,'update',2,'2024-08-16 20:07:48',NULL,1,'Account','---\nstate:\n- created\n- approved\n',NULL,NULL,NULL,NULL,'9915dd93-8933-4fe7-a3bb-9277a1a98c7b'),(10,1,'Service',NULL,NULL,NULL,'update',2,'2024-08-16 20:07:48',NULL,1,'Service','---\nnotification_settings:\n- \n- web_buyer:\n  - 0\n  - 50\n  - 80\n  - 90\n  - 100\n  - 120\n  - 150\n  - 200\n  - 300\n  email_buyer:\n  - 0\n  - 50\n  - 80\n  - 90\n  - 100\n  - 120\n  - 150\n  - 200\n  - 300\n  web_provider:\n  - 0\n  - 50\n  - 80\n  - 90\n  - 100\n  - 120\n  - 150\n  - 200\n  - 300\n  email_provider:\n  - 0\n  - 50\n  - 80\n  - 90\n  - 100\n  - 120\n  - 150\n  - 200\n  - 300\ndefault_application_plan_id:\n- \n- 2\n',NULL,NULL,NULL,NULL,'af616e9a-2bd4-4153-9e16-f095985055a0'),(11,1,'Service',NULL,NULL,NULL,'update',2,'2024-08-16 20:07:48',NULL,1,'Service','---\ndefault_application_plan_id:\n- 2\n- 4\n',NULL,NULL,NULL,NULL,'15711203-9e84-45d0-85fb-8e1727970f27'),(12,1,'Service',NULL,NULL,NULL,'update',3,'2024-08-16 20:07:48',NULL,1,'Service','---\ndeployment_option:\n- hosted\n- self_managed\n',NULL,NULL,NULL,NULL,'c2ca862a-e3c0-49b9-a5d0-4138b0f85cd2'),(13,1,'Settings',NULL,NULL,NULL,'update',1,'2024-08-16 20:07:48',NULL,1,'Settings','---\nservice_plans_switch:\n- hidden\n- visible\n',NULL,NULL,NULL,NULL,'5b041cda-ad3d-4480-a9d8-f72439c45ff9'),(14,1,'Metric',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:48',NULL,1,'Metric','---\nsystem_name: hits\ndescription: Number of API hits\nunit: hit\ncreated_at: \'2024-08-16T20:05:19Z\'\nservice_id: 1\nfriendly_name: Hits\nparent_id: \ntenant_id: \nowner_id: 1\nowner_type: Service\n',NULL,NULL,NULL,NULL,'ed5bfe67-6343-4492-bdb1-55ff142f430c'),(15,1,'Settings',NULL,NULL,NULL,'update',2,'2024-08-16 20:07:48',NULL,1,'Settings','---\naccount_plans_switch:\n- hidden\n- visible\n',NULL,NULL,NULL,NULL,'2e649f3c-b2db-4dcd-8a89-ba674a736f53'),(16,1,'BackendApi',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:48',NULL,NULL,'BackendApi','---\nname: Master Service Backend\nsystem_name: master_service\ndescription: Backend of Master Service\nprivate_endpoint: https://echo-api.3scale.net:443\naccount_id: 1\ncreated_at: \'2024-08-16T20:05:19Z\'\ntenant_id: \nstate: published\n',NULL,NULL,NULL,NULL,'d67f942d-857e-4a64-a47f-543f94e06e0c'),(17,1,'Settings',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:48',NULL,1,'Settings','---\naccount_id: 1\nbg_colour: \nlink_colour: \ntext_colour: \ncreated_at: \'2024-08-16T20:05:19Z\'\nmenu_bg_colour: \nlink_label: \nlink_url: \nwelcome_text: \nmenu_link_colour: \ncontent_bg_colour: \ntracker_code: \nfavicon: \nplans_tab_bg_colour: \nplans_bg_colour: \ncontent_border_colour: \nforum_enabled: false\napp_gallery_enabled: false\nanonymous_posts_enabled: false\nsignups_enabled: true\ndocumentation_enabled: true\nuseraccountarea_enabled: true\nrefund_policy: \nprivacy_policy: \nmonthly_charging_enabled: true\ntoken_api: default\ndocumentation_public: true\nforum_public: false\nhide_service: \ncc_terms_path: \"/termsofservice\"\ncc_privacy_path: \"/privacypolicy\"\ncc_refunds_path: \"/refundpolicy\"\nchange_account_plan_permission: request\nstrong_passwords_enabled: false\nchange_service_plan_permission: request\ncan_create_service: false\nspam_protection_level: none\ntenant_id: \nmultiple_applications_switch: denied\nmultiple_users_switch: denied\nfinance_switch: denied\nmultiple_services_switch: denied\ngroups_switch: denied\naccount_plans_switch: denied\nauthentication_strategy: oauth2\njanrain_api_key: \njanrain_relying_party: \nservice_plans_switch: denied\npublic_search: false\nproduct: connect\nbranding_switch: denied\nmonthly_billing_enabled: true\ncms_token: \ncas_server_url: \nsso_key: 9b9f56a696f238a1b56ada0f8066396a9bfd3844f8acb36473c9f4d40019c7dc\nsso_login_url: \ncms_escape_draft_html: true\ncms_escape_published_html: true\nheroku_id: \nheroku_name: \nsetup_fee_enabled: false\naccount_plans_ui_visible: false\nservice_plans_ui_visible: false\nskip_email_engagement_footer_switch: denied\nweb_hooks_switch: denied\niam_tools_switch: denied\nrequire_cc_on_signup_switch: denied\nenforce_sso: false\n',NULL,NULL,NULL,NULL,'7261ba73-d3b3-48ce-b0b8-2c2e65e7dcbb'),(18,1,'Plan',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:48',NULL,1,'ServicePlan','---\nissuer_id: 1\nname: Default\nrights: \nfull_legal: \ncost_per_month: \'0.0\'\ntrial_period_days: \ncreated_at: \'2024-08-16T20:05:19Z\'\nposition: 1\nstate: published\ncancellation_period: 0\ncost_aggregation_rule: sum\nsetup_fee: \'0.0\'\nmaster: false\noriginal_id: 0\nissuer_type: Service\ndescription: \napproval_required: false\ntenant_id: \nsystem_name: default\npartner_id: \ncontracts_count: 0\n',NULL,NULL,NULL,NULL,'96e158cc-58c0-4379-a600-ce04167d9a48'),(19,1,'Settings',NULL,NULL,NULL,'update',3,'2024-08-16 20:07:48',NULL,1,'Settings','---\naccount_plans_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,NULL,'c65dfc76-7d49-4c7b-b9e8-26b03e9c34dc'),(20,1,'Settings',NULL,NULL,NULL,'update',3,'2024-08-16 20:07:48',NULL,1,'Settings','---\nservice_plans_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,NULL,'3210cf37-2e0d-4740-8ea5-06ae3873a86f'),(21,3,'Plan',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:48',NULL,1,'AccountPlan','---\nissuer_id: 1\nname: Default account plan\nrights: \nfull_legal: \ncost_per_month: \'0.0\'\ntrial_period_days: \ncreated_at: \'2024-08-16T20:05:19Z\'\nposition: 1\nstate: hidden\ncancellation_period: 0\ncost_aggregation_rule: sum\nsetup_fee: \'0.0\'\nmaster: false\noriginal_id: 0\nissuer_type: Account\ndescription: \napproval_required: false\ntenant_id: \nsystem_name: default_account_plan\npartner_id: \ncontracts_count: 0\n',NULL,NULL,NULL,NULL,'43b22894-4c7f-4cf1-b4ad-4f46aadad999'),(22,2,'Metric',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:48',NULL,NULL,'Metric','---\nsystem_name: hits.1\ndescription: Number of API hits\nunit: hit\ncreated_at: \'2024-08-16T20:05:19Z\'\nservice_id: \nfriendly_name: Hits\nparent_id: \ntenant_id: \nowner_id: 1\nowner_type: BackendApi\n',NULL,NULL,NULL,NULL,'84042f84-e229-4a5e-832c-e05b3f2e1f80'),(23,3,'Metric',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:48',NULL,1,'Metric','---\nsystem_name: billing\ndescription: \nunit: hit\ncreated_at: \'2024-08-16T20:05:20Z\'\nservice_id: 1\nfriendly_name: Billing API\nparent_id: \ntenant_id: \nowner_id: 1\nowner_type: Service\n',NULL,NULL,NULL,NULL,'7d5ada5e-ebcd-406c-9b72-bd3ca57a89ec'),(24,1,'Settings',NULL,NULL,NULL,'update',4,'2024-08-16 20:07:48',NULL,1,'Settings','---\nbranding_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,NULL,'2beea6ff-98a7-44b5-bfab-a949e2bf5545'),(25,4,'Plan',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:48',NULL,1,'ApplicationPlan','---\nissuer_id: 1\nname: enterprise\nrights: \nfull_legal: \ncost_per_month: \'0.0\'\ntrial_period_days: \ncreated_at: \'2024-08-16T20:05:19Z\'\nposition: 3\nstate: hidden\ncancellation_period: 0\ncost_aggregation_rule: sum\nsetup_fee: \'0.0\'\nmaster: false\noriginal_id: 0\nissuer_type: Service\ndescription: \napproval_required: false\ntenant_id: \nsystem_name: enterprise\npartner_id: \ncontracts_count: 0\n',NULL,NULL,NULL,NULL,'ae44ef52-d43c-4af2-a920-ba361c789203'),(26,2,'Plan',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:48',NULL,1,'ApplicationPlan','---\nissuer_id: 1\nname: Master Plan\nrights: \nfull_legal: \ncost_per_month: \'0.0\'\ntrial_period_days: \ncreated_at: \'2024-08-16T20:05:19Z\'\nposition: 2\nstate: hidden\ncancellation_period: 0\ncost_aggregation_rule: sum\nsetup_fee: \'0.0\'\nmaster: false\noriginal_id: 0\nissuer_type: Service\ndescription: \napproval_required: false\ntenant_id: \nsystem_name: master_plan\npartner_id: \ncontracts_count: 0\n',NULL,NULL,NULL,NULL,'fea8d563-8c69-4534-a73f-d83dcdc2d877'),(27,1,'Contract',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:48',NULL,1,'Cinstance','---\nplan_id: 2\nuser_account_id: 1\nuser_key: ed41d7d3e2d9cde81eef05a943ea3ffc\nprovider_public_key: da8cd86e82ab4ebbda5af36329622001\ncreated_at: \'2024-08-16T20:05:19Z\'\nstate: live\ndescription: Default application created on signup.\npaid_until: \napplication_id: fd7a3602\nname: Master Account\'s App\ntrial_period_expires_at: \'2024-08-16T20:05:19Z\'\nsetup_fee: \'0.0\'\nredirect_url: \nvariable_cost_paid_until: \nextra_fields: {}\ntenant_id: \ncreate_origin: \nfirst_traffic_at: \nfirst_daily_traffic_at: \nservice_id: 1\naccepted_at: \n',NULL,NULL,NULL,NULL,'b09e7143-3b19-41e6-a568-07344ceb3035'),(28,2,'Account',NULL,NULL,NULL,'update',1,'2024-08-16 20:07:48',2,2,'Account','---\nstate:\n- created\n- approved\n',NULL,NULL,NULL,NULL,'dd39f9d3-5815-46af-b1e1-0475bb0d818c'),(29,4,'Metric',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:48',NULL,1,'Metric','---\nsystem_name: account\ndescription: \nunit: hit\ncreated_at: \'2024-08-16T20:05:20Z\'\nservice_id: 1\nfriendly_name: Account Management API\nparent_id: \ntenant_id: \nowner_id: 1\nowner_type: Service\n',NULL,NULL,NULL,NULL,'68d528bc-5f2e-480d-a25a-06e463f0ebb2'),(30,2,'Account',NULL,NULL,NULL,'update',1,'2024-08-16 20:07:48',2,2,'Account','---\nstate_changed_at:\n- \n- \'2024-08-16T20:05:20Z\'\n',NULL,NULL,NULL,NULL,'6ea4c98e-4f9b-4c1f-89df-9c4409cebd64'),(31,2,'Settings',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:48',2,2,'Settings','---\naccount_id: 2\nbg_colour: \nlink_colour: \ntext_colour: \ncreated_at: \'2024-08-16T20:05:20Z\'\nmenu_bg_colour: \nlink_label: \nlink_url: \nwelcome_text: \nmenu_link_colour: \ncontent_bg_colour: \ntracker_code: \nfavicon: \nplans_tab_bg_colour: \nplans_bg_colour: \ncontent_border_colour: \nforum_enabled: false\napp_gallery_enabled: false\nanonymous_posts_enabled: false\nsignups_enabled: true\ndocumentation_enabled: true\nuseraccountarea_enabled: true\nrefund_policy: \nprivacy_policy: \nmonthly_charging_enabled: true\ntoken_api: default\ndocumentation_public: true\nforum_public: false\nhide_service: \ncc_terms_path: \"/termsofservice\"\ncc_privacy_path: \"/privacypolicy\"\ncc_refunds_path: \"/refundpolicy\"\nchange_account_plan_permission: request\nstrong_passwords_enabled: false\nchange_service_plan_permission: request\ncan_create_service: false\nspam_protection_level: none\ntenant_id: \nmultiple_applications_switch: denied\nmultiple_users_switch: denied\nfinance_switch: denied\nmultiple_services_switch: denied\ngroups_switch: denied\naccount_plans_switch: denied\nauthentication_strategy: oauth2\njanrain_api_key: \njanrain_relying_party: \nservice_plans_switch: denied\npublic_search: false\nproduct: connect\nbranding_switch: denied\nmonthly_billing_enabled: true\ncms_token: \ncas_server_url: \nsso_key: 52033985455cb9db05087432f1b25c5c09eca478374a5d300cef5af91c1537ac\nsso_login_url: \ncms_escape_draft_html: true\ncms_escape_published_html: true\nheroku_id: \nheroku_name: \nsetup_fee_enabled: false\naccount_plans_ui_visible: false\nservice_plans_ui_visible: false\nskip_email_engagement_footer_switch: denied\nweb_hooks_switch: denied\niam_tools_switch: denied\nrequire_cc_on_signup_switch: denied\nenforce_sso: false\n',NULL,NULL,NULL,NULL,'882c1666-3f0b-4e40-9a59-5dade9ba6efc'),(32,2,'Account',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:48',2,2,'Account','---\norg_name: Provider Name\norg_legaladdress: \'\'\ncreated_at: \'2024-08-16T20:05:20Z\'\nprovider: true\nbuyer: false\ncountry_id: \nprovider_account_id: 1\ndomain: 3scale.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com\ntelephone_number: \nsite_access_code: 18d2bcc357\ncredit_card_partial_number: \ncredit_card_expires_on: \ncredit_card_auth_code: \nmaster: \nbilling_address_name: \nbilling_address_address1: \nbilling_address_address2: \nbilling_address_city: \nbilling_address_state: \nbilling_address_country: \nbilling_address_zip: \nbilling_address_phone: \norg_legaladdress_cont: \ncity: \nstate_region: \nstate: created\npaid: false\npaid_at: \nsigns_legal_terms: true\ntimezone: \ndelta: true\nfrom_email: \nprimary_business: \nbusiness_category: \nzip: \nextra_fields: {}\nvat_code: \nfiscal_code: \nvat_rate: \ninvoice_footnote: \nvat_zero_text: \ndefault_account_plan_id: \ndefault_service_id: \ncredit_card_authorize_net_payment_profile_token: \ntenant_id: 2\nself_domain: 3scale-admin.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com\ns3_prefix: provider-name\nprepared_assets_version: \nsample_data: true\nsupport_email: \nfinance_support_email: \nbilling_address_first_name: \nbilling_address_last_name: \nemail_all_users: false\npartner_id: \nhosted_proxy_deployed_at: \npo_number: \nstate_changed_at: \n',NULL,NULL,NULL,NULL,'7c4a7f23-0e6d-4687-885c-13561c3855be'),(33,2,'Settings',NULL,NULL,NULL,'update',1,'2024-08-16 20:07:48',2,2,'Settings','---\nproduct:\n- connect\n- enterprise\n',NULL,NULL,NULL,NULL,'ff22cb89-0116-4f45-b361-c543c3bf6fa5'),(34,2,'Service',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:49',2,2,'Service','---\naccount_id: 2\nname: API\ndescription: \ntxt_support: \ncreated_at: \'2024-08-16T20:05:20Z\'\nlogo_file_name: \nlogo_content_type: \nlogo_file_size: \nstate: incomplete\nintentions_required: false\nterms: \nbuyers_manage_apps: true\nbuyers_manage_keys: true\ncustom_keys_enabled: true\nbuyer_plan_change_permission: request\nbuyer_can_select_plan: false\nnotification_settings: \ndefault_application_plan_id: \ndefault_service_plan_id: \ntenant_id: \nsystem_name: api\nbackend_version: \'1\'\nmandatory_app_key: true\nbuyer_key_regenerate_enabled: true\nsupport_email: \nreferrer_filters_required: false\ndeployment_option: hosted\nkubernetes_service_link: \n',NULL,NULL,NULL,NULL,'1e8ee885-152e-496c-99c4-5862c9f9ee0a'),(35,6,'Metric',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:49',2,2,'Metric','---\nsystem_name: hits\ndescription: Number of API hits\nunit: hit\ncreated_at: \'2024-08-16T20:05:20Z\'\nservice_id: 2\nfriendly_name: Hits\nparent_id: \ntenant_id: \nowner_id: 2\nowner_type: Service\n',NULL,NULL,NULL,NULL,'d8c3e085-10ea-4baf-9a32-09c560eec348'),(36,2,'Settings',NULL,NULL,NULL,'update',2,'2024-08-16 20:07:49',2,2,'Settings','---\naccount_plans_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,NULL,'d9cd6804-7e72-4c6c-bb8e-55c1d485a77e'),(37,2,'Settings',NULL,NULL,NULL,'update',3,'2024-08-16 20:07:49',2,2,'Settings','---\nmultiple_users_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,NULL,'3574b947-90f9-424c-8c52-5c3eb5bd5ad2'),(38,2,'Settings',NULL,NULL,NULL,'update',3,'2024-08-16 20:07:49',2,2,'Settings','---\nfinance_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,NULL,'b8d3f9b1-8424-448c-92bc-05b3ea6de709'),(39,2,'Settings',NULL,NULL,NULL,'update',4,'2024-08-16 20:07:49',2,2,'Settings','---\nfinance_switch:\n- hidden\n- visible\n',NULL,NULL,NULL,NULL,'8de3e497-830d-4e2d-802a-f6dbee66d3c0'),(40,2,'Settings',NULL,NULL,NULL,'update',4,'2024-08-16 20:07:49',2,2,'Settings','---\nmultiple_applications_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,NULL,'00fcdd1b-a256-4f6c-a4cd-b4afec77becd'),(41,2,'Settings',NULL,NULL,NULL,'update',4,'2024-08-16 20:07:49',2,2,'Settings','---\nbranding_switch:\n- hidden\n- visible\n',NULL,NULL,NULL,NULL,'67b2dbe5-5db8-4cf0-ac47-fbabf239fc9d'),(42,2,'Settings',NULL,NULL,NULL,'update',4,'2024-08-16 20:07:49',2,2,'Settings','---\ngroups_switch:\n- hidden\n- visible\n',NULL,NULL,NULL,NULL,'cd6ea8ff-0093-4a80-badf-57e7807e3070'),(43,2,'Settings',NULL,NULL,NULL,'update',4,'2024-08-16 20:07:49',2,2,'Settings','---\nbranding_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,NULL,'990fd2b6-a3ca-4d48-ba65-3fdfa603c9c4'),(44,5,'Metric',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:49',NULL,1,'Metric','---\nsystem_name: analytics\ndescription: \nunit: hit\ncreated_at: \'2024-08-16T20:05:20Z\'\nservice_id: 1\nfriendly_name: Analytics API\nparent_id: \ntenant_id: \nowner_id: 1\nowner_type: Service\n',NULL,NULL,NULL,NULL,'f269f3a6-3390-47df-8aff-65e4b0854d69'),(45,2,'Settings',NULL,NULL,NULL,'update',5,'2024-08-16 20:07:49',2,2,'Settings','---\nmultiple_services_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,NULL,'0bd563db-479f-4c4a-957f-672aa9a8174b'),(46,2,'Settings',NULL,NULL,NULL,'update',5,'2024-08-16 20:07:49',2,2,'Settings','---\nrequire_cc_on_signup_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,NULL,'5dd39511-e316-4821-9f3e-e254ce407f73'),(47,2,'Settings',NULL,NULL,NULL,'update',5,'2024-08-16 20:07:49',2,2,'Settings','---\nrequire_cc_on_signup_switch:\n- hidden\n- visible\n',NULL,NULL,NULL,NULL,'6d1dc281-87e0-4fc2-8c6b-7f88187aed91'),(48,2,'Contract',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:49',NULL,1,'Cinstance','---\nplan_id: 4\nuser_account_id: 2\nuser_key: 48e9385e17a8a163e43f15ea9d4fa1d1\nprovider_public_key: b1f05d77432336afedd432f306f48e63\ncreated_at: \'2024-08-16T20:05:20Z\'\nstate: live\ndescription: Default application created on signup.\npaid_until: \napplication_id: 6faf60a1\nname: Provider Name\'s App\ntrial_period_expires_at: \'2024-08-16T20:05:20Z\'\nsetup_fee: \'0.0\'\nredirect_url: \nvariable_cost_paid_until: \nextra_fields: {}\ntenant_id: \ncreate_origin: \nfirst_traffic_at: \nfirst_daily_traffic_at: \nservice_id: 1\naccepted_at: \n',NULL,NULL,NULL,NULL,'c7c1692d-68d8-424d-aa05-2088d3b9b1fb'),(49,2,'Settings',NULL,NULL,NULL,'update',6,'2024-08-16 20:07:49',2,2,'Settings','---\ngroups_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,NULL,'c035ec18-223e-4850-b865-9789e1f0bc54'),(50,2,'Settings',NULL,NULL,NULL,'update',6,'2024-08-16 20:07:49',2,2,'Settings','---\nskip_email_engagement_footer_switch:\n- hidden\n- visible\n',NULL,NULL,NULL,NULL,'b1a30957-5b4f-41e4-b6a7-ab284553fbca'),(51,5,'Plan',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:49',2,2,'ServicePlan','---\nissuer_id: 2\nname: Default\nrights: \nfull_legal: \ncost_per_month: \'0.0\'\ntrial_period_days: \ncreated_at: \'2024-08-16T20:05:20Z\'\nposition: 1\nstate: published\ncancellation_period: 0\ncost_aggregation_rule: sum\nsetup_fee: \'0.0\'\nmaster: false\noriginal_id: 0\nissuer_type: Service\ndescription: \napproval_required: false\ntenant_id: \nsystem_name: default\npartner_id: \ncontracts_count: 0\n',NULL,NULL,NULL,NULL,'0d8df1de-31f3-497d-93ad-2db09fe6ee15'),(52,2,'Settings',NULL,NULL,NULL,'update',7,'2024-08-16 20:07:49',2,2,'Settings','---\nskip_email_engagement_footer_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,NULL,'9ffa32cf-fce0-491e-b677-b225eae4d2c8'),(53,2,'Settings',NULL,NULL,NULL,'update',8,'2024-08-16 20:07:49',2,2,'Settings','---\nweb_hooks_switch:\n- hidden\n- visible\n',NULL,NULL,NULL,NULL,'ced93cbf-0435-4aab-a76e-7b30dcf6681c'),(54,2,'BackendApi',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:49',NULL,NULL,'BackendApi','---\nname: API Backend\nsystem_name: api\ndescription: Backend of API\nprivate_endpoint: https://echo-api.3scale.net:443\naccount_id: 2\ncreated_at: \'2024-08-16T20:05:20Z\'\ntenant_id: \nstate: published\n',NULL,NULL,NULL,NULL,'123eeb51-2122-42c0-b229-0bb29d12bd99'),(55,2,'Settings',NULL,NULL,NULL,'update',8,'2024-08-16 20:07:49',2,2,'Settings','---\niam_tools_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,NULL,'6180227a-74b4-45a4-a4a4-5fbe9897e88b'),(56,2,'Settings',NULL,NULL,NULL,'update',9,'2024-08-16 20:07:49',2,2,'Settings','---\nmultiple_services_switch:\n- hidden\n- visible\n',NULL,NULL,NULL,NULL,'fdd15fd2-4d9a-48b0-9d22-89f8b701baf7'),(57,2,'Settings',NULL,NULL,NULL,'update',9,'2024-08-16 20:07:49',2,2,'Settings','---\nmultiple_applications_switch:\n- hidden\n- visible\n',NULL,NULL,NULL,NULL,'91b92ab7-b8ae-4b41-96cb-d1e302896c03'),(58,7,'Metric',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:49',NULL,NULL,'Metric','---\nsystem_name: hits.2\ndescription: Number of API hits\nunit: hit\ncreated_at: \'2024-08-16T20:05:20Z\'\nservice_id: \nfriendly_name: Hits\nparent_id: \ntenant_id: \nowner_id: 2\nowner_type: BackendApi\n',NULL,NULL,NULL,NULL,'568c158e-8839-4cb6-ba9e-3653f1e249cd'),(59,2,'Settings',NULL,NULL,NULL,'update',10,'2024-08-16 20:07:49',2,2,'Settings','---\nmultiple_users_switch:\n- hidden\n- visible\n',NULL,NULL,NULL,NULL,'681f175c-636f-4bab-b45b-3ba7d6e6e832'),(60,2,'Settings',NULL,NULL,NULL,'update',10,'2024-08-16 20:07:49',2,2,'Settings','---\nskip_email_engagement_footer_switch:\n- visible\n- hidden\n',NULL,NULL,NULL,NULL,'2ddabc1e-e754-4484-b592-c55207b9a1e6'),(61,2,'Settings',NULL,NULL,NULL,'update',10,'2024-08-16 20:07:49',2,2,'Settings','---\nservice_plans_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,NULL,'fc9ff00a-0e06-496c-aaf7-d9d5ffb37243'),(62,2,'User',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:49',NULL,1,'User','---\nusername: admin\nemail: admin@3scale.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com\ncreated_at: \'2024-08-16T20:05:20Z\'\nremember_token: \nremember_token_expires_at: \nactivation_code: 2591ec0615262f62972622afd78427079f44a76b\nactivated_at: \nstate: pending\nrole: admin\nlost_password_token: \naccount_id: 2\nfirst_name: \nlast_name: \nsignup_type: minimal\njob_role: \nemail_verification_code: \ntitle: \nextra_fields: {}\ntenant_id: \nlost_password_token_generated_at: \n',NULL,NULL,NULL,NULL,'74e51338-dc71-42f0-8aa7-f2921f50cdd1'),(63,2,'User',NULL,NULL,NULL,'update',1,'2024-08-16 20:07:49',NULL,1,'User','---\nactivation_code:\n- 2591ec0615262f62972622afd78427079f44a76b\n- \nactivated_at:\n- \n- \'2024-08-16T20:05:20Z\'\nstate:\n- pending\n- active\n',NULL,NULL,NULL,NULL,'088b8c4a-1a76-4b17-af2e-271f625d10eb'),(64,2,'Settings',NULL,NULL,NULL,'update',11,'2024-08-16 20:07:49',2,2,'Settings','---\nweb_hooks_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,NULL,'da6de54a-223d-414a-bc6e-3eaf14c0baa1'),(65,1,'ProviderConstraints',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:49',2,2,'ProviderConstraints','---\ntenant_id: \nprovider_id: 2\nmax_users: \nmax_services: \ncreated_at: \'2024-08-16T20:05:21Z\'\n',NULL,NULL,NULL,NULL,'bbee95dc-9d56-4d6b-beef-e11f560e7416'),(66,3,'User',NULL,NULL,NULL,'update',1,'2024-08-16 20:07:49',NULL,1,'User','---\nactivation_code:\n- 379cc3dcc613ffccfa4e7913f0ab765c65ddc1f9\n- \nactivated_at:\n- \n- \'2024-08-16T20:05:20Z\'\nstate:\n- pending\n- active\n',NULL,NULL,NULL,NULL,'5ec5fa88-3855-43ae-a051-483d79de815a'),(67,2,'AccessToken',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:49',NULL,1,'AccessToken','---\nowner_id: 1\nscopes:\n- account_management\nname: Master Token\npermission: rw\ncreated_at: \'2024-08-16T20:05:20Z\'\nupdated_at: \'2024-08-16T20:05:20Z\'\n',NULL,NULL,NULL,NULL,'8c282054-a02c-4cfc-a255-fc8d6e14dc11'),(68,1,'ProviderConstraints',NULL,NULL,NULL,'update',2,'2024-08-16 20:07:49',2,2,'ProviderConstraints','---\nmax_services:\n- \n- 3\n','Upgrading max_services because of switch is enabled.',NULL,NULL,NULL,'cd7ee694-e394-4588-99ee-98c069dc00d9'),(69,3,'AccessToken',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:49',2,2,'AccessToken','---\nowner_id: 2\nscopes:\n- cms\n- finance\n- account_management\n- stats\n- policy_registry\nname: Administration\npermission: rw\ncreated_at: \'2024-08-16T20:05:20Z\'\nupdated_at: \'2024-08-16T20:05:20Z\'\n',NULL,NULL,NULL,NULL,'f4d4a80b-c282-4d34-acc3-a1b3507ad2f5'),(70,1,'ProviderConstraints',NULL,NULL,NULL,'update',2,'2024-08-16 20:07:49',2,2,'ProviderConstraints','---\nmax_services:\n- 3\n- \n','Upgrading limits to match plan enterprise',NULL,NULL,NULL,'dbad062c-ec64-4e97-9f2a-879709d57913'),(71,1,'Finance::BillingStrategy',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:49',2,2,'Finance::PostpaidBillingStrategy','---\naccount_id: 2\nprepaid: false\ncharging_enabled: false\ncharging_retry_delay: 3\ncharging_retry_times: 3\ncreated_at: \'2024-08-16T20:05:20Z\'\nnumbering_period: monthly\ncurrency: USD\ntenant_id: \ntype: Finance::PostpaidBillingStrategy\n',NULL,NULL,NULL,NULL,'b7d6ed9b-ead1-4b2d-9750-c3b3cdda71e7'),(72,1,'AccessToken',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:49',NULL,1,'AccessToken','---\nowner_id: 1\nscopes:\n- account_management\nname: APIcast\npermission: ro\ncreated_at: \'2024-08-16T20:05:20Z\'\nupdated_at: \'2024-08-16T20:05:20Z\'\n',NULL,NULL,NULL,NULL,'e447d7f8-261a-423a-8e02-dc661ea8f718'),(73,3,'User',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:50',NULL,1,'User','---\nusername: 3scaleadmin\nemail: 3scaleadmin+3scale-admin.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com@3scale.net\ncreated_at: \'2024-08-16T20:05:20Z\'\nremember_token: \nremember_token_expires_at: \nactivation_code: 379cc3dcc613ffccfa4e7913f0ab765c65ddc1f9\nactivated_at: \nstate: pending\nrole: admin\nlost_password_token: \naccount_id: 2\nfirst_name: 3scale\nlast_name: Admin\nsignup_type: minimal\njob_role: \nemail_verification_code: \ntitle: \nextra_fields: {}\ntenant_id: \nlost_password_token_generated_at: \n',NULL,NULL,NULL,NULL,'f5426d04-197b-47fb-a58e-b667fa272631'),(74,4,'AccessToken',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:50',NULL,1,'AccessToken','---\nowner_id: 1\nscopes:\n- account_management\nname: OIDC Synchronization Token\npermission: ro\ncreated_at: \'2024-08-16T20:07:50Z\'\nupdated_at: \'2024-08-16T20:07:50Z\'\n',NULL,NULL,NULL,NULL,'58170f72-aa05-48d3-8287-501859d522e4'),(75,5,'AccessToken',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:50',2,2,'AccessToken','---\nowner_id: 3\nscopes:\n- account_management\nname: OIDC Synchronization Token\npermission: ro\ncreated_at: \'2024-08-16T20:07:50Z\'\nupdated_at: \'2024-08-16T20:07:50Z\'\n',NULL,NULL,NULL,NULL,'73bf800b-c55b-4210-afc3-9fd0c4b8af0e'),(76,6,'AccessToken',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:50',NULL,1,'AccessToken','---\nowner_id: 1\nscopes:\n- account_management\nname: OIDC Synchronization Token\npermission: ro\ncreated_at: \'2024-08-16T20:07:50Z\'\nupdated_at: \'2024-08-16T20:07:50Z\'\n',NULL,NULL,NULL,NULL,'ee58f4e4-80ef-437e-981d-f89a3d27103a'),(77,7,'AccessToken',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:50',NULL,1,'AccessToken','---\nowner_id: 1\nscopes:\n- account_management\nname: OIDC Synchronization Token\npermission: ro\ncreated_at: \'2024-08-16T20:07:50Z\'\nupdated_at: \'2024-08-16T20:07:50Z\'\n',NULL,NULL,NULL,NULL,'7026fc41-4d86-4eb5-b5de-6e282becd93a'),(78,6,'Plan',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:52',2,2,'AccountPlan','---\nissuer_id: 2\nname: Default\nrights: \nfull_legal: \ncost_per_month: \'0.0\'\ntrial_period_days: \ncreated_at: \'2024-08-16T20:07:48Z\'\nposition: 1\nstate: hidden\ncancellation_period: 0\ncost_aggregation_rule: sum\nsetup_fee: \'0.0\'\nmaster: false\noriginal_id: 0\nissuer_type: Account\ndescription: \napproval_required: false\ntenant_id: \nsystem_name: default\npartner_id: \ncontracts_count: 0\n',NULL,NULL,NULL,NULL,'293ab109-032e-4b85-9ee9-cff9aeeb8238'),(79,2,'Account',NULL,NULL,NULL,'update',2,'2024-08-16 20:07:52',2,2,'Account','---\ndefault_account_plan_id:\n- \n- 6\n',NULL,NULL,NULL,NULL,'8377782e-f6a5-4355-85cd-758e7a5e950d'),(80,2,'Service',NULL,NULL,NULL,'update',2,'2024-08-16 20:07:52',2,2,'Service','---\ndefault_service_plan_id:\n- \n- 5\n',NULL,NULL,NULL,NULL,'b14f6be2-7c72-42d1-be8a-a027e79c0370'),(81,2,'Service',NULL,NULL,NULL,'update',2,'2024-08-16 20:07:52',2,2,'Service','---\ndefault_application_plan_id:\n- \n- 7\n',NULL,NULL,NULL,NULL,'2526db88-05c2-4f8b-b50f-5a52332c8ff0'),(82,1,'Feature',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:52',2,2,'Feature','---\nfeaturable_id: 2\nname: Unlimited Greetings\ndescription: \ncreated_at: \'2024-08-16T20:07:48Z\'\nsystem_name: unlimited_greetings\nvisible: true\nfeaturable_type: Service\nscope: ApplicationPlan\ntenant_id: \n',NULL,NULL,NULL,NULL,'3c032359-aa12-48d5-afd0-b8c7523e96e4'),(83,7,'Plan',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:52',2,2,'ApplicationPlan','---\nissuer_id: 2\nname: Basic\nrights: \nfull_legal: \ncost_per_month: \'0.0\'\ntrial_period_days: \ncreated_at: \'2024-08-16T20:07:48Z\'\nposition: 2\nstate: hidden\ncancellation_period: 0\ncost_aggregation_rule: sum\nsetup_fee: \'0.0\'\nmaster: false\noriginal_id: 0\nissuer_type: Service\ndescription: \napproval_required: false\ntenant_id: \nsystem_name: basic\npartner_id: \ncontracts_count: 0\n',NULL,NULL,NULL,NULL,'eec87c67-5ee6-4bf4-9262-a0aa48420cad'),(84,7,'Plan',NULL,NULL,NULL,'update',1,'2024-08-16 20:07:52',2,2,'ApplicationPlan','---\nstate:\n- hidden\n- published\n',NULL,NULL,NULL,NULL,'532e829c-b8d8-4590-8e5e-492dfbc00efe'),(85,2,'Feature',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:52',2,2,'Feature','---\nfeaturable_id: 2\nname: 24/7 support\ndescription: \ncreated_at: \'2024-08-16T20:07:48Z\'\nsystem_name: 24_7_support\nvisible: true\nfeaturable_type: Service\nscope: ApplicationPlan\ntenant_id: \n',NULL,NULL,NULL,NULL,'9b8842e6-7453-4591-a8d3-178546e4f501'),(86,8,'Plan',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:52',2,2,'ApplicationPlan','---\nissuer_id: 2\nname: Unlimited\nrights: \nfull_legal: \ncost_per_month: \'0.0\'\ntrial_period_days: \ncreated_at: \'2024-08-16T20:07:49Z\'\nposition: 3\nstate: hidden\ncancellation_period: 0\ncost_aggregation_rule: sum\nsetup_fee: \'0.0\'\nmaster: false\noriginal_id: 0\nissuer_type: Service\ndescription: \napproval_required: false\ntenant_id: \nsystem_name: unlimited\npartner_id: \ncontracts_count: 0\n',NULL,NULL,NULL,NULL,'14184149-afbc-4a5a-b6b3-db7a8c9956f4'),(87,3,'Feature',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:52',2,2,'Feature','---\nfeaturable_id: 2\nname: Unlimited calls\ndescription: \ncreated_at: \'2024-08-16T20:07:49Z\'\nsystem_name: unlimited_calls\nvisible: true\nfeaturable_type: Service\nscope: ApplicationPlan\ntenant_id: \n',NULL,NULL,NULL,NULL,'8bc83ebe-8837-4a40-946b-dc628f9ade87'),(88,8,'Plan',NULL,NULL,NULL,'update',1,'2024-08-16 20:07:52',2,2,'ApplicationPlan','---\nstate:\n- hidden\n- published\n',NULL,NULL,NULL,NULL,'f998c888-59bc-46fc-9c01-250614304140'),(89,3,'Account',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:52',2,2,'Account','---\norg_name: Developer\norg_legaladdress: \'\'\ncreated_at: \'2024-08-16T20:07:49Z\'\nprovider: false\nbuyer: true\ncountry_id: \nprovider_account_id: 2\ndomain: \ntelephone_number: \nsite_access_code: \ncredit_card_partial_number: \ncredit_card_expires_on: \ncredit_card_auth_code: \nmaster: \nbilling_address_name: \nbilling_address_address1: \nbilling_address_address2: \nbilling_address_city: \nbilling_address_state: \nbilling_address_country: \nbilling_address_zip: \nbilling_address_phone: \norg_legaladdress_cont: \ncity: \nstate_region: \nstate: created\npaid: false\npaid_at: \nsigns_legal_terms: true\ntimezone: \ndelta: true\nfrom_email: \nprimary_business: \nbusiness_category: \nzip: \nextra_fields: {}\nvat_code: \nfiscal_code: \nvat_rate: \ninvoice_footnote: \nvat_zero_text: \ndefault_account_plan_id: \ndefault_service_id: \ncredit_card_authorize_net_payment_profile_token: \ntenant_id: \nself_domain: \ns3_prefix: \nprepared_assets_version: \nsample_data: \nsupport_email: \nfinance_support_email: \nbilling_address_first_name: \nbilling_address_last_name: \nemail_all_users: false\npartner_id: \nhosted_proxy_deployed_at: \npo_number: \nstate_changed_at: \n',NULL,NULL,NULL,NULL,'376d5459-884e-4405-8a45-3828f568c84a'),(90,3,'Account',NULL,NULL,NULL,'update',1,'2024-08-16 20:07:52',2,2,'Account','---\nstate_changed_at:\n- \n- \'2024-08-16T20:07:51Z\'\n',NULL,NULL,NULL,NULL,'9a813663-dc88-470a-be18-79f08f285ad3'),(91,3,'Account',NULL,NULL,NULL,'update',2,'2024-08-16 20:07:52',2,2,'Account','---\nstate:\n- created\n- approved\n',NULL,NULL,NULL,NULL,'5459b38e-7cd0-4355-8561-d7702ba0c5fb'),(92,4,'User',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:52',2,2,'User','---\nusername: john\nemail: admin+test@3scale.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com\ncreated_at: \'2024-08-16T20:07:51Z\'\nremember_token: \nremember_token_expires_at: \nactivation_code: 41c02769b6bb43959a88d81546013922af967c6d\nactivated_at: \nstate: pending\nrole: admin\nlost_password_token: \naccount_id: 3\nfirst_name: John\nlast_name: Doe\nsignup_type: minimal\njob_role: \nemail_verification_code: \ntitle: \nextra_fields: {}\ntenant_id: \nlost_password_token_generated_at: \n',NULL,NULL,NULL,NULL,'b16099a4-60ff-4d58-bf5e-6d04dc23b467'),(93,4,'Contract',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:52',2,2,'ServiceContract','---\nplan_id: 5\nuser_account_id: 3\nuser_key: \nprovider_public_key: \ncreated_at: \'2024-08-16T20:07:51Z\'\nstate: live\ndescription: \npaid_until: \napplication_id: \nname: \ntrial_period_expires_at: \'2024-08-16T20:07:51Z\'\nsetup_fee: \'0.0\'\nredirect_url: \nvariable_cost_paid_until: \nextra_fields: \ntenant_id: \ncreate_origin: \nfirst_traffic_at: \nfirst_daily_traffic_at: \nservice_id: 2\naccepted_at: \n',NULL,NULL,NULL,NULL,'976cc47b-8b9b-48ae-a022-1846c600f6d9'),(94,3,'Contract',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:52',2,2,'AccountContract','---\nplan_id: 6\nuser_account_id: 3\nuser_key: \nprovider_public_key: \ncreated_at: \'2024-08-16T20:07:51Z\'\nstate: pending\ndescription: \npaid_until: \napplication_id: \nname: \ntrial_period_expires_at: \'2024-08-16T20:07:51Z\'\nsetup_fee: \'0.0\'\nredirect_url: \nvariable_cost_paid_until: \nextra_fields: \ntenant_id: \ncreate_origin: \nfirst_traffic_at: \nfirst_daily_traffic_at: \nservice_id: \naccepted_at: \n',NULL,NULL,NULL,NULL,'a3cdce66-a946-4dd4-a51f-c67e7f191393'),(95,4,'User',NULL,NULL,NULL,'update',2,'2024-08-16 20:07:52',2,2,'User','---\nactivation_code:\n- 41c02769b6bb43959a88d81546013922af967c6d\n- \nactivated_at:\n- \n- \'2024-08-16T20:07:51Z\'\nstate:\n- pending\n- active\n',NULL,NULL,NULL,NULL,'9d0b2986-424f-4994-a15c-605956f135e3'),(96,5,'Contract',NULL,NULL,NULL,'create',1,'2024-08-16 20:07:52',2,2,'Cinstance','---\nplan_id: 7\nuser_account_id: 3\nuser_key: d86fc3b47ed5ab6e432e945d56fea756\nprovider_public_key: 105b4959448cc8a8d681369ca7be5068\ncreated_at: \'2024-08-16T20:07:51Z\'\nstate: live\ndescription: Default application created on signup.\npaid_until: \napplication_id: db3bec09\nname: Developer\'s App\ntrial_period_expires_at: \'2024-08-16T20:07:51Z\'\nsetup_fee: \'0.0\'\nredirect_url: \nvariable_cost_paid_until: \nextra_fields: {}\ntenant_id: \ncreate_origin: \nfirst_traffic_at: \nfirst_daily_traffic_at: \nservice_id: 2\naccepted_at: \n',NULL,NULL,NULL,NULL,'37e5d9d1-aab8-4b72-b771-dbbe83f05ae2'),(97,4,'Account',1,'User',NULL,'create',1,'2024-08-16 20:12:25',4,4,'Account','---\norg_name: Demo Organization\norg_legaladdress: \'\'\ncreated_at: \'2024-08-16T20:12:24Z\'\nprovider: true\nbuyer: false\ncountry_id: \nprovider_account_id: 1\ndomain: demo-organization.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com\ntelephone_number: \nsite_access_code: 620dbf6214\ncredit_card_partial_number: \ncredit_card_expires_on: \ncredit_card_auth_code: \nmaster: \nbilling_address_name: \nbilling_address_address1: \nbilling_address_address2: \nbilling_address_city: \nbilling_address_state: \nbilling_address_country: \nbilling_address_zip: \nbilling_address_phone: \norg_legaladdress_cont: \ncity: \nstate_region: \nstate: created\npaid: false\npaid_at: \nsigns_legal_terms: true\ntimezone: \ndelta: true\nfrom_email: \nprimary_business: \nbusiness_category: \nzip: \nextra_fields: {}\nvat_code: \nfiscal_code: \nvat_rate: \ninvoice_footnote: \nvat_zero_text: \ndefault_account_plan_id: \ndefault_service_id: \ncredit_card_authorize_net_payment_profile_token: \ntenant_id: 4\nself_domain: demo-organization-admin.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com\ns3_prefix: demo-organization\nprepared_assets_version: \nsample_data: true\nsupport_email: \nfinance_support_email: \nbilling_address_first_name: \nbilling_address_last_name: \nemail_all_users: true\npartner_id: \nhosted_proxy_deployed_at: \npo_number: \nstate_changed_at: \n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(98,5,'User',1,'User',NULL,'create',1,'2024-08-16 20:12:25',NULL,1,'User','---\nusername: 3scale-user\nemail: 3scale-user@demo-organization.com\ncreated_at: \'2024-08-16T20:12:24Z\'\nremember_token: \nremember_token_expires_at: \nactivation_code: d3aa45a2186a3d40ae56a3558b469a264090fa48\nactivated_at: \nstate: pending\nrole: admin\nlost_password_token: \naccount_id: 4\nfirst_name: \nlast_name: \nsignup_type: created_by_provider\njob_role: \nemail_verification_code: \ntitle: \nextra_fields: {}\ntenant_id: \nlost_password_token_generated_at: \n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(99,6,'User',1,'User',NULL,'create',1,'2024-08-16 20:12:25',NULL,1,'User','---\nusername: 3scaleadmin\nemail: 3scaleadmin+demo-organization.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com@3scale.net\ncreated_at: \'2024-08-16T20:12:24Z\'\nremember_token: \nremember_token_expires_at: \nactivation_code: 70a9fbb36058422bfc64b0f1b9abdeadbe5d410a\nactivated_at: \nstate: active\nrole: admin\nlost_password_token: \naccount_id: 4\nfirst_name: 3scale\nlast_name: Admin\nsignup_type: minimal\njob_role: \nemail_verification_code: \ntitle: \nextra_fields: {}\ntenant_id: \nlost_password_token_generated_at: \n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(100,6,'Contract',1,'User',NULL,'create',1,'2024-08-16 20:12:25',NULL,1,'AccountContract','---\nplan_id: 3\nuser_account_id: 4\nuser_key: \nprovider_public_key: \ncreated_at: \'2024-08-16T20:12:24Z\'\nstate: pending\ndescription: \npaid_until: \napplication_id: \nname: \ntrial_period_expires_at: \'2024-08-16T20:12:24Z\'\nsetup_fee: \'0.0\'\nredirect_url: \nvariable_cost_paid_until: \nextra_fields: \ntenant_id: \ncreate_origin: \nfirst_traffic_at: \nfirst_daily_traffic_at: \nservice_id: \naccepted_at: \n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(101,8,'AccessToken',NULL,NULL,NULL,'create',1,'2024-08-16 20:12:25',4,4,'AccessToken','---\nowner_id: 6\nscopes:\n- account_management\nname: OIDC Synchronization Token\npermission: ro\ncreated_at: \'2024-08-16T20:12:25Z\'\nupdated_at: \'2024-08-16T20:12:25Z\'\n',NULL,NULL,NULL,NULL,'0e4a5062-7129-4782-8342-f06d36ca1889'),(102,7,'Contract',1,'User',NULL,'create',1,'2024-08-16 20:12:25',NULL,1,'ServiceContract','---\nplan_id: 1\nuser_account_id: 4\nuser_key: \nprovider_public_key: \ncreated_at: \'2024-08-16T20:12:24Z\'\nstate: live\ndescription: \npaid_until: \napplication_id: \nname: \ntrial_period_expires_at: \'2024-08-16T20:12:24Z\'\nsetup_fee: \'0.0\'\nredirect_url: \nvariable_cost_paid_until: \nextra_fields: \ntenant_id: \ncreate_origin: \nfirst_traffic_at: \nfirst_daily_traffic_at: \nservice_id: 1\naccepted_at: \n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(103,8,'Contract',1,'User',NULL,'create',1,'2024-08-16 20:12:25',NULL,1,'Cinstance','---\nplan_id: 4\nuser_account_id: 4\nuser_key: 0f978993e3f9968bdbf99344f780e483\nprovider_public_key: 68c08c104a68888f096c975e10305a33\ncreated_at: \'2024-08-16T20:12:24Z\'\nstate: live\ndescription: Default application created on signup.\npaid_until: \napplication_id: a18de20f\nname: Demo Organization\'s App\ntrial_period_expires_at: \'2024-08-16T20:12:24Z\'\nsetup_fee: \'0.0\'\nredirect_url: \nvariable_cost_paid_until: \nextra_fields: {}\ntenant_id: \ncreate_origin: \nfirst_traffic_at: \nfirst_daily_traffic_at: \nservice_id: 1\naccepted_at: \n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(104,3,'Service',1,'User',NULL,'create',1,'2024-08-16 20:12:25',4,4,'Service','---\naccount_id: 4\nname: API\ndescription: \ntxt_support: \ncreated_at: \'2024-08-16T20:12:24Z\'\nlogo_file_name: \nlogo_content_type: \nlogo_file_size: \nstate: incomplete\nintentions_required: false\nterms: \nbuyers_manage_apps: true\nbuyers_manage_keys: true\ncustom_keys_enabled: true\nbuyer_plan_change_permission: request\nbuyer_can_select_plan: false\nnotification_settings: \ndefault_application_plan_id: \ndefault_service_plan_id: \ntenant_id: \nsystem_name: api\nbackend_version: \'1\'\nmandatory_app_key: true\nbuyer_key_regenerate_enabled: true\nsupport_email: \nreferrer_filters_required: false\ndeployment_option: hosted\nkubernetes_service_link: \n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(105,8,'Metric',1,'User',NULL,'create',1,'2024-08-16 20:12:25',4,4,'Metric','---\nsystem_name: hits\ndescription: Number of API hits\nunit: hit\ncreated_at: \'2024-08-16T20:12:24Z\'\nservice_id: 3\nfriendly_name: Hits\nparent_id: \ntenant_id: \nowner_id: 3\nowner_type: Service\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(106,3,'Settings',1,'User',NULL,'create',1,'2024-08-16 20:12:25',4,4,'Settings','---\naccount_id: 4\nbg_colour: \nlink_colour: \ntext_colour: \ncreated_at: \'2024-08-16T20:12:24Z\'\nmenu_bg_colour: \nlink_label: \nlink_url: \nwelcome_text: \nmenu_link_colour: \ncontent_bg_colour: \ntracker_code: \nfavicon: \nplans_tab_bg_colour: \nplans_bg_colour: \ncontent_border_colour: \nforum_enabled: false\napp_gallery_enabled: false\nanonymous_posts_enabled: false\nsignups_enabled: true\ndocumentation_enabled: true\nuseraccountarea_enabled: true\nrefund_policy: \nprivacy_policy: \nmonthly_charging_enabled: true\ntoken_api: default\ndocumentation_public: true\nforum_public: false\nhide_service: \ncc_terms_path: \"/termsofservice\"\ncc_privacy_path: \"/privacypolicy\"\ncc_refunds_path: \"/refundpolicy\"\nchange_account_plan_permission: request\nstrong_passwords_enabled: false\nchange_service_plan_permission: request\ncan_create_service: false\nspam_protection_level: none\ntenant_id: \nmultiple_applications_switch: denied\nmultiple_users_switch: denied\nfinance_switch: denied\nmultiple_services_switch: denied\ngroups_switch: denied\naccount_plans_switch: denied\nauthentication_strategy: oauth2\njanrain_api_key: \njanrain_relying_party: \nservice_plans_switch: denied\npublic_search: false\nproduct: connect\nbranding_switch: denied\nmonthly_billing_enabled: true\ncms_token: \ncas_server_url: \nsso_key: 35b5c2d45d04410ad80df8ea6757f56271073e4f54145916eea36d5b536bdaf6\nsso_login_url: \ncms_escape_draft_html: true\ncms_escape_published_html: true\nheroku_id: \nheroku_name: \nsetup_fee_enabled: false\naccount_plans_ui_visible: false\nservice_plans_ui_visible: false\nskip_email_engagement_footer_switch: denied\nweb_hooks_switch: denied\niam_tools_switch: denied\nrequire_cc_on_signup_switch: denied\nenforce_sso: false\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(107,3,'Settings',1,'User',NULL,'update',1,'2024-08-16 20:12:25',4,4,'Settings','---\nfinance_switch:\n- hidden\n- visible\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(108,3,'Settings',1,'User',NULL,'update',1,'2024-08-16 20:12:25',4,4,'Settings','---\nmultiple_users_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(109,3,'Settings',1,'User',NULL,'update',1,'2024-08-16 20:12:25',4,4,'Settings','---\ngroups_switch:\n- hidden\n- visible\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(110,3,'Settings',1,'User',NULL,'update',1,'2024-08-16 20:12:25',4,4,'Settings','---\ngroups_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(111,3,'Settings',1,'User',NULL,'update',1,'2024-08-16 20:12:25',4,4,'Settings','---\nbranding_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(112,3,'Settings',1,'User',NULL,'update',2,'2024-08-16 20:12:25',4,4,'Settings','---\nrequire_cc_on_signup_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(113,3,'Settings',1,'User',NULL,'update',2,'2024-08-16 20:12:25',4,4,'Settings','---\naccount_plans_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(114,3,'Settings',1,'User',NULL,'update',2,'2024-08-16 20:12:25',4,4,'Settings','---\nservice_plans_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(115,3,'Settings',1,'User',NULL,'update',2,'2024-08-16 20:12:25',4,4,'Settings','---\nmultiple_services_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(116,3,'Settings',1,'User',NULL,'update',2,'2024-08-16 20:12:25',4,4,'Settings','---\nskip_email_engagement_footer_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(117,3,'Settings',1,'User',NULL,'update',3,'2024-08-16 20:12:25',4,4,'Settings','---\nfinance_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(118,3,'Settings',1,'User',NULL,'update',3,'2024-08-16 20:12:25',4,4,'Settings','---\nweb_hooks_switch:\n- hidden\n- visible\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(119,3,'Settings',1,'User',NULL,'update',3,'2024-08-16 20:12:25',4,4,'Settings','---\nweb_hooks_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(120,3,'Settings',1,'User',NULL,'update',3,'2024-08-16 20:12:25',4,4,'Settings','---\nbranding_switch:\n- hidden\n- visible\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(121,9,'Plan',1,'User',NULL,'create',1,'2024-08-16 20:12:25',4,4,'ServicePlan','---\nissuer_id: 3\nname: Default\nrights: \nfull_legal: \ncost_per_month: \'0.0\'\ntrial_period_days: \ncreated_at: \'2024-08-16T20:12:25Z\'\nposition: 1\nstate: published\ncancellation_period: 0\ncost_aggregation_rule: sum\nsetup_fee: \'0.0\'\nmaster: false\noriginal_id: 0\nissuer_type: Service\ndescription: \napproval_required: false\ntenant_id: \nsystem_name: default\npartner_id: \ncontracts_count: 0\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(122,3,'Settings',1,'User',NULL,'update',4,'2024-08-16 20:12:25',4,4,'Settings','---\nmultiple_applications_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(123,3,'Settings',1,'User',NULL,'update',4,'2024-08-16 20:12:25',4,4,'Settings','---\niam_tools_switch:\n- denied\n- hidden\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(124,9,'Metric',1,'User',NULL,'create',1,'2024-08-16 20:12:26',NULL,NULL,'Metric','---\nsystem_name: hits.3\ndescription: Number of API hits\nunit: hit\ncreated_at: \'2024-08-16T20:12:25Z\'\nservice_id: \nfriendly_name: Hits\nparent_id: \ntenant_id: \nowner_id: 3\nowner_type: BackendApi\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(125,3,'Settings',1,'User',NULL,'update',5,'2024-08-16 20:12:26',4,4,'Settings','---\nproduct:\n- connect\n- enterprise\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(126,2,'ProviderConstraints',1,'User',NULL,'update',1,'2024-08-16 20:12:26',4,4,'ProviderConstraints','---\nmax_services:\n- \n- 3\n','Upgrading max_services because of switch is enabled.',NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(127,3,'BackendApi',1,'User',NULL,'create',1,'2024-08-16 20:12:26',NULL,NULL,'BackendApi','---\nname: API Backend\nsystem_name: api\ndescription: Backend of API\nprivate_endpoint: https://echo-api.3scale.net:443\naccount_id: 4\ncreated_at: \'2024-08-16T20:12:25Z\'\ntenant_id: \nstate: published\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(128,3,'Settings',1,'User',NULL,'update',6,'2024-08-16 20:12:26',4,4,'Settings','---\nrequire_cc_on_signup_switch:\n- hidden\n- visible\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(129,2,'Finance::BillingStrategy',1,'User',NULL,'create',1,'2024-08-16 20:12:26',4,4,'Finance::PostpaidBillingStrategy','---\naccount_id: 4\nprepaid: false\ncharging_enabled: false\ncharging_retry_delay: 3\ncharging_retry_times: 3\ncreated_at: \'2024-08-16T20:12:25Z\'\nnumbering_period: monthly\ncurrency: USD\ntenant_id: \ntype: Finance::PostpaidBillingStrategy\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(130,6,'Contract',1,'User',NULL,'update',2,'2024-08-16 20:12:26',NULL,1,'AccountContract','---\nstate:\n- pending\n- live\naccepted_at:\n- \n- \'2024-08-16T20:12:25Z\'\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(131,3,'Settings',1,'User',NULL,'update',6,'2024-08-16 20:12:26',4,4,'Settings','---\nskip_email_engagement_footer_switch:\n- hidden\n- visible\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(132,4,'Account',1,'User',NULL,'update',2,'2024-08-16 20:12:26',4,4,'Account','---\nstate:\n- created\n- approved\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(133,2,'ProviderConstraints',1,'User',NULL,'create',1,'2024-08-16 20:12:26',4,4,'ProviderConstraints','---\ntenant_id: \nprovider_id: 4\nmax_users: \nmax_services: \ncreated_at: \'2024-08-16T20:12:25Z\'\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(134,2,'ProviderConstraints',1,'User',NULL,'update',2,'2024-08-16 20:12:26',4,4,'ProviderConstraints','---\nmax_services:\n- 3\n- \n','Upgrading limits to match plan enterprise',NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(135,4,'Account',1,'User',NULL,'update',3,'2024-08-16 20:12:26',4,4,'Account','---\nstate_changed_at:\n- \n- \'2024-08-16T20:12:25Z\'\n',NULL,NULL,NULL,'62.45.139.47','54e35a68-f3f1-4fb0-8737-43fee880f9ad'),(136,10,'Plan',NULL,NULL,NULL,'create',1,'2024-08-16 20:12:50',4,4,'AccountPlan','---\nissuer_id: 4\nname: Default\nrights: \nfull_legal: \ncost_per_month: \'0.0\'\ntrial_period_days: \ncreated_at: \'2024-08-16T20:12:48Z\'\nposition: 1\nstate: hidden\ncancellation_period: 0\ncost_aggregation_rule: sum\nsetup_fee: \'0.0\'\nmaster: false\noriginal_id: 0\nissuer_type: Account\ndescription: \napproval_required: false\ntenant_id: \nsystem_name: default\npartner_id: \ncontracts_count: 0\n',NULL,NULL,NULL,NULL,'5f4effcb-ae72-482c-92e8-15cee394b8d5'),(137,4,'Account',NULL,NULL,NULL,'update',4,'2024-08-16 20:12:50',4,4,'Account','---\ndefault_account_plan_id:\n- \n- 10\n',NULL,NULL,NULL,NULL,'e01e236d-0944-445b-ad9a-dccc530f56b8'),(138,3,'Service',NULL,NULL,NULL,'update',2,'2024-08-16 20:12:50',4,4,'Service','---\ndefault_service_plan_id:\n- \n- 9\n',NULL,NULL,NULL,NULL,'405684af-f13b-4849-826c-4fe84a85ecb6'),(139,3,'Service',NULL,NULL,NULL,'update',2,'2024-08-16 20:12:50',4,4,'Service','---\ndefault_application_plan_id:\n- \n- 11\n',NULL,NULL,NULL,NULL,'3274bc7d-42bf-46b7-ac86-ae397ee8cc2e'),(140,4,'Feature',NULL,NULL,NULL,'create',1,'2024-08-16 20:12:50',4,4,'Feature','---\nfeaturable_id: 3\nname: Unlimited Greetings\ndescription: \ncreated_at: \'2024-08-16T20:12:48Z\'\nsystem_name: unlimited_greetings\nvisible: true\nfeaturable_type: Service\nscope: ApplicationPlan\ntenant_id: \n',NULL,NULL,NULL,NULL,'87561743-3a14-4241-af30-764c55ea31f3'),(141,11,'Plan',NULL,NULL,NULL,'create',1,'2024-08-16 20:12:50',4,4,'ApplicationPlan','---\nissuer_id: 3\nname: Basic\nrights: \nfull_legal: \ncost_per_month: \'0.0\'\ntrial_period_days: \ncreated_at: \'2024-08-16T20:12:48Z\'\nposition: 2\nstate: hidden\ncancellation_period: 0\ncost_aggregation_rule: sum\nsetup_fee: \'0.0\'\nmaster: false\noriginal_id: 0\nissuer_type: Service\ndescription: \napproval_required: false\ntenant_id: \nsystem_name: basic\npartner_id: \ncontracts_count: 0\n',NULL,NULL,NULL,NULL,'5de02222-d701-41fc-b55e-4a936e1e0339'),(142,11,'Plan',NULL,NULL,NULL,'update',1,'2024-08-16 20:12:50',4,4,'ApplicationPlan','---\nstate:\n- hidden\n- published\n',NULL,NULL,NULL,NULL,'075c8d8a-860d-4a20-bd78-45b61c167a32'),(143,5,'Feature',NULL,NULL,NULL,'create',1,'2024-08-16 20:12:50',4,4,'Feature','---\nfeaturable_id: 3\nname: 24/7 support\ndescription: \ncreated_at: \'2024-08-16T20:12:48Z\'\nsystem_name: 24_7_support\nvisible: true\nfeaturable_type: Service\nscope: ApplicationPlan\ntenant_id: \n',NULL,NULL,NULL,NULL,'ce1db4a0-e896-4cc5-9c49-1b637f3a9c01'),(144,6,'Feature',NULL,NULL,NULL,'create',1,'2024-08-16 20:12:50',4,4,'Feature','---\nfeaturable_id: 3\nname: Unlimited calls\ndescription: \ncreated_at: \'2024-08-16T20:12:48Z\'\nsystem_name: unlimited_calls\nvisible: true\nfeaturable_type: Service\nscope: ApplicationPlan\ntenant_id: \n',NULL,NULL,NULL,NULL,'eae9eb26-a9d6-4610-b9f8-a5e688b88dd5'),(145,12,'Plan',NULL,NULL,NULL,'create',1,'2024-08-16 20:12:50',4,4,'ApplicationPlan','---\nissuer_id: 3\nname: Unlimited\nrights: \nfull_legal: \ncost_per_month: \'0.0\'\ntrial_period_days: \ncreated_at: \'2024-08-16T20:12:48Z\'\nposition: 3\nstate: hidden\ncancellation_period: 0\ncost_aggregation_rule: sum\nsetup_fee: \'0.0\'\nmaster: false\noriginal_id: 0\nissuer_type: Service\ndescription: \napproval_required: false\ntenant_id: \nsystem_name: unlimited\npartner_id: \ncontracts_count: 0\n',NULL,NULL,NULL,NULL,'2f1837c3-2688-41ea-ba49-e55fb6b16b5d'),(146,12,'Plan',NULL,NULL,NULL,'update',1,'2024-08-16 20:12:50',4,4,'ApplicationPlan','---\nstate:\n- hidden\n- published\n',NULL,NULL,NULL,NULL,'bd061dd1-48b2-4e7d-8812-f57e3f537487'),(147,5,'Account',NULL,NULL,NULL,'create',1,'2024-08-16 20:12:50',4,4,'Account','---\norg_name: Developer\norg_legaladdress: \'\'\ncreated_at: \'2024-08-16T20:12:49Z\'\nprovider: false\nbuyer: true\ncountry_id: \nprovider_account_id: 4\ndomain: \ntelephone_number: \nsite_access_code: \ncredit_card_partial_number: \ncredit_card_expires_on: \ncredit_card_auth_code: \nmaster: \nbilling_address_name: \nbilling_address_address1: \nbilling_address_address2: \nbilling_address_city: \nbilling_address_state: \nbilling_address_country: \nbilling_address_zip: \nbilling_address_phone: \norg_legaladdress_cont: \ncity: \nstate_region: \nstate: created\npaid: false\npaid_at: \nsigns_legal_terms: true\ntimezone: \ndelta: true\nfrom_email: \nprimary_business: \nbusiness_category: \nzip: \nextra_fields: {}\nvat_code: \nfiscal_code: \nvat_rate: \ninvoice_footnote: \nvat_zero_text: \ndefault_account_plan_id: \ndefault_service_id: \ncredit_card_authorize_net_payment_profile_token: \ntenant_id: \nself_domain: \ns3_prefix: \nprepared_assets_version: \nsample_data: \nsupport_email: \nfinance_support_email: \nbilling_address_first_name: \nbilling_address_last_name: \nemail_all_users: false\npartner_id: \nhosted_proxy_deployed_at: \npo_number: \nstate_changed_at: \n',NULL,NULL,NULL,NULL,'33fc16c8-e9dc-46c3-8276-d4d113fdffc4'),(148,5,'Account',NULL,NULL,NULL,'update',1,'2024-08-16 20:12:50',4,4,'Account','---\nstate_changed_at:\n- \n- \'2024-08-16T20:12:50Z\'\n',NULL,NULL,NULL,NULL,'b64f6230-2820-4775-90fd-d0e0682fc12b'),(149,5,'Account',NULL,NULL,NULL,'update',1,'2024-08-16 20:12:50',4,4,'Account','---\nstate:\n- created\n- approved\n',NULL,NULL,NULL,NULL,'d9a9d400-8b92-4e33-9b96-0e0ebd7a2e56'),(150,7,'User',NULL,NULL,NULL,'update',1,'2024-08-16 20:12:50',4,4,'User','---\nactivation_code:\n- c717faf9328078c77de8169bf5738545c9b960b6\n- \nactivated_at:\n- \n- \'2024-08-16T20:12:50Z\'\nstate:\n- pending\n- active\n',NULL,NULL,NULL,NULL,'26e7b44d-309b-4184-90d2-58cedd851437'),(151,9,'Contract',NULL,NULL,NULL,'create',1,'2024-08-16 20:12:50',4,4,'AccountContract','---\nplan_id: 10\nuser_account_id: 5\nuser_key: \nprovider_public_key: \ncreated_at: \'2024-08-16T20:12:50Z\'\nstate: pending\ndescription: \npaid_until: \napplication_id: \nname: \ntrial_period_expires_at: \'2024-08-16T20:12:50Z\'\nsetup_fee: \'0.0\'\nredirect_url: \nvariable_cost_paid_until: \nextra_fields: \ntenant_id: \ncreate_origin: \nfirst_traffic_at: \nfirst_daily_traffic_at: \nservice_id: \naccepted_at: \n',NULL,NULL,NULL,NULL,'3a339a10-4462-4b30-b243-0a5208f7d24b'),(152,10,'Contract',NULL,NULL,NULL,'create',1,'2024-08-16 20:12:50',4,4,'ServiceContract','---\nplan_id: 9\nuser_account_id: 5\nuser_key: \nprovider_public_key: \ncreated_at: \'2024-08-16T20:12:50Z\'\nstate: live\ndescription: \npaid_until: \napplication_id: \nname: \ntrial_period_expires_at: \'2024-08-16T20:12:50Z\'\nsetup_fee: \'0.0\'\nredirect_url: \nvariable_cost_paid_until: \nextra_fields: \ntenant_id: \ncreate_origin: \nfirst_traffic_at: \nfirst_daily_traffic_at: \nservice_id: 3\naccepted_at: \n',NULL,NULL,NULL,NULL,'fed33583-9204-42f9-9191-2e4d01bf908f'),(153,11,'Contract',NULL,NULL,NULL,'create',1,'2024-08-16 20:12:50',4,4,'Cinstance','---\nplan_id: 11\nuser_account_id: 5\nuser_key: e80e0fb58613fb18489fca1acc6d5d3d\nprovider_public_key: d39ef34611d129a7dc24c413037d69ec\ncreated_at: \'2024-08-16T20:12:50Z\'\nstate: live\ndescription: Default application created on signup.\npaid_until: \napplication_id: 7ac05bd7\nname: Developer\'s App\ntrial_period_expires_at: \'2024-08-16T20:12:50Z\'\nsetup_fee: \'0.0\'\nredirect_url: \nvariable_cost_paid_until: \nextra_fields: {}\ntenant_id: \ncreate_origin: \nfirst_traffic_at: \nfirst_daily_traffic_at: \nservice_id: 3\naccepted_at: \n',NULL,NULL,NULL,NULL,'66fab958-9fe4-4556-bb11-39265ea6ccd9'),(154,7,'User',NULL,NULL,NULL,'create',1,'2024-08-16 20:12:50',4,4,'User','---\nusername: john\nemail: 3scale-user+test@demo-organization.com\ncreated_at: \'2024-08-16T20:12:50Z\'\nremember_token: \nremember_token_expires_at: \nactivation_code: c717faf9328078c77de8169bf5738545c9b960b6\nactivated_at: \nstate: pending\nrole: admin\nlost_password_token: \naccount_id: 5\nfirst_name: John\nlast_name: Doe\nsignup_type: minimal\njob_role: \nemail_verification_code: \ntitle: \nextra_fields: {}\ntenant_id: \nlost_password_token_generated_at: \n',NULL,NULL,NULL,NULL,'09767425-24c5-4b25-8d7b-dde0baaf860e'),(155,4,'Service',6,'User',NULL,'create',1,'2024-08-16 20:13:10',4,4,'Service','---\naccount_id: 4\nname: Product A\ndescription: \'\'\ntxt_support: \ncreated_at: \'2024-08-16T20:13:10Z\'\nlogo_file_name: \nlogo_content_type: \nlogo_file_size: \nstate: incomplete\nintentions_required: false\nterms: \nbuyers_manage_apps: true\nbuyers_manage_keys: true\ncustom_keys_enabled: true\nbuyer_plan_change_permission: request\nbuyer_can_select_plan: false\nnotification_settings: \ndefault_application_plan_id: \ndefault_service_plan_id: \ntenant_id: \nsystem_name: product_a\nbackend_version: \'1\'\nmandatory_app_key: true\nbuyer_key_regenerate_enabled: true\nsupport_email: \nreferrer_filters_required: false\ndeployment_option: hosted\nkubernetes_service_link: \n',NULL,NULL,NULL,'62.45.139.47','b5a4e247-1084-477c-9925-98b0a309656c'),(156,10,'Metric',6,'User',NULL,'create',1,'2024-08-16 20:13:10',4,4,'Metric','---\nsystem_name: hits\ndescription: Number of API hits\nunit: hit\ncreated_at: \'2024-08-16T20:13:10Z\'\nservice_id: 4\nfriendly_name: Hits\nparent_id: \ntenant_id: \nowner_id: 4\nowner_type: Service\n',NULL,NULL,NULL,'62.45.139.47','b5a4e247-1084-477c-9925-98b0a309656c'),(157,13,'Plan',6,'User',NULL,'create',1,'2024-08-16 20:13:10',4,4,'ServicePlan','---\nissuer_id: 4\nname: Default\nrights: \nfull_legal: \ncost_per_month: \'0.0\'\ntrial_period_days: \ncreated_at: \'2024-08-16T20:13:10Z\'\nposition: 1\nstate: published\ncancellation_period: 0\ncost_aggregation_rule: sum\nsetup_fee: \'0.0\'\nmaster: false\noriginal_id: 0\nissuer_type: Service\ndescription: \napproval_required: false\ntenant_id: \nsystem_name: default\npartner_id: \ncontracts_count: 0\n',NULL,NULL,NULL,'62.45.139.47','b5a4e247-1084-477c-9925-98b0a309656c'),(158,5,'User',1,'User',NULL,'update',2,'2024-08-16 20:17:42',4,4,'User','---\nstate:\n- pending\n- active\nactivated_at:\n- \n- \'2024-08-16T20:17:42Z\'\nactivation_code:\n- d3aa45a2186a3d40ae56a3558b469a264090fa48\n- \n',NULL,NULL,NULL,'62.45.139.47','07fcf6a7-864b-4665-93e8-ce7b449938dc'),(159,9,'AccessToken',6,'User',NULL,'create',1,'2024-08-16 20:52:09',4,4,'AccessToken','---\nowner_id: 6\nscopes:\n- cms\n- finance\n- account_management\n- stats\n- policy_registry\nname: RHDH Token\npermission: rw\ncreated_at: \'2024-08-16T20:52:09Z\'\nupdated_at: \'2024-08-16T20:52:09Z\'\n',NULL,NULL,NULL,'62.45.139.47','a704e268-afa0-4144-8bb7-c2fcbe0c7e1d');
/*!40000 ALTER TABLE `audits` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `audits_tenant_id` BEFORE INSERT ON `audits` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.provider_id <> master_id THEN
  SET NEW.tenant_id = NEW.provider_id;
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `authentication_providers`
--

DROP TABLE IF EXISTS `authentication_providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authentication_providers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `system_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `client_id` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `client_secret` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `token_url` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `user_info_url` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `authorize_url` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `site` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `account_id` bigint DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `identifier_key` varchar(255) COLLATE utf8mb3_bin DEFAULT 'id',
  `username_key` varchar(255) COLLATE utf8mb3_bin DEFAULT 'login',
  `trust_email` tinyint(1) DEFAULT '0',
  `kind` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `published` tinyint(1) DEFAULT '0',
  `branding_state` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `skip_ssl_certificate_verification` tinyint(1) DEFAULT '0',
  `account_type` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT 'developer',
  `automatically_approve_accounts` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_authentication_providers_on_account_id_and_system_name` (`account_id`,`system_name`),
  KEY `index_authentication_providers_on_account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authentication_providers`
--

LOCK TABLES `authentication_providers` WRITE;
/*!40000 ALTER TABLE `authentication_providers` DISABLE KEYS */;
/*!40000 ALTER TABLE `authentication_providers` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `authentication_providers_tenant_id` BEFORE INSERT ON `authentication_providers` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM accounts WHERE id = NEW.account_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `backend_api_configs`
--

DROP TABLE IF EXISTS `backend_api_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backend_api_configs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `path` varchar(255) COLLATE utf8mb3_bin DEFAULT '',
  `service_id` bigint DEFAULT NULL,
  `backend_api_id` bigint DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_backend_api_configs_on_backend_api_id_and_service_id` (`backend_api_id`,`service_id`),
  UNIQUE KEY `index_backend_api_configs_on_path_and_service_id` (`path`,`service_id`),
  KEY `index_backend_api_configs_on_service_id` (`service_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backend_api_configs`
--

LOCK TABLES `backend_api_configs` WRITE;
/*!40000 ALTER TABLE `backend_api_configs` DISABLE KEYS */;
INSERT INTO `backend_api_configs` VALUES (1,'/',1,1,'2024-08-16 20:05:19','2024-08-16 20:05:19',NULL),(2,'/',2,2,'2024-08-16 20:05:20','2024-08-16 20:05:20',2),(3,'/',3,3,'2024-08-16 20:12:25','2024-08-16 20:12:25',4);
/*!40000 ALTER TABLE `backend_api_configs` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `backend_api_configs_tenant_id` BEFORE INSERT ON `backend_api_configs` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM backend_apis WHERE id = NEW.backend_api_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `backend_apis`
--

DROP TABLE IF EXISTS `backend_apis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backend_apis` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(511) COLLATE utf8mb3_bin NOT NULL,
  `system_name` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `description` mediumtext COLLATE utf8mb3_bin,
  `private_endpoint` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `account_id` bigint DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT 'published',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_backend_apis_on_account_id_and_system_name` (`account_id`,`system_name`),
  KEY `index_backend_apis_on_state` (`state`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backend_apis`
--

LOCK TABLES `backend_apis` WRITE;
/*!40000 ALTER TABLE `backend_apis` DISABLE KEYS */;
INSERT INTO `backend_apis` VALUES (1,'Master Service Backend','master_service','Backend of Master Service','https://echo-api.3scale.net:443',1,'2024-08-16 20:05:19','2024-08-16 20:05:19',NULL,'published'),(2,'API Backend','api','Backend of API','https://echo-api.3scale.net:443',2,'2024-08-16 20:05:20','2024-08-16 20:05:20',2,'published'),(3,'API Backend','api','Backend of API','https://echo-api.3scale.net:443',4,'2024-08-16 20:12:25','2024-08-16 20:12:25',4,'published');
/*!40000 ALTER TABLE `backend_apis` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `backend_apis_tenant_id` BEFORE INSERT ON `backend_apis` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM accounts WHERE id = NEW.account_id AND (NOT master OR master is NULL));

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `backend_events`
--

DROP TABLE IF EXISTS `backend_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backend_events` (
  `id` bigint NOT NULL,
  `data` text COLLATE utf8mb3_bin,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backend_events`
--

LOCK TABLES `backend_events` WRITE;
/*!40000 ALTER TABLE `backend_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `backend_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `billing_strategies`
--

DROP TABLE IF EXISTS `billing_strategies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing_strategies` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` bigint DEFAULT NULL,
  `prepaid` tinyint(1) DEFAULT '0',
  `charging_enabled` tinyint(1) DEFAULT '0',
  `charging_retry_delay` int DEFAULT '3',
  `charging_retry_times` int DEFAULT '3',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `numbering_period` varchar(255) COLLATE utf8mb3_bin DEFAULT 'monthly',
  `currency` varchar(255) COLLATE utf8mb3_bin DEFAULT 'USD',
  `tenant_id` bigint DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_billing_strategies_on_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing_strategies`
--

LOCK TABLES `billing_strategies` WRITE;
/*!40000 ALTER TABLE `billing_strategies` DISABLE KEYS */;
INSERT INTO `billing_strategies` VALUES (1,2,0,0,3,3,'2024-08-16 20:05:20','2024-08-16 20:05:20','monthly','USD',2,'Finance::PostpaidBillingStrategy'),(2,4,0,0,3,3,'2024-08-16 20:12:25','2024-08-16 20:12:25','monthly','USD',4,'Finance::PostpaidBillingStrategy');
/*!40000 ALTER TABLE `billing_strategies` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `billing_strategies_tenant_id` BEFORE INSERT ON `billing_strategies` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.account_id <> master_id THEN
  SET NEW.tenant_id = NEW.account_id;
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category_type_id` bigint DEFAULT NULL,
  `parent_id` bigint DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `account_id` bigint DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_categories_on_account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `categories_tenant_id` BEFORE INSERT ON `categories` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.account_id <> master_id THEN
  SET NEW.tenant_id = NEW.account_id;
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `category_types`
--

DROP TABLE IF EXISTS `category_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_types` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `account_id` bigint DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_category_types_on_account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_types`
--

LOCK TABLES `category_types` WRITE;
/*!40000 ALTER TABLE `category_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `category_types` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `category_types_tenant_id` BEFORE INSERT ON `category_types` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.account_id <> master_id THEN
  SET NEW.tenant_id = NEW.account_id;
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cinstances`
--

DROP TABLE IF EXISTS `cinstances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cinstances` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `plan_id` bigint NOT NULL,
  `user_account_id` bigint DEFAULT NULL,
  `user_key` varchar(256) COLLATE utf8mb3_bin DEFAULT NULL,
  `provider_public_key` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `description` text COLLATE utf8mb3_bin,
  `paid_until` datetime DEFAULT NULL,
  `application_id` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `trial_period_expires_at` datetime DEFAULT NULL,
  `setup_fee` decimal(20,2) DEFAULT '0.00',
  `type` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT 'Cinstance',
  `redirect_url` text COLLATE utf8mb3_bin,
  `variable_cost_paid_until` datetime DEFAULT NULL,
  `extra_fields` text COLLATE utf8mb3_bin,
  `tenant_id` bigint DEFAULT NULL,
  `create_origin` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `first_traffic_at` datetime DEFAULT NULL,
  `first_daily_traffic_at` datetime DEFAULT NULL,
  `service_id` bigint DEFAULT NULL,
  `accepted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_cinstances_on_application_id` (`application_id`),
  KEY `fk_ct_contract_id` (`plan_id`),
  KEY `index_cinstances_on_type_and_plan_id_and_service_id_and_state` (`type`,`plan_id`,`service_id`,`state`),
  KEY `index_cinstances_on_type_and_service_id_and_created_at` (`type`,`service_id`,`created_at`),
  KEY `index_cinstances_on_type_and_service_id_and_plan_id_and_state` (`type`,`service_id`,`plan_id`,`state`),
  KEY `idx_cinstances_service_state_traffic` (`type`,`service_id`,`state`,`first_traffic_at`),
  KEY `fk_ct_user_account_id` (`user_account_id`),
  KEY `index_cinstances_on_user_key` (`user_key`(255))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cinstances`
--

LOCK TABLES `cinstances` WRITE;
/*!40000 ALTER TABLE `cinstances` DISABLE KEYS */;
INSERT INTO `cinstances` VALUES (1,2,1,'ed41d7d3e2d9cde81eef05a943ea3ffc','da8cd86e82ab4ebbda5af36329622001','2024-08-16 20:05:19','2024-08-16 20:05:19','live','Default application created on signup.',NULL,'fd7a3602','Master Account\'s App','2024-08-16 20:05:19',0.00,'Cinstance',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL),(2,4,2,'48e9385e17a8a163e43f15ea9d4fa1d1','b1f05d77432336afedd432f306f48e63','2024-08-16 20:05:20','2024-08-16 20:05:20','live','Default application created on signup.',NULL,'6faf60a1','Provider Name\'s App','2024-08-16 20:05:20',0.00,'Cinstance',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL),(3,6,3,NULL,NULL,'2024-08-16 20:07:51','2024-08-16 20:07:51','live',NULL,NULL,NULL,NULL,'2024-08-16 20:07:51',0.00,'AccountContract',NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,'2024-08-16 20:07:51'),(4,5,3,NULL,NULL,'2024-08-16 20:07:51','2024-08-16 20:07:51','live',NULL,NULL,NULL,NULL,'2024-08-16 20:07:51',0.00,'ServiceContract',NULL,NULL,NULL,2,NULL,NULL,NULL,2,NULL),(5,7,3,'d86fc3b47ed5ab6e432e945d56fea756','105b4959448cc8a8d681369ca7be5068','2024-08-16 20:07:51','2024-08-16 20:07:51','live','Default application created on signup.',NULL,'db3bec09','Developer\'s App','2024-08-16 20:07:51',0.00,'Cinstance',NULL,NULL,NULL,2,NULL,NULL,NULL,2,NULL),(6,3,4,NULL,NULL,'2024-08-16 20:12:24','2024-08-16 20:12:25','live',NULL,NULL,NULL,NULL,'2024-08-16 20:12:24',0.00,'AccountContract',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-08-16 20:12:25'),(7,1,4,NULL,NULL,'2024-08-16 20:12:24','2024-08-16 20:12:24','live',NULL,NULL,NULL,NULL,'2024-08-16 20:12:24',0.00,'ServiceContract',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL),(8,4,4,'0f978993e3f9968bdbf99344f780e483','68c08c104a68888f096c975e10305a33','2024-08-16 20:12:24','2024-08-16 20:12:24','live','Default application created on signup.',NULL,'a18de20f','Demo Organization\'s App','2024-08-16 20:12:24',0.00,'Cinstance',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL),(9,10,5,NULL,NULL,'2024-08-16 20:12:50','2024-08-16 20:12:50','live',NULL,NULL,NULL,NULL,'2024-08-16 20:12:50',0.00,'AccountContract',NULL,NULL,NULL,4,NULL,NULL,NULL,NULL,'2024-08-16 20:12:50'),(10,9,5,NULL,NULL,'2024-08-16 20:12:50','2024-08-16 20:12:50','live',NULL,NULL,NULL,NULL,'2024-08-16 20:12:50',0.00,'ServiceContract',NULL,NULL,NULL,4,NULL,NULL,NULL,3,NULL),(11,11,5,'e80e0fb58613fb18489fca1acc6d5d3d','d39ef34611d129a7dc24c413037d69ec','2024-08-16 20:12:50','2024-08-16 20:12:50','live','Default application created on signup.',NULL,'7ac05bd7','Developer\'s App','2024-08-16 20:12:50',0.00,'Cinstance',NULL,NULL,NULL,4,NULL,NULL,NULL,3,NULL);
/*!40000 ALTER TABLE `cinstances` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `cinstances_tenant_id` BEFORE INSERT ON `cinstances` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM plans WHERE id = NEW.plan_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cms_files`
--

DROP TABLE IF EXISTS `cms_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_files` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `provider_id` bigint NOT NULL,
  `section_id` bigint DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `attachment_updated_at` datetime DEFAULT NULL,
  `attachment_content_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `attachment_file_size` bigint DEFAULT NULL,
  `attachment_file_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `random_secret` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `path` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `downloadable` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_cms_files_on_provider_id_and_path` (`provider_id`,`path`),
  KEY `index_cms_files_on_provider_id` (`provider_id`),
  KEY `index_cms_files_on_section_id` (`section_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_files`
--

LOCK TABLES `cms_files` WRITE;
/*!40000 ALTER TABLE `cms_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_files` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `cms_files_tenant_id` BEFORE INSERT ON `cms_files` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.provider_id <> master_id THEN
  SET NEW.tenant_id = NEW.provider_id;
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cms_group_sections`
--

DROP TABLE IF EXISTS `cms_group_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_group_sections` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` bigint DEFAULT NULL,
  `section_id` bigint DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_cms_group_sections_on_group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_group_sections`
--

LOCK TABLES `cms_group_sections` WRITE;
/*!40000 ALTER TABLE `cms_group_sections` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_group_sections` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `cms_group_sections_tenant_id` BEFORE INSERT ON `cms_group_sections` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM cms_groups WHERE id = NEW.group_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cms_groups`
--

DROP TABLE IF EXISTS `cms_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint DEFAULT NULL,
  `provider_id` bigint NOT NULL,
  `name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_cms_groups_on_provider_id` (`provider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_groups`
--

LOCK TABLES `cms_groups` WRITE;
/*!40000 ALTER TABLE `cms_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_groups` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `cms_groups_tenant_id` BEFORE INSERT ON `cms_groups` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.provider_id <> master_id THEN
  SET NEW.tenant_id = NEW.provider_id;
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cms_permissions`
--

DROP TABLE IF EXISTS `cms_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint DEFAULT NULL,
  `account_id` bigint DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `group_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_cms_permissions_on_account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_permissions`
--

LOCK TABLES `cms_permissions` WRITE;
/*!40000 ALTER TABLE `cms_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_permissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `cms_permissions_tenant_id` BEFORE INSERT ON `cms_permissions` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM cms_groups WHERE id = NEW.group_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cms_redirects`
--

DROP TABLE IF EXISTS `cms_redirects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_redirects` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `provider_id` bigint NOT NULL,
  `source` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `target` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_cms_redirects_on_provider_id_and_source` (`provider_id`,`source`),
  KEY `index_cms_redirects_on_provider_id` (`provider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_redirects`
--

LOCK TABLES `cms_redirects` WRITE;
/*!40000 ALTER TABLE `cms_redirects` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_redirects` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `cms_redirects_tenant_id` BEFORE INSERT ON `cms_redirects` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.provider_id <> master_id THEN
  SET NEW.tenant_id = NEW.provider_id;
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cms_sections`
--

DROP TABLE IF EXISTS `cms_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_sections` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `provider_id` bigint NOT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `parent_id` bigint DEFAULT NULL,
  `partial_path` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `system_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `public` tinyint(1) DEFAULT '1',
  `type` varchar(255) COLLATE utf8mb3_bin DEFAULT 'CMS::Section',
  PRIMARY KEY (`id`),
  KEY `index_cms_sections_on_parent_id` (`parent_id`),
  KEY `index_cms_sections_on_provider_id` (`provider_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_sections`
--

LOCK TABLES `cms_sections` WRITE;
/*!40000 ALTER TABLE `cms_sections` DISABLE KEYS */;
INSERT INTO `cms_sections` VALUES (1,1,NULL,NULL,'/','Root','root','2024-08-16 20:05:18','2024-08-16 20:05:18',1,'CMS::Builtin::Section'),(2,1,NULL,1,'/services','Services','services','2024-08-16 20:05:19','2024-08-16 20:05:19',1,'CMS::Builtin::Section'),(3,2,2,NULL,'/','Root','root','2024-08-16 20:05:20','2024-08-16 20:05:20',1,'CMS::Builtin::Section'),(4,2,2,3,'/applications','Applications','applications','2024-08-16 20:05:20','2024-08-16 20:05:20',1,'CMS::Builtin::Section'),(5,2,2,3,'/services','Services','services','2024-08-16 20:05:21','2024-08-16 20:05:21',1,'CMS::Builtin::Section'),(21,4,4,NULL,'/','Root','root','2024-08-16 20:12:24','2024-08-16 20:12:24',1,'CMS::Builtin::Section'),(22,4,4,21,'/applications','Applications','applications','2024-08-16 20:12:25','2024-08-16 20:12:25',1,'CMS::Builtin::Section'),(23,4,4,21,'/services','Services','services','2024-08-16 20:12:25','2024-08-16 20:12:25',1,'CMS::Builtin::Section');
/*!40000 ALTER TABLE `cms_sections` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `cms_sections_tenant_id` BEFORE INSERT ON `cms_sections` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.provider_id <> master_id THEN
  SET NEW.tenant_id = NEW.provider_id;
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cms_templates`
--

DROP TABLE IF EXISTS `cms_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_templates` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `provider_id` bigint NOT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `section_id` bigint DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `path` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `system_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `published` mediumtext COLLATE utf8mb3_bin,
  `draft` mediumtext COLLATE utf8mb3_bin,
  `liquid_enabled` tinyint(1) DEFAULT NULL,
  `content_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `layout_id` bigint DEFAULT NULL,
  `options` text COLLATE utf8mb3_bin,
  `updated_by` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `handler` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `searchable` tinyint(1) DEFAULT '0',
  `rails_view_path` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_cms_templates_on_provider_id_and_path` (`provider_id`,`path`),
  KEY `index_cms_templates_on_provider_id_and_rails_view_path` (`provider_id`,`rails_view_path`),
  KEY `index_cms_templates_on_provider_id_and_system_name` (`provider_id`,`system_name`),
  KEY `index_cms_templates_on_provider_id_type` (`provider_id`,`type`),
  KEY `index_cms_templates_on_section_id` (`section_id`),
  KEY `index_cms_templates_on_type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_templates`
--

LOCK TABLES `cms_templates` WRITE;
/*!40000 ALTER TABLE `cms_templates` DISABLE KEYS */;
INSERT INTO `cms_templates` VALUES (1,1,NULL,2,'CMS::Builtin::Page',NULL,'Subscribe to a service','services/new','<h2>Subscribe to Service</h2>\n\n{% form \'subscription.create\' %}\n  <p>Please choose a service and plan you which to subscribe to.</p>\n\n  <fieldset class=\"inputs\" name=\"\">\n    <ol>\n      <li class=\"plan_selector required\" id=\"service_contract_plan_input\">\n        <label for=\"service_contract_plan_id\">Plan<abbr title=\"required\">*</abbr></label>\n        <select id=\"service_contract_plan_id\" name=\"service_contract[plan_id]\">\n            {% if subscription.service %}\n               <optgroup label=\"{{ subscription.service.name }}\">\n                 {% for plan in subscription.service.service_plans %}\n                   <option value=\"{{ plan.id }}\">{{ plan.name }}</option>\n                 {% endfor %}\n               </optgroup>\n            {% else %}\n              {% for service in provider.services %}\n                <optgroup label=\"{{ service.name }}\">\n                  {% for plan in service.service_plans %}\n                    <option value=\"{{ plan.id }}\">{{ plan.name }}</option>\n                  {% endfor %}\n                </optgroup>\n              {% endfor %}\n            {% endif %}\n        </select>\n        <p class=\"inline-hints\">Choose a plan you want to subscribe to.</p>\n      </li>\n    </ol>\n  </fieldset>\n\n  {% include \'service_subscription_licence\' %}\n\n  <fieldset class=\"buttons\">\n    <ol>\n      <li class=\"commit\">\n        <input class=\"important-button create\" name=\"commit\" type=\"submit\" value=\"Subscribe\">\n      </li>\n    </ol>\n  </fieldset>\n\n{% endform %}\n',NULL,NULL,NULL,'2024-08-16 20:05:20','2024-08-16 20:05:20',NULL,NULL,'',NULL,0,'services/new'),(2,1,NULL,2,'CMS::Builtin::Page',NULL,'List services','services/index','<div class=\"full\">\n  <div class=\"container\" >\n    <div class=\"row\">\n      <div class=\"col-md-10\">\n        <div class=\"panel panel-default\">\n          <div class=\"panel-body\">\n            <table class=\"table\">\n              <thead>\n                <tr>\n                  <th style=\"width:20%\">Name</th>\n                  <th>Description</th>\n                  <th>Plan</th>\n                  <th></th>\n                </tr>\n              </thead>\n              <tbody>\n                {% for service in provider.services %}\n                  <tr class=\"service\">\n                    {% if service.subscribable? %}\n                      {% assign subscription = service.subscription %}\n                      <td>\n                        {{ service.name }}\n                      </td>\n                      <td>\n                        <p>\n                          {{ service.description }}\n                        </p>\n                      </td>\n\n                      <td>\n                        {% if subscription %}\n                          {{ subscription.plan.name  }}\n                          {% unless subscription.live? %}\n                            ({{ subscription.state }})\n                          {% endunless %}\n                        {% endif %}\n                      </td>\n\n                      <td>\n                        {% if subscription %}\n                            {% if subscription.can.change_plan? %}\n                               <a href=\"#\" id=\"choose-plan-{{subscription.id}}\" class=\"btn btn-default\">Review/Change</a>\n                               {{ \"plans_widget_v2.js\" | javascript_include_tag }}\n                               {{ \"plans_widget.css\" | stylesheet_link_tag }}\n\n                                <script type=\"text/javascript\">\n                                  //<![CDATA[\n                                  $(document).ready(function() {\n                                    $(\"#choose-plan-{{ subscription.id }}\").on(\'click\', function(){\n                                      var planID = \'{{ subscription.plan.id }}\';\n                                      var contractID = \'{{ subscription.id }}\';\n                                      var url = \'{{ subscription.change_plan_url }}\';\n\n                                      function plan_chosen_callback(name, planID){\n                                      }\n\n                                      PlanWidget.loadPreview(planID, plan_chosen_callback, url, contractID );\n\n                                      return false;\n                                    });\n                                  });\n                                  //]]>\n                                </script>\n\n                            {% endif %}\n                       {% else %}\n                         {{ \"Subscribe to \" | append: service.name | link_to: service.subscribe_url }}\n                       {% endif %}\n                      </td>\n                      {% endif %}\n                  </tr>\n                 {% endfor %}\n              </tbody>\n            </table>\n          </div>\n        </div>\n      </div>\n    </div>\n  </div>\n</div>\n\n',NULL,NULL,NULL,'2024-08-16 20:05:20','2024-08-16 20:05:20',NULL,NULL,'',NULL,0,'services/index'),(3,2,2,4,'CMS::Builtin::Page',NULL,'New Application','applications/new','<div class=\"row\">\n  <div class=\"col-md-9\">\n    <div class=\"panel panel-default\">\n      <div class=\"panel-heading\">\n        New Application\n      </div>\n      <div class=\"panel-body panel-footer\">\n        {% form \'application.create\', application, class: \"form-horizontal\" %}\n          {% include \'applications/form\' %}\n          <fieldset>\n            <div class=\"form-group\">\n              <div class=\"col-md-10\">\n                <input class=\"btn btn-primary pull-right\"\n                                 name=\"commit\"\n                                 type=\"submit\"\n                                 value=\"Create Application\" />\n              </div>\n            </div>\n          </fieldset>\n        {% endform %}\n      </div>\n    </div>\n  </div>\n</div>\n',NULL,NULL,NULL,'2024-08-16 20:05:20','2024-08-16 20:05:20',NULL,NULL,'',NULL,0,'applications/new'),(4,2,2,4,'CMS::Builtin::Page',NULL,'Choose Service','applications/choose_service','<h2>Select service</h2>\n<p>In order to create an application, select one of the services you are subscribed to.</p>\n\n<dl class=\"select-service-list\">\n  {% for service in services %}\n    <dt class=\"service\">\n      <a href=\"{{ urls.new_application }}?service_id={{ service.system_name }}\" class=\"\">{{ service.name }}</a>\n    </dt>\n    <dd>{{ service.description }}</dd>\n  {% endfor %}\n</dl>\n',NULL,NULL,NULL,'2024-08-16 20:05:21','2024-08-16 20:05:21',NULL,NULL,'',NULL,0,'applications/choose_service'),(5,2,2,5,'CMS::Builtin::Page',NULL,'Subscribe to a service','services/new','<h2>Subscribe to Service</h2>\n\n{% form \'subscription.create\' %}\n  <p>Please choose a service and plan you which to subscribe to.</p>\n\n  <fieldset class=\"inputs\" name=\"\">\n    <ol>\n      <li class=\"plan_selector required\" id=\"service_contract_plan_input\">\n        <label for=\"service_contract_plan_id\">Plan<abbr title=\"required\">*</abbr></label>\n        <select id=\"service_contract_plan_id\" name=\"service_contract[plan_id]\">\n            {% if subscription.service %}\n               <optgroup label=\"{{ subscription.service.name }}\">\n                 {% for plan in subscription.service.service_plans %}\n                   <option value=\"{{ plan.id }}\">{{ plan.name }}</option>\n                 {% endfor %}\n               </optgroup>\n            {% else %}\n              {% for service in provider.services %}\n                <optgroup label=\"{{ service.name }}\">\n                  {% for plan in service.service_plans %}\n                    <option value=\"{{ plan.id }}\">{{ plan.name }}</option>\n                  {% endfor %}\n                </optgroup>\n              {% endfor %}\n            {% endif %}\n        </select>\n        <p class=\"inline-hints\">Choose a plan you want to subscribe to.</p>\n      </li>\n    </ol>\n  </fieldset>\n\n  {% include \'service_subscription_licence\' %}\n\n  <fieldset class=\"buttons\">\n    <ol>\n      <li class=\"commit\">\n        <input class=\"important-button create\" name=\"commit\" type=\"submit\" value=\"Subscribe\">\n      </li>\n    </ol>\n  </fieldset>\n\n{% endform %}\n',NULL,NULL,NULL,'2024-08-16 20:05:21','2024-08-16 20:05:21',NULL,NULL,'',NULL,0,'services/new'),(6,2,2,5,'CMS::Builtin::Page',NULL,'List services','services/index','<div class=\"full\">\n  <div class=\"container\" >\n    <div class=\"row\">\n      <div class=\"col-md-10\">\n        <div class=\"panel panel-default\">\n          <div class=\"panel-body\">\n            <table class=\"table\">\n              <thead>\n                <tr>\n                  <th style=\"width:20%\">Name</th>\n                  <th>Description</th>\n                  <th>Plan</th>\n                  <th></th>\n                </tr>\n              </thead>\n              <tbody>\n                {% for service in provider.services %}\n                  <tr class=\"service\">\n                    {% if service.subscribable? %}\n                      {% assign subscription = service.subscription %}\n                      <td>\n                        {{ service.name }}\n                      </td>\n                      <td>\n                        <p>\n                          {{ service.description }}\n                        </p>\n                      </td>\n\n                      <td>\n                        {% if subscription %}\n                          {{ subscription.plan.name  }}\n                          {% unless subscription.live? %}\n                            ({{ subscription.state }})\n                          {% endunless %}\n                        {% endif %}\n                      </td>\n\n                      <td>\n                        {% if subscription %}\n                            {% if subscription.can.change_plan? %}\n                               <a href=\"#\" id=\"choose-plan-{{subscription.id}}\" class=\"btn btn-default\">Review/Change</a>\n                               {{ \"plans_widget_v2.js\" | javascript_include_tag }}\n                               {{ \"plans_widget.css\" | stylesheet_link_tag }}\n\n                                <script type=\"text/javascript\">\n                                  //<![CDATA[\n                                  $(document).ready(function() {\n                                    $(\"#choose-plan-{{ subscription.id }}\").on(\'click\', function(){\n                                      var planID = \'{{ subscription.plan.id }}\';\n                                      var contractID = \'{{ subscription.id }}\';\n                                      var url = \'{{ subscription.change_plan_url }}\';\n\n                                      function plan_chosen_callback(name, planID){\n                                      }\n\n                                      PlanWidget.loadPreview(planID, plan_chosen_callback, url, contractID );\n\n                                      return false;\n                                    });\n                                  });\n                                  //]]>\n                                </script>\n\n                            {% endif %}\n                       {% else %}\n                         {{ \"Subscribe to \" | append: service.name | link_to: service.subscribe_url }}\n                       {% endif %}\n                      </td>\n                      {% endif %}\n                  </tr>\n                 {% endfor %}\n              </tbody>\n            </table>\n          </div>\n        </div>\n      </div>\n    </div>\n  </div>\n</div>\n\n',NULL,NULL,NULL,'2024-08-16 20:05:21','2024-08-16 20:05:21',NULL,NULL,'',NULL,0,'services/index'),(77,4,4,22,'CMS::Builtin::Page',NULL,'New Application','applications/new','<div class=\"row\">\n  <div class=\"col-md-9\">\n    <div class=\"panel panel-default\">\n      <div class=\"panel-heading\">\n        New Application\n      </div>\n      <div class=\"panel-body panel-footer\">\n        {% form \'application.create\', application, class: \"form-horizontal\" %}\n          {% include \'applications/form\' %}\n          <fieldset>\n            <div class=\"form-group\">\n              <div class=\"col-md-10\">\n                <input class=\"btn btn-primary pull-right\"\n                                 name=\"commit\"\n                                 type=\"submit\"\n                                 value=\"Create Application\" />\n              </div>\n            </div>\n          </fieldset>\n        {% endform %}\n      </div>\n    </div>\n  </div>\n</div>\n',NULL,NULL,NULL,'2024-08-16 20:12:25','2024-08-16 20:12:25',NULL,NULL,'master',NULL,0,'applications/new'),(78,4,4,22,'CMS::Builtin::Page',NULL,'Choose Service','applications/choose_service','<h2>Select service</h2>\n<p>In order to create an application, select one of the services you are subscribed to.</p>\n\n<dl class=\"select-service-list\">\n  {% for service in services %}\n    <dt class=\"service\">\n      <a href=\"{{ urls.new_application }}?service_id={{ service.system_name }}\" class=\"\">{{ service.name }}</a>\n    </dt>\n    <dd>{{ service.description }}</dd>\n  {% endfor %}\n</dl>\n',NULL,NULL,NULL,'2024-08-16 20:12:25','2024-08-16 20:12:25',NULL,NULL,'master',NULL,0,'applications/choose_service'),(79,4,4,23,'CMS::Builtin::Page',NULL,'Subscribe to a service','services/new','<h2>Subscribe to Service</h2>\n\n{% form \'subscription.create\' %}\n  <p>Please choose a service and plan you which to subscribe to.</p>\n\n  <fieldset class=\"inputs\" name=\"\">\n    <ol>\n      <li class=\"plan_selector required\" id=\"service_contract_plan_input\">\n        <label for=\"service_contract_plan_id\">Plan<abbr title=\"required\">*</abbr></label>\n        <select id=\"service_contract_plan_id\" name=\"service_contract[plan_id]\">\n            {% if subscription.service %}\n               <optgroup label=\"{{ subscription.service.name }}\">\n                 {% for plan in subscription.service.service_plans %}\n                   <option value=\"{{ plan.id }}\">{{ plan.name }}</option>\n                 {% endfor %}\n               </optgroup>\n            {% else %}\n              {% for service in provider.services %}\n                <optgroup label=\"{{ service.name }}\">\n                  {% for plan in service.service_plans %}\n                    <option value=\"{{ plan.id }}\">{{ plan.name }}</option>\n                  {% endfor %}\n                </optgroup>\n              {% endfor %}\n            {% endif %}\n        </select>\n        <p class=\"inline-hints\">Choose a plan you want to subscribe to.</p>\n      </li>\n    </ol>\n  </fieldset>\n\n  {% include \'service_subscription_licence\' %}\n\n  <fieldset class=\"buttons\">\n    <ol>\n      <li class=\"commit\">\n        <input class=\"important-button create\" name=\"commit\" type=\"submit\" value=\"Subscribe\">\n      </li>\n    </ol>\n  </fieldset>\n\n{% endform %}\n',NULL,NULL,NULL,'2024-08-16 20:12:25','2024-08-16 20:12:25',NULL,NULL,'master',NULL,0,'services/new'),(80,4,4,23,'CMS::Builtin::Page',NULL,'List services','services/index','<div class=\"full\">\n  <div class=\"container\" >\n    <div class=\"row\">\n      <div class=\"col-md-10\">\n        <div class=\"panel panel-default\">\n          <div class=\"panel-body\">\n            <table class=\"table\">\n              <thead>\n                <tr>\n                  <th style=\"width:20%\">Name</th>\n                  <th>Description</th>\n                  <th>Plan</th>\n                  <th></th>\n                </tr>\n              </thead>\n              <tbody>\n                {% for service in provider.services %}\n                  <tr class=\"service\">\n                    {% if service.subscribable? %}\n                      {% assign subscription = service.subscription %}\n                      <td>\n                        {{ service.name }}\n                      </td>\n                      <td>\n                        <p>\n                          {{ service.description }}\n                        </p>\n                      </td>\n\n                      <td>\n                        {% if subscription %}\n                          {{ subscription.plan.name  }}\n                          {% unless subscription.live? %}\n                            ({{ subscription.state }})\n                          {% endunless %}\n                        {% endif %}\n                      </td>\n\n                      <td>\n                        {% if subscription %}\n                            {% if subscription.can.change_plan? %}\n                               <a href=\"#\" id=\"choose-plan-{{subscription.id}}\" class=\"btn btn-default\">Review/Change</a>\n                               {{ \"plans_widget_v2.js\" | javascript_include_tag }}\n                               {{ \"plans_widget.css\" | stylesheet_link_tag }}\n\n                                <script type=\"text/javascript\">\n                                  //<![CDATA[\n                                  $(document).ready(function() {\n                                    $(\"#choose-plan-{{ subscription.id }}\").on(\'click\', function(){\n                                      var planID = \'{{ subscription.plan.id }}\';\n                                      var contractID = \'{{ subscription.id }}\';\n                                      var url = \'{{ subscription.change_plan_url }}\';\n\n                                      function plan_chosen_callback(name, planID){\n                                      }\n\n                                      PlanWidget.loadPreview(planID, plan_chosen_callback, url, contractID );\n\n                                      return false;\n                                    });\n                                  });\n                                  //]]>\n                                </script>\n\n                            {% endif %}\n                       {% else %}\n                         {{ \"Subscribe to \" | append: service.name | link_to: service.subscribe_url }}\n                       {% endif %}\n                      </td>\n                      {% endif %}\n                  </tr>\n                 {% endfor %}\n              </tbody>\n            </table>\n          </div>\n        </div>\n      </div>\n    </div>\n  </div>\n</div>\n\n',NULL,NULL,NULL,'2024-08-16 20:12:25','2024-08-16 20:12:25',NULL,NULL,'master',NULL,0,'services/index');
/*!40000 ALTER TABLE `cms_templates` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `cms_templates_tenant_id` BEFORE INSERT ON `cms_templates` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF (master_id IS NULL OR NEW.provider_id <> master_id) THEN
  SET NEW.tenant_id = NEW.provider_id;
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cms_templates_versions`
--

DROP TABLE IF EXISTS `cms_templates_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_templates_versions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `provider_id` bigint NOT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `section_id` bigint DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `path` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `system_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `published` mediumtext COLLATE utf8mb3_bin,
  `draft` mediumtext COLLATE utf8mb3_bin,
  `liquid_enabled` tinyint(1) DEFAULT NULL,
  `content_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `layout_id` bigint DEFAULT NULL,
  `template_id` bigint DEFAULT NULL,
  `template_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `options` text COLLATE utf8mb3_bin,
  `updated_by` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `handler` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `searchable` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_cms_templates_versions_on_provider_id_type` (`provider_id`,`type`),
  KEY `by_template` (`template_id`,`template_type`)
) ENGINE=InnoDB AUTO_INCREMENT=225 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_templates_versions`
--

LOCK TABLES `cms_templates_versions` WRITE;
/*!40000 ALTER TABLE `cms_templates_versions` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_templates_versions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `cms_templates_versions_tenant_id` BEFORE INSERT ON `cms_templates_versions` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.provider_id <> master_id THEN
  SET NEW.tenant_id = NEW.provider_id;
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `configuration_values`
--

DROP TABLE IF EXISTS `configuration_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configuration_values` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `configurable_id` bigint DEFAULT NULL,
  `configurable_type` varchar(50) COLLATE utf8mb3_bin DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `value` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_on_configurable_and_name` (`configurable_id`,`configurable_type`,`name`),
  KEY `index_on_configurable` (`configurable_id`,`configurable_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuration_values`
--

LOCK TABLES `configuration_values` WRITE;
/*!40000 ALTER TABLE `configuration_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `configuration_values` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `configuration_values_tenant_id` BEFORE INSERT ON `configuration_values` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.configurable_type = 'Account' AND NEW.configurable_id <> master_id THEN
  SET NEW.tenant_id = NEW.configurable_id;
ELSEIF NEW.configurable_type = 'Service' THEN
  SET NEW.tenant_id = (SELECT tenant_id FROM services WHERE id = NEW.configurable_id AND tenant_id <> master_id);
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `currency` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `tax_rate` decimal(5,2) NOT NULL DEFAULT '0.00',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `tenant_id` int DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `index_countries_on_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=249 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'AD','Andorra','EUR',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(2,'AE','United Arab Emirates','AED',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(3,'AF','Afghanistan','AFN',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(4,'AG','Antigua and Barbuda','XCD',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(5,'AI','Anguilla','XCD',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(6,'AL','Albania','ALL',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(7,'AM','Armenia','AMD',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(8,'AO','Angola','AOA',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(9,'AR','Argentina','ARS',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(10,'AS','American Samoa','USD',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(11,'AT','Austria','EUR',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(12,'AU','Australia','AUD',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(13,'AW','Aruba','AWG',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(14,'AX','Aland Islands','EUR',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(15,'AZ','Azerbaijan','AZN',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(16,'BA','Bosnia and Herzegovina','BAM',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(17,'BB','Barbados','BBD',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(18,'BD','Bangladesh','BDT',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(19,'BE','Belgium','EUR',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(20,'BF','Burkina Faso','XOF',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(21,'BG','Bulgaria','BGN',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(22,'BH','Bahrain','BHD',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(23,'BI','Burundi','BIF',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(24,'BJ','Benin','XOF',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(25,'BL','Saint Barthelemy','EUR',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(26,'BM','Bermuda','BMD',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(27,'BN','Brunei','BND',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(28,'BO','Bolivia','BOB',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(29,'BQ','Bonaire, Saint Eustatius and Saba ','USD',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(30,'BR','Brazil','BRL',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(31,'BS','Bahamas','BSD',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(32,'BT','Bhutan','BTN',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(33,'BV','Bouvet Island','NOK',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(34,'BW','Botswana','BWP',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(35,'BY','Belarus','BYN',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(36,'BZ','Belize','BZD',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(37,'CA','Canada','CAD',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(38,'CC','Cocos Islands','AUD',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(39,'CD','Democratic Republic of the Congo','CDF',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(40,'CF','Central African Republic','XAF',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(41,'CG','Republic of the Congo','XAF',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(42,'CH','Switzerland','CHF',0.00,'2024-08-16 20:05:22','2024-08-16 20:05:22',NULL,1),(43,'CI','Ivory Coast','XOF',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(44,'CK','Cook Islands','NZD',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(45,'CL','Chile','CLP',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(46,'CM','Cameroon','XAF',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(47,'CN','China','CNY',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(48,'CO','Colombia','COP',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(49,'CR','Costa Rica','CRC',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(50,'CU','Cuba','CUP',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,0),(51,'CV','Cabo Verde','CVE',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(52,'CW','Curacao','ANG',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(53,'CX','Christmas Island','AUD',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(54,'CY','Cyprus','EUR',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(55,'CZ','Czechia','CZK',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(56,'DE','Germany','EUR',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(57,'DJ','Djibouti','DJF',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(58,'DK','Denmark','DKK',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(59,'DM','Dominica','XCD',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(60,'DO','Dominican Republic','DOP',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(61,'DZ','Algeria','DZD',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(62,'EC','Ecuador','USD',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(63,'EE','Estonia','EUR',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(64,'EG','Egypt','EGP',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(65,'EH','Western Sahara','MAD',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(66,'ER','Eritrea','ERN',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(67,'ES','Spain','EUR',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(68,'ET','Ethiopia','ETB',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(69,'FI','Finland','EUR',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(70,'FJ','Fiji','FJD',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(71,'FK','Falkland Islands','FKP',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(72,'FM','Micronesia','USD',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(73,'FO','Faroe Islands','DKK',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(74,'FR','France','EUR',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(75,'GA','Gabon','XAF',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(76,'GB','United Kingdom','GBP',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(77,'GD','Grenada','XCD',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(78,'GE','Georgia','GEL',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(79,'GF','French Guiana','EUR',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(80,'GG','Guernsey','GBP',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(81,'GH','Ghana','GHS',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(82,'GI','Gibraltar','GIP',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(83,'GL','Greenland','DKK',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(84,'GM','Gambia','GMD',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(85,'GN','Guinea','GNF',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(86,'GP','Guadeloupe','EUR',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(87,'GQ','Equatorial Guinea','XAF',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(88,'GR','Greece','EUR',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(89,'GS','South Georgia and the South Sandwich Islands','GBP',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(90,'GT','Guatemala','GTQ',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(91,'GU','Guam','USD',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(92,'GW','Guinea-Bissau','XOF',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(93,'GY','Guyana','GYD',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(94,'HK','Hong Kong','HKD',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(95,'HM','Heard Island and McDonald Islands','AUD',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(96,'HN','Honduras','HNL',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(97,'HR','Croatia','EUR',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(98,'HT','Haiti','HTG',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(99,'HU','Hungary','HUF',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(100,'ID','Indonesia','IDR',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(101,'IE','Ireland','EUR',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(102,'IL','Israel','ILS',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(103,'IM','Isle of Man','GBP',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(104,'IN','India','INR',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(105,'IO','British Indian Ocean Territory','USD',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(106,'IQ','Iraq','IQD',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(107,'IR','Iran','IRR',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,0),(108,'IS','Iceland','ISK',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(109,'IT','Italy','EUR',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(110,'JE','Jersey','GBP',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(111,'JM','Jamaica','JMD',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(112,'JO','Jordan','JOD',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(113,'JP','Japan','JPY',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(114,'KE','Kenya','KES',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(115,'KG','Kyrgyzstan','KGS',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(116,'KH','Cambodia','KHR',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(117,'KI','Kiribati','AUD',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(118,'KM','Comoros','KMF',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(119,'KN','Saint Kitts and Nevis','XCD',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(120,'KP','North Korea','KPW',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,0),(121,'KR','South Korea','KRW',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(122,'KW','Kuwait','KWD',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(123,'KY','Cayman Islands','KYD',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(124,'KZ','Kazakhstan','KZT',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(125,'LA','Laos','LAK',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(126,'LB','Lebanon','LBP',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(127,'LC','Saint Lucia','XCD',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(128,'LI','Liechtenstein','CHF',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(129,'LK','Sri Lanka','LKR',0.00,'2024-08-16 20:05:23','2024-08-16 20:05:23',NULL,1),(130,'LR','Liberia','LRD',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(131,'LS','Lesotho','LSL',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(132,'LT','Lithuania','EUR',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(133,'LU','Luxembourg','EUR',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(134,'LV','Latvia','EUR',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(135,'LY','Libya','LYD',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(136,'MA','Morocco','MAD',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(137,'MC','Monaco','EUR',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(138,'MD','Moldova','MDL',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(139,'ME','Montenegro','EUR',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(140,'MF','Saint Martin','EUR',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(141,'MG','Madagascar','MGA',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(142,'MH','Marshall Islands','USD',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(143,'MK','North Macedonia','MKD',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(144,'ML','Mali','XOF',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(145,'MM','Myanmar','MMK',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(146,'MN','Mongolia','MNT',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(147,'MO','Macao','MOP',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(148,'MP','Northern Mariana Islands','USD',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(149,'MQ','Martinique','EUR',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(150,'MR','Mauritania','MRU',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(151,'MS','Montserrat','XCD',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(152,'MT','Malta','EUR',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(153,'MU','Mauritius','MUR',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(154,'MV','Maldives','MVR',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(155,'MW','Malawi','MWK',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(156,'MX','Mexico','MXN',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(157,'MY','Malaysia','MYR',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(158,'MZ','Mozambique','MZN',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(159,'NA','Namibia','NAD',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(160,'NC','New Caledonia','XPF',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(161,'NE','Niger','XOF',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(162,'NF','Norfolk Island','AUD',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(163,'NG','Nigeria','NGN',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(164,'NI','Nicaragua','NIO',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(165,'NL','The Netherlands','EUR',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(166,'NO','Norway','NOK',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(167,'NP','Nepal','NPR',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(168,'NR','Nauru','AUD',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(169,'NU','Niue','NZD',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(170,'NZ','New Zealand','NZD',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(171,'OM','Oman','OMR',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(172,'PA','Panama','PAB',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(173,'PE','Peru','PEN',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(174,'PF','French Polynesia','XPF',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(175,'PG','Papua New Guinea','PGK',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(176,'PH','Philippines','PHP',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(177,'PK','Pakistan','PKR',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(178,'PL','Poland','PLN',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(179,'PM','Saint Pierre and Miquelon','EUR',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(180,'PN','Pitcairn','NZD',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(181,'PR','Puerto Rico','USD',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(182,'PS','Palestinian Territory','ILS',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(183,'PT','Portugal','EUR',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(184,'PW','Palau','USD',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(185,'PY','Paraguay','PYG',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(186,'QA','Qatar','QAR',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(187,'RE','Reunion','EUR',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(188,'RO','Romania','RON',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(189,'RS','Serbia','RSD',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(190,'RU','Russia','RUB',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(191,'RW','Rwanda','RWF',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(192,'SA','Saudi Arabia','SAR',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(193,'SB','Solomon Islands','SBD',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(194,'SC','Seychelles','SCR',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(195,'SD','Sudan','SDG',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,0),(196,'SS','South Sudan','SSP',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(197,'SE','Sweden','SEK',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(198,'SG','Singapore','SGD',0.00,'2024-08-16 20:05:24','2024-08-16 20:05:24',NULL,1),(199,'SH','Saint Helena','SHP',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(200,'SI','Slovenia','EUR',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(201,'SJ','Svalbard and Jan Mayen','NOK',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(202,'SK','Slovakia','EUR',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(203,'SL','Sierra Leone','SLL',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(204,'SM','San Marino','EUR',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(205,'SN','Senegal','XOF',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(206,'SO','Somalia','SOS',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(207,'SR','Suriname','SRD',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(208,'ST','Sao Tome and Principe','STN',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(209,'SV','El Salvador','USD',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(210,'SX','Sint Maarten','ANG',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(211,'SY','Syria','SYP',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,0),(212,'SZ','Eswatini','SZL',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(213,'TC','Turks and Caicos Islands','USD',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(214,'TD','Chad','XAF',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(215,'TF','French Southern Territories','EUR',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(216,'TG','Togo','XOF',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(217,'TH','Thailand','THB',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(218,'TJ','Tajikistan','TJS',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(219,'TK','Tokelau','NZD',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(220,'TL','Timor Leste','USD',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(221,'TM','Turkmenistan','TMT',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(222,'TN','Tunisia','TND',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(223,'TO','Tonga','TOP',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(224,'TR','Turkey','TRY',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(225,'TT','Trinidad and Tobago','TTD',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(226,'TV','Tuvalu','AUD',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(227,'TW','Taiwan','TWD',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(228,'TZ','Tanzania','TZS',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(229,'UA','Ukraine','UAH',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(230,'UG','Uganda','UGX',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(231,'US','United States','USD',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(232,'UY','Uruguay','UYU',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(233,'UZ','Uzbekistan','UZS',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(234,'VA','Vatican','EUR',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(235,'VC','Saint Vincent and the Grenadines','XCD',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(236,'VE','Venezuela','VES',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(237,'VG','British Virgin Islands','USD',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(238,'VI','U.S. Virgin Islands','USD',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(239,'VN','Vietnam','VND',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(240,'VU','Vanuatu','VUV',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(241,'WF','Wallis and Futuna','XPF',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(242,'WS','Samoa','WST',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(243,'YE','Yemen','YER',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(244,'YT','Mayotte','EUR',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(245,'ZA','South Africa','ZAR',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(246,'ZM','Zambia','ZMW',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(247,'ZW','Zimbabwe','ZWL',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1),(248,'AN','Netherlands Antilles','ANG',0.00,'2024-08-16 20:05:25','2024-08-16 20:05:25',NULL,1);
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deleted_objects`
--

DROP TABLE IF EXISTS `deleted_objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deleted_objects` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `owner_id` bigint DEFAULT NULL,
  `owner_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `object_id` bigint DEFAULT NULL,
  `object_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `metadata` text COLLATE utf8mb3_bin,
  PRIMARY KEY (`id`),
  KEY `index_deleted_objects_on_object_type_and_object_id` (`object_type`,`object_id`),
  KEY `index_deleted_objects_on_owner_type_and_owner_id` (`owner_type`,`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deleted_objects`
--

LOCK TABLES `deleted_objects` WRITE;
/*!40000 ALTER TABLE `deleted_objects` DISABLE KEYS */;
/*!40000 ALTER TABLE `deleted_objects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_configurations`
--

DROP TABLE IF EXISTS `email_configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_configurations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` int DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `domain` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `user_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `authentication` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `tls` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `openssl_verify_mode` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `port` smallint unsigned DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_email_configurations_on_email` (`email`),
  KEY `index_email_configurations_on_account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_configurations`
--

LOCK TABLES `email_configurations` WRITE;
/*!40000 ALTER TABLE `email_configurations` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_configurations` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `email_configurations_tenant_id` BEFORE INSERT ON `email_configurations` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.account_id <> master_id THEN
    SET NEW.tenant_id = NEW.account_id;
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `event_store_events`
--

DROP TABLE IF EXISTS `event_store_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_store_events` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `stream` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `event_type` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `event_id` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `metadata` mediumtext COLLATE utf8mb3_bin,
  `data` text COLLATE utf8mb3_bin,
  `created_at` datetime NOT NULL,
  `provider_id` bigint DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_event_store_events_on_event_id` (`event_id`),
  KEY `index_event_store_events_on_created_at` (`created_at`),
  KEY `index_event_store_events_on_provider_id` (`provider_id`),
  KEY `index_event_store_events_on_stream` (`stream`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_store_events`
--

LOCK TABLES `event_store_events` WRITE;
/*!40000 ALTER TABLE `event_store_events` DISABLE KEYS */;
INSERT INTO `event_store_events` VALUES (1,'all','Domains::ProviderDomainsChangedEvent','a5c4e83b-9d16-4518-bebd-493b1b83d44b','---\n:provider_id: 1\n:zync:\n  :tenant_id: 1\n:timestamp: 2024-08-16 20:05:18.096062106 Z\n','---\nparent_event_id: \nparent_event_type: \nprovider:\n  _aj_globalid: gid://system/Account/1\nadmin_domains:\n- master.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com\ndeveloper_domains:\n- master.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com\n_aj_symbol_keys:\n- parent_event_id\n- parent_event_type\n- provider\n- admin_domains\n- developer_domains\n','2024-08-16 20:05:18',1,1),(2,'zync','ZyncEvent','8e37e996-bd35-4645-99c6-e385e4a336f0','---\n:provider_id: 1\n:zync:\n  :tenant_id: 1\n:timestamp: 2024-08-16 20:05:18.096062106 Z\n','---\ntype: Provider\nid: 1\nparent_event_id: a5c4e83b-9d16-4518-bebd-493b1b83d44b\nparent_event_type: Domains::ProviderDomainsChangedEvent\ntenant_id: 1\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n','2024-08-16 20:05:18',1,1),(3,'all','Accounts::AccountStateChangedEvent','b48e9ef4-c31b-40db-8a8f-5030ffaf39ef','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:05:18.184412211 Z\n','---\naccount:\n  _aj_globalid: gid://system/Account/1\nstate: approved\nprevious_state: created\nprovider:\n  _aj_globalid: gid://system/Account/1\n_aj_symbol_keys:\n- account\n- state\n- previous_state\n- provider\n','2024-08-16 20:05:18',1,1),(4,'b48e9ef4-c31b-40db-8a8f-5030ffaf39ef','NotificationEvent','f2937f42-2480-44fa-9eb2-f903afe1aba7','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:05:18.194913897 Z\n','---\nparent_event_id: b48e9ef4-c31b-40db-8a8f-5030ffaf39ef\nsystem_name: account_state_changed\nprovider_id: 1\n_aj_symbol_keys:\n- parent_event_id\n- system_name\n- provider_id\n','2024-08-16 20:05:18',1,1),(5,'all','Domains::ProxyDomainsChangedEvent','c234d45b-62bf-4e10-8eda-ca4ef64b240e','---\n:provider_id: 1\n:zync:\n  :tenant_id: 1\n  :service_id: 1\n:timestamp: 2024-08-16 20:05:19.462506796 Z\n','---\nparent_event_id: \nparent_event_type: \nproxy:\n  _aj_globalid: gid://system/MissingModel::MissingProxy/1\nstaging_domains:\n- master-service-master-apicast-staging.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com\nproduction_domains:\n- master-service-master-apicast-production.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com\n_aj_symbol_keys:\n- parent_event_id\n- parent_event_type\n- proxy\n- staging_domains\n- production_domains\n','2024-08-16 20:05:19',1,1),(6,'zync','ZyncEvent','23299df4-aa2d-4d4c-a0fe-86cf86ccab3a','---\n:provider_id: 1\n:zync:\n  :tenant_id: 1\n  :service_id: 1\n:timestamp: 2024-08-16 20:05:19.462506796 Z\n','---\ntype: Proxy\nid: 1\nparent_event_id: c234d45b-62bf-4e10-8eda-ca4ef64b240e\nparent_event_type: Domains::ProxyDomainsChangedEvent\ntenant_id: 1\nservice_id: 1\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n- service_id\n','2024-08-16 20:05:19',1,1),(7,'all','OIDC::ServiceChangedEvent','25f62a12-4ac1-4f7e-b1c4-a5e71bc109f6','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:05:19.483798089 Z\n','---\nid: 1\nservice:\n  _aj_globalid: gid://system/Service/1\n_aj_symbol_keys:\n- id\n- service\n','2024-08-16 20:05:19',1,1),(8,'zync','ZyncEvent','68838efd-0fb6-4c54-bdd4-e92a2540ab76','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:05:19.483798089 Z\n','---\ntype: Service\nid: 1\nparent_event_id: 25f62a12-4ac1-4f7e-b1c4-a5e71bc109f6\nparent_event_type: OIDC::ServiceChangedEvent\ntenant_id: 1\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n','2024-08-16 20:05:19',1,1),(9,'all','OIDC::ServiceChangedEvent','b1789cf1-7eb7-4d7b-97dc-617ca800adb5','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:05:19.555767531 Z\n','---\nid: 1\nservice:\n  _aj_globalid: gid://system/Service/1\n_aj_symbol_keys:\n- id\n- service\n','2024-08-16 20:05:19',1,1),(10,'zync','ZyncEvent','9029447b-2365-4b6d-813d-807e430ceb3e','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:05:19.555767531 Z\n','---\ntype: Service\nid: 1\nparent_event_id: b1789cf1-7eb7-4d7b-97dc-617ca800adb5\nparent_event_type: OIDC::ServiceChangedEvent\ntenant_id: 1\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n','2024-08-16 20:05:19',1,1),(11,'all','OIDC::ServiceChangedEvent','2dfbe8c8-b779-4e7f-8bf4-23a7439f5cf9','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:05:19.642263095 Z\n','---\nid: 1\nservice:\n  _aj_globalid: gid://system/Service/1\n_aj_symbol_keys:\n- id\n- service\n','2024-08-16 20:05:19',1,1),(12,'zync','ZyncEvent','317e2a13-3b35-43f2-8c5e-5a0706185a4a','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:05:19.642263095 Z\n','---\ntype: Service\nid: 1\nparent_event_id: 2dfbe8c8-b779-4e7f-8bf4-23a7439f5cf9\nparent_event_type: OIDC::ServiceChangedEvent\ntenant_id: 1\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n','2024-08-16 20:05:19',1,1),(13,'all','Applications::ApplicationCreatedEvent','fbd0f792-bd76-4baa-8902-b4d8bace3f89','---\n:provider_id: 1\n:zync:\n  :service_id: 1\n:timestamp: 2024-08-16 20:05:19.680822887 Z\n','---\napplication:\n  _aj_globalid: gid://system/Cinstance/1\naccount:\n  _aj_globalid: gid://system/Account/1\nprovider:\n  _aj_globalid: gid://system/Account/1\nservice:\n  _aj_globalid: gid://system/Service/1\nplan:\n  _aj_globalid: gid://system/ApplicationPlan/2\nuser:\n  _aj_globalid: gid://system/User/1\n_aj_symbol_keys:\n- application\n- account\n- provider\n- service\n- plan\n- user\n','2024-08-16 20:05:19',1,1),(14,'fbd0f792-bd76-4baa-8902-b4d8bace3f89','NotificationEvent','7f0e613f-9275-437d-a3d0-60de53da8b13','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:05:19.698400047 Z\n','---\nparent_event_id: fbd0f792-bd76-4baa-8902-b4d8bace3f89\nsystem_name: application_created\nprovider_id: 1\n_aj_symbol_keys:\n- parent_event_id\n- system_name\n- provider_id\n','2024-08-16 20:05:19',1,1),(15,'zync','ZyncEvent','3e9ae799-3c4a-4931-88e2-2b281faa1f45','---\n:provider_id: 1\n:zync:\n  :service_id: 1\n:timestamp: 2024-08-16 20:05:19.680822887 Z\n','---\ntype: Application\nid: 1\nparent_event_id: fbd0f792-bd76-4baa-8902-b4d8bace3f89\nparent_event_type: Applications::ApplicationCreatedEvent\ntenant_id: 1\nservice_id: 1\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n- service_id\n','2024-08-16 20:05:19',1,1),(16,'all','OIDC::ServiceChangedEvent','3fb0f805-9366-41e5-a7f4-47e98baa0986','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:05:19.833612136 Z\n','---\nid: 1\nservice:\n  _aj_globalid: gid://system/Service/1\n_aj_symbol_keys:\n- id\n- service\n','2024-08-16 20:05:19',1,1),(17,'zync','ZyncEvent','12c788e2-ff1c-4068-b4e5-9778b441a71b','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:05:19.833612136 Z\n','---\ntype: Service\nid: 1\nparent_event_id: 3fb0f805-9366-41e5-a7f4-47e98baa0986\nparent_event_type: OIDC::ServiceChangedEvent\ntenant_id: 1\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n','2024-08-16 20:05:19',1,1),(18,'all','Domains::ProxyDomainsChangedEvent','4c47ea56-2593-4eb6-87cf-7d27d58390f1','---\n:provider_id: 1\n:zync:\n  :tenant_id: 1\n  :service_id: 1\n:timestamp: 2024-08-16 20:05:19.865644037 Z\n','---\nparent_event_id: \nparent_event_type: \nproxy:\n  _aj_globalid: gid://system/MissingModel::MissingProxy/1\nstaging_domains:\n- \nproduction_domains:\n- \n_aj_symbol_keys:\n- parent_event_id\n- parent_event_type\n- proxy\n- staging_domains\n- production_domains\n','2024-08-16 20:05:19',1,1),(19,'zync','ZyncEvent','d99c35c2-c984-4479-9261-7a905282160c','---\n:provider_id: 1\n:zync:\n  :tenant_id: 1\n  :service_id: 1\n:timestamp: 2024-08-16 20:05:19.865644037 Z\n','---\ntype: Proxy\nid: 1\nparent_event_id: 4c47ea56-2593-4eb6-87cf-7d27d58390f1\nparent_event_type: Domains::ProxyDomainsChangedEvent\ntenant_id: 1\nservice_id: 1\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n- service_id\n','2024-08-16 20:05:19',1,1),(20,'all','OIDC::ServiceChangedEvent','a705c93d-6c12-4915-a988-25cdac87ce81','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:05:19.875544019 Z\n','---\nid: 1\nservice:\n  _aj_globalid: gid://system/Service/1\n_aj_symbol_keys:\n- id\n- service\n','2024-08-16 20:05:19',1,1),(21,'zync','ZyncEvent','dbae21ef-8277-4f52-b6cb-3227eba8f79c','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:05:19.875544019 Z\n','---\ntype: Service\nid: 1\nparent_event_id: a705c93d-6c12-4915-a988-25cdac87ce81\nparent_event_type: OIDC::ServiceChangedEvent\ntenant_id: 1\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n','2024-08-16 20:05:19',1,1),(22,'all','Applications::ApplicationCreatedEvent','8d4b2593-3b32-4cb8-b0d7-7d190da47a45','---\n:provider_id: 1\n:zync:\n  :service_id: 1\n:timestamp: 2024-08-16 20:05:20.144689909 Z\n','---\napplication:\n  _aj_globalid: gid://system/Cinstance/2\naccount:\n  _aj_globalid: gid://system/Account/2\nprovider:\n  _aj_globalid: gid://system/Account/1\nservice:\n  _aj_globalid: gid://system/Service/1\nplan:\n  _aj_globalid: gid://system/ApplicationPlan/4\nuser: \n_aj_symbol_keys:\n- application\n- account\n- provider\n- service\n- plan\n- user\n','2024-08-16 20:05:20',1,1),(23,'8d4b2593-3b32-4cb8-b0d7-7d190da47a45','NotificationEvent','20184864-1703-4678-934b-ce0eb3419fc6','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:05:20.157851582 Z\n','---\nparent_event_id: 8d4b2593-3b32-4cb8-b0d7-7d190da47a45\nsystem_name: application_created\nprovider_id: 1\n_aj_symbol_keys:\n- parent_event_id\n- system_name\n- provider_id\n','2024-08-16 20:05:20',1,1),(24,'zync','ZyncEvent','c6123829-be4f-48f2-b512-2e9742ecaaf7','---\n:provider_id: 1\n:zync:\n  :service_id: 1\n:timestamp: 2024-08-16 20:05:20.144689909 Z\n','---\ntype: Application\nid: 2\nparent_event_id: 8d4b2593-3b32-4cb8-b0d7-7d190da47a45\nparent_event_type: Applications::ApplicationCreatedEvent\ntenant_id: 1\nservice_id: 1\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n- service_id\n','2024-08-16 20:05:20',1,1),(25,'all','Domains::ProxyDomainsChangedEvent','5e3aedfb-b5e7-4d01-a15e-d5112cd48bb4','---\n:provider_id: 2\n:zync:\n  :tenant_id: 2\n  :service_id: 2\n:timestamp: 2024-08-16 20:05:20.245596803 Z\n','---\nparent_event_id: \nparent_event_type: \nproxy:\n  _aj_globalid: gid://system/MissingModel::MissingProxy/2\nstaging_domains:\n- api-3scale-apicast-staging.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com\nproduction_domains:\n- api-3scale-apicast-production.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com\n_aj_symbol_keys:\n- parent_event_id\n- parent_event_type\n- proxy\n- staging_domains\n- production_domains\n','2024-08-16 20:05:20',2,2),(26,'zync','ZyncEvent','9e1048d0-7527-43ef-979d-033f3aa76f6e','---\n:provider_id: 2\n:zync:\n  :tenant_id: 2\n  :service_id: 2\n:timestamp: 2024-08-16 20:05:20.245596803 Z\n','---\ntype: Proxy\nid: 2\nparent_event_id: 5e3aedfb-b5e7-4d01-a15e-d5112cd48bb4\nparent_event_type: Domains::ProxyDomainsChangedEvent\ntenant_id: 2\nservice_id: 2\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n- service_id\n','2024-08-16 20:05:20',2,2),(27,'all','OIDC::ServiceChangedEvent','8b7af474-8b18-4316-ad6a-241f41916c52','---\n:provider_id: 2\n:timestamp: 2024-08-16 20:05:20.263421235 Z\n','---\nid: 2\nservice:\n  _aj_globalid: gid://system/Service/2\n_aj_symbol_keys:\n- id\n- service\n','2024-08-16 20:05:20',2,2),(28,'zync','ZyncEvent','37039681-c5df-4f2d-94d5-9f4a208638fd','---\n:provider_id: 2\n:timestamp: 2024-08-16 20:05:20.263421235 Z\n','---\ntype: Service\nid: 2\nparent_event_id: 8b7af474-8b18-4316-ad6a-241f41916c52\nparent_event_type: OIDC::ServiceChangedEvent\ntenant_id: 2\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n','2024-08-16 20:05:20',2,2),(29,'all','Domains::ProviderDomainsChangedEvent','41eb68a1-b181-4f3c-accb-7570046d659b','---\n:provider_id: 2\n:zync:\n  :tenant_id: 2\n:timestamp: 2024-08-16 20:05:20.344754265 Z\n','---\nparent_event_id: \nparent_event_type: \nprovider:\n  _aj_globalid: gid://system/Account/2\nadmin_domains:\n- 3scale-admin.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com\ndeveloper_domains:\n- 3scale.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com\n_aj_symbol_keys:\n- parent_event_id\n- parent_event_type\n- provider\n- admin_domains\n- developer_domains\n','2024-08-16 20:05:20',2,2),(30,'zync','ZyncEvent','7a06092a-bc79-4108-88b0-62dbe8eba67a','---\n:provider_id: 2\n:zync:\n  :tenant_id: 2\n:timestamp: 2024-08-16 20:05:20.344754265 Z\n','---\ntype: Provider\nid: 2\nparent_event_id: 41eb68a1-b181-4f3c-accb-7570046d659b\nparent_event_type: Domains::ProviderDomainsChangedEvent\ntenant_id: 2\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n','2024-08-16 20:05:20',2,2),(31,'all','Accounts::AccountStateChangedEvent','97da05ae-87d9-41d0-b97f-ab43df8f8f8b','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:05:20.376790496 Z\n','---\naccount:\n  _aj_globalid: gid://system/Account/2\nstate: approved\nprevious_state: created\nprovider:\n  _aj_globalid: gid://system/Account/1\n_aj_symbol_keys:\n- account\n- state\n- previous_state\n- provider\n','2024-08-16 20:05:20',1,1),(32,'97da05ae-87d9-41d0-b97f-ab43df8f8f8b','NotificationEvent','a655754e-b149-4b80-acc7-32a2ad1aecff','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:05:20.385031958 Z\n','---\nparent_event_id: 97da05ae-87d9-41d0-b97f-ab43df8f8f8b\nsystem_name: account_state_changed\nprovider_id: 1\n_aj_symbol_keys:\n- parent_event_id\n- system_name\n- provider_id\n','2024-08-16 20:05:20',1,1),(33,'all','Services::ServiceCreatedEvent','a30f7517-7418-4f2f-89ae-63af5eaad503','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:05:21.291274848 Z\n','---\nservice:\n  _aj_globalid: gid://system/Service/1\nuser: \nprovider:\n  _aj_globalid: gid://system/Account/1\ntoken_value: d961dc71504f2716923ec30e2680ae93453e835b3ff8cf1ba4b76adb20818ddb\n_aj_symbol_keys:\n- service\n- user\n- provider\n- token_value\n','2024-08-16 20:05:21',1,1),(34,'all','Services::ServiceCreatedEvent','d6edab9e-cfb9-44e4-9ee8-e9c70dad1350','---\n:provider_id: 2\n:timestamp: 2024-08-16 20:05:21.907776029 Z\n','---\nservice:\n  _aj_globalid: gid://system/Service/2\nuser: \nprovider:\n  _aj_globalid: gid://system/Account/2\ntoken_value: 25faf639e193f6f106168be75b1227d7b9fb999d2de53b8fa188ef500cca396f\n_aj_symbol_keys:\n- service\n- user\n- provider\n- token_value\n','2024-08-16 20:05:21',2,2),(35,'all','OIDC::ServiceChangedEvent','a0b7e801-aaa6-4d9f-ba2a-26caa16f44f3','---\n:provider_id: 2\n:timestamp: 2024-08-16 20:07:48.633994078 Z\n','---\nid: 2\nservice:\n  _aj_globalid: gid://system/Service/2\n_aj_symbol_keys:\n- id\n- service\n','2024-08-16 20:07:48',2,2),(36,'zync','ZyncEvent','70b7d33f-e30a-4858-9051-84dc8fc0750c','---\n:provider_id: 2\n:timestamp: 2024-08-16 20:07:48.633994078 Z\n','---\ntype: Service\nid: 2\nparent_event_id: a0b7e801-aaa6-4d9f-ba2a-26caa16f44f3\nparent_event_type: OIDC::ServiceChangedEvent\ntenant_id: 2\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n','2024-08-16 20:07:48',2,2),(37,'all','OIDC::ServiceChangedEvent','860b9e0c-7b6b-4518-9f36-4bcf5b47b17c','---\n:provider_id: 2\n:timestamp: 2024-08-16 20:07:49.213711503 Z\n','---\nid: 2\nservice:\n  _aj_globalid: gid://system/Service/2\n_aj_symbol_keys:\n- id\n- service\n','2024-08-16 20:07:49',2,2),(38,'zync','ZyncEvent','43c1daf7-c396-40d2-afe1-00768ab4f7f1','---\n:provider_id: 2\n:timestamp: 2024-08-16 20:07:49.213711503 Z\n','---\ntype: Service\nid: 2\nparent_event_id: 860b9e0c-7b6b-4518-9f36-4bcf5b47b17c\nparent_event_type: OIDC::ServiceChangedEvent\ntenant_id: 2\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n','2024-08-16 20:07:49',2,2),(39,'zync','ZyncEvent','de3fe2d1-ee8e-4cb0-a88d-632e3cc9db2f','---\n:provider_id: 1\n:zync:\n  :service_id: 1\n:timestamp: 2024-08-16 20:05:20.144689909 Z\n','---\ntype: Service\nid: 1\nparent_event_id: c6123829-be4f-48f2-b512-2e9742ecaaf7\nparent_event_type: ZyncEvent\ntenant_id: 1\nservice_id: 1\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n- service_id\n','2024-08-16 20:07:50',1,1),(40,'zync','ZyncEvent','a28ce6e7-9019-4565-afe9-e40ab02b47fa','---\n:provider_id: 1\n:zync:\n  :service_id: 1\n:timestamp: 2024-08-16 20:05:20.144689909 Z\n','---\ntype: Proxy\nid: 1\nparent_event_id: c6123829-be4f-48f2-b512-2e9742ecaaf7\nparent_event_type: ZyncEvent\ntenant_id: 1\nservice_id: 1\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n- service_id\n','2024-08-16 20:07:50',1,1),(41,'zync','ZyncEvent','5cdc8e08-2541-40ee-adaa-68d64dedff8f','---\n:provider_id: 1\n:zync:\n  :tenant_id: 1\n  :service_id: 1\n:timestamp: 2024-08-16 20:05:19.462506796 Z\n','---\ntype: Service\nid: 1\nparent_event_id: 23299df4-aa2d-4d4c-a0fe-86cf86ccab3a\nparent_event_type: ZyncEvent\ntenant_id: 1\nservice_id: 1\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n- service_id\n','2024-08-16 20:07:50',1,1),(42,'zync','ZyncEvent','73bd984b-abf4-48fd-8fab-bb7305293b0e','---\n:provider_id: 2\n:zync:\n  :tenant_id: 2\n  :service_id: 2\n:timestamp: 2024-08-16 20:05:20.245596803 Z\n','---\ntype: Service\nid: 2\nparent_event_id: 9e1048d0-7527-43ef-979d-033f3aa76f6e\nparent_event_type: ZyncEvent\ntenant_id: 2\nservice_id: 2\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n- service_id\n','2024-08-16 20:07:50',2,2),(43,'all','ServiceContracts::ServiceContractCreatedEvent','4eecf869-7b99-4cb7-9b4c-a55c4d98458d','---\n:provider_id: 2\n:timestamp: 2024-08-16 20:07:51.780665341 Z\n','---\nservice_contract:\n  _aj_globalid: gid://system/ServiceContract/4\nservice:\n  _aj_globalid: gid://system/Service/2\nplan:\n  _aj_globalid: gid://system/ServicePlan/5\nprovider:\n  _aj_globalid: gid://system/Account/2\naccount:\n  _aj_globalid: gid://system/Account/3\nuser:\n  _aj_globalid: gid://system/User/4\n_aj_symbol_keys:\n- service_contract\n- service\n- plan\n- provider\n- account\n- user\n','2024-08-16 20:07:51',2,2),(44,'all','Applications::ApplicationCreatedEvent','838c31c3-667a-4e19-9c9b-1028009ceda1','---\n:provider_id: 2\n:zync:\n  :service_id: 2\n:timestamp: 2024-08-16 20:07:51.855718509 Z\n','---\napplication:\n  _aj_globalid: gid://system/Cinstance/5\naccount:\n  _aj_globalid: gid://system/Account/3\nprovider:\n  _aj_globalid: gid://system/Account/2\nservice:\n  _aj_globalid: gid://system/Service/2\nplan:\n  _aj_globalid: gid://system/ApplicationPlan/7\nuser:\n  _aj_globalid: gid://system/User/4\n_aj_symbol_keys:\n- application\n- account\n- provider\n- service\n- plan\n- user\n','2024-08-16 20:07:51',2,2),(45,'zync','ZyncEvent','1dfd78d7-5776-4ef0-980f-4f2534dc03cd','---\n:provider_id: 2\n:zync:\n  :service_id: 2\n:timestamp: 2024-08-16 20:07:51.855718509 Z\n','---\ntype: Application\nid: 5\nparent_event_id: 838c31c3-667a-4e19-9c9b-1028009ceda1\nparent_event_type: Applications::ApplicationCreatedEvent\ntenant_id: 2\nservice_id: 2\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n- service_id\n','2024-08-16 20:07:51',2,2),(46,'all','Accounts::AccountStateChangedEvent','0e362672-fa55-4508-a6c0-5e2f73954d58','---\n:provider_id: 2\n:timestamp: 2024-08-16 20:07:51.893304820 Z\n','---\naccount:\n  _aj_globalid: gid://system/Account/3\nstate: approved\nprevious_state: created\nprovider:\n  _aj_globalid: gid://system/Account/2\n_aj_symbol_keys:\n- account\n- state\n- previous_state\n- provider\n','2024-08-16 20:07:51',2,2),(47,'all','Accounts::AccountCreatedEvent','13219508-ee24-4b2b-bbae-b4c28ff0a4b1','---\n:provider_id: 2\n:timestamp: 2024-08-16 20:07:51.948624579 Z\n','---\nprovider:\n  _aj_globalid: gid://system/Account/2\naccount:\n  _aj_globalid: gid://system/Account/3\nuser:\n  _aj_globalid: gid://system/User/4\n_aj_symbol_keys:\n- provider\n- account\n- user\n','2024-08-16 20:07:51',2,2),(48,'all','Domains::ProviderDomainsChangedEvent','7eab7b7a-8dd2-4d01-a84f-4cd2a58284b3','---\n:provider_id: 4\n:zync:\n  :tenant_id: 4\n:timestamp: 2024-08-16 20:12:24.767994617 Z\n','---\nparent_event_id: \nparent_event_type: \nprovider:\n  _aj_globalid: gid://system/Account/4\nadmin_domains:\n- demo-organization-admin.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com\ndeveloper_domains:\n- demo-organization.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com\n_aj_symbol_keys:\n- parent_event_id\n- parent_event_type\n- provider\n- admin_domains\n- developer_domains\n','2024-08-16 20:12:24',4,4),(49,'zync','ZyncEvent','19d9c922-d627-4e81-8057-8c689a9ac48e','---\n:provider_id: 4\n:zync:\n  :tenant_id: 4\n:timestamp: 2024-08-16 20:12:24.767994617 Z\n','---\ntype: Provider\nid: 4\nparent_event_id: 7eab7b7a-8dd2-4d01-a84f-4cd2a58284b3\nparent_event_type: Domains::ProviderDomainsChangedEvent\ntenant_id: 4\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n','2024-08-16 20:12:24',4,4),(50,'all','ServiceContracts::ServiceContractCreatedEvent','cb70ee3d-08c5-4d22-b4ee-7f0def489ccc','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:12:24.852895848 Z\n','---\nservice_contract:\n  _aj_globalid: gid://system/ServiceContract/7\nservice:\n  _aj_globalid: gid://system/Service/1\nplan:\n  _aj_globalid: gid://system/ServicePlan/1\nprovider:\n  _aj_globalid: gid://system/Account/1\naccount:\n  _aj_globalid: gid://system/Account/4\nuser:\n  _aj_globalid: gid://system/User/1\n_aj_symbol_keys:\n- service_contract\n- service\n- plan\n- provider\n- account\n- user\n','2024-08-16 20:12:24',1,1),(51,'cb70ee3d-08c5-4d22-b4ee-7f0def489ccc','NotificationEvent','f2d353a4-4799-45c7-a6d1-ec9f859ac420','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:12:24.869501374 Z\n','---\nparent_event_id: cb70ee3d-08c5-4d22-b4ee-7f0def489ccc\nsystem_name: service_contract_created\nprovider_id: 1\n_aj_symbol_keys:\n- parent_event_id\n- system_name\n- provider_id\n','2024-08-16 20:12:24',1,1),(52,'all','Applications::ApplicationCreatedEvent','0480850b-5f57-4b56-881a-35b9667c4ca9','---\n:provider_id: 1\n:zync:\n  :service_id: 1\n:timestamp: 2024-08-16 20:12:24.908575042 Z\n','---\napplication:\n  _aj_globalid: gid://system/Cinstance/8\naccount:\n  _aj_globalid: gid://system/Account/4\nprovider:\n  _aj_globalid: gid://system/Account/1\nservice:\n  _aj_globalid: gid://system/Service/1\nplan:\n  _aj_globalid: gid://system/ApplicationPlan/4\nuser:\n  _aj_globalid: gid://system/User/1\n_aj_symbol_keys:\n- application\n- account\n- provider\n- service\n- plan\n- user\n','2024-08-16 20:12:24',1,1),(53,'0480850b-5f57-4b56-881a-35b9667c4ca9','NotificationEvent','025ed69d-c720-4a8a-85aa-3d5b1c680e90','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:12:24.923917200 Z\n','---\nparent_event_id: \'0480850b-5f57-4b56-881a-35b9667c4ca9\'\nsystem_name: application_created\nprovider_id: 1\n_aj_symbol_keys:\n- parent_event_id\n- system_name\n- provider_id\n','2024-08-16 20:12:24',1,1),(54,'zync','ZyncEvent','51bd30ef-984c-4440-b05e-e9be3438df3d','---\n:provider_id: 1\n:zync:\n  :service_id: 1\n:timestamp: 2024-08-16 20:12:24.908575042 Z\n','---\ntype: Application\nid: 8\nparent_event_id: \'0480850b-5f57-4b56-881a-35b9667c4ca9\'\nparent_event_type: Applications::ApplicationCreatedEvent\ntenant_id: 1\nservice_id: 1\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n- service_id\n','2024-08-16 20:12:24',1,1),(55,'all','Domains::ProxyDomainsChangedEvent','f61de30a-5c55-476b-9d06-bcd2d165d7cc','---\n:provider_id: 4\n:zync:\n  :tenant_id: 4\n  :service_id: 3\n:timestamp: 2024-08-16 20:12:25.081259163 Z\n','---\nparent_event_id: \nparent_event_type: \nproxy:\n  _aj_globalid: gid://system/MissingModel::MissingProxy/3\nstaging_domains:\n- api-demo-organization-apicast-staging.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com\nproduction_domains:\n- api-demo-organization-apicast-production.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com\n_aj_symbol_keys:\n- parent_event_id\n- parent_event_type\n- proxy\n- staging_domains\n- production_domains\n','2024-08-16 20:12:25',4,4),(56,'zync','ZyncEvent','62a6c30b-727c-48c1-87da-d4d379c796aa','---\n:provider_id: 4\n:zync:\n  :tenant_id: 4\n  :service_id: 3\n:timestamp: 2024-08-16 20:12:25.081259163 Z\n','---\ntype: Proxy\nid: 3\nparent_event_id: f61de30a-5c55-476b-9d06-bcd2d165d7cc\nparent_event_type: Domains::ProxyDomainsChangedEvent\ntenant_id: 4\nservice_id: 3\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n- service_id\n','2024-08-16 20:12:25',4,4),(57,'all','OIDC::ServiceChangedEvent','62108e7e-0b99-4b00-b420-fcaab49cb88c','---\n:provider_id: 4\n:timestamp: 2024-08-16 20:12:25.099869792 Z\n','---\nid: 3\nservice:\n  _aj_globalid: gid://system/Service/3\n_aj_symbol_keys:\n- id\n- service\n','2024-08-16 20:12:25',4,4),(58,'zync','ZyncEvent','17ab5af3-b584-49a3-9dc9-78c7d3a8f190','---\n:provider_id: 4\n:timestamp: 2024-08-16 20:12:25.099869792 Z\n','---\ntype: Service\nid: 3\nparent_event_id: 62108e7e-0b99-4b00-b420-fcaab49cb88c\nparent_event_type: OIDC::ServiceChangedEvent\ntenant_id: 4\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n','2024-08-16 20:12:25',4,4),(59,'all','Accounts::AccountCreatedEvent','71db73f6-3097-43b1-b910-07152d30353d','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:12:25.515868073 Z\n','---\nprovider:\n  _aj_globalid: gid://system/Account/1\naccount:\n  _aj_globalid: gid://system/Account/4\nuser:\n  _aj_globalid: gid://system/User/5\n_aj_symbol_keys:\n- provider\n- account\n- user\n','2024-08-16 20:12:25',1,1),(60,'71db73f6-3097-43b1-b910-07152d30353d','NotificationEvent','aa10de43-a679-4dcf-87a0-6ed612ca44c6','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:12:25.526396950 Z\n','---\nparent_event_id: 71db73f6-3097-43b1-b910-07152d30353d\nsystem_name: account_created\nprovider_id: 1\n_aj_symbol_keys:\n- parent_event_id\n- system_name\n- provider_id\n','2024-08-16 20:12:25',1,1),(61,'all','Services::ServiceCreatedEvent','f27baf56-9d7d-42bd-958f-09631a30da6a','---\n:provider_id: 4\n:timestamp: 2024-08-16 20:12:25.751992268 Z\n','---\nservice:\n  _aj_globalid: gid://system/Service/3\nuser:\n  _aj_globalid: gid://system/User/1\nprovider:\n  _aj_globalid: gid://system/Account/4\ntoken_value: d1d7665258c60577d663569039811db918d277c571f3b0b98f222d7498643b67\n_aj_symbol_keys:\n- service\n- user\n- provider\n- token_value\n','2024-08-16 20:12:25',4,4),(62,'all','Accounts::AccountStateChangedEvent','d636702e-1019-4dee-ad8b-1840e28b24ce','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:12:25.891797739 Z\n','---\naccount:\n  _aj_globalid: gid://system/Account/4\nstate: approved\nprevious_state: created\nprovider:\n  _aj_globalid: gid://system/Account/1\n_aj_symbol_keys:\n- account\n- state\n- previous_state\n- provider\n','2024-08-16 20:12:25',1,1),(63,'d636702e-1019-4dee-ad8b-1840e28b24ce','NotificationEvent','97f32f2a-f235-4455-812b-5bce7d3f257b','---\n:provider_id: 1\n:timestamp: 2024-08-16 20:12:25.901150009 Z\n','---\nparent_event_id: d636702e-1019-4dee-ad8b-1840e28b24ce\nsystem_name: account_state_changed\nprovider_id: 1\n_aj_symbol_keys:\n- parent_event_id\n- system_name\n- provider_id\n','2024-08-16 20:12:25',1,1),(64,'all','ProxyConfigs::AffectingObjectChangedEvent','1be9d685-2980-4c5f-b87a-56785b6ece77','---\n:service_id: 3\n:provider_id: 4\n:timestamp: 2024-08-16 20:12:25.982318656 Z\n','---\nproxy_id: 3\nobject_id: \nobject_type: ProxyConfigAffectingChanges::Tracker\n_aj_symbol_keys:\n- proxy_id\n- object_id\n- object_type\n','2024-08-16 20:12:25',4,4),(65,'zync','ZyncEvent','6a5fc3a5-04f9-4786-9113-0ae59305f982','---\n:provider_id: 4\n:zync:\n  :tenant_id: 4\n  :service_id: 3\n:timestamp: 2024-08-16 20:12:25.081259163 Z\n','---\ntype: Service\nid: 3\nparent_event_id: 62a6c30b-727c-48c1-87da-d4d379c796aa\nparent_event_type: ZyncEvent\ntenant_id: 4\nservice_id: 3\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n- service_id\n','2024-08-16 20:12:26',4,4),(66,'all','OIDC::ServiceChangedEvent','c61c2ae7-a6c3-465c-a13e-09feb2d5a1bc','---\n:provider_id: 4\n:timestamp: 2024-08-16 20:12:48.797333694 Z\n','---\nid: 3\nservice:\n  _aj_globalid: gid://system/Service/3\n_aj_symbol_keys:\n- id\n- service\n','2024-08-16 20:12:48',4,4),(67,'zync','ZyncEvent','487e77d4-fa41-47a2-a0c4-ad1161a6a399','---\n:provider_id: 4\n:timestamp: 2024-08-16 20:12:48.797333694 Z\n','---\ntype: Service\nid: 3\nparent_event_id: c61c2ae7-a6c3-465c-a13e-09feb2d5a1bc\nparent_event_type: OIDC::ServiceChangedEvent\ntenant_id: 4\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n','2024-08-16 20:12:48',4,4),(68,'all','OIDC::ServiceChangedEvent','bf39ca22-6674-4d5b-8803-97561c06a020','---\n:provider_id: 4\n:timestamp: 2024-08-16 20:12:48.950660868 Z\n','---\nid: 3\nservice:\n  _aj_globalid: gid://system/Service/3\n_aj_symbol_keys:\n- id\n- service\n','2024-08-16 20:12:48',4,4),(69,'zync','ZyncEvent','75e7c37e-6616-4379-a255-a4d0f0ebd70f','---\n:provider_id: 4\n:timestamp: 2024-08-16 20:12:48.950660868 Z\n','---\ntype: Service\nid: 3\nparent_event_id: bf39ca22-6674-4d5b-8803-97561c06a020\nparent_event_type: OIDC::ServiceChangedEvent\ntenant_id: 4\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n','2024-08-16 20:12:48',4,4),(70,'all','ServiceContracts::ServiceContractCreatedEvent','b1136947-61e3-4a78-80ff-b0041f4cd1bf','---\n:provider_id: 4\n:timestamp: 2024-08-16 20:12:50.048933430 Z\n','---\nservice_contract:\n  _aj_globalid: gid://system/ServiceContract/10\nservice:\n  _aj_globalid: gid://system/Service/3\nplan:\n  _aj_globalid: gid://system/ServicePlan/9\nprovider:\n  _aj_globalid: gid://system/Account/4\naccount:\n  _aj_globalid: gid://system/Account/5\nuser:\n  _aj_globalid: gid://system/User/7\n_aj_symbol_keys:\n- service_contract\n- service\n- plan\n- provider\n- account\n- user\n','2024-08-16 20:12:50',4,4),(71,'all','Applications::ApplicationCreatedEvent','8b830308-84aa-46b9-9b03-80130091343b','---\n:provider_id: 4\n:zync:\n  :service_id: 3\n:timestamp: 2024-08-16 20:12:50.088793264 Z\n','---\napplication:\n  _aj_globalid: gid://system/Cinstance/11\naccount:\n  _aj_globalid: gid://system/Account/5\nprovider:\n  _aj_globalid: gid://system/Account/4\nservice:\n  _aj_globalid: gid://system/Service/3\nplan:\n  _aj_globalid: gid://system/ApplicationPlan/11\nuser:\n  _aj_globalid: gid://system/User/7\n_aj_symbol_keys:\n- application\n- account\n- provider\n- service\n- plan\n- user\n','2024-08-16 20:12:50',4,4),(72,'zync','ZyncEvent','b1d78331-fad7-4a48-a7d8-9670dd33d64c','---\n:provider_id: 4\n:zync:\n  :service_id: 3\n:timestamp: 2024-08-16 20:12:50.088793264 Z\n','---\ntype: Application\nid: 11\nparent_event_id: 8b830308-84aa-46b9-9b03-80130091343b\nparent_event_type: Applications::ApplicationCreatedEvent\ntenant_id: 4\nservice_id: 3\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n- service_id\n','2024-08-16 20:12:50',4,4),(73,'all','Accounts::AccountStateChangedEvent','78c248bd-79b6-4abb-9a18-caaa656e2233','---\n:provider_id: 4\n:timestamp: 2024-08-16 20:12:50.127304984 Z\n','---\naccount:\n  _aj_globalid: gid://system/Account/5\nstate: approved\nprevious_state: created\nprovider:\n  _aj_globalid: gid://system/Account/4\n_aj_symbol_keys:\n- account\n- state\n- previous_state\n- provider\n','2024-08-16 20:12:50',4,4),(74,'all','Accounts::AccountCreatedEvent','04d1cc92-c3f2-47da-bd9b-8f6d974621bd','---\n:provider_id: 4\n:timestamp: 2024-08-16 20:12:50.180310674 Z\n','---\nprovider:\n  _aj_globalid: gid://system/Account/4\naccount:\n  _aj_globalid: gid://system/Account/5\nuser:\n  _aj_globalid: gid://system/User/7\n_aj_symbol_keys:\n- provider\n- account\n- user\n','2024-08-16 20:12:50',4,4),(75,'all','Domains::ProxyDomainsChangedEvent','7843f6f3-bd5c-46d2-8117-f73d327c63eb','---\n:provider_id: 4\n:zync:\n  :tenant_id: 4\n  :service_id: 4\n:timestamp: 2024-08-16 20:13:10.153889943 Z\n','---\nparent_event_id: \nparent_event_type: \nproxy:\n  _aj_globalid: gid://system/MissingModel::MissingProxy/4\nstaging_domains:\n- product-a-demo-organization-apicast-staging.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com\nproduction_domains:\n- product-a-demo-organization-apicast-production.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com\n_aj_symbol_keys:\n- parent_event_id\n- parent_event_type\n- proxy\n- staging_domains\n- production_domains\n','2024-08-16 20:13:10',4,4),(76,'zync','ZyncEvent','4da906b2-f7dd-4ae5-8132-edfd60099783','---\n:provider_id: 4\n:zync:\n  :tenant_id: 4\n  :service_id: 4\n:timestamp: 2024-08-16 20:13:10.153889943 Z\n','---\ntype: Proxy\nid: 4\nparent_event_id: 7843f6f3-bd5c-46d2-8117-f73d327c63eb\nparent_event_type: Domains::ProxyDomainsChangedEvent\ntenant_id: 4\nservice_id: 4\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n- service_id\n','2024-08-16 20:13:10',4,4),(77,'all','OIDC::ServiceChangedEvent','d2813a6a-de80-4ef8-a05f-b89343ab0415','---\n:provider_id: 4\n:timestamp: 2024-08-16 20:13:10.197490019 Z\n','---\nid: 4\nservice:\n  _aj_globalid: gid://system/Service/4\n_aj_symbol_keys:\n- id\n- service\n','2024-08-16 20:13:10',4,4),(78,'zync','ZyncEvent','aeb54066-6eb6-4b55-9a9e-91f346327a9f','---\n:provider_id: 4\n:timestamp: 2024-08-16 20:13:10.197490019 Z\n','---\ntype: Service\nid: 4\nparent_event_id: d2813a6a-de80-4ef8-a05f-b89343ab0415\nparent_event_type: OIDC::ServiceChangedEvent\ntenant_id: 4\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n','2024-08-16 20:13:10',4,4),(79,'all','Services::ServiceCreatedEvent','435b96b7-ddd2-4449-878d-33f4771f6f1a','---\n:provider_id: 4\n:timestamp: 2024-08-16 20:13:10.246884301 Z\n','---\nservice:\n  _aj_globalid: gid://system/Service/4\nuser:\n  _aj_globalid: gid://system/User/6\nprovider:\n  _aj_globalid: gid://system/Account/4\ntoken_value: 5dbe22072e16208909d4794c22956fe08ada429bd85815422e9b4263111f0f4b\n_aj_symbol_keys:\n- service\n- user\n- provider\n- token_value\n','2024-08-16 20:13:10',4,4),(80,'all','ProxyConfigs::AffectingObjectChangedEvent','0d515a6a-890a-4cb4-8f28-0961a6e43485','---\n:service_id: 4\n:provider_id: 4\n:timestamp: 2024-08-16 20:13:10.658635166 Z\n','---\nproxy_id: 4\nobject_id: \nobject_type: ProxyConfigAffectingChanges::Tracker\n_aj_symbol_keys:\n- proxy_id\n- object_id\n- object_type\n','2024-08-16 20:13:10',4,4),(81,'zync','ZyncEvent','5bc641a5-3038-4734-ab3c-68c359e39a6f','---\n:provider_id: 4\n:zync:\n  :tenant_id: 4\n  :service_id: 4\n:timestamp: 2024-08-16 20:13:10.153889943 Z\n','---\ntype: Service\nid: 4\nparent_event_id: 4da906b2-f7dd-4ae5-8132-edfd60099783\nparent_event_type: ZyncEvent\ntenant_id: 4\nservice_id: 4\n_aj_symbol_keys:\n- type\n- id\n- parent_event_id\n- parent_event_type\n- tenant_id\n- service_id\n','2024-08-16 20:13:10',4,4);
/*!40000 ALTER TABLE `event_store_events` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `event_store_events_tenant_id` BEFORE INSERT ON `event_store_events` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = NEW.provider_id;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `features`
--

DROP TABLE IF EXISTS `features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `features` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `featurable_id` bigint DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `description` text COLLATE utf8mb3_bin,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `system_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `featurable_type` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT 'Service',
  `scope` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT 'ApplicationPlan',
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_features_on_featurable_type_and_featurable_id` (`featurable_type`,`featurable_id`),
  KEY `index_features_on_featurable_type` (`featurable_type`),
  KEY `index_features_on_scope` (`scope`),
  KEY `index_features_on_system_name` (`system_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `features`
--

LOCK TABLES `features` WRITE;
/*!40000 ALTER TABLE `features` DISABLE KEYS */;
INSERT INTO `features` VALUES (1,2,'Unlimited Greetings',NULL,'2024-08-16 20:07:48','2024-08-16 20:07:48','unlimited_greetings',1,'Service','ApplicationPlan',2),(2,2,'24/7 support',NULL,'2024-08-16 20:07:48','2024-08-16 20:07:48','24_7_support',1,'Service','ApplicationPlan',2),(3,2,'Unlimited calls',NULL,'2024-08-16 20:07:49','2024-08-16 20:07:49','unlimited_calls',1,'Service','ApplicationPlan',2),(4,3,'Unlimited Greetings',NULL,'2024-08-16 20:12:48','2024-08-16 20:12:48','unlimited_greetings',1,'Service','ApplicationPlan',4),(5,3,'24/7 support',NULL,'2024-08-16 20:12:48','2024-08-16 20:12:48','24_7_support',1,'Service','ApplicationPlan',4),(6,3,'Unlimited calls',NULL,'2024-08-16 20:12:48','2024-08-16 20:12:48','unlimited_calls',1,'Service','ApplicationPlan',4);
/*!40000 ALTER TABLE `features` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `features_tenant_id` BEFORE INSERT ON `features` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.featurable_type = 'Account' AND NEW.featurable_id <> master_id THEN
  SET NEW.tenant_id = NEW.featurable_id;
ELSEIF NEW.featurable_type = 'Service' THEN
  SET NEW.tenant_id = (SELECT tenant_id FROM services WHERE id = NEW.featurable_id AND tenant_id <> master_id);
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `features_plans`
--

DROP TABLE IF EXISTS `features_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `features_plans` (
  `plan_id` bigint NOT NULL,
  `feature_id` bigint NOT NULL,
  `plan_type` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`plan_id`,`feature_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `features_plans`
--

LOCK TABLES `features_plans` WRITE;
/*!40000 ALTER TABLE `features_plans` DISABLE KEYS */;
INSERT INTO `features_plans` VALUES (7,1,'Plan',2),(8,1,'Plan',2),(8,2,'Plan',2),(8,3,'Plan',2),(11,4,'Plan',4),(12,4,'Plan',4),(12,5,'Plan',4),(12,6,'Plan',4);
/*!40000 ALTER TABLE `features_plans` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `features_plans_tenant_id` BEFORE INSERT ON `features_plans` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM features WHERE id = NEW.feature_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `fields_definitions`
--

DROP TABLE IF EXISTS `fields_definitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fields_definitions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` bigint DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `target` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `hidden` tinyint(1) DEFAULT '0',
  `required` tinyint(1) DEFAULT '0',
  `label` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `choices` text COLLATE utf8mb3_bin,
  `hint` text COLLATE utf8mb3_bin,
  `read_only` tinyint(1) DEFAULT '0',
  `pos` int DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_fields_definitions_on_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fields_definitions`
--

LOCK TABLES `fields_definitions` WRITE;
/*!40000 ALTER TABLE `fields_definitions` DISABLE KEYS */;
INSERT INTO `fields_definitions` VALUES (1,1,'2024-08-16 20:05:18','2024-08-16 20:05:18','Account',0,1,'Organization/Group Name','org_name',NULL,NULL,0,1,NULL),(2,1,'2024-08-16 20:05:18','2024-08-16 20:05:18','User',0,1,'Username','username',NULL,NULL,0,1,NULL),(3,1,'2024-08-16 20:05:18','2024-08-16 20:05:18','User',0,1,'Email','email',NULL,NULL,0,2,NULL),(4,1,'2024-08-16 20:05:18','2024-08-16 20:05:18','Cinstance',0,1,'Name','name',NULL,NULL,0,1,NULL),(5,1,'2024-08-16 20:05:18','2024-08-16 20:05:18','Cinstance',0,0,'Description','description',NULL,NULL,0,2,NULL),(6,2,'2024-08-16 20:05:20','2024-08-16 20:05:20','Account',0,1,'Organization/Group Name','org_name',NULL,NULL,0,1,2),(7,2,'2024-08-16 20:05:20','2024-08-16 20:05:20','User',0,1,'Username','username',NULL,NULL,0,1,2),(8,2,'2024-08-16 20:05:20','2024-08-16 20:05:20','User',0,1,'Email','email',NULL,NULL,0,2,2),(9,2,'2024-08-16 20:05:20','2024-08-16 20:05:20','Cinstance',0,1,'Name','name',NULL,NULL,0,1,2),(10,2,'2024-08-16 20:05:20','2024-08-16 20:05:20','Cinstance',0,0,'Description','description',NULL,NULL,0,2,2),(11,4,'2024-08-16 20:12:24','2024-08-16 20:12:24','Account',0,1,'Organization/Group Name','org_name',NULL,NULL,0,1,4),(12,4,'2024-08-16 20:12:24','2024-08-16 20:12:24','User',0,1,'Username','username',NULL,NULL,0,1,4),(13,4,'2024-08-16 20:12:24','2024-08-16 20:12:24','User',0,1,'Email','email',NULL,NULL,0,2,4),(14,4,'2024-08-16 20:12:24','2024-08-16 20:12:24','Cinstance',0,1,'Name','name',NULL,NULL,0,1,4),(15,4,'2024-08-16 20:12:24','2024-08-16 20:12:24','Cinstance',0,0,'Description','description',NULL,NULL,0,2,4);
/*!40000 ALTER TABLE `fields_definitions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `fields_definitions_tenant_id` BEFORE INSERT ON `fields_definitions` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.account_id <> master_id THEN
  SET NEW.tenant_id = NEW.account_id;
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `forums`
--

DROP TABLE IF EXISTS `forums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forums` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `topics_count` int DEFAULT '0',
  `posts_count` int DEFAULT '0',
  `position` int DEFAULT '0',
  `description_html` text COLLATE utf8mb3_bin,
  `state` varchar(255) COLLATE utf8mb3_bin DEFAULT 'public',
  `permalink` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `account_id` bigint DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_forums_on_site_id_and_permalink` (`permalink`),
  KEY `index_forums_on_position_and_site_id` (`position`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forums`
--

LOCK TABLES `forums` WRITE;
/*!40000 ALTER TABLE `forums` DISABLE KEYS */;
INSERT INTO `forums` VALUES (1,'Forum',NULL,0,0,0,NULL,'public','forum',1,NULL),(2,'Forum',NULL,0,0,0,NULL,'public','forum-2',4,4);
/*!40000 ALTER TABLE `forums` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `forums_tenant_id` BEFORE INSERT ON `forums` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.account_id <> master_id THEN
  SET NEW.tenant_id = NEW.account_id;
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `gateway_configurations`
--

DROP TABLE IF EXISTS `gateway_configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gateway_configurations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `settings` text COLLATE utf8mb3_bin,
  `proxy_id` bigint DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_gateway_configurations_on_proxy_id` (`proxy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gateway_configurations`
--

LOCK TABLES `gateway_configurations` WRITE;
/*!40000 ALTER TABLE `gateway_configurations` DISABLE KEYS */;
/*!40000 ALTER TABLE `gateway_configurations` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `gateway_configurations_tenant_id` BEFORE INSERT ON `gateway_configurations` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM proxies WHERE id = NEW.proxy_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `go_live_states`
--

DROP TABLE IF EXISTS `go_live_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_live_states` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` bigint DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `steps` text COLLATE utf8mb3_bin,
  `recent` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `finished` tinyint(1) DEFAULT '0',
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_go_live_states_on_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_live_states`
--

LOCK TABLES `go_live_states` WRITE;
/*!40000 ALTER TABLE `go_live_states` DISABLE KEYS */;
INSERT INTO `go_live_states` VALUES (1,1,'2024-08-16 20:05:18','2024-08-16 20:05:18',NULL,NULL,0,NULL),(2,2,'2024-08-16 20:05:20','2024-08-16 20:05:20',NULL,NULL,0,2),(3,4,'2024-08-16 20:12:24','2024-08-16 20:12:24',NULL,NULL,0,4);
/*!40000 ALTER TABLE `go_live_states` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `go_live_states_tenant_id` BEFORE INSERT ON `go_live_states` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.account_id <> master_id THEN
  SET NEW.tenant_id = NEW.account_id;
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `invitations`
--

DROP TABLE IF EXISTS `invitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invitations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `sent_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `account_id` bigint DEFAULT NULL,
  `accepted_at` datetime DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invitations`
--

LOCK TABLES `invitations` WRITE;
/*!40000 ALTER TABLE `invitations` DISABLE KEYS */;
/*!40000 ALTER TABLE `invitations` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `invitations_tenant_id` BEFORE INSERT ON `invitations` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM accounts WHERE id = NEW.account_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `invoice_counters`
--

DROP TABLE IF EXISTS `invoice_counters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_counters` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `provider_account_id` bigint NOT NULL,
  `invoice_prefix` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `invoice_count` int DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_invoice_counters_provider_prefix` (`provider_account_id`,`invoice_prefix`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_counters`
--

LOCK TABLES `invoice_counters` WRITE;
/*!40000 ALTER TABLE `invoice_counters` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_counters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoices` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `provider_account_id` bigint DEFAULT NULL,
  `buyer_account_id` bigint DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `due_on` date DEFAULT NULL,
  `pdf_file_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `pdf_content_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `pdf_file_size` int DEFAULT NULL,
  `pdf_updated_at` datetime DEFAULT NULL,
  `period` date DEFAULT NULL,
  `issued_on` date DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT 'open',
  `friendly_id` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT 'fix',
  `tenant_id` bigint DEFAULT NULL,
  `finalized_at` datetime DEFAULT NULL,
  `fiscal_code` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `vat_code` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `vat_rate` decimal(20,2) DEFAULT NULL,
  `currency` varchar(4) COLLATE utf8mb3_bin DEFAULT NULL,
  `from_address_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `from_address_line1` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `from_address_line2` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `from_address_city` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `from_address_region` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `from_address_state` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `from_address_country` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `from_address_zip` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `from_address_phone` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `to_address_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `to_address_line1` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `to_address_line2` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `to_address_city` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `to_address_region` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `to_address_state` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `to_address_country` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `to_address_zip` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `to_address_phone` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `charging_retries_count` int NOT NULL DEFAULT '0',
  `last_charging_retry` date DEFAULT NULL,
  `creation_type` varchar(255) COLLATE utf8mb3_bin DEFAULT 'manual',
  PRIMARY KEY (`id`),
  KEY `index_invoices_on_buyer_account_id_and_state` (`buyer_account_id`,`state`),
  KEY `index_invoices_on_buyer_account_id` (`buyer_account_id`),
  KEY `index_invoices_on_provider_account_id_and_buyer_account_id` (`provider_account_id`,`buyer_account_id`),
  KEY `index_invoices_on_provider_account_id` (`provider_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `invoices_tenant_id` BEFORE INSERT ON `invoices` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.provider_account_id <> master_id THEN
  SET NEW.tenant_id = NEW.provider_account_id;
END IF;

IF NEW.friendly_id IS NOT NULL AND NEW.friendly_id <> 'fix' THEN
  /* Subject to race condition, so better not to create invoices in parallel passing client-chosen friendly IDs */

  SET @numbering_period = (SELECT numbering_period
                           FROM billing_strategies
                           WHERE account_id = NEW.provider_account_id
                           LIMIT 1);

  IF @numbering_period = 'monthly' THEN
    SET @invoice_prefix_format = "%Y-%m";
  ELSE
    SET @invoice_prefix_format = "%Y";
  END IF;

  SET @invoice_prefix = DATE_FORMAT(NEW.period, @invoice_prefix_format);

  SELECT id, invoice_count
          INTO @invoice_counter_id, @invoice_count
          FROM invoice_counters
          WHERE provider_account_id = NEW.provider_account_id AND invoice_prefix = @invoice_prefix
          LIMIT 1
          FOR UPDATE;

  SET @chosen_sufix = COALESCE(SUBSTRING_INDEX(NEW.friendly_id, '-', -1), 0) * 1;
  SET @invoice_count = GREATEST(COALESCE(@invoice_count, 0), @chosen_sufix);

  UPDATE invoice_counters
  SET invoice_count = @invoice_count, updated_at = NEW.updated_at
  WHERE id = @invoice_counter_id;
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `legal_term_acceptances`
--

DROP TABLE IF EXISTS `legal_term_acceptances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `legal_term_acceptances` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `legal_term_id` bigint DEFAULT NULL,
  `legal_term_version` int DEFAULT NULL,
  `resource_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `resource_id` bigint DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `account_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_legal_term_acceptances_on_account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `legal_term_acceptances`
--

LOCK TABLES `legal_term_acceptances` WRITE;
/*!40000 ALTER TABLE `legal_term_acceptances` DISABLE KEYS */;
/*!40000 ALTER TABLE `legal_term_acceptances` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `legal_term_acceptances_tenant_id` BEFORE INSERT ON `legal_term_acceptances` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM legal_terms WHERE id = NEW.legal_term_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `legal_term_bindings`
--

DROP TABLE IF EXISTS `legal_term_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `legal_term_bindings` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `legal_term_id` bigint DEFAULT NULL,
  `legal_term_version` int DEFAULT NULL,
  `resource_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `resource_id` bigint DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `scope` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `legal_term_bindings`
--

LOCK TABLES `legal_term_bindings` WRITE;
/*!40000 ALTER TABLE `legal_term_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `legal_term_bindings` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `legal_term_bindings_tenant_id` BEFORE INSERT ON `legal_term_bindings` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM legal_terms WHERE id = NEW.legal_term_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `legal_term_versions`
--

DROP TABLE IF EXISTS `legal_term_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `legal_term_versions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `legal_term_id` bigint DEFAULT NULL,
  `version` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `body` longtext COLLATE utf8mb3_bin,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `published` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `archived` tinyint(1) DEFAULT '0',
  `version_comment` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_by_id` bigint DEFAULT NULL,
  `updated_by_id` bigint DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `legal_term_versions`
--

LOCK TABLES `legal_term_versions` WRITE;
/*!40000 ALTER TABLE `legal_term_versions` DISABLE KEYS */;
/*!40000 ALTER TABLE `legal_term_versions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `legal_term_versions_tenant_id` BEFORE INSERT ON `legal_term_versions` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM legal_terms WHERE id = NEW.legal_term_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `legal_terms`
--

DROP TABLE IF EXISTS `legal_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `legal_terms` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `version` int DEFAULT NULL,
  `lock_version` int DEFAULT '0',
  `name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `body` longtext COLLATE utf8mb3_bin,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `published` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `archived` tinyint(1) DEFAULT '0',
  `created_by_id` bigint DEFAULT NULL,
  `updated_by_id` bigint DEFAULT NULL,
  `account_id` bigint DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_legal_terms_on_account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `legal_terms`
--

LOCK TABLES `legal_terms` WRITE;
/*!40000 ALTER TABLE `legal_terms` DISABLE KEYS */;
/*!40000 ALTER TABLE `legal_terms` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `legal_terms_tenant_id` BEFORE INSERT ON `legal_terms` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.account_id <> master_id THEN
  SET NEW.tenant_id = NEW.account_id;
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `line_items`
--

DROP TABLE IF EXISTS `line_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `line_items` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `invoice_id` bigint DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `cost` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb3_bin DEFAULT '',
  `metric_id` bigint DEFAULT NULL,
  `finished_at` datetime DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `started_at` time DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `contract_id` bigint DEFAULT NULL,
  `contract_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `cinstance_id` int DEFAULT NULL,
  `plan_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_line_items_on_invoice_id` (`invoice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `line_items`
--

LOCK TABLES `line_items` WRITE;
/*!40000 ALTER TABLE `line_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `line_items` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `line_items_tenant_id` BEFORE INSERT ON `line_items` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM invoices WHERE id = NEW.invoice_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `log_entries`
--

DROP TABLE IF EXISTS `log_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_entries` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint DEFAULT NULL,
  `provider_id` bigint DEFAULT NULL,
  `buyer_id` bigint DEFAULT NULL,
  `level` int DEFAULT '10',
  `description` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_log_entries_on_provider_id` (`provider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_entries`
--

LOCK TABLES `log_entries` WRITE;
/*!40000 ALTER TABLE `log_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_entries` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `log_entries_tenant_id` BEFORE INSERT ON `log_entries` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM accounts WHERE id = NEW.provider_id AND (NOT master OR master is NULL));

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `mail_dispatch_rules`
--

DROP TABLE IF EXISTS `mail_dispatch_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mail_dispatch_rules` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` bigint DEFAULT NULL,
  `system_operation_id` bigint DEFAULT NULL,
  `emails` text COLLATE utf8mb3_bin,
  `dispatch` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_mail_dispatch_rules_on_account_id_and_system_operation_id` (`account_id`,`system_operation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mail_dispatch_rules`
--

LOCK TABLES `mail_dispatch_rules` WRITE;
/*!40000 ALTER TABLE `mail_dispatch_rules` DISABLE KEYS */;
INSERT INTO `mail_dispatch_rules` VALUES (1,1,2,NULL,1,'2024-08-16 20:05:21','2024-08-16 20:05:21',NULL),(2,1,1,NULL,1,'2024-08-16 20:07:50','2024-08-16 20:07:50',NULL),(5,1,3,NULL,1,'2024-08-16 20:07:50','2024-08-16 20:07:50',NULL),(9,1,4,NULL,1,'2024-08-16 20:07:50','2024-08-16 20:07:50',NULL),(11,1,5,NULL,1,'2024-08-16 20:07:50','2024-08-16 20:07:50',NULL),(14,1,6,NULL,1,'2024-08-16 20:07:50','2024-08-16 20:07:50',NULL),(18,1,7,NULL,1,'2024-08-16 20:07:50','2024-08-16 20:07:50',NULL),(21,1,8,NULL,1,'2024-08-16 20:07:50','2024-08-16 20:07:50',NULL),(24,1,9,NULL,1,'2024-08-16 20:07:50','2024-08-16 20:07:50',NULL),(27,1,10,NULL,0,'2024-08-16 20:07:50','2024-08-16 20:07:50',NULL),(31,1,11,NULL,1,'2024-08-16 20:07:50','2024-08-16 20:07:50',NULL),(35,1,12,NULL,1,'2024-08-16 20:07:50','2024-08-16 20:07:50',NULL),(38,1,13,NULL,1,'2024-08-16 20:07:50','2024-08-16 20:07:50',NULL),(42,1,14,NULL,0,'2024-08-16 20:07:50','2024-08-16 20:07:50',NULL),(46,1,15,NULL,0,'2024-08-16 20:07:50','2024-08-16 20:07:50',NULL),(50,1,16,NULL,1,'2024-08-16 20:07:50','2024-08-16 20:07:50',NULL),(53,4,1,'3scale-user@demo-organization.com',1,'2024-08-16 20:25:42','2024-08-16 20:25:42',4),(54,4,2,'3scale-user@demo-organization.com',1,'2024-08-16 20:25:42','2024-08-16 20:25:42',4),(55,4,3,'3scale-user@demo-organization.com',1,'2024-08-16 20:25:42','2024-08-16 20:25:42',4),(56,4,4,'3scale-user@demo-organization.com',1,'2024-08-16 20:25:42','2024-08-16 20:25:42',4),(57,4,5,'3scale-user@demo-organization.com',1,'2024-08-16 20:25:42','2024-08-16 20:25:42',4),(58,4,6,'3scale-user@demo-organization.com',1,'2024-08-16 20:25:42','2024-08-16 20:25:42',4),(59,4,7,'3scale-user@demo-organization.com',1,'2024-08-16 20:25:42','2024-08-16 20:25:42',4),(60,4,8,'3scale-user@demo-organization.com',1,'2024-08-16 20:25:42','2024-08-16 20:25:42',4),(61,4,9,'3scale-user@demo-organization.com',1,'2024-08-16 20:25:42','2024-08-16 20:25:42',4),(62,4,10,'3scale-user@demo-organization.com',0,'2024-08-16 20:25:42','2024-08-16 20:25:42',4),(63,4,11,'3scale-user@demo-organization.com',1,'2024-08-16 20:25:42','2024-08-16 20:25:42',4),(64,4,12,'3scale-user@demo-organization.com',1,'2024-08-16 20:25:42','2024-08-16 20:25:42',4),(65,4,13,'3scale-user@demo-organization.com',1,'2024-08-16 20:25:42','2024-08-16 20:25:42',4),(66,4,14,'3scale-user@demo-organization.com',0,'2024-08-16 20:25:42','2024-08-16 20:25:42',4),(67,4,15,'3scale-user@demo-organization.com',0,'2024-08-16 20:25:42','2024-08-16 20:25:42',4),(68,4,16,'3scale-user@demo-organization.com',1,'2024-08-16 20:25:42','2024-08-16 20:25:42',4);
/*!40000 ALTER TABLE `mail_dispatch_rules` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `mail_dispatch_rules_tenant_id` BEFORE INSERT ON `mail_dispatch_rules` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM accounts WHERE id = NEW.account_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `member_permissions`
--

DROP TABLE IF EXISTS `member_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `admin_section` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `service_ids` blob,
  PRIMARY KEY (`id`),
  KEY `index_member_permissions_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_permissions`
--

LOCK TABLES `member_permissions` WRITE;
/*!40000 ALTER TABLE `member_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_permissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `member_permissions_tenant_id` BEFORE INSERT ON `member_permissions` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM users WHERE id = NEW.user_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `message_recipients`
--

DROP TABLE IF EXISTS `message_recipients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message_recipients` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `message_id` bigint NOT NULL,
  `receiver_id` bigint NOT NULL,
  `receiver_type` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `kind` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `position` int DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `hidden_at` datetime DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_message_recipients_on_message_id_and_kind` (`message_id`,`kind`),
  KEY `idx_receiver_id` (`receiver_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_recipients`
--

LOCK TABLES `message_recipients` WRITE;
/*!40000 ALTER TABLE `message_recipients` DISABLE KEYS */;
INSERT INTO `message_recipients` VALUES (1,1,1,'Account','to',NULL,'unread',NULL,NULL,NULL),(2,2,1,'Account','to',NULL,'unread',NULL,2,NULL),(3,3,1,'Account','to',NULL,'unread',NULL,4,NULL),(4,4,1,'Account','to',NULL,'unread',NULL,4,NULL);
/*!40000 ALTER TABLE `message_recipients` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `message_recipients_tenant_id` BEFORE INSERT ON `message_recipients` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM messages WHERE id = NEW.message_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sender_id` bigint NOT NULL,
  `subject` text COLLATE utf8mb3_bin,
  `body` text COLLATE utf8mb3_bin,
  `state` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `hidden_at` datetime DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `system_operation_id` bigint DEFAULT NULL,
  `headers` text COLLATE utf8mb3_bin,
  `tenant_id` bigint DEFAULT NULL,
  `origin` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_messages_on_sender_id_and_hidden_at` (`sender_id`,`hidden_at`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,1,'API System: New Application submission','Dear API Administrator,\n\n\n\nA new user master has signed up for your service Master Service on plan Master Plan. The user\'s details are:\n\n* Name: \n* Email: \n* Organization: Master Account\n* Telephone: \n\n\n\nYou can check current user signups on your API Dashboard at https://master.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com/p/admin/applications/1.\n\n\nThe API Team\n','sent',NULL,NULL,'2024-08-16 20:05:21','2024-08-16 20:05:21',2,'--- {}\n',NULL,NULL),(2,2,'API System: New Application submission','Dear API Administrator,\n\n\n\nA new user admin has signed up for your service Master Service on plan enterprise. The user\'s details are:\n\n* Name: \n* Email: admin@3scale.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com\n* Organization: Provider Name\n* Telephone: \n\n\n\nYou can check current user signups on your API Dashboard at https://master.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com/p/admin/applications/2.\n\n\nThe API Team\n','sent',NULL,NULL,'2024-08-16 20:05:21','2024-08-16 20:05:21',2,'--- {}\n',2,NULL),(3,4,'API System: New Service subscription','Dear API Administrator,\n\nThe user Demo Organization has subscribed to your service Master Service on plan Default.\n\nThe user\'s details are:\n\n* Name: \n* Email: 3scale-user@demo-organization.com\n* Organization: Demo Organization\n* Telephone: \n\n\n\n\n\nThe API Team\n','sent',NULL,NULL,'2024-08-16 20:12:25','2024-08-16 20:12:25',3,'--- {}\n',4,NULL),(4,4,'API System: New Application submission','Dear API Administrator,\n\n\n\nA new user 3scale-user has signed up for your service Master Service on plan enterprise. The user\'s details are:\n\n* Name: \n* Email: 3scale-user@demo-organization.com\n* Organization: Demo Organization\n* Telephone: \n\n\n\nYou can check current user signups on your API Dashboard at https://master.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com/p/admin/applications/8.\n\n\nThe API Team\n','sent',NULL,NULL,'2024-08-16 20:12:25','2024-08-16 20:12:25',2,'--- {}\n',4,NULL);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `messages_tenant_id` BEFORE INSERT ON `messages` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM accounts WHERE id = NEW.sender_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `metrics`
--

DROP TABLE IF EXISTS `metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metrics` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `system_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `description` text COLLATE utf8mb3_bin,
  `unit` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `service_id` bigint DEFAULT NULL,
  `friendly_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `parent_id` bigint DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `owner_id` bigint DEFAULT NULL,
  `owner_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_metrics_on_owner_type_and_owner_id_and_system_name` (`owner_type`,`owner_id`,`system_name`),
  UNIQUE KEY `index_metrics_on_service_id_and_system_name` (`service_id`,`system_name`),
  KEY `index_metrics_on_owner_type_and_owner_id` (`owner_type`,`owner_id`),
  KEY `index_metrics_on_parent_id` (`parent_id`),
  KEY `index_metrics_on_service_id` (`service_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metrics`
--

LOCK TABLES `metrics` WRITE;
/*!40000 ALTER TABLE `metrics` DISABLE KEYS */;
INSERT INTO `metrics` VALUES (1,'hits','Number of API hits','hit','2024-08-16 20:05:19','2024-08-16 20:05:19',1,'Hits',NULL,NULL,1,'Service'),(2,'hits.1','Number of API hits','hit','2024-08-16 20:05:19','2024-08-16 20:05:19',NULL,'Hits',NULL,NULL,1,'BackendApi'),(3,'billing',NULL,'hit','2024-08-16 20:05:20','2024-08-16 20:05:20',1,'Billing API',NULL,NULL,1,'Service'),(4,'account',NULL,'hit','2024-08-16 20:05:20','2024-08-16 20:05:20',1,'Account Management API',NULL,NULL,1,'Service'),(5,'analytics',NULL,'hit','2024-08-16 20:05:20','2024-08-16 20:05:20',1,'Analytics API',NULL,NULL,1,'Service'),(6,'hits','Number of API hits','hit','2024-08-16 20:05:20','2024-08-16 20:05:20',2,'Hits',NULL,2,2,'Service'),(7,'hits.2','Number of API hits','hit','2024-08-16 20:05:20','2024-08-16 20:05:20',NULL,'Hits',NULL,NULL,2,'BackendApi'),(8,'hits','Number of API hits','hit','2024-08-16 20:12:24','2024-08-16 20:12:24',3,'Hits',NULL,4,3,'Service'),(9,'hits.3','Number of API hits','hit','2024-08-16 20:12:25','2024-08-16 20:12:25',NULL,'Hits',NULL,NULL,3,'BackendApi'),(10,'hits','Number of API hits','hit','2024-08-16 20:13:10','2024-08-16 20:13:10',4,'Hits',NULL,4,4,'Service');
/*!40000 ALTER TABLE `metrics` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `metrics_tenant_id` BEFORE INSERT ON `metrics` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM services WHERE id = NEW.service_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `moderatorships`
--

DROP TABLE IF EXISTS `moderatorships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moderatorships` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `forum_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moderatorships`
--

LOCK TABLES `moderatorships` WRITE;
/*!40000 ALTER TABLE `moderatorships` DISABLE KEYS */;
/*!40000 ALTER TABLE `moderatorships` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `moderatorships_tenant_id` BEFORE INSERT ON `moderatorships` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM forums WHERE id = NEW.forum_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `notification_preferences`
--

DROP TABLE IF EXISTS `notification_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_preferences` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `preferences` blob,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_notification_preferences_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_preferences`
--

LOCK TABLES `notification_preferences` WRITE;
/*!40000 ALTER TABLE `notification_preferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_preferences` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `notification_preferences_tenant_id` BEFORE INSERT ON `notification_preferences` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM users WHERE id = NEW.user_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `event_id` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `system_name` varchar(1000) COLLATE utf8mb3_bin DEFAULT NULL,
  `state` varchar(20) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `title` varchar(1000) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_notifications_on_event_id` (`event_id`),
  KEY `index_notifications_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,1,'7f0e613f-9275-437d-a3d0-60de53da8b13','application_created','delivered','2024-08-16 20:07:51','2024-08-16 20:07:51','Master Account\'s App created on Master Service'),(2,1,'f2d353a4-4799-45c7-a6d1-ec9f859ac420','service_contract_created','delivered','2024-08-16 20:12:25','2024-08-16 20:12:25','Demo Organization has subscribed to your service Master Service'),(3,1,'025ed69d-c720-4a8a-85aa-3d5b1c680e90','application_created','delivered','2024-08-16 20:12:26','2024-08-16 20:12:26','Demo Organization\'s App created on Master Service');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oidc_configurations`
--

DROP TABLE IF EXISTS `oidc_configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oidc_configurations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `config` text COLLATE utf8mb3_bin,
  `oidc_configurable_type` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `oidc_configurable_id` bigint NOT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `oidc_configurable` (`oidc_configurable_type`,`oidc_configurable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oidc_configurations`
--

LOCK TABLES `oidc_configurations` WRITE;
/*!40000 ALTER TABLE `oidc_configurations` DISABLE KEYS */;
/*!40000 ALTER TABLE `oidc_configurations` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `oidc_configurations_tenant_id` BEFORE INSERT ON `oidc_configurations` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM proxies WHERE id = NEW.oidc_configurable_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `onboardings`
--

DROP TABLE IF EXISTS `onboardings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `onboardings` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` bigint DEFAULT NULL,
  `wizard_state` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `bubble_api_state` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `bubble_metric_state` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `bubble_deployment_state` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `bubble_mapping_state` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `bubble_limit_state` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_onboardings_on_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `onboardings`
--

LOCK TABLES `onboardings` WRITE;
/*!40000 ALTER TABLE `onboardings` DISABLE KEYS */;
INSERT INTO `onboardings` VALUES (1,2,'initial',NULL,NULL,NULL,'2024-08-16 20:05:20','2024-08-16 20:05:20',NULL,NULL,2),(2,4,'started',NULL,NULL,NULL,'2024-08-16 20:17:42','2024-08-16 20:18:19',NULL,NULL,4);
/*!40000 ALTER TABLE `onboardings` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `onboardings_tenant_id` BEFORE INSERT ON `onboardings` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.account_id <> master_id THEN
  SET NEW.tenant_id = NEW.account_id;
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `partners`
--

DROP TABLE IF EXISTS `partners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partners` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `api_key` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `system_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `logout_url` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partners`
--

LOCK TABLES `partners` WRITE;
/*!40000 ALTER TABLE `partners` DISABLE KEYS */;
/*!40000 ALTER TABLE `partners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_details`
--

DROP TABLE IF EXISTS `payment_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_details` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` bigint DEFAULT NULL,
  `buyer_reference` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `payment_service_reference` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `credit_card_partial_number` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `credit_card_expires_on` date DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `payment_method_id` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_payment_details_on_account_id_and_buyer_reference` (`account_id`,`buyer_reference`),
  KEY `index_payment_details_on_account_id_and_payment_ref` (`account_id`,`payment_service_reference`),
  KEY `index_payment_details_on_account_id` (`account_id`),
  CONSTRAINT `fk_rails_ffc9ce649e` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_details`
--

LOCK TABLES `payment_details` WRITE;
/*!40000 ALTER TABLE `payment_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_details` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `payment_details_tenant_id` BEFORE INSERT ON `payment_details` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM accounts WHERE id = NEW.account_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `payment_gateway_settings`
--

DROP TABLE IF EXISTS `payment_gateway_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_gateway_settings` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `gateway_settings` blob,
  `gateway_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `account_id` bigint DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_payment_gateway_settings_on_account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_gateway_settings`
--

LOCK TABLES `payment_gateway_settings` WRITE;
/*!40000 ALTER TABLE `payment_gateway_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_gateway_settings` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `payment_gateway_settings_tenant_id` BEFORE INSERT ON `payment_gateway_settings` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.account_id <> master_id THEN
  SET NEW.tenant_id = NEW.account_id;
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `payment_intents`
--

DROP TABLE IF EXISTS `payment_intents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_intents` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `invoice_id` int NOT NULL,
  `state` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `reference` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_payment_intents_on_reference` (`reference`),
  KEY `index_payment_intents_on_invoice_id` (`invoice_id`),
  KEY `index_payment_intents_on_state` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_intents`
--

LOCK TABLES `payment_intents` WRITE;
/*!40000 ALTER TABLE `payment_intents` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_intents` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `payment_intents_tenant_id` BEFORE INSERT ON `payment_intents` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM invoices WHERE id = NEW.invoice_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `payment_transactions`
--

DROP TABLE IF EXISTS `payment_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_transactions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` bigint DEFAULT NULL,
  `invoice_id` bigint DEFAULT NULL,
  `success` tinyint(1) NOT NULL DEFAULT '0',
  `amount` decimal(20,4) DEFAULT NULL,
  `currency` varchar(4) COLLATE utf8mb3_bin NOT NULL DEFAULT 'EUR',
  `reference` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `message` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `action` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `params` text COLLATE utf8mb3_bin,
  `test` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_payment_transactions_on_invoice_id` (`invoice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_transactions`
--

LOCK TABLES `payment_transactions` WRITE;
/*!40000 ALTER TABLE `payment_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_transactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `payment_transactions_tenant_id` BEFORE INSERT ON `payment_transactions` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM invoices WHERE id = NEW.invoice_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `plan_metrics`
--

DROP TABLE IF EXISTS `plan_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plan_metrics` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `plan_id` bigint DEFAULT NULL,
  `metric_id` bigint DEFAULT NULL,
  `visible` tinyint(1) DEFAULT '1',
  `limits_only_text` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `plan_type` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_plan_metrics_metric_id` (`metric_id`),
  KEY `idx_plan_metrics_plan_id` (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_metrics`
--

LOCK TABLES `plan_metrics` WRITE;
/*!40000 ALTER TABLE `plan_metrics` DISABLE KEYS */;
/*!40000 ALTER TABLE `plan_metrics` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `plan_metrics_tenant_id` BEFORE INSERT ON `plan_metrics` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM plans WHERE id = NEW.plan_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `plans`
--

DROP TABLE IF EXISTS `plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plans` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `issuer_id` bigint NOT NULL,
  `name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `rights` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `full_legal` longtext COLLATE utf8mb3_bin,
  `cost_per_month` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `trial_period_days` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `position` int DEFAULT '0',
  `state` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `cancellation_period` int NOT NULL DEFAULT '0',
  `cost_aggregation_rule` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT 'sum',
  `setup_fee` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `master` tinyint(1) DEFAULT '0',
  `original_id` bigint NOT NULL DEFAULT '0',
  `type` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `issuer_type` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `description` text COLLATE utf8mb3_bin,
  `approval_required` tinyint(1) NOT NULL DEFAULT '0',
  `tenant_id` bigint DEFAULT NULL,
  `system_name` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `partner_id` bigint DEFAULT NULL,
  `contracts_count` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_plans_on_cost_per_month_and_setup_fee` (`cost_per_month`,`setup_fee`),
  KEY `idx_plans_issuer_type_original` (`issuer_id`,`issuer_type`,`type`,`original_id`),
  KEY `fk_contracts_service_id` (`issuer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plans`
--

LOCK TABLES `plans` WRITE;
/*!40000 ALTER TABLE `plans` DISABLE KEYS */;
INSERT INTO `plans` VALUES (1,1,'Default',NULL,NULL,0.0000,NULL,'2024-08-16 20:05:19','2024-08-16 20:05:19',1,'published',0,'sum',0.0000,0,0,'ServicePlan','Service',NULL,0,NULL,'default',NULL,1),(2,1,'Master Plan',NULL,NULL,0.0000,NULL,'2024-08-16 20:05:19','2024-08-16 20:05:19',2,'hidden',0,'sum',0.0000,0,0,'ApplicationPlan','Service',NULL,0,NULL,'master_plan',NULL,1),(3,1,'Default account plan',NULL,NULL,0.0000,NULL,'2024-08-16 20:05:19','2024-08-16 20:05:19',1,'hidden',0,'sum',0.0000,0,0,'AccountPlan','Account',NULL,0,NULL,'default_account_plan',NULL,1),(4,1,'enterprise',NULL,NULL,0.0000,NULL,'2024-08-16 20:05:19','2024-08-16 20:05:19',3,'hidden',0,'sum',0.0000,0,0,'ApplicationPlan','Service',NULL,0,NULL,'enterprise',NULL,2),(5,2,'Default',NULL,NULL,0.0000,NULL,'2024-08-16 20:05:20','2024-08-16 20:05:20',1,'published',0,'sum',0.0000,0,0,'ServicePlan','Service',NULL,0,2,'default',NULL,1),(6,2,'Default',NULL,NULL,0.0000,NULL,'2024-08-16 20:07:48','2024-08-16 20:07:48',1,'hidden',0,'sum',0.0000,0,0,'AccountPlan','Account',NULL,0,2,'default',NULL,1),(7,2,'Basic',NULL,NULL,0.0000,NULL,'2024-08-16 20:07:48','2024-08-16 20:07:49',2,'published',0,'sum',0.0000,0,0,'ApplicationPlan','Service',NULL,0,2,'basic',NULL,1),(8,2,'Unlimited',NULL,NULL,0.0000,NULL,'2024-08-16 20:07:49','2024-08-16 20:07:51',3,'published',0,'sum',0.0000,0,0,'ApplicationPlan','Service',NULL,0,2,'unlimited',NULL,0),(9,3,'Default',NULL,NULL,0.0000,NULL,'2024-08-16 20:12:25','2024-08-16 20:12:25',1,'published',0,'sum',0.0000,0,0,'ServicePlan','Service',NULL,0,4,'default',NULL,1),(10,4,'Default',NULL,NULL,0.0000,NULL,'2024-08-16 20:12:48','2024-08-16 20:12:48',1,'hidden',0,'sum',0.0000,0,0,'AccountPlan','Account',NULL,0,4,'default',NULL,1),(11,3,'Basic',NULL,NULL,0.0000,NULL,'2024-08-16 20:12:48','2024-08-16 20:12:48',2,'published',0,'sum',0.0000,0,0,'ApplicationPlan','Service',NULL,0,4,'basic',NULL,1),(12,3,'Unlimited',NULL,NULL,0.0000,NULL,'2024-08-16 20:12:48','2024-08-16 20:12:50',3,'published',0,'sum',0.0000,0,0,'ApplicationPlan','Service',NULL,0,4,'unlimited',NULL,0),(13,4,'Default',NULL,NULL,0.0000,NULL,'2024-08-16 20:13:10','2024-08-16 20:13:10',1,'published',0,'sum',0.0000,0,0,'ServicePlan','Service',NULL,0,4,'default',NULL,0);
/*!40000 ALTER TABLE `plans` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `plans_tenant_id` BEFORE INSERT ON `plans` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.type = 'AccountPlan' AND NEW.issuer_id <> master_id THEN
  SET NEW.tenant_id = NEW.issuer_id;
ELSEIF NEW.type = 'ApplicationPlan' OR NEW.type = 'ServicePlan' THEN
  SET NEW.tenant_id = (SELECT tenant_id FROM services WHERE id = NEW.issuer_id AND tenant_id <> master_id);
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `policies`
--

DROP TABLE IF EXISTS `policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `policies` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `version` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `schema` longblob NOT NULL,
  `account_id` bigint NOT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `identifier` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_policies_on_account_id_and_identifier` (`account_id`,`identifier`),
  KEY `index_policies_on_account_id` (`account_id`),
  CONSTRAINT `fk_rails_abc989f6f5` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `policies`
--

LOCK TABLES `policies` WRITE;
/*!40000 ALTER TABLE `policies` DISABLE KEYS */;
/*!40000 ALTER TABLE `policies` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `policies_tenant_id` BEFORE INSERT ON `policies` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM accounts WHERE id = NEW.account_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `topic_id` bigint DEFAULT NULL,
  `body` text COLLATE utf8mb3_bin,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `forum_id` bigint DEFAULT NULL,
  `body_html` text COLLATE utf8mb3_bin,
  `email` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `anonymous_user` tinyint(1) DEFAULT '0',
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_posts_on_forum_id` (`created_at`,`forum_id`),
  KEY `index_posts_on_topic_id` (`created_at`,`topic_id`),
  KEY `index_posts_on_user_id` (`created_at`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `posts_tenant_id` BEFORE INSERT ON `posts` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM forums WHERE id = NEW.forum_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pricing_rules`
--

DROP TABLE IF EXISTS `pricing_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pricing_rules` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `metric_id` bigint DEFAULT NULL,
  `min` bigint NOT NULL DEFAULT '1',
  `max` bigint DEFAULT NULL,
  `cost_per_unit` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `plan_id` bigint DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_pricing_rules_on_plan_id_and_plan_type` (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pricing_rules`
--

LOCK TABLES `pricing_rules` WRITE;
/*!40000 ALTER TABLE `pricing_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `pricing_rules` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `pricing_rules_tenant_id` BEFORE INSERT ON `pricing_rules` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM plans WHERE id = NEW.plan_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` bigint NOT NULL,
  `oneline_description` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `description` text COLLATE utf8mb3_bin,
  `company_url` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `blog_url` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `rssfeed_url` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `email_sales` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `email_techsupport` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `email_press` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `logo_file_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `logo_content_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `logo_file_size` int DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `company_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `customers_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `company_size` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `products_delivered` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `profiles_tenant_id` BEFORE INSERT ON `profiles` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM accounts WHERE id = NEW.account_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `provided_access_tokens`
--

DROP TABLE IF EXISTS `provided_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provided_access_tokens` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `value` text COLLATE utf8mb3_bin,
  `user_id` bigint DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_rails_260e99b630` (`user_id`),
  CONSTRAINT `fk_rails_260e99b630` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provided_access_tokens`
--

LOCK TABLES `provided_access_tokens` WRITE;
/*!40000 ALTER TABLE `provided_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `provided_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `provided_access_tokens_tenant_id` BEFORE INSERT ON `provided_access_tokens` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM users WHERE id = NEW.user_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `provider_constraints`
--

DROP TABLE IF EXISTS `provider_constraints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provider_constraints` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint DEFAULT NULL,
  `provider_id` bigint DEFAULT NULL,
  `max_users` int DEFAULT NULL,
  `max_services` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_provider_constraints_on_provider_id` (`provider_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_constraints`
--

LOCK TABLES `provider_constraints` WRITE;
/*!40000 ALTER TABLE `provider_constraints` DISABLE KEYS */;
INSERT INTO `provider_constraints` VALUES (1,2,2,NULL,NULL,'2024-08-16 20:05:21','2024-08-16 20:05:21'),(2,4,4,NULL,NULL,'2024-08-16 20:12:25','2024-08-16 20:12:25');
/*!40000 ALTER TABLE `provider_constraints` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `provider_constraints_tenant_id` BEFORE INSERT ON `provider_constraints` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = NEW.provider_id;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `proxies`
--

DROP TABLE IF EXISTS `proxies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proxies` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint DEFAULT NULL,
  `service_id` bigint DEFAULT NULL,
  `endpoint` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `deployed_at` datetime DEFAULT NULL,
  `auth_app_key` varchar(255) COLLATE utf8mb3_bin DEFAULT 'app_key',
  `auth_app_id` varchar(255) COLLATE utf8mb3_bin DEFAULT 'app_id',
  `auth_user_key` varchar(255) COLLATE utf8mb3_bin DEFAULT 'user_key',
  `credentials_location` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT 'query',
  `error_auth_failed` varchar(255) COLLATE utf8mb3_bin DEFAULT 'Authentication failed',
  `error_auth_missing` varchar(255) COLLATE utf8mb3_bin DEFAULT 'Authentication parameters missing',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `error_status_auth_failed` int NOT NULL DEFAULT '403',
  `error_headers_auth_failed` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT 'text/plain; charset=us-ascii',
  `error_status_auth_missing` int NOT NULL DEFAULT '403',
  `error_headers_auth_missing` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT 'text/plain; charset=us-ascii',
  `error_no_match` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT 'No Mapping Rule matched',
  `error_status_no_match` int NOT NULL DEFAULT '404',
  `error_headers_no_match` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT 'text/plain; charset=us-ascii',
  `secret_token` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `hostname_rewrite` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `oauth_login_url` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `sandbox_endpoint` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `api_test_path` varchar(8192) COLLATE utf8mb3_bin DEFAULT NULL,
  `api_test_success` tinyint(1) DEFAULT NULL,
  `apicast_configuration_driven` tinyint(1) NOT NULL DEFAULT '1',
  `oidc_issuer_endpoint` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `lock_version` bigint NOT NULL DEFAULT '0',
  `authentication_method` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `policies_config` mediumtext COLLATE utf8mb3_bin,
  `oidc_issuer_type` varchar(255) COLLATE utf8mb3_bin DEFAULT 'keycloak',
  `error_headers_limits_exceeded` varchar(255) COLLATE utf8mb3_bin DEFAULT 'text/plain; charset=us-ascii',
  `error_status_limits_exceeded` int DEFAULT '429',
  `error_limits_exceeded` varchar(255) COLLATE utf8mb3_bin DEFAULT 'Usage limit exceeded',
  `staging_domain` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `production_domain` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_proxies_on_service_id` (`service_id`),
  KEY `index_proxies_on_staging_domain_and_production_domain` (`staging_domain`,`production_domain`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxies`
--

LOCK TABLES `proxies` WRITE;
/*!40000 ALTER TABLE `proxies` DISABLE KEYS */;
INSERT INTO `proxies` VALUES (1,NULL,1,NULL,NULL,'app_key','app_id','user_key','query','Authentication failed','Authentication parameters missing','2024-08-16 20:05:19','2024-08-16 20:05:21',403,'text/plain; charset=us-ascii',403,'text/plain; charset=us-ascii','No Mapping Rule matched',404,'text/plain; charset=us-ascii','Shared_secret_sent_from_proxy_to_API_backend_915913a9ff960b5b',NULL,NULL,NULL,'/',NULL,1,NULL,1,NULL,NULL,'keycloak','text/plain; charset=us-ascii',429,'Usage limit exceeded',NULL,NULL),(2,2,2,'https://api-3scale-apicast-production.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com',NULL,'app_key','app_id','user_key','query','Authentication failed','Authentication parameters missing','2024-08-16 20:05:20','2024-08-16 20:05:21',403,'text/plain; charset=us-ascii',403,'text/plain; charset=us-ascii','No Mapping Rule matched',404,'text/plain; charset=us-ascii','Shared_secret_sent_from_proxy_to_API_backend_f4f30b8508a92cbc',NULL,NULL,'https://api-3scale-apicast-staging.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com','/',NULL,1,NULL,0,NULL,NULL,'keycloak','text/plain; charset=us-ascii',429,'Usage limit exceeded','api-3scale-apicast-staging.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com','api-3scale-apicast-production.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com'),(3,4,3,'https://api-demo-organization-apicast-production.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com',NULL,'app_key','app_id','user_key','query','Authentication failed','Authentication parameters missing','2024-08-16 20:12:25','2024-08-16 20:12:26',403,'text/plain; charset=us-ascii',403,'text/plain; charset=us-ascii','No Mapping Rule matched',404,'text/plain; charset=us-ascii','Shared_secret_sent_from_proxy_to_API_backend_71362f6248fdf0a6',NULL,NULL,'https://api-demo-organization-apicast-staging.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com','/',NULL,1,NULL,0,NULL,NULL,'keycloak','text/plain; charset=us-ascii',429,'Usage limit exceeded','api-demo-organization-apicast-staging.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com','api-demo-organization-apicast-production.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com'),(4,4,4,'https://product-a-demo-organization-apicast-production.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com',NULL,'app_key','app_id','user_key','query','Authentication failed','Authentication parameters missing','2024-08-16 20:13:10','2024-08-16 20:13:10',403,'text/plain; charset=us-ascii',403,'text/plain; charset=us-ascii','No Mapping Rule matched',404,'text/plain; charset=us-ascii','Shared_secret_sent_from_proxy_to_API_backend_3f138e81d98668eb',NULL,NULL,'https://product-a-demo-organization-apicast-staging.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com','/',NULL,1,NULL,0,NULL,NULL,'keycloak','text/plain; charset=us-ascii',429,'Usage limit exceeded','product-a-demo-organization-apicast-staging.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com','product-a-demo-organization-apicast-production.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com');
/*!40000 ALTER TABLE `proxies` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `proxies_tenant_id` BEFORE INSERT ON `proxies` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM services WHERE id = NEW.service_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `proxy_config_affecting_changes`
--

DROP TABLE IF EXISTS `proxy_config_affecting_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proxy_config_affecting_changes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `proxy_id` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_proxy_config_affecting_changes_on_proxy_id` (`proxy_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_config_affecting_changes`
--

LOCK TABLES `proxy_config_affecting_changes` WRITE;
/*!40000 ALTER TABLE `proxy_config_affecting_changes` DISABLE KEYS */;
INSERT INTO `proxy_config_affecting_changes` VALUES (1,1,'2024-08-16 20:05:21','2024-08-16 20:05:21'),(2,2,'2024-08-16 20:05:21','2024-08-16 20:05:21'),(3,3,'2024-08-16 20:12:25','2024-08-16 20:12:26'),(4,4,'2024-08-16 20:13:10','2024-08-16 20:13:10');
/*!40000 ALTER TABLE `proxy_config_affecting_changes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_configs`
--

DROP TABLE IF EXISTS `proxy_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proxy_configs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `proxy_id` bigint NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `version` int NOT NULL DEFAULT '0',
  `tenant_id` bigint DEFAULT NULL,
  `environment` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `content` mediumtext COLLATE utf8mb3_bin NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `hosts` varchar(8192) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_proxy_configs_on_proxy_id_and_environment_and_version` (`proxy_id`,`environment`,`version`),
  KEY `index_proxy_configs_on_proxy_id` (`proxy_id`),
  KEY `index_proxy_configs_on_user_id` (`user_id`),
  CONSTRAINT `fk_rails_1ec86b4ffa` FOREIGN KEY (`proxy_id`) REFERENCES `proxies` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rails_7508cee9be` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_configs`
--

LOCK TABLES `proxy_configs` WRITE;
/*!40000 ALTER TABLE `proxy_configs` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_configs` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `proxy_configs_tenant_id` BEFORE INSERT ON `proxy_configs` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM proxies WHERE id = NEW.proxy_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `proxy_logs`
--

DROP TABLE IF EXISTS `proxy_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proxy_logs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `provider_id` bigint DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `lua_file` mediumtext COLLATE utf8mb3_bin,
  `status` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_logs`
--

LOCK TABLES `proxy_logs` WRITE;
/*!40000 ALTER TABLE `proxy_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_rules`
--

DROP TABLE IF EXISTS `proxy_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proxy_rules` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `proxy_id` bigint DEFAULT NULL,
  `http_method` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `pattern` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `metric_id` bigint DEFAULT NULL,
  `metric_system_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `delta` int DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `redirect_url` text COLLATE utf8mb3_bin,
  `position` int DEFAULT NULL,
  `last` tinyint(1) DEFAULT '0',
  `owner_id` bigint DEFAULT NULL,
  `owner_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_proxy_rules_on_owner_type_and_owner_id` (`owner_type`,`owner_id`),
  KEY `index_proxy_rules_on_proxy_id` (`proxy_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_rules`
--

LOCK TABLES `proxy_rules` WRITE;
/*!40000 ALTER TABLE `proxy_rules` DISABLE KEYS */;
INSERT INTO `proxy_rules` VALUES (1,1,'GET','/',1,NULL,1,NULL,'2024-08-16 20:05:19','2024-08-16 20:05:19',NULL,1,0,1,'Proxy'),(2,2,'GET','/',6,NULL,1,2,'2024-08-16 20:05:20','2024-08-16 20:05:20',NULL,1,0,2,'Proxy'),(3,3,'GET','/',8,NULL,1,4,'2024-08-16 20:12:25','2024-08-16 20:12:25',NULL,1,0,3,'Proxy'),(4,4,'GET','/',10,NULL,1,4,'2024-08-16 20:13:10','2024-08-16 20:13:10',NULL,1,0,4,'Proxy');
/*!40000 ALTER TABLE `proxy_rules` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `proxy_rules_tenant_id` BEFORE INSERT ON `proxy_rules` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM proxies WHERE id = NEW.proxy_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `referrer_filters`
--

DROP TABLE IF EXISTS `referrer_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referrer_filters` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `application_id` bigint NOT NULL,
  `value` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_referrer_filters_on_application_id` (`application_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referrer_filters`
--

LOCK TABLES `referrer_filters` WRITE;
/*!40000 ALTER TABLE `referrer_filters` DISABLE KEYS */;
/*!40000 ALTER TABLE `referrer_filters` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `referrer_filters_tenant_id` BEFORE INSERT ON `referrer_filters` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM cinstances WHERE id = NEW.application_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('10'),('11'),('12'),('13'),('15'),('16'),('17'),('18'),('2'),('20080625073419'),('20080625082630'),('20080625082631'),('20080627133345'),('200807061128'),('20080709134104'),('20080710163010'),('20080711095301'),('20080711103351'),('20080711104453'),('20080711104817'),('20080711110654'),('20080714073240'),('20080714073248'),('20080714073256'),('20080716113318'),('20080716131833'),('20080723081006'),('20080725075118'),('20080725163757'),('20080731075548'),('20080804100915'),('20080805111151'),('20080805124622'),('20080805131040'),('20080807080224'),('20080807135449'),('20080807162728'),('20080811101309'),('20080811144118'),('20080813081202'),('20080819093558'),('20080820084058'),('20080822082807'),('20080822110016'),('20080822140627'),('20080823164126'),('20080825093858'),('20080825105417'),('20080826093604'),('20080827104341'),('20080829120553'),('20080829131308'),('20080831181227'),('20080904172946'),('20080918155651'),('20080919154608'),('20080922101934'),('20080922155721'),('20080930100356'),('20081001084702'),('20081001100021'),('20081001103639'),('20081001105410'),('20081002083452'),('20081005124636'),('20081007104553'),('20081008084840'),('20081009154135'),('20081017095320'),('20081020092531'),('20081022140306'),('20081022144307'),('20081023094902'),('20081023103234'),('20081023133041'),('20081024155910'),('20081024180108'),('20081027114815'),('20081028163133'),('20081106150615'),('20081106161416'),('20081106175319'),('20081111160226'),('20081112151449'),('20081113141413'),('20081114155620'),('20081117120328'),('20081117160916'),('20081117164304'),('20081119123048'),('20081119135532'),('20081126124332'),('20081127093516'),('20081127151651'),('20081201104452'),('20081202102619'),('20081202105835'),('20081202153532'),('20081204131950'),('20081205102832'),('20081205120000'),('20081205122454'),('20081205122455'),('20081208110016'),('20081215113353'),('20090113130646'),('20090130091527'),('20090130094153'),('20090202161814'),('20090205091420'),('20090206174052'),('20090212185738'),('20090217095819'),('20090223122752'),('20090301180237'),('20090302115936'),('20090302161124'),('20090302164837'),('20090303160646'),('20090305121915'),('20090311133621'),('20090317115539'),('20090319115519'),('20090320090219'),('20090320154407'),('20090323104758'),('20090323121345'),('20090327114631'),('20090403150024'),('20090406093212'),('20090417112329'),('20090420124658'),('20090423115942'),('20090424090928'),('20090430090426'),('20090504132405'),('20090512073323'),('20090515083246'),('20090519112147'),('20090519121121'),('20090520105050'),('20090529120921'),('20090529121216'),('20090529122317'),('20090602123636'),('20090603082249'),('20090603092750'),('20090603100749'),('20090603101703'),('20090603113704'),('20090604151847'),('20090605112749'),('20090608104256'),('20090608135336'),('20090616131706'),('20090617095433'),('20090617131615'),('20090618121114'),('20090622135712'),('20090622150114'),('20090623093129'),('20090624080714'),('20090630092648'),('20090630100805'),('20090701152746'),('20090706110424'),('20090708135658'),('20090807074355'),('20090814145240'),('20090814164849'),('20090817103028'),('20090820101449'),('20090821134332'),('20090826091019'),('20090901091042'),('20090902131630'),('20090903152523'),('20090907100511'),('20090908151717'),('20090909095230'),('20090909112537'),('20090911111308'),('20090911113459'),('20090917110055'),('20090917110124'),('20090917114124'),('20090918164401'),('20090921110752'),('20090922123653'),('20090923103450'),('20090925211339'),('20090928083142'),('20091001155538'),('20091001160527'),('20091002123151'),('20091002155852'),('20091006144158'),('20091008161735'),('20091013091052'),('20091014140257'),('20091015124855'),('20091015140540'),('20091015142942'),('20091103132734'),('20091103142217'),('20091103175956'),('20091109110813'),('20091109115121'),('20091119112117'),('20091125101002'),('20091127181105'),('20091202114428'),('20091207173701'),('20091207174000'),('20091207174349'),('20091207174628'),('20100112120314'),('20100112133222'),('20100120161705'),('20100121122329'),('20100122173112'),('20100122173744'),('20100125103539'),('20100126162954'),('20100130124010'),('20100208183511'),('20100209153108'),('20100211142311'),('20100211152021'),('20100215151621'),('20100216080646'),('20100216080656'),('20100216120713'),('20100216124538'),('20100218093115'),('20100218111012'),('20100218163550'),('20100218171137'),('20100218174201'),('20100219095049'),('20100219123723'),('20100219143500'),('20100219143830'),('20100219164351'),('20100222141912'),('20100222153810'),('20100223123145'),('20100223172814'),('20100225123220'),('20100225123509'),('20100226102830'),('20100226174424'),('20100228190455'),('20100303140314'),('20100305151813'),('20100308133900'),('20100308153944'),('20100308170448'),('20100309101320'),('20100309192818'),('20100311121156'),('20100330154653'),('20100413080331'),('20100414161609'),('20100504073737'),('20100506142737'),('20100506152657'),('20100506153109'),('20100511130148'),('20100520103533'),('20100521131637'),('20100531092243'),('20100603131102'),('20100603132506'),('20100603141621'),('20100608094036'),('20100608094350'),('20100608094801'),('20100608110846'),('20100608155742'),('20100611134800'),('20100614111742'),('20100614141612'),('20100615085757'),('20100615103833'),('20100617121807'),('20100621205252'),('20100622082530'),('20100622160518'),('20100630104208'),('20100701094228'),('20100706081430'),('20100706085642'),('20100708091659'),('20100713132521'),('20100713135711'),('20100714105328'),('20100715102901'),('20100719130710'),('20100720133402'),('20100721133848'),('20100722082453'),('20100726095645'),('20100728123200'),('20100729114040'),('20100803091210'),('20100804165742'),('20100805100434'),('20100805164945'),('20100805165337'),('20100809103633'),('20100816093244'),('20100816142427'),('20100818100842'),('20100823170414'),('20100824122253'),('20100824123726'),('20100826132829'),('20100830112017'),('20100831144742'),('20100901130900'),('20100906094313'),('20100914153434'),('20100927111600'),('20100929103536'),('20100929141336'),('20101006131837'),('20101007101448'),('20101014164141'),('20101026173617'),('20101027144759'),('20101102104632'),('20101102114850'),('20101103102324'),('20101103124124'),('20101103154257'),('20101110130607'),('20101110163111'),('20101110163112'),('20101112113402'),('20101115152754'),('20101115162035'),('20101116095722'),('20101123151226'),('20101124113500'),('20101124130320'),('20101124153421'),('20101124173842'),('20101126150235'),('20101126175422'),('20101203113059'),('20101210160111'),('20101223124204'),('20110125104959'),('20110125130411'),('20110125130738'),('20110126114450'),('20110131150424'),('20110207170613'),('20110208105005'),('20110214135016'),('20110215120354'),('20110215135743'),('20110216111613'),('20110216153203'),('20110217123722'),('20110219162959'),('20110222122537'),('20110228142653'),('20110228163123'),('20110301170124'),('20110304184014'),('20110305115529'),('20110310112225'),('20110317174216'),('20110325103322'),('20110404133322'),('20110404133323'),('20110412120607'),('20110419104655'),('20110425111439'),('20110426161130'),('20110513104753'),('20110519123038'),('20110603113114'),('20110620113829'),('20110627123346'),('20110628095103'),('20110628110646'),('20110630124502'),('20110706171254'),('20110719161209'),('20110722113951'),('20110725141425'),('20110726170322'),('20110728090308'),('20110728100049'),('20110728155133'),('20110803102316'),('20110804155756'),('20110805140849'),('20110810154213'),('20110812112413'),('20110818162938'),('20110822124136'),('20110825161310'),('20110829161140'),('20110831100612'),('20110905122008'),('20110908082123'),('20110908110657'),('20110912144433'),('20110920105421'),('20110921111151'),('20110923134102'),('20110926122440'),('20110930120648'),('20110930125722'),('20111001111820'),('20111007135201'),('20111010114127'),('20111011094500'),('20111011150706'),('20111013154812'),('20111022191632'),('20111024083410'),('20111025111918'),('20111025133445'),('20111025134256'),('20111025155637'),('20111027153022'),('20111104140910'),('20111107135050'),('20111109111901'),('20111109153604'),('20111110153340'),('20111116111229'),('20111116132712'),('20111116135701'),('20111117120605'),('20111118120458'),('20111121105015'),('20111121152708'),('20111122103437'),('20111122132305'),('20111123111906'),('20111123124607'),('20111124174023'),('20111128085358'),('20111128090920'),('20111128142634'),('20111129114039'),('20111129151951'),('20111129153645'),('20111129172656'),('20111130100321'),('20111130110343'),('20111201114907'),('20111205143403'),('20111212142051'),('20111213150651'),('20111213173444'),('20111215093415'),('20111215151537'),('20111219154340'),('20111220120330'),('20111220131148'),('20111221115217'),('20111227151508'),('20111228093506'),('20111228124811'),('20120105153348'),('20120109110445'),('20120109151500'),('20120109161319'),('20120110104802'),('20120111102213'),('20120111112921'),('20120116105124'),('20120117134623'),('20120117162256'),('20120119150215'),('20120120151742'),('20120123121825'),('20120130115941'),('20120131151153'),('20120208164029'),('20120213151300'),('20120214162013'),('20120215120628'),('20120215152115'),('20120216142315'),('20120216174749'),('20120217171441'),('20120221100312'),('20120221113156'),('20120223154502'),('20120224105153'),('20120224144831'),('20120224152526'),('20120229142040'),('20120305150055'),('20120313154335'),('20120314105150'),('20120315111750'),('20120315132820'),('20120315140355'),('20120320134306'),('20120322151246'),('20120322160705'),('20120326100833'),('20120329115727'),('20120403141107'),('20120404125032'),('20120404125256'),('20120405092114'),('20120412143434'),('20120417102115'),('20120423100949'),('20120423144632'),('20120424095609'),('20120424134319'),('20120425141105'),('20120426121339'),('20120426144240'),('20120504095402'),('20120504120450'),('20120509101022'),('20120511140727'),('20120514111454'),('20120515110956'),('20120516142540'),('20120517140136'),('20120518152907'),('20120519194217'),('20120522111406'),('20120522131752'),('20120522172029'),('20120523090041'),('20120523100139'),('20120523112435'),('20120523112933'),('20120523142057'),('20120524104332'),('20120524105338'),('20120524132107'),('20120524150944'),('20120529102149'),('20120530090622'),('20120531143215'),('20120604104536'),('20120607151349'),('20120607151350'),('20120608090149'),('20120611155023'),('20120612090752'),('20120614130257'),('20120614131253'),('20120615113534'),('20120621101720'),('20120705102117'),('20120706134650'),('20120710103036'),('20120716162126'),('20120723092537'),('20120730141909'),('20120731114547'),('20120807151641'),('20120830110923'),('20120903160829'),('20120903161840'),('20120904095151'),('20120904110612'),('20120906140651'),('20120907114801'),('20120907114802'),('20120907114803'),('20120907114804'),('20120912125130'),('20120912144621'),('20120912145504'),('20120912170142'),('20120918131109'),('20120925105310'),('20120928105427'),('20121009114247'),('20121010152107'),('20121011111815'),('20121015105728'),('20121015125457'),('20121016145926'),('20121018100514'),('20121018113624'),('20121019150059'),('20121022101322'),('20121023084751'),('20121026145541'),('20121029164037'),('20121030135622'),('20121106111409'),('20121106125227'),('20121108165539'),('20121203172610'),('20121218152315'),('20121221151859'),('20130114143414'),('20130117155354'),('20130117175505'),('20130129152938'),('20130131155826'),('20130211203826'),('20130219115601'),('20130219145920'),('20130226153312'),('20130308152453'),('20130312155750'),('20130315105949'),('20130319122120'),('20130319122854'),('20130321122122'),('20130321150402'),('20130325172609'),('20130404103815'),('20130412150352'),('20130423144252'),('20130424111229'),('20131112150455'),('20131112150456'),('20131112150457'),('20131112150458'),('20131112150459'),('20131112150460'),('20131112150461'),('20131112150462'),('20131112150463'),('20131112150464'),('20131112150465'),('20131128153326'),('20131128171117'),('20131129112019'),('20131202110159'),('20131202140626'),('20131202172337'),('20131204101351'),('20131205151403'),('20131210142320'),('20131210145056'),('20131211114646'),('20131213161519'),('20131216111726'),('20140221154402'),('20140225132629'),('20140227122652'),('20140416152936'),('20140425143820'),('20140430151311'),('20140505131225'),('20140505131258'),('20140528163120'),('20140529143441'),('20140605131629'),('20140623145320'),('20140710102539'),('20140710123832'),('20140710131530'),('20140722120932'),('20140722144140'),('20140801090139'),('20140818093429'),('20140910140444'),('20140916113851'),('20140925145352'),('20140926145200'),('20140930073336'),('20141001095732'),('20141010135941'),('20141021113737'),('20141024134450'),('20141105125849'),('20141110150133'),('20141124114319'),('20141204112844'),('20141205152054'),('20141215183115'),('20141216120113'),('20150116111113'),('20150116111530'),('20150211105532'),('20150211110620'),('20150211142022'),('20150218143927'),('20150224150705'),('20150225112811'),('20150226140644'),('20150309141751'),('20150310163428'),('20150310163429'),('20150312135507'),('20150324103521'),('20150427112006'),('20150430100645'),('20150513110545'),('20150514110622'),('20150518145034'),('20150605105321'),('20150612174110'),('20150616164516'),('20150616175433'),('20150616181343'),('20150617101723'),('20150622091416'),('20150731101115'),('20150803103600'),('20150910111913'),('20150914174507'),('20150921181939'),('20150921204048'),('20150922155236'),('20150928125304'),('20150928233446'),('20151020145550'),('20151117163837'),('20151123123421'),('20151124173458'),('20151201163149'),('20151204120928'),('20151204142551'),('20151209141307'),('20151209171945'),('20160113172148'),('20160114112733'),('20160114162343'),('20160114164554'),('20160122120748'),('20160129152456'),('20160215120505'),('20160224121322'),('20160229172206'),('20160324155428'),('20160418160323'),('20160425085214'),('20160425102745'),('20160427104104'),('20160429095940'),('20160502152346'),('20160503153129'),('20160519150944'),('20160606090533'),('20160607080248'),('20160613124539'),('20160622141238'),('20160717091618'),('20160717092501'),('20160721153421'),('20160727124320'),('20160802141937'),('20160803155532'),('20160901092601'),('20160908162309'),('20161020125110'),('20161102141532'),('20161205155616'),('20161228092348'),('20170117090711'),('20170130152125'),('20170208011723'),('20170301094445'),('20170306162323'),('20170323174926'),('20170407111625'),('20170419075818'),('20170420103439'),('20170511111343'),('20170612145225'),('20170615161350'),('20170620183340'),('20170714145832'),('20170717105813'),('20170718092220'),('20170718105813'),('20170814121335'),('20170821093446'),('20170901160407'),('20170918094801'),('20170920103014'),('20171010115025'),('20171018151225'),('20171122100102'),('20171205142650'),('20171205142654'),('20171205170906'),('20171205170910'),('20171205170916'),('20180112150916'),('20180123182348'),('20180201111133'),('20180206151716'),('20180308150646'),('20180309022325'),('20180309022857'),('20180409130352'),('20180409130515'),('20180409130624'),('20180427123337'),('20180508133602'),('20180511145413'),('20180514101428'),('20180515091011'),('20180515094127'),('20180525141920'),('20180702143842'),('20180703110006'),('20180704082511'),('20180704103040'),('20180704104843'),('20180710110854'),('20180712165419'),('20180814151552'),('20180913135328'),('20180928114956'),('20181008065816'),('20181011104937'),('20181018082620'),('20181105203727'),('20181105212016'),('20181130072917'),('20181205131457'),('20181210222627'),('20190104134224'),('20190125090030'),('20190212111202'),('20190221101857'),('20190225170501'),('20190304094026'),('20190304222108'),('20190527104222'),('20190530065503'),('20190617100508'),('20190620092211'),('20190627103617'),('20190715144518'),('20190716110000'),('20190716110520'),('20190722114341'),('20190731092006'),('20190731092338'),('20190801143026'),('20190801143259'),('20190802133303'),('20190805135839'),('20190904144157'),('20190920123906'),('20190925133159'),('20190925152107'),('20191007101321'),('20200121142649'),('20200211080911'),('20200224095152'),('20200324130825'),('20200420104331'),('20200622134955'),('20200622162824'),('20200622163332'),('20200622163431'),('20200622163553'),('20200629103209'),('20200629104436'),('20200629105416'),('20200629105653'),('20200629110238'),('20200629110740'),('20200921135637'),('20201222214415'),('20210119101158'),('20210128155025'),('20210708100519'),('20210914124206'),('20210917163154'),('20211109141544'),('20211117094501'),('20211117094502'),('20211215120415'),('20220228215614'),('20230308155529'),('20230612105944'),('20230614232715'),('20230621090207'),('20230704094429'),('20230707104807'),('20230707110416'),('20230711123200'),('20230718082519'),('20230719112703'),('20230927012615'),('3'),('4'),('9');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_cubert_infos`
--

DROP TABLE IF EXISTS `service_cubert_infos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_cubert_infos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `bucket_id` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `service_id` bigint DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_cubert_infos`
--

LOCK TABLES `service_cubert_infos` WRITE;
/*!40000 ALTER TABLE `service_cubert_infos` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_cubert_infos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_tokens`
--

DROP TABLE IF EXISTS `service_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_tokens` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `service_id` bigint DEFAULT NULL,
  `value` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_service_tokens_on_service_id` (`service_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_tokens`
--

LOCK TABLES `service_tokens` WRITE;
/*!40000 ALTER TABLE `service_tokens` DISABLE KEYS */;
INSERT INTO `service_tokens` VALUES (1,1,'d961dc71504f2716923ec30e2680ae93453e835b3ff8cf1ba4b76adb20818ddb','2024-08-16 20:07:48','2024-08-16 20:07:48',NULL),(2,2,'25faf639e193f6f106168be75b1227d7b9fb999d2de53b8fa188ef500cca396f','2024-08-16 20:07:51','2024-08-16 20:07:51',2),(3,3,'d1d7665258c60577d663569039811db918d277c571f3b0b98f222d7498643b67','2024-08-16 20:12:25','2024-08-16 20:12:25',4),(4,4,'5dbe22072e16208909d4794c22956fe08ada429bd85815422e9b4263111f0f4b','2024-08-16 20:13:10','2024-08-16 20:13:10',4);
/*!40000 ALTER TABLE `service_tokens` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `service_tokens_tenant_id` BEFORE INSERT ON `service_tokens` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM services WHERE id = NEW.service_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` bigint NOT NULL,
  `name` varchar(255) COLLATE utf8mb3_bin DEFAULT '',
  `description` text COLLATE utf8mb3_bin,
  `txt_support` text COLLATE utf8mb3_bin,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `logo_file_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `logo_content_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `logo_file_size` int DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `intentions_required` tinyint(1) DEFAULT '0',
  `terms` text COLLATE utf8mb3_bin,
  `buyers_manage_apps` tinyint(1) DEFAULT '1',
  `buyers_manage_keys` tinyint(1) DEFAULT '1',
  `custom_keys_enabled` tinyint(1) DEFAULT '1',
  `buyer_plan_change_permission` varchar(255) COLLATE utf8mb3_bin DEFAULT 'request',
  `buyer_can_select_plan` tinyint(1) DEFAULT '0',
  `notification_settings` text COLLATE utf8mb3_bin,
  `default_application_plan_id` bigint DEFAULT NULL,
  `default_service_plan_id` bigint DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `system_name` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `backend_version` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT '1',
  `mandatory_app_key` tinyint(1) DEFAULT '1',
  `buyer_key_regenerate_enabled` tinyint(1) DEFAULT '1',
  `support_email` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `referrer_filters_required` tinyint(1) DEFAULT '0',
  `deployment_option` varchar(255) COLLATE utf8mb3_bin DEFAULT 'hosted',
  `kubernetes_service_link` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_services_on_system_name_and_account_id_and_deleted_at` (`system_name`,`account_id`),
  KEY `index_services_on_account_id_and_state` (`account_id`,`state`),
  KEY `idx_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,1,'Master Service',NULL,NULL,'2024-08-16 20:05:18','2024-08-16 20:05:21',NULL,NULL,NULL,'incomplete',0,NULL,1,1,1,'request',0,'---\n:web_buyer: &1\n- 0\n- 50\n- 80\n- 90\n- 100\n- 120\n- 150\n- 200\n- 300\n:email_buyer: *1\n:web_provider: *1\n:email_provider: *1\n',4,1,NULL,'master_service','1',1,1,NULL,0,'self_managed',NULL),(2,2,'API',NULL,NULL,'2024-08-16 20:05:20','2024-08-16 20:05:21',NULL,NULL,NULL,'incomplete',0,NULL,1,1,1,'request',0,NULL,7,5,2,'api','1',1,1,NULL,0,'hosted',NULL),(3,4,'API',NULL,NULL,'2024-08-16 20:12:24','2024-08-16 20:12:26',NULL,NULL,NULL,'incomplete',0,NULL,1,1,1,'request',0,NULL,11,9,4,'api','1',1,1,NULL,0,'hosted',NULL),(4,4,'Product A','',NULL,'2024-08-16 20:13:10','2024-08-16 20:13:10',NULL,NULL,NULL,'incomplete',0,NULL,1,1,1,'request',0,NULL,NULL,NULL,4,'product_a','1',1,1,NULL,0,'hosted',NULL);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `services_tenant_id` BEFORE INSERT ON `services` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.account_id <> master_id THEN
    SET NEW.tenant_id = NEW.account_id;
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` bigint DEFAULT NULL,
  `bg_colour` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `link_colour` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `text_colour` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `menu_bg_colour` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `link_label` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `link_url` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `welcome_text` text COLLATE utf8mb3_bin,
  `menu_link_colour` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `content_bg_colour` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `tracker_code` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `favicon` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `plans_tab_bg_colour` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `plans_bg_colour` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `content_border_colour` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `forum_enabled` tinyint(1) DEFAULT '1',
  `app_gallery_enabled` tinyint(1) DEFAULT '0',
  `anonymous_posts_enabled` tinyint(1) DEFAULT '0',
  `signups_enabled` tinyint(1) DEFAULT '1',
  `documentation_enabled` tinyint(1) DEFAULT '1',
  `useraccountarea_enabled` tinyint(1) DEFAULT '1',
  `refund_policy` text COLLATE utf8mb3_bin,
  `privacy_policy` text COLLATE utf8mb3_bin,
  `monthly_charging_enabled` tinyint(1) DEFAULT '1',
  `token_api` varchar(255) COLLATE utf8mb3_bin DEFAULT 'default',
  `documentation_public` tinyint(1) NOT NULL DEFAULT '1',
  `forum_public` tinyint(1) NOT NULL DEFAULT '1',
  `hide_service` tinyint(1) DEFAULT NULL,
  `cc_terms_path` varchar(255) COLLATE utf8mb3_bin DEFAULT '/termsofservice',
  `cc_privacy_path` varchar(255) COLLATE utf8mb3_bin DEFAULT '/privacypolicy',
  `cc_refunds_path` varchar(255) COLLATE utf8mb3_bin DEFAULT '/refundpolicy',
  `change_account_plan_permission` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT 'request',
  `strong_passwords_enabled` tinyint(1) DEFAULT '0',
  `change_service_plan_permission` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT 'request',
  `can_create_service` tinyint(1) NOT NULL DEFAULT '0',
  `spam_protection_level` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT 'none',
  `tenant_id` bigint DEFAULT NULL,
  `multiple_applications_switch` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `multiple_users_switch` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `finance_switch` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `multiple_services_switch` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `groups_switch` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `account_plans_switch` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `authentication_strategy` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT 'oauth2',
  `janrain_api_key` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `janrain_relying_party` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `service_plans_switch` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `public_search` tinyint(1) NOT NULL DEFAULT '0',
  `product` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT 'connect',
  `branding_switch` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `monthly_billing_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `cms_token` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `cas_server_url` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `sso_key` varchar(256) COLLATE utf8mb3_bin DEFAULT NULL,
  `sso_login_url` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `cms_escape_draft_html` tinyint(1) NOT NULL DEFAULT '1',
  `cms_escape_published_html` tinyint(1) NOT NULL DEFAULT '1',
  `heroku_id` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `heroku_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `setup_fee_enabled` tinyint(1) DEFAULT '0',
  `account_plans_ui_visible` tinyint(1) DEFAULT '0',
  `service_plans_ui_visible` tinyint(1) DEFAULT '0',
  `skip_email_engagement_footer_switch` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT 'denied',
  `web_hooks_switch` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT 'denied',
  `iam_tools_switch` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT 'denied',
  `require_cc_on_signup_switch` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT 'denied',
  `enforce_sso` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_settings_on_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,1,NULL,NULL,NULL,'2024-08-16 20:05:19','2024-08-16 20:05:20',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,1,1,1,NULL,NULL,1,'default',1,0,NULL,'/termsofservice','/privacypolicy','/refundpolicy','request',0,'request',0,'none',NULL,'denied','denied','denied','denied','denied','visible','oauth2',NULL,NULL,'visible',0,'connect','hidden',1,NULL,NULL,'9b9f56a696f238a1b56ada0f8066396a9bfd3844f8acb36473c9f4d40019c7dc',NULL,1,1,NULL,NULL,0,0,0,'denied','denied','denied','denied',0),(2,2,NULL,NULL,NULL,'2024-08-16 20:05:20','2024-08-16 20:05:21',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,1,1,1,NULL,NULL,1,'default',1,0,NULL,'/termsofservice','/privacypolicy','/refundpolicy','request',0,'request',0,'none',2,'visible','visible','visible','visible','visible','hidden','oauth2',NULL,NULL,'hidden',0,'enterprise','visible',1,NULL,NULL,'52033985455cb9db05087432f1b25c5c09eca478374a5d300cef5af91c1537ac',NULL,1,1,NULL,NULL,0,0,0,'hidden','visible','hidden','visible',0),(3,4,NULL,NULL,NULL,'2024-08-16 20:12:24','2024-08-16 20:12:25',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,1,1,1,NULL,NULL,1,'default',1,0,NULL,'/termsofservice','/privacypolicy','/refundpolicy','request',0,'request',0,'none',4,'hidden','hidden','visible','hidden','visible','hidden','oauth2',NULL,NULL,'hidden',0,'enterprise','visible',1,NULL,NULL,'35b5c2d45d04410ad80df8ea6757f56271073e4f54145916eea36d5b536bdaf6',NULL,1,1,NULL,NULL,0,0,0,'visible','visible','hidden','visible',0);
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `settings_tenant_id` BEFORE INSERT ON `settings` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM accounts WHERE id = NEW.account_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `slugs`
--

DROP TABLE IF EXISTS `slugs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `slugs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `sluggable_type` varchar(50) COLLATE utf8mb3_bin DEFAULT NULL,
  `sluggable_id` bigint DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `sequence` int NOT NULL DEFAULT '1',
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_slugs_on_n_s_and_s` (`name`,`sluggable_type`,`sequence`),
  KEY `index_slugs_on_sluggable_id` (`sluggable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slugs`
--

LOCK TABLES `slugs` WRITE;
/*!40000 ALTER TABLE `slugs` DISABLE KEYS */;
/*!40000 ALTER TABLE `slugs` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `slugs_tenant_id` BEFORE INSERT ON `slugs` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.sluggable_type = 'Profile' THEN
  SET NEW.tenant_id = (SELECT tenant_id FROM profiles WHERE id = NEW.sluggable_id AND tenant_id <> master_id);
ELSEIF NEW.sluggable_type = 'Service' THEN
  SET NEW.tenant_id = (SELECT tenant_id FROM services WHERE id = NEW.sluggable_id AND tenant_id <> master_id);
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sso_authorizations`
--

DROP TABLE IF EXISTS `sso_authorizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sso_authorizations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `authentication_provider_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `id_token` text COLLATE utf8mb3_bin,
  PRIMARY KEY (`id`),
  KEY `index_sso_authorizations_on_authentication_provider_id` (`authentication_provider_id`),
  KEY `index_sso_authorizations_on_user_id` (`user_id`),
  CONSTRAINT `fk_rails_a2edd6c261` FOREIGN KEY (`authentication_provider_id`) REFERENCES `authentication_providers` (`id`),
  CONSTRAINT `fk_rails_cc6004e8c7` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sso_authorizations`
--

LOCK TABLES `sso_authorizations` WRITE;
/*!40000 ALTER TABLE `sso_authorizations` DISABLE KEYS */;
/*!40000 ALTER TABLE `sso_authorizations` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `sso_authorizations_tenant_id` BEFORE INSERT ON `sso_authorizations` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM users WHERE id = NEW.user_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `system_operations`
--

DROP TABLE IF EXISTS `system_operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_operations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `ref` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `description` text COLLATE utf8mb3_bin,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `pos` int DEFAULT NULL,
  `tenant_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_operations`
--

LOCK TABLES `system_operations` WRITE;
/*!40000 ALTER TABLE `system_operations` DISABLE KEYS */;
INSERT INTO `system_operations` VALUES (1,'user_signup','New user signup',NULL,'2024-08-16 20:05:21','2024-08-16 20:05:21',NULL,NULL),(2,'new_app','New application created',NULL,'2024-08-16 20:05:21','2024-08-16 20:05:21',NULL,NULL),(3,'new_contract','New service subscription',NULL,'2024-08-16 20:05:21','2024-08-16 20:05:21',NULL,NULL),(4,'app_suspended','Application suspended',NULL,'2024-08-16 20:05:21','2024-08-16 20:05:21',NULL,NULL),(5,'contract_suspended','Service subscription suspended',NULL,'2024-08-16 20:05:21','2024-08-16 20:05:21',NULL,NULL),(6,'key_created','Application key created',NULL,'2024-08-16 20:05:21','2024-08-16 20:05:21',NULL,NULL),(7,'key_deleted','Application key deleted',NULL,'2024-08-16 20:05:21','2024-08-16 20:05:21',NULL,NULL),(8,'new_message','Receiving a new message',NULL,'2024-08-16 20:05:21','2024-08-16 20:05:21',NULL,NULL),(9,'plan_change','Plan change by a user',NULL,'2024-08-16 20:05:21','2024-08-16 20:05:21',NULL,NULL),(10,'new_forum_post','New forum post',NULL,'2024-08-16 20:05:21','2024-08-16 20:05:21',NULL,NULL),(11,'limit_alerts','Limit alerts and violations',NULL,'2024-08-16 20:05:21','2024-08-16 20:05:21',NULL,NULL),(12,'cinstance_cancellation','User cancels account',NULL,'2024-08-16 20:05:21','2024-08-16 20:05:21',NULL,NULL),(13,'contract_cancellation','Service subscription cancelation',NULL,'2024-08-16 20:05:21','2024-08-16 20:05:21',NULL,NULL),(14,'weekly_reports','Weekly aggregate reports',NULL,'2024-08-16 20:05:21','2024-08-16 20:05:21',NULL,NULL),(15,'daily_reports','Daily aggregate reports',NULL,'2024-08-16 20:05:21','2024-08-16 20:05:21',NULL,NULL),(16,'plan_change_request','Request to change plan',NULL,'2024-08-16 20:05:21','2024-08-16 20:05:21',NULL,NULL);
/*!40000 ALTER TABLE `system_operations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taggings`
--

DROP TABLE IF EXISTS `taggings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taggings` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tag_id` bigint DEFAULT NULL,
  `taggable_id` bigint DEFAULT NULL,
  `taggable_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `tagger_id` int DEFAULT NULL,
  `tagger_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `context` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_taggings_on_tag_id` (`tag_id`),
  KEY `taggings_taggable_context_idx` (`taggable_id`,`taggable_type`,`context`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taggings`
--

LOCK TABLES `taggings` WRITE;
/*!40000 ALTER TABLE `taggings` DISABLE KEYS */;
/*!40000 ALTER TABLE `taggings` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `taggings_tenant_id` BEFORE INSERT ON `taggings` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM tags WHERE id = NEW.tag_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `account_id` bigint DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `taggings_count` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_tags_on_name` (`name`,`tenant_id`),
  KEY `index_tags_on_account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `tags_tenant_id` BEFORE INSERT ON `tags` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.account_id <> master_id THEN
  SET NEW.tenant_id = NEW.account_id;
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `topic_categories`
--

DROP TABLE IF EXISTS `topic_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topic_categories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `forum_id` bigint DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_topic_categories_on_forum_id` (`forum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic_categories`
--

LOCK TABLES `topic_categories` WRITE;
/*!40000 ALTER TABLE `topic_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `topic_categories` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `topic_categories_tenant_id` BEFORE INSERT ON `topic_categories` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM forums WHERE id = NEW.forum_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `topics`
--

DROP TABLE IF EXISTS `topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topics` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `forum_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `hits` int DEFAULT '0',
  `sticky` tinyint(1) NOT NULL DEFAULT '0',
  `posts_count` int DEFAULT '0',
  `locked` tinyint(1) DEFAULT '0',
  `last_post_id` bigint DEFAULT NULL,
  `last_updated_at` datetime DEFAULT NULL,
  `last_user_id` bigint DEFAULT NULL,
  `permalink` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `category_id` bigint DEFAULT NULL,
  `delta` tinyint(1) NOT NULL DEFAULT '1',
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_topics_on_forum_id_and_permalink` (`forum_id`,`permalink`),
  KEY `index_topics_on_forum_id_and_last_updated_at` (`last_updated_at`,`forum_id`),
  KEY `index_topics_on_sticky_and_last_updated_at` (`sticky`,`last_updated_at`,`forum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topics`
--

LOCK TABLES `topics` WRITE;
/*!40000 ALTER TABLE `topics` DISABLE KEYS */;
/*!40000 ALTER TABLE `topics` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `topics_tenant_id` BEFORE INSERT ON `topics` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM forums WHERE id = NEW.forum_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usage_limits`
--

DROP TABLE IF EXISTS `usage_limits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usage_limits` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `metric_id` bigint DEFAULT NULL,
  `period` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `value` bigint DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `plan_id` bigint DEFAULT NULL,
  `plan_type` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_usage_limits_on_metric_id_and_plan_id_and_period` (`metric_id`,`plan_id`,`period`),
  KEY `idx_usage_limits_metric_id` (`metric_id`),
  KEY `idx_usage_limits_plan_id` (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usage_limits`
--

LOCK TABLES `usage_limits` WRITE;
/*!40000 ALTER TABLE `usage_limits` DISABLE KEYS */;
/*!40000 ALTER TABLE `usage_limits` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `usage_limits_tenant_id` BEFORE INSERT ON `usage_limits` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM metrics WHERE id = NEW.metric_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user_sessions`
--

DROP TABLE IF EXISTS `user_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_sessions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `key` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `ip` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `accessed_at` datetime DEFAULT NULL,
  `revoked_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `secured_until` datetime DEFAULT NULL,
  `sso_authorization_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_key` (`key`),
  KEY `index_user_sessions_on_sso_authorization_id` (`sso_authorization_id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `fk_rails_075076e365` FOREIGN KEY (`sso_authorization_id`) REFERENCES `sso_authorizations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_sessions`
--

LOCK TABLES `user_sessions` WRITE;
/*!40000 ALTER TABLE `user_sessions` DISABLE KEYS */;
INSERT INTO `user_sessions` VALUES (1,1,'YIkDZTgQkATdLbOfCTd1fUBwx9C94aHWTGh3n8fyg7I','62.45.139.47','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36','2024-08-16 20:17:42',NULL,'2024-08-16 20:09:47','2024-08-16 20:17:42',NULL,NULL),(2,6,'zwzEUBYSlSYKoRWJp2FXAwQYZZKVNC_Eua1sNYmO0zQ','62.45.139.47','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36','2024-08-16 20:52:09',NULL,'2024-08-16 20:12:40','2024-08-16 20:52:09',NULL,NULL),(3,5,'PSYN9TewDM2IhmT4hENEDaDMZgTlphTbmAPZfnPSjWY','62.45.139.47','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36','2024-08-16 20:18:32',NULL,'2024-08-16 20:18:19','2024-08-16 20:18:32',NULL,NULL);
/*!40000 ALTER TABLE `user_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_topics`
--

DROP TABLE IF EXISTS `user_topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_topics` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `topic_id` bigint DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `tenant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_topics`
--

LOCK TABLES `user_topics` WRITE;
/*!40000 ALTER TABLE `user_topics` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_topics` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `user_topics_tenant_id` BEFORE INSERT ON `user_topics` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM topics WHERE id = NEW.topic_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(40) COLLATE utf8mb3_bin DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `crypted_password` varchar(40) COLLATE utf8mb3_bin DEFAULT NULL,
  `salt` varchar(40) COLLATE utf8mb3_bin DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `remember_token` varchar(40) COLLATE utf8mb3_bin DEFAULT NULL,
  `remember_token_expires_at` datetime DEFAULT NULL,
  `activation_code` varchar(40) COLLATE utf8mb3_bin DEFAULT NULL,
  `activated_at` datetime DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `role` varchar(255) COLLATE utf8mb3_bin DEFAULT '',
  `lost_password_token` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `posts_count` int DEFAULT '0',
  `account_id` bigint DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `signup_type` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `job_role` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `last_login_ip` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `email_verification_code` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `extra_fields` text COLLATE utf8mb3_bin,
  `tenant_id` bigint DEFAULT NULL,
  `cas_identifier` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `lost_password_token_generated_at` datetime DEFAULT NULL,
  `authentication_id` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `open_id` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `password_digest` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_open_id` (`open_id`),
  KEY `idx_users_account_id` (`account_id`),
  KEY `index_users_on_email` (`email`),
  KEY `index_site_users_on_posts_count` (`posts_count`),
  KEY `index_users_on_login` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'master',NULL,NULL,NULL,'2024-08-16 20:05:18','2024-08-16 20:05:18',NULL,NULL,NULL,'2024-08-16 20:05:18','active','admin',NULL,0,1,NULL,NULL,'minimal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'$2a$12$0DIaEIsn0KDxmL17xSiQyOOeuzjC15oYSTWRVIprDGe1p/M.T1wtO'),(2,'admin','admin@3scale.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com',NULL,NULL,'2024-08-16 20:05:20','2024-08-16 20:05:20',NULL,NULL,NULL,'2024-08-16 20:05:20','active','admin',NULL,0,2,NULL,NULL,'minimal',NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,'$2a$12$8PAcMReURVqbWTRzqsZGbuPqtUs/CJplRgRorTlYEhQaQ1wIn.ATq'),(3,'3scaleadmin','3scaleadmin+3scale-admin.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com@3scale.net',NULL,NULL,'2024-08-16 20:05:20','2024-08-16 20:05:20',NULL,NULL,NULL,'2024-08-16 20:05:20','active','admin',NULL,0,2,'3scale','Admin','minimal',NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL),(4,'john','admin+test@3scale.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com',NULL,NULL,'2024-08-16 20:07:51','2024-08-16 20:07:51',NULL,NULL,NULL,'2024-08-16 20:07:51','active','admin',NULL,0,3,'John','Doe','minimal',NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,'$2a$12$cGc.i.p7qHhdAvIsdGQeAOvS.DvFHOwlcD.jbb9nBGF1jBqpmS9tW'),(5,'3scale-user','3scale-user@demo-organization.com',NULL,NULL,'2024-08-16 20:12:24','2024-08-16 20:17:42',NULL,NULL,NULL,'2024-08-16 20:17:42','active','admin',NULL,0,4,NULL,NULL,'created_by_provider',NULL,NULL,NULL,NULL,NULL,NULL,4,NULL,NULL,NULL,NULL,'$2a$12$w4T9.0qhStY0c6G.Re3q5.PXIGeppEITP.UkSrnhAIbvAka2S31ku'),(6,'3scaleadmin','3scaleadmin+demo-organization.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com@3scale.net',NULL,NULL,'2024-08-16 20:12:24','2024-08-16 20:12:24',NULL,NULL,'70a9fbb36058422bfc64b0f1b9abdeadbe5d410a',NULL,'active','admin',NULL,0,4,'3scale','Admin','minimal',NULL,NULL,NULL,NULL,NULL,NULL,4,NULL,NULL,NULL,NULL,NULL),(7,'john','3scale-user+test@demo-organization.com',NULL,NULL,'2024-08-16 20:12:50','2024-08-16 20:12:50',NULL,NULL,NULL,'2024-08-16 20:12:50','active','admin',NULL,0,5,'John','Doe','minimal',NULL,NULL,NULL,NULL,NULL,NULL,4,NULL,NULL,NULL,NULL,'$2a$12$bxZbEySh3c4wpLTVmSFMluesV9vkbQn3Bh2Nd69tWDSjfeATesR1u');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `users_tenant_id` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      SET NEW.tenant_id = (SELECT tenant_id FROM accounts WHERE id = NEW.account_id AND tenant_id <> master_id);

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `web_hooks`
--

DROP TABLE IF EXISTS `web_hooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `web_hooks` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` bigint DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `account_created_on` tinyint(1) DEFAULT '0',
  `account_updated_on` tinyint(1) DEFAULT '0',
  `account_deleted_on` tinyint(1) DEFAULT '0',
  `user_created_on` tinyint(1) DEFAULT '0',
  `user_updated_on` tinyint(1) DEFAULT '0',
  `user_deleted_on` tinyint(1) DEFAULT '0',
  `application_created_on` tinyint(1) DEFAULT '0',
  `application_updated_on` tinyint(1) DEFAULT '0',
  `application_deleted_on` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `provider_actions` tinyint(1) DEFAULT '0',
  `account_plan_changed_on` tinyint(1) DEFAULT '0',
  `application_plan_changed_on` tinyint(1) DEFAULT '0',
  `application_user_key_updated_on` tinyint(1) DEFAULT '0',
  `application_key_created_on` tinyint(1) DEFAULT '0',
  `application_key_deleted_on` tinyint(1) DEFAULT '0',
  `active` tinyint(1) DEFAULT '0',
  `application_suspended_on` tinyint(1) DEFAULT '0',
  `tenant_id` bigint DEFAULT NULL,
  `push_application_content_type` tinyint(1) DEFAULT '1',
  `application_key_updated_on` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_hooks`
--

LOCK TABLES `web_hooks` WRITE;
/*!40000 ALTER TABLE `web_hooks` DISABLE KEYS */;
/*!40000 ALTER TABLE `web_hooks` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `web_hooks_tenant_id` BEFORE INSERT ON `web_hooks` FOR EACH ROW BEGIN
  DECLARE master_id numeric;
  IF @disable_triggers IS NULL THEN
    IF NEW.tenant_id IS NULL THEN
      SET master_id = (SELECT id FROM accounts WHERE master)
;
      IF NEW.account_id <> master_id THEN
    SET NEW.tenant_id = NEW.account_id;
END IF;

    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-16 20:52:46
