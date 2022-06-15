DROP DATABASE IF EXISTS autodig;

CREATE DATABASE autodig DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_unicode_ci;

grant all on autodig.* to 'autodig'@'%' identified by 'Abc123';

flush privileges;

/*
Navicat MySQL Data Transfer

Source Server         : local-autodig
Source Server Version : 50723
Source Host           : 192.168.56.101:3306
Source Database       : autodig

Target Server Type    : MYSQL
Target Server Version : 50723
File Encoding         : 65001

Date: 2022-06-06 14:22:11
*/

USE autodig;

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task` (
  `taskId` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '任务id, 唯一',
  `messageSN` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '消息流水号, 唯一且自增',
  `domain` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT '域名',
  `monitorType` int(11) NOT NULL COMMENT '拨测类型\r\n1 - A记录\r\n2 - AAAA记录\r\n3 - CNAME\r\n4 - NS\r\n5 - MX\r\n6 - TXT',
  `taskCycleType` int(11) NOT NULL COMMENT '周期类型 1 周期任务 2 一次性任务',
  `monitorLevel` int(11) DEFAULT NULL COMMENT '监控级别 1 高级版周期10分钟 2 基础版周期30分钟 NULL 一次性',
  `closeMark` int(11) NOT NULL DEFAULT '0' COMMENT '是否已关闭 0/1',
  `monitorStartTime` timestamp NULL DEFAULT NULL COMMENT '周期任务监控开始时间 一次性和无限周期任务为NULL',
  `monitorEndTime` timestamp NULL DEFAULT NULL COMMENT '周期任务监控结束时间 一次性和无限周期任务为NULL',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`taskId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='拨测任务定义表';

-- ----------------------------
-- Table structure for task_inst
-- ----------------------------
DROP TABLE IF EXISTS `task_inst`;
CREATE TABLE `task_inst` (
  `instId` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'uuid',
  `taskId` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `domain` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `monitorType` int(11) NOT NULL,
  `nodeName` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `nodeIp` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(3000) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '域名解析出的IP, 如果拨测出错此字段为NULL',
  `digStdOutput` varchar(3000) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'dig命令标准输出',
  `digErrOutput` varchar(3000) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'dig命令错误输出',
  `loggerStdOutput` varchar(3000) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'logger命令标准输出',
  `loggerErrOutput` varchar(3000) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'logger命令错误输出',
  `errMsg` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '异常消息',
  `recordTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '拨测时间',
  PRIMARY KEY (`instId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='任务运行实例表';
