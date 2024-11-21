-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 21/11/2024 às 22:37
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
-- Estrutura para tabela `tb_cliente`
--

CREATE TABLE `tb_cliente` (
  `id` bigint(20) NOT NULL,
  `ativo` bit(1) NOT NULL,
  `cpf` varchar(255) NOT NULL,
  `data_nascimento` date NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_secundario` varchar(255) NOT NULL,
  `genero` varchar(255) NOT NULL,
  `grupo` enum('ADMINISTRADOR','CLIENTE','ESTOQUISTA') DEFAULT NULL,
  `nome_completo` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tb_cliente`
--

INSERT INTO `tb_cliente` (`id`, `ativo`, `cpf`, `data_nascimento`, `email`, `email_secundario`, `genero`, `grupo`, `nome_completo`, `senha`) VALUES
(1, b'1', '987.654.321-00', '1997-09-12', 'ecthor.silva@email.com', 'ecthor.nunes@email.com', 'Masculino', 'CLIENTE', 'Ecthor Silva', '$2a$10$IgclrWUKWPhMa7srje01QuTnMjgscHO3oqqpYVL/Srd.43WLmy5xu'),
(4, b'1', '987.654.321-00', '1999-09-26', 'ecthor.nunes@email.com', 'ecthor@email.com', 'Masculino', 'CLIENTE', 'Ecthor Silva', '$2a$10$OY3km8hMy5yXHb3jhN47HeyK.nEONtenEdKgFYxbEbxQW1A9bN40e'),
(5, b'1', '110.989.670-03', '2000-10-10', 'guilherme.soares@email.com', 'guilherme@email.com', 'Masculino', 'CLIENTE', 'Guilherme Soares', '$2a$10$mHrgGCcAhcrLuiUHuX6he.JooHCCG5GMIA5aQVg09CdjarQHcqY6.'),
(6, b'1', '074.886.820-84', '2001-02-02', 'christian.freitas@email.com', 'christian@email.com', 'Masculino', 'CLIENTE', 'Christian Freitas', '$2a$10$KazU5IjQ9tiBj8KzM/VOdO.rx4ZyMfuY1fKcat.H89wJkSl8Hy9uG'),
(7, b'1', '438.356.350-34', '1222-10-10', 'vitor.maia@email.com', 'vitor.maia2@email.com', 'Masculino', 'CLIENTE', 'Vitor Maia ', '$2a$10$GDdWEREHR.1Lakhuw7yetuoD8xrv9CR0/DesheZuCpniIlnkMutAW'),
(8, b'1', '473.521.238-81', '2004-07-07', 'fellipe.nobre@gmail.com', 'fellipe.nobre1@gmail.com', 'Masculino', 'CLIENTE', 'Fellipe Nobre Bizarria', '$2a$10$R2xpgvSTqKpFI9IWEQymUOHk9tjU6ZKswZy0VDO8YlbPUmkOmPwV2');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_imagem_produto`
--

CREATE TABLE `tb_imagem_produto` (
  `id` bigint(20) NOT NULL,
  `diretorio` varchar(255) NOT NULL,
  `nome_imagem` varchar(255) NOT NULL,
  `principal` bit(1) NOT NULL,
  `produto_id` bigint(20) DEFAULT NULL,
  `imagem_base64` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tb_imagem_produto`
--

INSERT INTO `tb_imagem_produto` (`id`, `diretorio`, `nome_imagem`, `principal`, `produto_id`, `imagem_base64`) VALUES
(1, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dba4769702d0a9c4e1100/screenshots/l0aerhu9widfsmt1rbrr.jpg', b'0', 1, NULL),
(2, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dba4769702d0a9c4e1100/screenshots/bqzbfxxsbkd4eljyw0h6.jpg', b'0', 1, NULL),
(3, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dba4769702d0a9c4e1100/screenshots/d0wfeldnoj0g0to9wvt3.jpg', b'0', 1, NULL),
(4, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/575aff17d277343eff0001e9/screenshots/jxpiqejawsjejtfgvzhy.jpg', b'0', 2, NULL),
(5, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/575aff17d277343eff0001e9/screenshots/czo3bnid8yqdp8j9zwal.jpg', b'0', 2, NULL),
(6, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/575aff17d277343eff0001e9/screenshots/xnox8vgqddtbb3ltfjaw.jpg', b'0', 2, NULL),
(7, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dba3269702d0a9c8e0700/screenshots/xlqgoavolhomm4gnizta.jpg', b'0', 3, NULL),
(8, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dba3269702d0a9c8e0700/screenshots/thwga4vknyghoznuvccy.jpg', b'0', 3, NULL),
(9, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dba3269702d0a9c8e0700/screenshots/cxetr5c8yiztf2bszl0f.jpg', b'0', 3, NULL),
(10, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5c0feb8a88102447edfd94fe/screenshots/fdy8jenh1reiq7688md4.jpg', b'0', 4, NULL),
(11, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5c0feb8a88102447edfd94fe/screenshots/bm0v3mzlup8nrbmnonqg.jpg', b'0', 4, NULL),
(12, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5c0feb8a88102447edfd94fe/screenshots/wkgnhoqhc3k8qnsdcudl.jpg', b'0', 4, NULL),
(13, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dbc1e69702d0a9c62d400/screenshots/talxz2xzpc0phiim088v.jpg', b'0', 5, NULL),
(14, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dbc1e69702d0a9c62d400/screenshots/l22zmchxtlhmg6h4kmaf.jpg', b'0', 5, NULL),
(15, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dbc1e69702d0a9c62d400/screenshots/xrdonsznbhl784axpqil.jpg', b'0', 5, NULL),
(16, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dbaf169702d0a9cb55f00/screenshots/lspt1ushlxawg506d04f.jpg', b'0', 6, NULL),
(17, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dbaf169702d0a9cb55f00/screenshots/vpa8prhqj0ueqevixwzl.jpg', b'0', 6, NULL),
(18, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dbaf169702d0a9cb55f00/screenshots/gxekdsnmobh1xxhspwj6.jpg', b'0', 6, NULL),
(19, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5c5093428810242173c0bb5c/screenshots/eq7suv6wjzlgu81odiob.jpg', b'0', 7, NULL),
(20, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5c5093428810242173c0bb5c/screenshots/kesqotwkspjhulehclqc.jpg', b'0', 7, NULL),
(21, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5c5093428810242173c0bb5c/screenshots/uvwltzjkmjvrb9digzjn.jpg', b'0', 7, NULL),
(22, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/60087598a3f8b147910a6750/screenshots/khi867gnrpbyhjh41xmn.jpg', b'0', 8, NULL),
(23, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/60087598a3f8b147910a6750/screenshots/qkbnzexjvccdp8lvpfok.jpg', b'0', 8, NULL),
(24, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/60087598a3f8b147910a6750/screenshots/r6uawqxqtaxbh49hf9px.jpg', b'0', 8, NULL),
(25, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/62c7039e4e421d00161d73e6/screenshots/knuzzrcby77cevubdtm6.jpg', b'0', 9, NULL),
(26, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/62c7039e4e421d00161d73e6/screenshots/n5tlcvbk1dukzlljlln2.jpg', b'0', 9, NULL),
(27, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/62c7039e4e421d00161d73e6/screenshots/hlvck5nojou1hovvnbis.jpg', b'0', 9, NULL),
(28, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/60fad187a3f8b14a5deb775b/screenshots/wscv3vrchsopys4mxfpz.jpg', b'0', 10, NULL),
(29, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/60fad187a3f8b14a5deb775b/screenshots/y9ba3zqmn34dqgu2druw.jpg', b'0', 10, NULL),
(30, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/60fad187a3f8b14a5deb775b/screenshots/jqf2yomz9swp8vzozl9r.jpg', b'0', 10, NULL),
(31, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/56d9b255d277346f9f000029/screenshots/gqhir9cgbcbxic9zusdl.jpg', b'0', 11, NULL),
(32, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/56d9b255d277346f9f000029/screenshots/c0otak4cvv12w4ss3ulw.jpg', b'0', 11, NULL),
(33, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/56d9b255d277346f9f000029/screenshots/kmr82pgbk3udir5sduim.jpg', b'0', 11, NULL),
(34, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/60c0dc92c883e604a3e41e46/screenshots/z1og1wcggd7y3xwh10qb.jpg', b'0', 12, NULL),
(35, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/60c0dc92c883e604a3e41e46/screenshots/r0wzgpboxfihtgx1rpfl.jpg', b'0', 12, NULL),
(36, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/60c0dc92c883e604a3e41e46/screenshots/pf5t1wwzijj3lobucrvj.jpg', b'0', 12, NULL),
(37, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/618418052f91a002e3f9cf6b/screenshots/sulcmvodnhfwgc6i8evb.jpg', b'0', 13, NULL),
(38, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/618418052f91a002e3f9cf6b/screenshots/dkwnd7zhavqbssv9ic6h.jpg', b'0', 13, NULL),
(39, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/618418052f91a002e3f9cf6b/screenshots/crk3pwg0d5gsifh5nazt.jpg', b'0', 13, NULL),
(40, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5b0467082a1c6e250aceff3f/screenshots/k504smcadqc1sswiln3o.jpg', b'0', 14, NULL),
(41, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5b0467082a1c6e250aceff3f/screenshots/lohsw1grqo7puxdsh74v.jpg', b'0', 14, NULL),
(42, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5b0467082a1c6e250aceff3f/screenshots/wblahf6kaneifhuxea27.jpg', b'0', 14, NULL),
(43, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/570bab1cf3728033c70005b7/screenshots/an47ohqoftp5shgo3ykw.jpg', b'0', 15, NULL),
(44, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/570bab1cf3728033c70005b7/screenshots/oviczlkymrpp9iit4cue.jpg', b'0', 15, NULL),
(45, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/570bab1cf3728033c70005b7/screenshots/ihzew4brkj5jrxdolnwu.jpg', b'0', 15, NULL),
(46, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5703b71ed277345658000059/screenshots/evoj6uxsj8doaoqnyv20.jpg', b'0', 16, NULL),
(47, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5703b71ed277345658000059/screenshots/qbygpigwcj2jhuipdkmj.jpg', b'0', 16, NULL),
(48, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5703b71ed277345658000059/screenshots/radgj9wgujbqd9owa1p5.jpg', b'0', 16, NULL),
(49, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/62449221b193230016108781/screenshots/ho676o03v69w1ml6bwfz.jpg', b'0', 17, NULL),
(50, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/62449221b193230016108781/screenshots/lhokrodd2lek12k1ckc3.jpg', b'0', 17, NULL),
(51, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/62449221b193230016108781/screenshots/n3nxabzcbulzlnaxdfzi.jpg', b'0', 17, NULL),
(52, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/62449221b193230016108781/screenshots/mdyibb8gohxpytvsczft.jpg', b'0', 17, NULL),
(53, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/66a136e7e4a2a7aa99b76768/screenshot/fy0rdtrl7md1sof726ah.jpg', b'0', 18, NULL),
(54, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/66a136e7e4a2a7aa99b76768/screenshot/lshona5mse7qc7opbinz.jpg', b'0', 18, NULL),
(55, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/66a136e7e4a2a7aa99b76768/screenshot/eekmxeow0bdslpjkmw6r.jpg', b'0', 18, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_item_pedido`
--

CREATE TABLE `tb_item_pedido` (
  `id` bigint(20) NOT NULL,
  `nome_produto` varchar(255) NOT NULL,
  `produto_id` bigint(20) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `valor_unitario` decimal(38,2) NOT NULL,
  `pedido_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tb_item_pedido`
--

INSERT INTO `tb_item_pedido` (`id`, `nome_produto`, `produto_id`, `quantidade`, `valor_unitario`, `pedido_id`) VALUES
(1, 'LEGO The Hobbit', 5, 1, 4.49, 1),
(2, 'LEGO Batman', 6, 2, 4.49, 1),
(3, 'Cult of the Lamb', 9, 1, 64.95, 2),
(4, 'Back 4 Blood', 8, 1, 25.19, 3),
(5, 'Death\'s Door', 10, 1, 59.99, 3),
(6, 'Dark Souls Remastered', 14, 1, 69.70, 4),
(7, 'Watch_Dogs 2', 2, 1, 22.49, 4),
(8, 'Back 4 Blood', 8, 2, 25.19, 5),
(9, 'LEGO The Hobbit', 5, 1, 4.49, 5),
(10, 'DARK SOULS III', 16, 1, 103.45, 5),
(11, 'LEGO The Hobbit', 5, 1, 4.49, 6),
(12, 'LEGO Batman', 6, 2, 4.49, 6),
(13, 'LEGO The Hobbit', 5, 1, 4.49, 7),
(14, 'LEGO Batman', 6, 1, 4.49, 7),
(15, 'LEGO The Hobbit', 5, 1, 4.49, 8),
(16, 'LEGO The Hobbit', 5, 1, 4.49, 9),
(17, 'LEGO Batman', 6, 1, 4.49, 9),
(18, 'Cult of the Lamb', 9, 1, 64.95, 10),
(19, 'LEGO Batman', 6, 1, 4.49, 10),
(20, 'LEGO The Hobbit', 5, 1, 4.49, 11),
(21, 'Watch_Dogs 2', 2, 2, 22.49, 12),
(22, 'Prince of Persia: The Two Thrones', 3, 1, 5.99, 12),
(23, 'LEGO The Hobbit', 5, 1, 4.49, 13),
(24, 'LEGO Batman', 6, 2, 4.49, 13),
(25, 'Far Cry 3', 1, 1, 19.99, 14);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_pedido`
--

CREATE TABLE `tb_pedido` (
  `id` bigint(20) NOT NULL,
  `cliente_id` bigint(20) NOT NULL,
  `data_pedido` datetime(6) NOT NULL,
  `forma_pagamento` enum('BOLETO','CARTAO_CREDITO','PIX') DEFAULT NULL,
  `status` enum('AGUARDANDO_PAGAMENTO','CANCELADO','ENTREGUE','ENVIADO','PAGO') DEFAULT NULL,
  `valor_total` decimal(38,2) NOT NULL,
  `email_entrega` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tb_pedido`
--

INSERT INTO `tb_pedido` (`id`, `cliente_id`, `data_pedido`, `forma_pagamento`, `status`, `valor_total`, `email_entrega`) VALUES
(1, 4, '2024-11-02 17:08:34.000000', 'CARTAO_CREDITO', 'PAGO', 13.47, ''),
(2, 4, '2024-11-05 14:43:22.000000', 'BOLETO', 'AGUARDANDO_PAGAMENTO', 45.46, ''),
(3, 4, '2024-11-07 16:47:17.000000', 'BOLETO', 'AGUARDANDO_PAGAMENTO', 59.63, ''),
(4, 1, '2024-11-07 17:33:30.000000', 'BOLETO', 'AGUARDANDO_PAGAMENTO', 64.53, ''),
(5, 1, '2024-11-07 17:36:55.000000', 'BOLETO', 'AGUARDANDO_PAGAMENTO', 110.82, ''),
(6, 5, '2024-11-07 17:58:14.000000', 'CARTAO_CREDITO', 'AGUARDANDO_PAGAMENTO', 13.47, ''),
(7, 5, '2024-11-07 18:10:17.000000', 'BOLETO', 'AGUARDANDO_PAGAMENTO', 6.29, ''),
(8, 5, '2024-11-07 18:12:09.000000', 'BOLETO', 'AGUARDANDO_PAGAMENTO', 3.14, ''),
(9, 5, '2024-11-07 18:20:16.000000', 'BOLETO', 'AGUARDANDO_PAGAMENTO', 6.29, ''),
(10, 1, '2024-11-08 21:04:00.000000', 'BOLETO', 'AGUARDANDO_PAGAMENTO', 48.61, ''),
(11, 8, '2024-11-18 19:49:48.000000', 'BOLETO', 'AGUARDANDO_PAGAMENTO', 3.14, ''),
(12, 8, '2024-11-18 21:34:06.000000', 'BOLETO', 'AGUARDANDO_PAGAMENTO', 35.68, ''),
(13, 1, '2024-11-21 10:25:54.000000', 'CARTAO_CREDITO', 'AGUARDANDO_PAGAMENTO', 13.47, 'cliente@example.com'),
(14, 1, '2024-11-21 10:40:41.000000', 'BOLETO', 'AGUARDANDO_PAGAMENTO', 13.99, 'ecthor.silva@email.com');

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
  `tem_desconto` bit(1) NOT NULL,
  `imagem_base64` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tb_produto`
--

INSERT INTO `tb_produto` (`id`, `ativo`, `avaliacao`, `categoria`, `descricao_detalhada`, `distribuidor`, `img_url`, `nome`, `parcelas`, `preco`, `preco_com_desconto`, `quantidade_em_estoque`, `tem_desconto`, `imagem_base64`) VALUES
(1, b'1', 5.0, 1, 'Far Cry 3 leva os jogadores à pele de Jason Brody, um homem sozinho nos confins do mundo, preso em uma misteriosa ilha tropical isolada da civilização. Neste paraíso selvagem onde ilegalidade e violência são a única certeza, os jogadores vão determinar quando, onde e como os eventos do jogo se desenrolam. Jogadores vão cortar em pedaços, deslocar, detonar e atirar em seus caminhos pela ilha num mundo que perdeu todo o senso do certo e do errado.', 'Ubisoft', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/557dba4769702d0a9c4e1100/banners/nmsyv3r0zp66seeg5g69.jpg', 'Far Cry 3', 3, 59.99, 19.99, 10, b'1', NULL),
(2, b'1', 3.0, 1, 'Bem-vindo a São Francisco! Seu objetivo: a maior operação hacker da história. Jogue como Marcus Holloway, um hacker genial no berço da revolução tecnológica, a área da baía de São Francisco. Junte-se ao Dedsec, um grupo notório de hackers, para executar o maior hack da história; derrube o ctOS 2.0, um sistema operacional invasivo que está sendo usado por um gênio do crime para monitorar e manipular os cidadãos em uma escala massiva.', 'Ubisoft', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/575aff17d277343eff0001e9/banners/pwkjxknabmiwxpjknrws.jpg', 'Watch_Dogs 2', 3, 149.99, 22.49, 10, b'1', NULL),
(3, b'1', 3.5, 1, 'O Príncipe da Pérsia, um experiente guerreiro, retorna da Ilha do Tempo para a Babilônia com seu amor, Kaileena. Mas, em vez da paz que ele anseia, ele encontra sua pátria devastada pela guerra e o reino se volta contra ele. O Príncipe é rapidamente capturado e Kaileena não tem outra escolha a não ser sacrificar-se e libertar as Areias do Tempo, a fim de salvá-lo. Agora expulso nas ruas e caçado como um fugitivo, o Príncipe logo descobre que batalhas do passado deram origem a um mortal Príncipe Negro, cujo espírito gradualmente o possui..', 'Ubisoft', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/557dba3269702d0a9c8e0700/banners/bofbgewhdruwfrjnlx67.jpg', 'Prince of Persia: The Two Thrones', 3, 29.99, 5.99, 10, b'1', NULL),
(4, b'1', 1.5, 1, 'O UNO que você conhece e ama - e muito mais! É uma corrida para terminar conforme você tenta esvaziar sua mão antes de todo mundo. Jogue com amigos e familiares do jeito que quiser com uma gama de regras da casa e, pela primeira vez, temas com visual atualizado e novas cartas temáticas que introduzem efeitos e poderes loucos ao jogo.', 'Ubisoft', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/5c0fed352a1c6e02c3c0c98a/banners/cfci3cqtlyu0znye7gfy.jpg', 'UNO', 3, 29.99, 0.00, 10, b'0', NULL),
(5, b'1', 5.0, 1, 'Recupere o Reino Perdido peça por peça! Junte-se a Bilbo Bolseiro, Gandalf, Thorin e sua companhia de anões em uma aventura épica através da Terra Média para recapturar a Montanha Solitária no jogo da LEGO mais expansivo até hoje.', 'Warner Bros. Games', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/557dbc1e69702d0a9c62d400/banners/jtqzsafetae2lo5vhysp.jpg', 'LEGO The Hobbit', 3, 89.99, 4.49, 10, b'1', NULL),
(6, b'1', 5.0, 1, 'Quando todos os vilões do Arkham Asylum se unem e fogem, somente a dupla dinâmica será capaz de impedi-los e salvar Gotham City. A diversão de LEGO e a história de Batman, essa combinação incomparável faz de LEGO Batman: The Videogame uma aventura cômica e empolgante. Jogue como Batman e seu parceiro Robin enquanto você constrói, dirige, balança e luta em Gotham City capturando vilões incluindo Coringa, Pinguim, Espantalho, entre outros. Então, entre no outro lado da história e jogue como os inimigos do Batman! Aproveite o poder que você possui e confronte Batman enquanto espalha o caos pela cidade. Não existe descanso para quem é bom (ou mal!)', 'Warner Bros. Games', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/557dbaf169702d0a9cb55f00/banners/pcqddpt6bo50hlebrxol.jpg', 'LEGO Batman', 3, 89.99, 4.49, 10, b'1', NULL),
(7, b'1', 2.6, 0, 'Mortal Kombat está de volta, melhor do que nunca, em uma evolução da icônica franquia! Todas as variações de customização de personagens lhe dão liberdade total para personalizar os lutadores e torná-los únicos! MK 11 faz você mergulhar em crânios rachados e uma grande quantidade de partes do corpo do seu oponente voando; com lutadores clássicos, novos e antigos, a incrível cinemática do modo história de Mortal Kombat continua a contar a saga épica de 25 anos atrás.', 'Warner Bros. Games', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/5c5093428810242173c0bb5c/banners/d2m04tkhgphzxvcskrwk.jpg', 'Mortal Kombat 11', 3, 229.99, 20.69, 10, b'1', NULL),
(8, b'1', 3.6, 0, 'Back 4 Blood é um jogo de tiro em primeira pessoa dos criadores da franquia aclamada pela crítica Left 4 Dead. Você está no centro de uma guerra contra os contagiados. Esses humanos portadores de um parasita mortal se transformaram em criaturas assustadoras inclinadas a devorar os restos da civilização. Com a extinção da humanidade em jogo, cabe a você e seus amigos enfrentar esse inimigo, erradicar os corrompidos e reconquistar o mundo.', 'Warner Bros. Games', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/60087598a3f8b147910a6750/banners/dmsyjen4zc3whgheq6x4.jpg', 'Back 4 Blood', 3, 279.99, 25.19, 10, b'1', NULL),
(9, b'1', 5.0, 1, 'Cult of the Lamb coloca o jogador no papel de um cordeiro possuído, que é salvo da aniquilação por um estranho sinistro e precisa quitar sua dívida recrutando seguidores leais em nome dele. Crie seu próprio culto em uma terra de falsos profetas, aventurando-se por regiões misteriosas e diversas para criar uma comunidade fiel de adoradores da floresta e para propagar sua Palavra e se tornar o único culto verdadeiro.', 'Devolver', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/62c7039e4e421d00161d73e6/banners/qfvemajsxksnqg8qn6vd.jpg', 'Cult of the Lamb', 3, 64.95, 0.00, 10, b'0', NULL),
(10, b'1', 5.0, 4, 'Ceifar a alma dos mortos e bater o cartão pode ser uma rotina monótona, mas é o trabalho honesto de um Corvo em Death\'s Door. Mas isso está prestes a mudar, quando sua alma designada é roubada, e você deve perseguir um ladrão desesperado até um reino intocado pela morte, onde criaturas vivem muito além do que deveriam e acumulam ganância e poder.', 'Devolver', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/60fad187a3f8b14a5deb775b/banners/xemvrayuvukttztjdlwn.jpg', 'Death\'s Door', 3, 59.99, 0.00, 10, b'0', NULL),
(11, b'1', 4.0, 3, 'O grande tesouro supremo do lendário Gundeon foi descoberto: Uma arma que pode matar o passado. Hora que pegar o equipamento pesado e reunir a equipe mais desajustada do mundo para poder atirar, pilhar, se esquivar e chutar todas as portas que estiverem no caminho. Escolha entre os grandes heróis e lute avançando até a mais profunda camada do Gundeon, sobrevivendo a séries desafiadoras e evoluindo cada vez mais! Os andares se tornam cada vez mais perigosos e os chefes estão armados até os dentes por todo o caminho... Agarre-se a qualquer possibilidade de vitória e continue atirando mesmo enquanto tenta sobreviver!', 'Devolver', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/56d9b255d277346f9f000029/banners/pue8g7ynwfaddgluwkd9.jpg', 'Enter the Gungeon', 3, 46.99, 0.00, 10, b'0', NULL),
(12, b'1', 4.0, 3, 'Perambule por uma ilha minúscula em um planeta coberto de poluição em Sludge Life, onde você é o promissor grafiteiro GHOST, um tranquilo delinquente que busca seu lugar na elite do grafite. Explore a paisagem repleta de marcas corporativas, junte-se a outros grafiteiros, e roube tranqueiras e corações pelo caminho. Você vai virar o rei da ilha e grafitar tudo quanto é canto, vai se infiltrar na poluente empresa GLUG, ou vai simplesmente tocar o terror?', 'Devolver', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/60c0dc92c883e604a3e41e46/banners/bqbr8crvhjboz2nemg3t.jpg', 'Sludge Life', 3, 46.99, 0.00, 10, b'0', NULL),
(13, b'1', 5.0, 2, 'Levante-se, Maculado, e seja guiado pela graça para portar o poder do Anel Prístino e se tornar um Lorde Prístino nas Terras Intermédias.', 'FromSoftware', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/618418052f91a002e3f9cf6b/banners/bbmglzl5shlmvc7dv2ix.jpg', 'Elden Ring', 3, 229.99, 0.00, 10, b'0', NULL),
(14, b'1', 5.0, 2, 'Então, houve fogo. Vivencie novamente o jogo que iniciou tudo, que definiu o gênero e aclamado pela crítica. Belamente remasterizado e, agora, legendado em português, retorne a Lordran em deslumbrantes detalhes de alta definição a 60 fps. Dark Souls Remastered inclui o jogo principal mais o DLC Atorias of the Abyss.', 'FromSoftware', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/5b0467082a1c6e250aceff3f/banners/t7wk5ojrnuff2osmz28g.jpg', 'Dark Souls Remastered', 3, 154.90, 69.70, 10, b'1', NULL),
(15, b'1', 5.0, 2, 'Os jogadores terão uma grande surpresa em DARK SOULS II: Scholar of the First Sin. Vá além do que pensava ser possível e descubra incríveis desafios e recompensas emocionantes. Independente de você já ter jogado DARK SOULS II antes, ou ser novo na premiada franquia, você terá uma experiência inteiramente diferente com esta exclusiva Versão do Diretor do jogo. O jogo online foi melhorado com a adição de um item especial para regular almas adquiridas em batalha. Agora é possível formar partidas online de forma mais consistente. O número de jogadores que podem participar de uma sessão online também foi aumentado, de 4 para 6 pessoas, mudando completamente a dinâmica do jogo online. DARK SOULS II: Scholar of the First Sin leva a renomada obscuridade e jogabilidade viciante da franquia a um novo nível. Junte-se à jornada sombria e vivencie encontros com inimigos devastadores, perigos diabólicos e o desafio implacável.', 'FromSoftware', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/570bab1cf3728033c70005b7/banners/ljtxgaz9bczx8jyl8nka.jpg', 'DARK SOULS II: Scholar of the First Sin', 3, 154.90, 69.69, 10, b'1', NULL),
(16, b'1', 5.0, 2, 'À medida que o fogo desvanece e o mundo vai à ruína, mergulhe em um universo repleto de cenários e inimigos colossais. Tanto fãs da série quanto novatos se perderão em sua jogabilidade recompensadora e gráficos imersivos. Agora só restam brasas...', 'FromSoftware', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/5703b71ed277345658000059/banners/uhvknekkx3n5nalqlaap.jpg', 'DARK SOULS III', 3, 229.99, 103.45, 10, b'1', NULL),
(17, b'1', 5.0, 1, 'Do lendário diretor Hideo Kojima, surge uma experiência que desafia gêneros, ainda maior em DIRECTOR’S CUT. No futuro, um evento misterioso conhecido como Death Stranding abriu uma passagem entre os vivos e os mortos, resultando em criaturas grotescas do pós-vida andando pelo mundo arruinado, marcado por uma sociedade desolada. Jogando como Sam Bridges, sua missão é entregar esperança à humanidade ao conectar os sobreviventes de uma América devastada. Você conseguirá reunir este mundo destruído, um passo de cada vez?', 'Kojima Productions', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/62449221b193230016108781/banners/gtepjsgkao3hw5inbv7s.jpg', 'Death Stranding Director\'s Cut', 3, 159.00, 0.00, 10, b'0', NULL),
(18, b'1', 5.0, 1, 'Black Myth: Wukong é um RPG de ação inspirado na mitologia chinesa. A história é baseada em Jornada para o Oeste, um dos Quatro Grandes Romances Clássicos da literatura do país. Você assume o papel do Predestinado e tem a responsabilidade de encarar os desafios e as maravilhas do mundo para desvendar a verdade obscura por trás de uma lenda gloriosa do passado.', 'Game Science', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/66a136e7e4a2a7aa99b76768/banner/d6sexkbrkj6kxrhuguq4.jpg', 'Black Myth: Wukong', 3, 229.99, 204.99, 10, b'1', NULL);

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
(29, b'1', '85259549007', 'cristian@email.com', 'ESTOQUISTA', 'cristian', '$2a$10$cyt1VvLAxcRG3t/SS7aBAu3OEEjByDJrqFD3PoK0glzpbVLdDLvMe');

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
-- Índices de tabela `tb_cliente`
--
ALTER TABLE `tb_cliente`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `tb_imagem_produto`
--
ALTER TABLE `tb_imagem_produto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK2tknjwh9hx3phphf8qi80o6f7` (`produto_id`);

--
-- Índices de tabela `tb_item_pedido`
--
ALTER TABLE `tb_item_pedido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK3qvnhpdyxagngbf1t326cvnse` (`pedido_id`);

--
-- Índices de tabela `tb_pedido`
--
ALTER TABLE `tb_pedido`
  ADD PRIMARY KEY (`id`);

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
-- AUTO_INCREMENT de tabela `tb_cliente`
--
ALTER TABLE `tb_cliente`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `tb_imagem_produto`
--
ALTER TABLE `tb_imagem_produto`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;

--
-- AUTO_INCREMENT de tabela `tb_item_pedido`
--
ALTER TABLE `tb_item_pedido`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de tabela `tb_pedido`
--
ALTER TABLE `tb_pedido`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de tabela `tb_produto`
--
ALTER TABLE `tb_produto`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT de tabela `tb_usuario`
--
ALTER TABLE `tb_usuario`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

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

--
-- Restrições para tabelas `tb_item_pedido`
--
ALTER TABLE `tb_item_pedido`
  ADD CONSTRAINT `FK3qvnhpdyxagngbf1t326cvnse` FOREIGN KEY (`pedido_id`) REFERENCES `tb_pedido` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
