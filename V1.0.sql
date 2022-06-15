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
  `createTime` timestamp NOT NULL DEFAULT NOW(),
  `updateTime` timestamp NOT NULL DEFAULT NOW(),
  PRIMARY KEY (`taskId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='拨测任务定义表';




