-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 23/09/2024 às 23:08
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `ecommerce`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `spring_session`
--

CREATE TABLE `spring_session` (
  `PRIMARY_ID` char(36) NOT NULL,
  `SESSION_ID` char(36) NOT NULL,
  `CREATION_TIME` bigint(20) NOT NULL,
  `LAST_ACCESS_TIME` bigint(20) NOT NULL,
  `MAX_INACTIVE_INTERVAL` int(11) NOT NULL,
  `EXPIRY_TIME` bigint(20) NOT NULL,
  `PRINCIPAL_NAME` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estrutura para tabela `spring_session_attributes`
--

CREATE TABLE `spring_session_attributes` (
  `SESSION_PRIMARY_ID` char(36) NOT NULL,
  `ATTRIBUTE_NAME` varchar(200) NOT NULL,
  `ATTRIBUTE_BYTES` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_imagem_produto`
--

CREATE TABLE `tb_imagem_produto` (
  `id` bigint(20) NOT NULL,
  `diretorio` varchar(255) NOT NULL,
  `nome_imagem` varchar(255) NOT NULL,
  `principal` bit(1) NOT NULL,
  `produto_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tb_imagem_produto`
--

INSERT INTO `tb_imagem_produto` (`id`, `diretorio`, `nome_imagem`, `principal`, `produto_id`) VALUES
(1, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/66a136e7e4a2a7aa99b76768/screenshot/eekmxeow0bdslpjkmw6r.jpg', b'1', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_produto`
--

CREATE TABLE `tb_produto` (
  `id` bigint(20) NOT NULL,
  `ativo` bit(1) NOT NULL,
  `avaliacao` decimal(2,1) NOT NULL,
  `categoria` tinyint(4) NOT NULL,
  `descricao_detalhada` varchar(2000) NOT NULL,
  `distribuidor` varchar(255) NOT NULL,
  `img_url` varchar(255) NOT NULL,
  `nome` varchar(200) NOT NULL,
  `parcelas` tinyint(4) NOT NULL,
  `preco` decimal(12,2) NOT NULL,
  `preco_com_desconto` decimal(38,2) DEFAULT NULL,
  `quantidade_em_estoque` int(11) NOT NULL,
  `tem_desconto` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tb_produto`
--

INSERT INTO `tb_produto` (`id`, `ativo`, `avaliacao`, `categoria`, `descricao_detalhada`, `distribuidor`, `img_url`, `nome`, `parcelas`, `preco`, `preco_com_desconto`, `quantidade_em_estoque`, `tem_desconto`) VALUES
(1, b'1', 4.5, 1, 'Descrição detalhada do produto', 'Warner Bros. Games', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/61437f66a3f8b1386fb570e3/banners/dzgtvpre3btb2l6i9ife.jpg', 'Batman Arkham Collection', 3, 279.99, 27.99, 100, b'1'),
(2, b'1', 4.5, 2, 'Descrição detalhada do produto', 'Warner Bros. Games', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/5c5093428810242173c0bb5c/banners/d2m04tkhgphzxvcskrwk.jpg', 'Mortal Kombat 11', 3, 229.99, 20.69, 100, b'1'),
(3, b'1', 4.5, 1, 'Descrição detalhada do produto', 'Warner Bros. Games', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/60087598a3f8b147910a6750/banners/dmsyjen4zc3whgheq6x4.jpg', 'Back 4 Blood', 3, 279.99, 25.19, 100, b'1'),
(4, b'1', 4.5, 1, 'Descrição detalhada do produto', 'Warner Bros. Games', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/6307dd93ba5b7c0014a7502e/banners/jacjyy6j14rfyik2bbix.jpg', 'Hogwarts Legacy', 3, 299.99, 104.99, 100, b'1'),
(5, b'1', 4.5, 4, 'Descrição detalhada do produto', 'Devolver', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/60c0dc92c883e604a3e41e46/banners/bqbr8crvhjboz2nemg3t.jpg', 'Sludge Life', 3, 46.99, 11.74, 100, b'1'),
(7, b'1', 4.5, 1, 'Descrição detalhada do produto', 'Devolver', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/6482375064ffa20014ecc6e6/banners/pefeo93dojenhpskf5d7.jpg', 'SLUDGE LIFE 2', 3, 46.99, 28.19, 100, b'1'),
(8, b'1', 4.5, 1, 'Descrição detalhada do produto', 'Devolver', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/557dbcb269702d0a9c330801/banners/qewcrzqhtdyakesepvbm.jpg', 'Titan Souls', 3, 46.99, 4.69, 100, b'1'),
(9, b'1', 4.5, 0, 'Descrição detalhada do produto', 'Devolver', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/5cab8313881024573902bae5/banners/wiuakjsvl3d7bc3v4gg7.jpg', 'My Friend Pedro', 3, 59.99, 14.99, 100, b'1'),
(10, b'1', 4.5, 0, 'Descrição detalhada do produto', 'Ubisoft', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/6000b86cc883e61e8835cf7f/banners/hbkribsf2ruddgiiglsa.jpg', 'Scott Pilgrim vs. The World: The Game', 3, 59.99, 19.79, 100, b'1'),
(11, b'1', 4.5, 0, 'Descrição detalhada do produto', 'Ubisoft', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/5c0fed352a1c6e02c3c0c98a/banners/cfci3cqtlyu0znye7gfy.jpg', 'UNO', 3, 29.99, 11.99, 100, b'1'),
(12, b'1', 4.5, 0, 'Descrição detalhada do produto', 'Ubisoft', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/60622a4cc883e67df526538a/banners/pllgiho4qa0euf6vefem.jpg', 'The Division 2', 3, 199.99, 59.99, 100, b'1'),
(13, b'1', 4.5, 0, 'Descrição detalhada do produto', 'Ubisoft', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/558b19ba69702d0b6f000000/banners/hs8t3wnauzmoa9suxvaf.jpg', 'Anno 2205', 3, 119.99, 29.99, 100, b'1');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_usuario`
--

CREATE TABLE `tb_usuario` (
  `id` bigint(20) NOT NULL,
  `ativo` bit(1) NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `grupo` enum('ADMINISTRADOR','ESTOQUISTA') NOT NULL,
  `nome` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tb_usuario`
--

INSERT INTO `tb_usuario` (`id`, `ativo`, `cpf`, `email`, `grupo`, `nome`, `senha`) VALUES
(3, b'1', '12345678901', 'ecthor@email.com', 'ADMINISTRADOR', 'Ecthor Nunes', '$2a$10$7fn10cnOJl/SfeugATONKeB8OmARPmBcmNWDujm0tAR1F3BUEIsbG'),
(4, b'1', '00630628017', 'guilherme@email.com', 'ESTOQUISTA', 'Guilherme Soares', '$2a$10$lx2r5tvciS./csMItPVYKupY/fAzEKqMlisUf9qbjqTmCaDg95/ve'),
(12, b'1', '77037087041', 'vitor@email.com', 'ESTOQUISTA', 'Vitor Maia', '$2a$10$GCTCtj1jAnCRlfua5u7aYevv0GXCdVItK9ISCqDmwEBTz/CVvuhhC'),
(15, b'1', '85259549007', 'cristian@email.com', 'ESTOQUISTA', 'cristian', '$2a$10$Gf1fe4Rta0cMEAngkoLMFud9bRnoCOiuuBIonaIZ04OaqHqznKzHy'),
(16, b'1', '01047218046', 'teste@teste.com', 'ESTOQUISTA', 'teste', '$2a$10$ksy3nPScB/76cpMKk3d6Guxvt8BclgPs6EIBxp9xfox/yJGcfmPXi'),
(18, b'0', '30554689022', '123@email.com', 'ADMINISTRADOR', 'teste', '$2a$10$VAm.ZYtQBKsrrs5PmE7.IelBdsZxjO.WWO5.CCL1e9UDjv5u3rZYK');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `spring_session`
--
ALTER TABLE `spring_session`
  ADD PRIMARY KEY (`PRIMARY_ID`),
  ADD UNIQUE KEY `SPRING_SESSION_IX1` (`SESSION_ID`),
  ADD KEY `SPRING_SESSION_IX2` (`EXPIRY_TIME`),
  ADD KEY `SPRING_SESSION_IX3` (`PRINCIPAL_NAME`);

--
-- Índices de tabela `spring_session_attributes`
--
ALTER TABLE `spring_session_attributes`
  ADD PRIMARY KEY (`SESSION_PRIMARY_ID`,`ATTRIBUTE_NAME`);

--
-- Índices de tabela `tb_imagem_produto`
--
ALTER TABLE `tb_imagem_produto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK2tknjwh9hx3phphf8qi80o6f7` (`produto_id`);

--
-- Índices de tabela `tb_produto`
--
ALTER TABLE `tb_produto`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `tb_usuario`
--
ALTER TABLE `tb_usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UKspmnyb4dsul95fjmr5kmdmvub` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `tb_imagem_produto`
--
ALTER TABLE `tb_imagem_produto`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `tb_produto`
--
ALTER TABLE `tb_produto`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `tb_usuario`
--
ALTER TABLE `tb_usuario`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `spring_session_attributes`
--
ALTER TABLE `spring_session_attributes`
  ADD CONSTRAINT `SPRING_SESSION_ATTRIBUTES_FK` FOREIGN KEY (`SESSION_PRIMARY_ID`) REFERENCES `spring_session` (`PRIMARY_ID`) ON DELETE CASCADE;

--
-- Restrições para tabelas `tb_imagem_produto`
--
ALTER TABLE `tb_imagem_produto`
  ADD CONSTRAINT `FK2tknjwh9hx3phphf8qi80o6f7` FOREIGN KEY (`produto_id`) REFERENCES `tb_produto` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
