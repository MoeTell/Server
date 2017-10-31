-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: 2017-10-31 06:28:14
-- 服务器版本： 5.7.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `moetell`
--

-- --------------------------------------------------------

--
-- 表的结构 `archive`
--

CREATE TABLE `archive` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sid` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `source_id` varchar(50) CHARACTER SET utf8mb4 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `comment`
--

CREATE TABLE `comment` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` bigint(20) UNSIGNED NOT NULL,
  `aid` bigint(20) UNSIGNED NOT NULL,
  `sid` bigint(20) UNSIGNED NOT NULL,
  `content` longtext NOT NULL,
  `time` datetime NOT NULL,
  `extra` longblob NOT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL,
  `parent` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `oauth`
--

CREATE TABLE `oauth` (
  `uid` bigint(20) UNSIGNED NOT NULL,
  `type` tinyint(3) UNSIGNED NOT NULL,
  `openid` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `site`
--

CREATE TABLE `site` (
  `id` int(10) UNSIGNED NOT NULL,
  `domain` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `time` datetime NOT NULL,
  `secret` char(24) NOT NULL,
  `uid` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

CREATE TABLE `user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `nickname` varchar(20) NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL,
  `homepage` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `time_register` datetime NOT NULL,
  `time_last_login` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `archive`
--
ALTER TABLE `archive`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sid` (`sid`,`source_id`);

--
-- Indexes for table `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `parent` (`parent`),
  ADD KEY `aid` (`aid`),
  ADD KEY `sid` (`sid`);

--
-- Indexes for table `oauth`
--
ALTER TABLE `oauth`
  ADD KEY `uid` (`uid`),
  ADD KEY `openid` (`openid`,`type`);

--
-- Indexes for table `site`
--
ALTER TABLE `site`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `archive`
--
ALTER TABLE `archive`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `comment`
--
ALTER TABLE `comment`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `site`
--
ALTER TABLE `site`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `user`
--
ALTER TABLE `user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
