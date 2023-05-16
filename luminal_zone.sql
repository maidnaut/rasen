-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 16, 2023 at 06:07 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `luminal_zone`
--

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `slug` text NOT NULL,
  `postdate` text NOT NULL,
  `content` text NOT NULL,
  `files` text NOT NULL,
  `hidden` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `title`, `slug`, `postdate`, `content`, `files`, `hidden`) VALUES
(51, 'README', 'readme', '1684203352', 'The eye at the bottom of the page is the login, you can take out the link by editing /lib/tpl/globals/footer.tpl\r\n\r\nEverything is laid out in templates, so you can change those if you want to but you&#039;ll need to re-upload the files on change.\r\n\r\n[ + new post + ] in the admin panel scrolls out the form, and you can only upload 4 images at a time. If you want to do more, you can go to the upload tab in the admin panel to embed images to the post, but if you ONLY include images in a post that way, the post will show up in the blog instead of the images tab in the feed.\r\n\r\nPage editing directly edits template files, so technically I could make every template editable but that takes a lot of work to make a dynamic system for that, so I&#039;m just going to keep it to the Registry, License and Archive pages for now. Later when I work on lumizone again, I&#039;ll port those pages to the database so you can make new dynamic pages.\r\n\r\nHidden posts don&#039;t show up in the feed but you can link them directly.\r\n\r\nYou can use bbcode in posts, so far I just have b, i, u, center and img tags you do like (img)link(/img), you use square brackets for bbcode.\r\n\r\nuhhh idk if there&#039;s anything else i need to put here, it&#039;s a pretty simple blog system\r\n\r\nok byeeeeeee\r\n\r\n~jinni', '', '0');

-- --------------------------------------------------------

--
-- Table structure for table `registry`
--

CREATE TABLE `registry` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `link` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `registry`
--

INSERT INTO `registry` (`id`, `title`, `link`) VALUES
(1, 'itch.io', 'https://bilexth.itch.io/');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` text NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `avatar` text NOT NULL,
  `session` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `username`, `password`, `avatar`, `session`) VALUES
(1, 'xhct@protonmail.com', 'bilexth', '$2y$10$AQjDDW6.11Jh97j6GI.Y9u5wxJ1qj6mlY84gnvf598sLllzH/lQ7K', 'https://pbs.twimg.com/media/FtnNQKeXwAAnBVY?format=png&name=small', 'pdligro8dkdu37kp2rvdc0s3up');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `registry`
--
ALTER TABLE `registry`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `registry`
--
ALTER TABLE `registry`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
