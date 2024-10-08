USE master;
GO

IF NOT EXISTS (
      SELECT name
      FROM sys.databases
      WHERE name = N'TutorialDB'
      )
   CREATE DATABASE [Foodie-Fi];
GO

IF SERVERPROPERTY('ProductVersion') > '12'
   ALTER DATABASE [Foodie-Fi] SET QUERY_STORE = ON;
GO

--Creating the Plans Table and Inserting the Data
CREATE TABLE dbo.plans (
  plan_id INTEGER,
  plan_name VARCHAR(13),
  price DECIMAL(5,2)
);

INSERT INTO dbo.plans
  (plan_id, plan_name, price)
VALUES
  ('0', 'trial', '0'),
  ('1', 'basic monthly', '9.90'),
  ('2', 'pro monthly', '19.90'),
  ('3', 'pro annual', '199'),
  ('4', 'churn', null);

  SELECT *
  FROM dbo.plans

  --Creating the Subscriptions and Inserting the Data
  CREATE TABLE dbo.subscriptions (
  customer_id INTEGER,
  plan_id INTEGER,
  start_date DATE
);

INSERT INTO subscriptions
  (customer_id, plan_id, start_date)


VALUES
  ('1', '0', '2020-08-01'),
  ('1', '1', '2020-08-08'),
  ('2', '0', '2020-09-20'),
  ('2', '3', '2020-09-27'),
  ('3', '0', '2020-01-13'),
  ('3', '1', '2020-01-20'),
  ('4', '0', '2020-01-17'),
  ('4', '1', '2020-01-24'),
  ('4', '4', '2020-04-21'),
  ('5', '0', '2020-08-03'),
  ('5', '1', '2020-08-10'),
  ('6', '0', '2020-12-23'),
  ('6', '1', '2020-12-30'),
  ('6', '4', '2021-02-26'),
  ('7', '0', '2020-02-05'),
  ('7', '1', '2020-02-12'),
  ('7', '2', '2020-05-22'),
  ('8', '0', '2020-06-11'),
  ('8', '1', '2020-06-18'),
  ('8', '2', '2020-08-03'),
  ('9', '0', '2020-12-07'),
  ('9', '3', '2020-12-14'),
  ('10', '0', '2020-09-19'),
  ('10', '2', '2020-09-26'),
  ('11', '0', '2020-11-19'),
  ('11', '4', '2020-11-26'),
  ('12', '0', '2020-09-22'),
  ('12', '1', '2020-09-29'),
  ('13', '0', '2020-12-15'),
  ('13', '1', '2020-12-22'),
  ('13', '2', '2021-03-29'),
  ('14', '0', '2020-09-22'),
  ('14', '1', '2020-09-29'),
  ('15', '0', '2020-03-17'),
  ('15', '2', '2020-03-24'),
  ('15', '4', '2020-04-29'),
  ('16', '0', '2020-05-31'),
  ('16', '1', '2020-06-07'),
  ('16', '3', '2020-10-21'),
  ('17', '0', '2020-07-27'),
  ('17', '1', '2020-08-03'),
  ('17', '3', '2020-12-11'),
  ('18', '0', '2020-07-06'),
  ('18', '2', '2020-07-13'),
  ('19', '0', '2020-06-22'),
  ('19', '2', '2020-06-29'),
  ('19', '3', '2020-08-29'),
  ('20', '0', '2020-04-08'),
  ('20', '1', '2020-04-15'),
  ('20', '3', '2020-06-05'),
  ('21', '0', '2020-02-04'),
  ('21', '1', '2020-02-11'),
  ('21', '2', '2020-06-03'),
  ('21', '4', '2020-09-27'),
  ('22', '0', '2020-01-10'),
  ('22', '2', '2020-01-17'),
  ('23', '0', '2020-05-13'),
  ('23', '3', '2020-05-20'),
  ('24', '0', '2020-11-10'),
  ('24', '2', '2020-11-17'),
  ('24', '3', '2021-04-17'),
  ('25', '0', '2020-05-10'),
  ('25', '1', '2020-05-17'),
  ('25', '2', '2020-06-16'),
  ('26', '0', '2020-12-08'),
  ('26', '2', '2020-12-15'),
  ('27', '0', '2020-08-24'),
  ('27', '2', '2020-08-31'),
  ('28', '0', '2020-06-30'),
  ('28', '3', '2020-07-07'),
  ('29', '0', '2020-01-23'),
  ('29', '2', '2020-01-30'),
  ('30', '0', '2020-04-29'),
  ('30', '1', '2020-05-06'),
  ('31', '0', '2020-06-22'),
  ('31', '2', '2020-06-29'),
  ('31', '3', '2020-11-29'),
  ('32', '0', '2020-06-12'),
  ('32', '1', '2020-06-19'),
  ('32', '2', '2020-07-18'),
  ('33', '0', '2020-09-03'),
  ('33', '2', '2020-09-10'),
  ('33', '4', '2021-02-05'),
  ('34', '0', '2020-12-20'),
  ('34', '1', '2020-12-27'),
  ('34', '2', '2021-03-26'),
  ('35', '0', '2020-09-03'),
  ('35', '2', '2020-09-10'),
  ('36', '0', '2020-02-25'),
  ('36', '2', '2020-03-03'),
  ('37', '0', '2020-08-05'),
  ('37', '1', '2020-08-12'),
  ('37', '2', '2020-11-11'),
  ('38', '0', '2020-10-02'),
  ('38', '2', '2020-10-09'),
  ('38', '3', '2020-11-09'),
  ('39', '0', '2020-05-28'),
  ('39', '1', '2020-06-04'),
  ('39', '2', '2020-08-25'),
  ('39', '4', '2020-09-10'),
  ('40', '0', '2020-01-22'),
  ('40', '1', '2020-01-29'),
  ('40', '2', '2020-03-25');

--A. Customer Journey
--Based off the 8 sample customers provided in the sample from the subscriptions table, write a brief description about each customerís onboarding journey.
SELECT customer_id, plans.plan_name, start_date, LAG(start_date) OVER (PARTITION BY (customer_id) ORDER BY (customer_id)) AS previous_start_date, 
DATEDIFF(DAY, LAG(start_date) OVER (PARTITION BY (customer_id) ORDER BY (customer_id)), start_date) AS day_gap
FROM subscriptions
JOIN plans
ON subscriptions.plan_id = plans.plan_id
WHERE customer_id < 9
--Customer 1 started trial on 8/1/2020 and started basic monthly right after the trial ended
--Customer 2 started trial on 9/20/2020 and started pro annual right after the trial ended
--Customer 3 started trial on 1/13/2020 and started basic monthly right after the trial ended
--Customer 4 started trial on 1/17/2020, started basic monthly right after the trial ended, and switched to churn on 4/21/2020
--Customer 5 started trial on 8/3/2020 and started basic monthly right after the trial ended
--Customer 6 started trial on 12/23/2020, started basic monthly right after the trial ended, and switched to churn on 2/26/2021
--Customer 7 started trial on 2/5/2020, started basic monthly right after the trial ended, and switched to pro monthly on 5/22/2020
--Customer 8 started trial on 6/11/2020, started basic monthly right after the trial ended, switched to pro monthly on 8/3/2020

--B. Data Analysis 
INSERT INTO subscriptions VALUES
 ('41', '0', '2020-05-16'),
  ('41', '2', '2020-05-23'),
  ('42', '0', '2020-10-27'),
  ('42', '1', '2020-11-03'),
  ('42', '2', '2021-04-28'),
  ('43', '0', '2020-08-13'),
  ('43', '1', '2020-08-20'),
  ('43', '2', '2020-12-18'),
  ('44', '0', '2020-03-17'),
  ('44', '3', '2020-03-24'),
  ('45', '0', '2020-02-11'),
  ('45', '1', '2020-02-18'),
  ('45', '2', '2020-08-12'),
  ('46', '0', '2020-04-19'),
  ('46', '1', '2020-04-26'),
  ('46', '2', '2020-07-06'),
  ('46', '3', '2020-08-06'),
  ('47', '0', '2020-06-06'),
  ('47', '1', '2020-06-13'),
  ('47', '3', '2020-10-26'),
  ('48', '0', '2020-01-11'),
  ('48', '1', '2020-01-18'),
  ('48', '4', '2020-06-01'),
  ('49', '0', '2020-04-24'),
  ('49', '2', '2020-05-01'),
  ('49', '3', '2020-08-01'),
  ('50', '0', '2020-07-21'),
  ('50', '2', '2020-07-28'),
  ('51', '0', '2020-01-19'),
  ('51', '1', '2020-01-26'),
  ('51', '3', '2020-03-09'),
  ('51', '4', '2021-03-09'),
  ('52', '0', '2020-05-31'),
  ('52', '1', '2020-06-07'),
  ('52', '4', '2020-07-05'),
  ('53', '0', '2020-01-18'),
  ('53', '1', '2020-01-25'),
  ('54', '0', '2020-05-23'),
  ('54', '2', '2020-05-30'),
  ('55', '0', '2020-10-22'),
  ('55', '1', '2020-10-29'),
  ('55', '3', '2021-03-01'),
  ('56', '0', '2020-01-03'),
  ('56', '3', '2020-01-10'),
  ('57', '0', '2020-03-03'),
  ('57', '2', '2020-03-10'),
  ('58', '0', '2020-07-04'),
  ('58', '1', '2020-07-11'),
  ('58', '3', '2020-09-24'),
  ('59', '0', '2020-10-30'),
  ('59', '1', '2020-11-06'),
  ('59', '4', '2021-04-29'),
  ('60', '0', '2020-06-17'),
  ('60', '1', '2020-06-24'),
  ('61', '0', '2020-08-31'),
  ('61', '1', '2020-09-07'),
  ('61', '3', '2021-02-13'),
  ('62', '0', '2020-10-12'),
  ('62', '1', '2020-10-19'),
  ('62', '2', '2021-01-02'),
  ('62', '4', '2021-02-23'),
  ('63', '0', '2020-05-28'),
  ('63', '1', '2020-06-04'),
  ('63', '4', '2020-06-18'),
  ('64', '0', '2020-03-08'),
  ('64', '1', '2020-03-15'),
  ('64', '2', '2020-04-03'),
  ('64', '4', '2020-04-27'),
  ('65', '0', '2020-05-12'),
  ('65', '1', '2020-05-19'),
  ('65', '2', '2020-10-09'),
  ('66', '0', '2020-07-30'),
  ('66', '1', '2020-08-06'),
  ('66', '3', '2020-10-04'),
  ('67', '0', '2020-08-14'),
  ('67', '2', '2020-08-21'),
  ('68', '0', '2020-04-10'),
  ('68', '3', '2020-04-17'),
  ('69', '0', '2020-03-07'),
  ('69', '1', '2020-03-14'),
  ('69', '2', '2020-04-14'),
  ('70', '0', '2020-07-06'),
  ('70', '1', '2020-07-13'),
  ('70', '2', '2021-01-06'),
  ('71', '0', '2020-07-23'),
  ('71', '2', '2020-07-30'),
  ('71', '4', '2020-12-08'),
  ('72', '0', '2020-12-10'),
  ('72', '2', '2020-12-17'),
  ('72', '4', '2021-02-01'),
  ('73', '0', '2020-03-24'),
  ('73', '1', '2020-03-31'),
  ('73', '2', '2020-05-13'),
  ('73', '3', '2020-10-13'),
  ('74', '0', '2020-05-24'),
  ('74', '1', '2020-05-31'),
  ('74', '3', '2020-10-01'),
  ('75', '0', '2020-07-14'),
  ('75', '1', '2020-07-21'),
  ('75', '2', '2020-11-19'),
  ('76', '0', '2020-08-31'),
  ('76', '3', '2020-09-07'),
  ('77', '0', '2020-04-18'),
  ('77', '2', '2020-04-25'),
  ('77', '3', '2020-10-25'),
  ('78', '0', '2020-09-03'),
  ('78', '2', '2020-09-10'),
  ('78', '4', '2021-02-19'),
  ('79', '0', '2020-07-30'),
  ('79', '2', '2020-08-06'),
  ('80', '0', '2020-09-23'),
  ('80', '2', '2020-09-30'),
  ('80', '4', '2021-01-17'),
  ('81', '0', '2020-05-29'),
  ('81', '2', '2020-06-05'),
  ('81', '4', '2020-10-20'),
  ('82', '0', '2020-05-02'),
  ('82', '1', '2020-05-09'),
  ('83', '0', '2020-05-18'),
  ('83', '1', '2020-05-25'),
  ('83', '2', '2020-10-29'),
  ('83', '3', '2021-04-29'),
  ('84', '0', '2020-06-14'),
  ('84', '1', '2020-06-21'),
  ('84', '4', '2020-07-07'),
  ('85', '0', '2020-08-13'),
  ('85', '1', '2020-08-20'),
  ('86', '0', '2020-07-10'),
  ('86', '3', '2020-07-17'),
  ('87', '0', '2020-08-08'),
  ('87', '2', '2020-08-15'),
  ('87', '3', '2020-09-15'),
  ('88', '0', '2020-12-30'),
  ('88', '2', '2021-01-06'),
  ('89', '0', '2020-03-05'),
  ('89', '2', '2020-03-12'),
  ('89', '4', '2020-09-02'),
  ('90', '0', '2020-11-25'),
  ('90', '1', '2020-12-02'),
  ('90', '2', '2021-03-28'),
  ('90', '3', '2021-04-28'),
  ('91', '0', '2020-09-08'),
  ('91', '2', '2020-09-15'),
  ('91', '4', '2021-03-04'),
  ('92', '0', '2020-11-02'),
  ('92', '1', '2020-11-09'),
  ('93', '0', '2020-03-14'),
  ('93', '2', '2020-03-21'),
  ('93', '4', '2020-08-30'),
  ('94', '0', '2020-12-09'),
  ('94', '2', '2020-12-16'),
  ('95', '0', '2020-11-02'),
  ('95', '1', '2020-11-09'),
  ('95', '2', '2021-03-16'),
  ('96', '0', '2020-08-22'),
  ('96', '1', '2020-08-29'),
  ('96', '3', '2021-01-23'),
  ('97', '0', '2020-10-29'),
  ('97', '1', '2020-11-05'),
  ('98', '0', '2020-01-05'),
  ('98', '1', '2020-01-12'),
  ('98', '2', '2020-01-22'),
  ('98', '4', '2020-04-05'),
  ('99', '0', '2020-12-05'),
  ('99', '4', '2020-12-12'),
  ('100', '0', '2020-06-02'),
  ('100', '1', '2020-06-09'),
  ('100', '2', '2020-09-11'),
  ('101', '0', '2020-06-08'),
  ('101', '1', '2020-06-15'),
  ('101', '3', '2020-07-20'),
  ('102', '0', '2020-06-02'),
  ('102', '1', '2020-06-09'),
  ('102', '2', '2020-06-18'),
  ('102', '4', '2020-12-01'),
  ('103', '0', '2020-07-24'),
  ('103', '2', '2020-07-31'),
  ('103', '4', '2020-10-28'),
  ('104', '0', '2020-03-29'),
  ('104', '2', '2020-04-05'),
  ('105', '0', '2020-09-20'),
  ('105', '1', '2020-09-27'),
  ('105', '3', '2020-10-22'),
  ('106', '0', '2020-08-02'),
  ('106', '3', '2020-08-09'),
  ('107', '0', '2020-01-12'),
  ('107', '1', '2020-01-19'),
  ('107', '2', '2020-03-23'),
  ('108', '0', '2020-09-10'),
  ('108', '4', '2020-09-17'),
  ('109', '0', '2020-10-12'),
  ('109', '1', '2020-10-19'),
  ('109', '2', '2021-03-20'),
  ('110', '0', '2020-05-12'),
  ('110', '2', '2020-05-19'),
  ('111', '0', '2020-08-25'),
  ('111', '3', '2020-09-01'),
  ('112', '0', '2020-10-20'),
  ('112', '2', '2020-10-27'),
  ('112', '4', '2021-01-08'),
  ('113', '0', '2020-04-10'),
  ('113', '1', '2020-04-17'),
  ('113', '2', '2020-09-13'),
  ('113', '4', '2020-11-01'),
  ('114', '0', '2020-06-05'),
  ('114', '1', '2020-06-12'),
  ('114', '3', '2020-09-13'),
  ('115', '0', '2020-08-14'),
  ('115', '3', '2020-08-21'),
  ('116', '0', '2020-05-23'),
  ('116', '1', '2020-05-30'),
  ('116', '4', '2020-09-15'),
  ('117', '0', '2020-05-22'),
  ('117', '1', '2020-05-29'),
  ('117', '3', '2020-11-14'),
  ('118', '0', '2020-01-24'),
  ('118', '1', '2020-01-31'),
  ('118', '4', '2020-06-30'),
  ('119', '0', '2020-11-09'),
  ('119', '1', '2020-11-16'),
  ('119', '3', '2021-02-27'),
  ('120', '0', '2020-05-14'),
  ('120', '2', '2020-05-21'),
  ('120', '3', '2020-09-21'),
  ('121', '0', '2020-06-18'),
  ('121', '1', '2020-06-25'),
  ('121', '3', '2020-10-07'),
  ('122', '0', '2020-03-30'),
  ('122', '4', '2020-04-06'),
  ('123', '0', '2020-03-12'),
  ('123', '1', '2020-03-19'),
  ('123', '4', '2020-05-15'),
  ('124', '0', '2020-03-17'),
  ('124', '1', '2020-03-24'),
  ('124', '3', '2020-06-20'),
  ('125', '0', '2020-08-07'),
  ('125', '1', '2020-08-14'),
  ('125', '4', '2020-12-03'),
  ('126', '0', '2020-09-15'),
  ('126', '1', '2020-09-22'),
  ('127', '0', '2020-05-23'),
  ('127', '2', '2020-05-30'),
  ('127', '4', '2020-08-11'),
  ('128', '0', '2020-01-19'),
  ('128', '4', '2020-01-26'),
  ('129', '0', '2020-07-23'),
  ('129', '1', '2020-07-30'),
  ('130', '0', '2020-09-22'),
  ('130', '2', '2020-09-29'),
  ('131', '0', '2020-10-16'),
  ('131', '3', '2020-10-23'),
  ('132', '0', '2020-10-18'),
  ('132', '1', '2020-10-25'),
  ('132', '4', '2021-01-07'),
  ('133', '0', '2020-03-29'),
  ('133', '1', '2020-04-05'),
  ('133', '3', '2020-07-11'),
  ('134', '0', '2020-07-02'),
  ('134', '2', '2020-07-09'),
  ('135', '0', '2020-12-23'),
  ('135', '4', '2020-12-30'),
  ('136', '0', '2020-08-16'),
  ('136', '4', '2020-08-23'),
  ('137', '0', '2020-08-12'),
  ('137', '2', '2020-08-19'),
  ('138', '0', '2020-10-26'),
  ('138', '1', '2020-11-02'),
  ('138', '2', '2020-12-25'),
  ('138', '3', '2021-01-25'),
  ('139', '0', '2020-07-17'),
  ('139', '2', '2020-07-24'),
  ('140', '0', '2020-12-25'),
  ('140', '1', '2021-01-01'),
  ('141', '0', '2020-04-19'),
  ('141', '1', '2020-04-26'),
  ('141', '3', '2020-10-18'),
  ('142', '0', '2020-05-30'),
  ('142', '2', '2020-06-06'),
  ('143', '0', '2020-12-20'),
  ('143', '1', '2020-12-27'),
  ('143', '4', '2021-03-03'),
  ('144', '0', '2020-09-04'),
  ('144', '1', '2020-09-11'),
  ('144', '2', '2021-02-09'),
  ('145', '0', '2020-01-17'),
  ('145', '2', '2020-01-24'),
  ('146', '0', '2020-07-05'),
  ('146', '1', '2020-07-12'),
  ('146', '2', '2020-10-28'),
  ('146', '4', '2020-12-18'),
  ('147', '0', '2020-12-18'),
  ('147', '2', '2020-12-25'),
  ('148', '0', '2020-03-12'),
  ('148', '2', '2020-03-19'),
  ('149', '0', '2020-12-19'),
  ('149', '1', '2020-12-26'),
  ('150', '0', '2020-02-05'),
  ('150', '2', '2020-02-12'),
  ('151', '0', '2020-09-07'),
  ('151', '1', '2020-09-14'),
  ('151', '2', '2020-09-17'),
  ('152', '0', '2020-10-14'),
  ('152', '1', '2020-10-21'),
  ('152', '2', '2021-03-08'),
  ('153', '0', '2020-11-28'),
  ('153', '2', '2020-12-05'),
  ('154', '0', '2020-03-18'),
  ('154', '1', '2020-03-25'),
  ('154', '2', '2020-05-01'),
  ('155', '0', '2020-09-13'),
  ('155', '4', '2020-09-20'),
  ('156', '0', '2020-01-19'),
  ('156', '4', '2020-01-26'),
  ('157', '0', '2020-04-23'),
  ('157', '1', '2020-04-30'),
  ('157', '3', '2020-05-11'),
  ('158', '0', '2020-03-02'),
  ('158', '1', '2020-03-09'),
  ('158', '2', '2020-05-09'),
  ('159', '0', '2020-09-09'),
  ('159', '2', '2020-09-16'),
  ('160', '0', '2020-11-16'),
  ('160', '1', '2020-11-23'),
  ('161', '0', '2020-12-17'),
  ('161', '4', '2020-12-24'),
  ('162', '0', '2020-02-23'),
  ('162', '4', '2020-03-01'),
  ('163', '0', '2020-12-23'),
  ('163', '2', '2020-12-30'),
  ('164', '0', '2020-11-27'),
  ('164', '2', '2020-12-04'),
  ('164', '4', '2020-12-24'),
  ('165', '0', '2020-10-05'),
  ('165', '1', '2020-10-12'),
  ('165', '3', '2020-11-08'),
  ('166', '0', '2020-07-03'),
  ('166', '1', '2020-07-10'),
  ('166', '4', '2020-09-22'),
  ('167', '0', '2020-05-07'),
  ('167', '2', '2020-05-14'),
  ('168', '0', '2020-03-07'),
  ('168', '2', '2020-03-14'),
  ('169', '0', '2020-04-07'),
  ('169', '4', '2020-04-14'),
  ('170', '0', '2020-04-18'),
  ('170', '1', '2020-04-25'),
  ('170', '2', '2020-08-28'),
  ('170', '3', '2020-12-28'),
  ('171', '0', '2020-11-28'),
  ('171', '2', '2020-12-05'),
  ('172', '0', '2020-12-05'),
  ('172', '1', '2020-12-12'),
  ('172', '4', '2021-02-15'),
  ('173', '0', '2020-06-24'),
  ('173', '2', '2020-07-01'),
  ('174', '0', '2020-02-01'),
  ('174', '1', '2020-02-08'),
  ('174', '3', '2020-07-10'),
  ('175', '0', '2020-08-15'),
  ('175', '2', '2020-08-22'),
  ('175', '4', '2020-11-23'),
  ('176', '0', '2020-09-13'),
  ('176', '1', '2020-09-20'),
  ('177', '0', '2020-05-01'),
  ('177', '2', '2020-05-08'),
  ('177', '4', '2020-09-09'),
  ('178', '0', '2020-02-22'),
  ('178', '4', '2020-02-29'),
  ('179', '0', '2020-06-13'),
  ('179', '2', '2020-06-20'),
  ('179', '4', '2020-09-25'),
  ('180', '0', '2020-10-31'),
  ('180', '1', '2020-11-07'),
  ('180', '2', '2021-01-17'),
  ('181', '0', '2020-02-11'),
  ('181', '2', '2020-02-18'),
  ('182', '0', '2020-09-26'),
  ('182', '1', '2020-10-03'),
  ('182', '4', '2021-02-25'),
  ('183', '0', '2020-09-25'),
  ('183', '2', '2020-10-02'),
  ('184', '0', '2020-02-16'),
  ('184', '1', '2020-02-23'),
  ('185', '0', '2020-12-03'),
  ('185', '2', '2020-12-10'),
  ('186', '0', '2020-09-30'),
  ('186', '2', '2020-10-07'),
  ('186', '4', '2021-02-05'),
  ('187', '0', '2020-09-19'),
  ('187', '3', '2020-09-26'),
  ('188', '0', '2020-02-22'),
  ('188', '1', '2020-02-29'),
  ('189', '0', '2020-12-09'),
  ('189', '2', '2020-12-16'),
  ('190', '0', '2020-04-20'),
  ('190', '1', '2020-04-27'),
  ('190', '3', '2020-09-04'),
  ('191', '0', '2020-01-02'),
  ('191', '2', '2020-01-09'),
  ('192', '0', '2020-07-29'),
  ('192', '1', '2020-08-05'),
  ('193', '0', '2020-05-19'),
  ('193', '1', '2020-05-26'),
  ('193', '2', '2020-09-21'),
  ('193', '3', '2020-10-21'),
  ('194', '0', '2020-11-20'),
  ('194', '2', '2020-11-27'),
  ('194', '4', '2021-01-13'),
  ('195', '0', '2020-02-08'),
  ('195', '2', '2020-02-15'),
  ('195', '3', '2020-06-15'),
  ('196', '0', '2020-03-09'),
  ('196', '2', '2020-03-16'),
  ('197', '0', '2020-05-17'),
  ('197', '2', '2020-05-24'),
  ('197', '4', '2020-07-01'),
  ('198', '0', '2020-11-11'),
  ('198', '1', '2020-11-18'),
  ('198', '4', '2021-03-16'),
  ('199', '0', '2020-12-09'),
  ('199', '2', '2020-12-16'),
  ('200', '0', '2020-04-05'),
  ('200', '2', '2020-04-12'),
  ('201', '0', '2020-03-07'),
  ('201', '1', '2020-03-14'),
  ('202', '0', '2020-07-01'),
  ('202', '2', '2020-07-08'),
  ('203', '0', '2020-08-24'),
  ('203', '1', '2020-08-31'),
  ('203', '3', '2020-09-19'),
  ('204', '0', '2020-06-10'),
  ('204', '1', '2020-06-17'),
  ('204', '4', '2020-10-05'),
  ('205', '0', '2020-11-02'),
  ('205', '1', '2020-11-09'),
  ('205', '3', '2021-03-13'),
  ('206', '0', '2020-03-17'),
  ('206', '1', '2020-03-24'),
  ('206', '3', '2020-09-02'),
  ('207', '0', '2020-05-20'),
  ('207', '1', '2020-05-27'),
  ('208', '0', '2020-06-12'),
  ('208', '2', '2020-06-19'),
  ('208', '3', '2020-09-19'),
  ('209', '0', '2020-08-13'),
  ('209', '2', '2020-08-20'),
  ('210', '0', '2020-02-09'),
  ('210', '2', '2020-02-16'),
  ('210', '4', '2020-06-21'),
  ('211', '0', '2020-10-10'),
  ('211', '1', '2020-10-17'),
  ('211', '3', '2020-10-18'),
  ('212', '0', '2020-03-02'),
  ('212', '1', '2020-03-09'),
  ('213', '0', '2020-08-07'),
  ('213', '3', '2020-08-14'),
  ('214', '0', '2020-02-03'),
  ('214', '1', '2020-02-10'),
  ('214', '2', '2020-05-07'),
  ('214', '4', '2020-08-21'),
  ('215', '0', '2020-04-16'),
  ('215', '2', '2020-04-23'),
  ('215', '3', '2020-07-23'),
  ('216', '0', '2020-08-26'),
  ('216', '2', '2020-09-02'),
  ('217', '0', '2020-12-06'),
  ('217', '2', '2020-12-13'),
  ('218', '0', '2020-12-02'),
  ('218', '1', '2020-12-09'),
  ('218', '4', '2021-04-24'),
  ('219', '0', '2020-10-22'),
  ('219', '2', '2020-10-29'),
  ('219', '3', '2021-04-29'),
  ('220', '0', '2020-06-08'),
  ('220', '4', '2020-06-15'),
  ('221', '0', '2020-09-27'),
  ('221', '1', '2020-10-04'),
  ('221', '3', '2021-03-29'),
  ('222', '0', '2020-08-29'),
  ('222', '1', '2020-09-05'),
  ('222', '4', '2020-12-25'),
  ('223', '0', '2020-08-01'),
  ('223', '1', '2020-08-08'),
  ('223', '3', '2021-01-31'),
  ('224', '0', '2020-01-26'),
  ('224', '2', '2020-02-02'),
  ('224', '3', '2020-05-02'),
  ('225', '0', '2020-12-27'),
  ('225', '4', '2021-01-03'),
  ('226', '0', '2020-11-01'),
  ('226', '1', '2020-11-08'),
  ('226', '2', '2020-11-24'),
  ('227', '0', '2020-03-02'),
  ('227', '2', '2020-03-09'),
  ('227', '3', '2020-08-09'),
  ('228', '0', '2020-10-02'),
  ('228', '2', '2020-10-09'),
  ('228', '3', '2021-02-09'),
  ('229', '0', '2020-07-24'),
  ('229', '1', '2020-07-31'),
  ('229', '4', '2021-01-24'),
  ('230', '0', '2020-04-08'),
  ('230', '4', '2020-04-15'),
  ('231', '0', '2020-05-13'),
  ('231', '1', '2020-05-20'),
  ('231', '2', '2020-07-09'),
  ('232', '0', '2020-08-26'),
  ('232', '1', '2020-09-02'),
  ('232', '2', '2021-02-03'),
  ('233', '0', '2020-07-31'),
  ('233', '1', '2020-08-07'),
  ('233', '3', '2020-10-29'),
  ('234', '0', '2020-01-19'),
  ('234', '2', '2020-01-26'),
  ('235', '0', '2020-08-20'),
  ('235', '1', '2020-08-27'),
  ('235', '2', '2020-10-17'),
  ('236', '0', '2020-06-22'),
  ('236', '1', '2020-06-29'),
  ('237', '0', '2020-11-07'),
  ('237', '1', '2020-11-14'),
  ('237', '2', '2021-03-24'),
  ('238', '0', '2020-10-27'),
  ('238', '1', '2020-11-03'),
  ('238', '3', '2020-12-23'),
  ('239', '0', '2020-08-15'),
  ('239', '1', '2020-08-22'),
  ('239', '4', '2020-10-20'),
  ('240', '0', '2020-01-14'),
  ('240', '1', '2020-01-21'),
  ('240', '3', '2020-03-03'),
  ('240', '4', '2021-03-03'),
  ('241', '0', '2020-10-03'),
  ('241', '1', '2020-10-10'),
  ('241', '3', '2020-11-11'),
  ('242', '0', '2020-10-19'),
  ('242', '2', '2020-10-26'),
  ('243', '0', '2020-09-04'),
  ('243', '1', '2020-09-11'),
  ('244', '0', '2020-03-04'),
  ('244', '2', '2020-03-11'),
  ('245', '0', '2020-03-28'),
  ('245', '4', '2020-04-04'),
  ('246', '0', '2020-01-27'),
  ('246', '1', '2020-02-03'),
  ('247', '0', '2020-07-07'),
  ('247', '1', '2020-07-14'),
  ('247', '2', '2020-08-20'),
  ('248', '0', '2020-11-09'),
  ('248', '1', '2020-11-16'),
  ('249', '0', '2020-02-18'),
  ('249', '2', '2020-02-25'),
  ('250', '0', '2020-06-15'),
  ('250', '2', '2020-06-22'),
  ('250', '3', '2020-09-22'),
  ('251', '0', '2020-03-09'),
  ('251', '4', '2020-03-16'),
  ('252', '0', '2020-11-08'),
  ('252', '1', '2020-11-15'),
  ('252', '2', '2020-12-23'),
  ('253', '0', '2020-05-15'),
  ('253', '2', '2020-05-22'),
  ('253', '4', '2020-10-12'),
  ('254', '0', '2020-07-23'),
  ('254', '4', '2020-07-30'),
  ('255', '0', '2020-03-29'),
  ('255', '2', '2020-04-05'),
  ('255', '3', '2020-10-05'),
  ('256', '0', '2020-07-13'),
  ('256', '1', '2020-07-20'),
  ('256', '2', '2020-11-23'),
  ('257', '0', '2020-01-15'),
  ('257', '2', '2020-01-22'),
  ('257', '3', '2020-04-22'),
  ('257', '4', '2021-04-22'),
  ('258', '0', '2020-06-19'),
  ('258', '1', '2020-06-26'),
  ('258', '3', '2020-07-06'),
  ('259', '0', '2020-11-09'),
  ('259', '1', '2020-11-16'),
  ('259', '2', '2021-02-13'),
  ('260', '0', '2020-09-21'),
  ('260', '2', '2020-09-28'),
  ('261', '0', '2020-03-12'),
  ('261', '2', '2020-03-19'),
  ('261', '3', '2020-05-19'),
  ('262', '0', '2020-05-14'),
  ('262', '1', '2020-05-21'),
  ('263', '0', '2020-07-10'),
  ('263', '2', '2020-07-17'),
  ('263', '4', '2020-07-20'),
  ('264', '0', '2020-09-12'),
  ('264', '2', '2020-09-19'),
  ('264', '4', '2020-12-07'),
  ('265', '0', '2020-06-13'),
  ('265', '1', '2020-06-20'),
  ('265', '4', '2020-07-14'),
  ('266', '0', '2020-07-20'),
  ('266', '1', '2020-07-27'),
  ('266', '3', '2020-12-04'),
  ('267', '0', '2020-09-19'),
  ('267', '1', '2020-09-26'),
  ('267', '3', '2020-10-10'),
  ('268', '0', '2020-10-07'),
  ('268', '1', '2020-10-14'),
  ('268', '4', '2020-11-07'),
  ('269', '0', '2020-07-29'),
  ('269', '1', '2020-08-05'),
  ('269', '2', '2020-12-06'),
  ('270', '0', '2020-07-05'),
  ('270', '2', '2020-07-12'),
  ('270', '3', '2021-01-12'),
  ('271', '0', '2020-08-29'),
  ('271', '2', '2020-09-05'),
  ('272', '0', '2020-12-19'),
  ('272', '1', '2020-12-26'),
  ('272', '3', '2021-01-17'),
  ('273', '0', '2020-02-14'),
  ('273', '1', '2020-02-21'),
  ('274', '0', '2020-03-01'),
  ('274', '1', '2020-03-08'),
  ('275', '0', '2020-04-27'),
  ('275', '1', '2020-05-04'),
  ('275', '4', '2020-09-09'),
  ('276', '0', '2020-12-25'),
  ('276', '2', '2021-01-01'),
  ('276', '3', '2021-03-01'),
  ('277', '0', '2020-08-06'),
  ('277', '1', '2020-08-13'),
  ('278', '0', '2020-08-01'),
  ('278', '2', '2020-08-08'),
  ('278', '3', '2020-11-08'),
  ('279', '0', '2020-03-31'),
  ('279', '3', '2020-04-07'),
  ('280', '0', '2020-06-17'),
  ('280', '1', '2020-06-24'),
  ('280', '2', '2020-10-28'),
  ('280', '4', '2021-02-23'),
  ('281', '0', '2020-01-01'),
  ('281', '1', '2020-01-08'),
  ('282', '0', '2020-06-21'),
  ('282', '2', '2020-06-28'),
  ('283', '0', '2020-06-11'),
  ('283', '1', '2020-06-18'),
  ('283', '2', '2020-09-11'),
  ('283', '3', '2020-12-11'),
  ('284', '0', '2020-07-27'),
  ('284', '2', '2020-08-03'),
  ('284', '4', '2020-11-18'),
  ('285', '0', '2020-07-06'),
  ('285', '4', '2020-07-13'),
  ('286', '0', '2020-03-23'),
  ('286', '2', '2020-03-30'),
  ('287', '0', '2020-08-23'),
  ('287', '1', '2020-08-30'),
  ('287', '3', '2020-12-09'),
  ('288', '0', '2020-11-28'),
  ('288', '1', '2020-12-05'),
  ('288', '4', '2020-12-06'),
  ('289', '0', '2020-01-08'),
  ('289', '2', '2020-01-15'),
  ('290', '0', '2020-01-10'),
  ('290', '1', '2020-01-17'),
  ('291', '0', '2020-03-03'),
  ('291', '1', '2020-03-10'),
  ('291', '3', '2020-08-16'),
  ('292', '0', '2020-08-14'),
  ('292', '1', '2020-08-21'),
  ('292', '3', '2020-10-18'),
  ('293', '0', '2020-10-30'),
  ('293', '1', '2020-11-06'),
  ('293', '2', '2021-03-15'),
  ('293', '4', '2021-03-18'),
  ('294', '0', '2020-01-19'),
  ('294', '4', '2020-01-26'),
  ('295', '0', '2020-06-01'),
  ('295', '1', '2020-06-08'),
  ('295', '2', '2020-08-17'),
  ('296', '0', '2020-10-17'),
  ('296', '4', '2020-10-24'),
  ('297', '0', '2020-08-13'),
  ('297', '2', '2020-08-20'),
  ('297', '3', '2020-12-20'),
  ('298', '0', '2020-10-26'),
  ('298', '1', '2020-11-02'),
  ('298', '2', '2020-12-13'),
  ('299', '0', '2020-09-13'),
  ('299', '1', '2020-09-20'),
  ('299', '2', '2020-10-28'),
  ('299', '3', '2021-01-28'),
  ('300', '0', '2020-04-06'),
  ('300', '1', '2020-04-13'),
  ('300', '3', '2020-10-04');

--b.1 How many customers has Foodie-Fi ever had?
SELECT COUNT(customer_id) AS [number of customers]
FROM subscriptions
--They have had 796 customers

--b.2 What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value
SELECT DATEPART(MONTH, start_date) AS months, COUNT(plan_id) AS [number of users]
FROM subscriptions
WHERE plan_id = '0'
GROUP BY DATEPART(MONTH, start_date)
--ORDER BY COUNT(plan_id) DESC
--August has the most trial's users with 33
--February has the least with 16 users
--Food-Fi had the biggest decrease in April with 82% decrease in the number of users
--However, after April, the number of users gradually increased and reached its peak in August with 33 users

--b.3 What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name
SELECT plans.plan_name, COUNT(subscriptions.plan_id) AS changes_after_2020
FROM subscriptions
JOIN plans
ON subscriptions.plan_id = plans.plan_id
WHERE DATEPART(YEAR, start_date) > '2020'
GROUP BY plans.plan_name
--After 2020, only 1 user chose basic monthly plan
--17 users chose pro monthly and pro annual 
--24 chose churn
--None chose free trials plan

--b.4 What is the customer count and percentage of customers who have churned rounded to 1 decimal place?
SELECT SUM(CASE WHEN plan_id = '4' THEN 1 ELSE 0 END) AS [churn customer count],
ROUND((1.0 * SUM(CASE WHEN plan_id = '4' THEN 1 ELSE 0 END)/COUNT(DISTINCT customer_id)) * 100,1) AS [churn percentage]
FROM subscriptions
--There is 87 customers chose churn, which is 29% of all the customers

--b.5 How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?
SELECT COUNT(A.customer_id) AS [churn customer count], 
ROUND((1.0 *COUNT(A.customer_id) /(SELECT COUNT(DISTINCT customer_id) FROM subscriptions)) * 100,0) AS [churn after trials percentage]
FROM
(SELECT customer_id, plan_id, start_date,LAG(start_date) OVER(PARTITION BY(customer_id) ORDER BY(customer_id)) AS previous_start_date
FROM subscriptions
WHERE plan_id = 0 OR plan_id = 4
)A
WHERE A.previous_start_date is NOT NULL AND DATEDIFF(DAY, A.previous_start_date, A.start_date) = '7'
--There were 22 customers chose churn after free trials plan, which accounts for 7% of all the customers

--b.6 What is the number and percentage of customer plans after their initial free trial?
SELECT B.next_plan, COUNT(B.next_plan) AS [next plan count], 
ROUND((1.0 * COUNT(B.next_plan)/(SELECT COUNT(DISTINCT customer_id) FROM subscriptions)) * 100,1) AS [plan percentage]
FROM
(SELECT subscriptions.customer_id, plans.plan_name,
LEAD(plans.plan_name) OVER(PARTITION BY(subscriptions.customer_id) ORDER BY(subscriptions.customer_id)) AS next_plan
FROM subscriptions
JOIN plans
ON subscriptions.plan_id = plans.plan_id
)B
WHERE B.next_plan is NOT NULL AND B.plan_name = 'trial'
GROUP BY B.next_plan
--159 users, 53%, chose basic monthly
--103 users, 34.3%, proceeded to pro monthly
--Only 16 users, 5.3%, proceeded to pro annual
--22 of them, 7.3% chose churn

--b.7 What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?
SELECT plans.plan_name, COUNT(C.plan_id) AS [customer count], ROUND((1.0 * COUNT(C.plan_id))/(SELECT COUNT(DISTINCT customer_id) FROM subscriptions) * 100,1) AS [percentage]
FROM
(SELECT *, LEAD(plan_id) OVER (PARTITION BY(customer_id) ORDER BY(customer_id)) AS [next plan]
FROM subscriptions
WHERE start_date <= '2020-12-31'
)C
JOIN plans
ON C.plan_id = plans.plan_id
WHERE C.[next plan] is NULL
GROUP BY plans.plan_name
--1.3%, 4 customers, chose to stay at trial
--21.7% chose basic monthly
--31.7% chose pro monthly
--24.3% chose pro annual
--21.0% chose churn

--b.8 How many customers have upgraded to an annual plan in 2020?
SELECT COUNT(D.customer_id) AS [annual plan customers in 2020]
FROM
(SELECT *, LEAD(plan_id) OVER(PARTITION BY (customer_id) ORDER BY customer_id) AS [next plan]
FROM subscriptions
WHERE DATEPART(YEAR,start_date) = '2020'
)D
WHERE D.[next plan] is NULL AND D.plan_id = 3
--There are 73 customers who have upgraded to annual plan in 2020

--b.9 How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?
--create temp table for all the customer first start date
SELECT customer_id, plan_id, start_date
INTO #trials_plan 
FROM subscriptions
WHERE plan_id = 0

--create temp table for the date the customers switch to pro annual
SELECT customer_id, plan_id, start_date
INTO #pro_annual_plan 
FROM subscriptions
WHERE plan_id = 3

SELECT AVG(DATEDIFF(DAY, #trials_plan.start_date, #pro_annual_plan.start_date)) AS [average day for pro annual switch]
FROM #trials_plan
JOIN #pro_annual_plan 
ON #trials_plan.customer_id = #pro_annual_plan.customer_id
---The average day for a customer to switch to pro annual is 96 days

--b.10 Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)
SELECT DATEDIFF(DAY, tp.start_date, an.start_date) AS [Date Diff]
INTO #date_diff
FROM #trials_plan AS tp
RIGHT JOIN #pro_annual_plan AS an ON tp.customer_id = an.customer_id 

SELECT *, FLOOR([Date Diff]/30) AS group_day
INTO #group_date
FROM #date_diff

SELECT *
FROM #group_date

SELECT COUNT(#group_date.group_day) AS [Date Diff Counts], CONCAT((group_day *30) +1,'-',(group_day +1) * 30, 'days') AS [Day Range]
FROM #group_date
GROUP BY group_day

--There were 22 days fell between the range 1-30 days
--10 for 31-60 days
--6 for 61-90 days
--16 for 91-120 days
--13 for 121-150 days
--11 for 151-180 days
--10 for 181-210 days
--1 for 241-270 days
--1 for 331-360 days

--b.11 How many customers downgraded from a pro monthly to a basic monthly plan in 2020?
SELECT COUNT(customer_id) AS [Downgrading customers]
FROM
(SELECT *, LEAD(plan_id) OVER(PARTITION BY customer_id ORDER BY customer_id) AS [next plan]
FROM subscriptions
WHERE DATEPART(YEAR, start_date) = '2020'
)F
WHERE plan_id = 2 AND [next plan] = 1
--There was no customers chose to downgrade