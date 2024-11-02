-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 03/11/2024 às 00:07
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

--
-- Despejando dados para a tabela `spring_session`
--

INSERT INTO `spring_session` (`PRIMARY_ID`, `SESSION_ID`, `CREATION_TIME`, `LAST_ACCESS_TIME`, `MAX_INACTIVE_INTERVAL`, `EXPIRY_TIME`, `PRINCIPAL_NAME`) VALUES
('6a4f213e-190b-42e2-aae7-8b51c99ddacc', 'c23a1c92-b9f2-4409-b612-eabb26740db0', 1730587579681, 1730588198332, 1800, 1730589998332, 'ecthor.nunes@email.com'),
('9ed456c4-74a4-48c0-a070-1358413ae707', '4f2751d3-a247-4ae7-a943-e65191b01bb4', 1730587507058, 1730587537305, 1800, 1730589337305, 'ecthor.silva@email.com');

-- --------------------------------------------------------

--
-- Estrutura para tabela `spring_session_attributes`
--

CREATE TABLE `spring_session_attributes` (
  `SESSION_PRIMARY_ID` char(36) NOT NULL,
  `ATTRIBUTE_NAME` varchar(200) NOT NULL,
  `ATTRIBUTE_BYTES` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Despejando dados para a tabela `spring_session_attributes`
--

INSERT INTO `spring_session_attributes` (`SESSION_PRIMARY_ID`, `ATTRIBUTE_NAME`, `ATTRIBUTE_BYTES`) VALUES
('6a4f213e-190b-42e2-aae7-8b51c99ddacc', 'SPRING_SECURITY_CONTEXT', 0xaced00057372003d6f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e636f6e746578742e5365637572697479436f6e74657874496d706c000000000000026c0200014c000e61757468656e7469636174696f6e7400324c6f72672f737072696e676672616d65776f726b2f73656375726974792f636f72652f41757468656e7469636174696f6e3b78707372004f6f72672e737072696e676672616d65776f726b2e73656375726974792e61757468656e7469636174696f6e2e557365726e616d6550617373776f726441757468656e7469636174696f6e546f6b656e000000000000026c0200024c000b63726564656e7469616c737400124c6a6176612f6c616e672f4f626a6563743b4c00097072696e636970616c71007e0004787200476f72672e737072696e676672616d65776f726b2e73656375726974792e61757468656e7469636174696f6e2e416273747261637441757468656e7469636174696f6e546f6b656ed3aa287e6e47640e0200035a000d61757468656e746963617465644c000b617574686f7269746965737400164c6a6176612f7574696c2f436f6c6c656374696f6e3b4c000764657461696c7371007e00047870017372001f6a6176612e7574696c2e436f6c6c656374696f6e7324456d7074794c6973747ab817b43ca79ede0200007870737200486f72672e737072696e676672616d65776f726b2e73656375726974792e7765622e61757468656e7469636174696f6e2e57656241757468656e7469636174696f6e44657461696c73000000000000026c0200024c000d72656d6f7465416464726573737400124c6a6176612f6c616e672f537472696e673b4c000973657373696f6e496471007e000b787074000f303a303a303a303a303a303a303a3174002461333938666362352d376564612d343433322d396665362d3563656361653835616131627073720031636f6d2e6578616d706c652e65717569706563616f2e65636f6d6d657263655f6170692e6d6f64656c2e436c69656e7465fc494225c0e2e26c02000a5a0005617469766f4a000269644c000363706671007e000b4c000e646174614e617363696d656e746f7400154c6a6176612f74696d652f4c6f63616c446174653b4c0005656d61696c71007e000b4c000f656d61696c536563756e646172696f71007e000b4c000667656e65726f71007e000b4c0005677275706f7400314c636f6d2f6578616d706c652f65717569706563616f2f65636f6d6d657263655f6170692f6d6f64656c2f477275706f3b4c000c6e6f6d65436f6d706c65746f71007e000b4c000573656e686171007e000b787001000000000000000474000e3938372e3635342e3332312d30307372000d6a6176612e74696d652e536572955d84ba1b2248b20c00007870770703000007cf091a78740016656374686f722e6e756e657340656d61696c2e636f6d740010656374686f7240656d61696c2e636f6d7400094d617363756c696e6f7e72002f636f6d2e6578616d706c652e65717569706563616f2e65636f6d6d657263655f6170692e6d6f64656c2e477275706f00000000000000001200007872000e6a6176612e6c616e672e456e756d00000000000000001200007870740007434c49454e544574000c456374686f722053696c766174003c243261243130244f59336b6d38684d793579584862336a684e34374865794b2e6e454f4e74656e45644b67465978624562785157314139624e343065),
('6a4f213e-190b-42e2-aae7-8b51c99ddacc', 'SPRING_SECURITY_SAVED_REQUEST', 0xaced0005737200416f72672e737072696e676672616d65776f726b2e73656375726974792e7765622e7361766564726571756573742e44656661756c74536176656452657175657374000000000000026c02000f49000a736572766572506f72744c000b636f6e74657874506174687400124c6a6176612f6c616e672f537472696e673b4c0007636f6f6b6965737400154c6a6176612f7574696c2f41727261794c6973743b4c00076865616465727374000f4c6a6176612f7574696c2f4d61703b4c00076c6f63616c657371007e00024c001c6d61746368696e6752657175657374506172616d657465724e616d6571007e00014c00066d6574686f6471007e00014c000a706172616d657465727371007e00034c000870617468496e666f71007e00014c000b7175657279537472696e6771007e00014c000a7265717565737455524971007e00014c000a7265717565737455524c71007e00014c0006736368656d6571007e00014c000a7365727665724e616d6571007e00014c000b736572766c65745061746871007e0001787000001f90740000737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a6578700000000077040000000078737200116a6176612e7574696c2e547265654d61700cc1f63e2d256ae60300014c000a636f6d70617261746f727400164c6a6176612f7574696c2f436f6d70617261746f723b78707372002a6a6176612e6c616e672e537472696e672443617365496e73656e736974697665436f6d70617261746f7277035c7d5c50e5ce020000787077040000000e7400066163636570747371007e0006000000017704000000017400032a2f2a7874000f6163636570742d656e636f64696e677371007e000600000001770400000001740017677a69702c206465666c6174652c2062722c207a7374647874000f6163636570742d6c616e67756167657371007e00060000000177040000000174000e70742d42522c70743b713d302e397874000a636f6e6e656374696f6e7371007e00060000000177040000000174000a6b6565702d616c6976657874000c636f6e74656e742d747970657371007e0006000000017704000000017400106170706c69636174696f6e2f6a736f6e78740004686f73747371007e00060000000177040000000174000e6c6f63616c686f73743a3830383078740007726566657265727371007e000600000001770400000001740016687474703a2f2f6c6f63616c686f73743a383038302f787400097365632d63682d75617371007e000600000001770400000001740041224368726f6d69756d223b763d22313330222c2022476f6f676c65204368726f6d65223b763d22313330222c20224e6f743f415f4272616e64223b763d22393922787400107365632d63682d75612d6d6f62696c657371007e0006000000017704000000017400023f30787400127365632d63682d75612d706c6174666f726d7371007e0006000000017704000000017400092257696e646f7773227874000e7365632d66657463682d646573747371007e000600000001770400000001740005656d7074797874000e7365632d66657463682d6d6f64657371007e000600000001770400000001740004636f72737874000e7365632d66657463682d736974657371007e00060000000177040000000174000b73616d652d6f726967696e7874000a757365722d6167656e747371007e00060000000177040000000174006f4d6f7a696c6c612f352e30202857696e646f7773204e542031302e303b2057696e36343b2078363429204170706c655765624b69742f3533372e333620284b48544d4c2c206c696b65204765636b6f29204368726f6d652f3133302e302e302e30205361666172692f3533372e333678787371007e000600000002770400000002737200106a6176612e7574696c2e4c6f63616c657ef811609c30f9ec03000649000868617368636f64654c0007636f756e74727971007e00014c000a657874656e73696f6e7371007e00014c00086c616e677561676571007e00014c000673637269707471007e00014c000776617269616e7471007e00017870ffffffff740002425271007e0005740002707471007e000571007e0005787371007e0038ffffffff71007e000571007e000571007e003b71007e000571007e00057878740008636f6e74696e75657400034745547371007e00087077040000000078707074000c2f6170692f617574682f6d65740021687474703a2f2f6c6f63616c686f73743a383038302f6170692f617574682f6d65740004687474707400096c6f63616c686f737474000c2f6170692f617574682f6d65),
('9ed456c4-74a4-48c0-a070-1358413ae707', 'SPRING_SECURITY_CONTEXT', 0xaced00057372003d6f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e636f6e746578742e5365637572697479436f6e74657874496d706c000000000000026c0200014c000e61757468656e7469636174696f6e7400324c6f72672f737072696e676672616d65776f726b2f73656375726974792f636f72652f41757468656e7469636174696f6e3b78707372004f6f72672e737072696e676672616d65776f726b2e73656375726974792e61757468656e7469636174696f6e2e557365726e616d6550617373776f726441757468656e7469636174696f6e546f6b656e000000000000026c0200024c000b63726564656e7469616c737400124c6a6176612f6c616e672f4f626a6563743b4c00097072696e636970616c71007e0004787200476f72672e737072696e676672616d65776f726b2e73656375726974792e61757468656e7469636174696f6e2e416273747261637441757468656e7469636174696f6e546f6b656ed3aa287e6e47640e0200035a000d61757468656e746963617465644c000b617574686f7269746965737400164c6a6176612f7574696c2f436f6c6c656374696f6e3b4c000764657461696c7371007e00047870017372001f6a6176612e7574696c2e436f6c6c656374696f6e7324456d7074794c6973747ab817b43ca79ede0200007870737200486f72672e737072696e676672616d65776f726b2e73656375726974792e7765622e61757468656e7469636174696f6e2e57656241757468656e7469636174696f6e44657461696c73000000000000026c0200024c000d72656d6f7465416464726573737400124c6a6176612f6c616e672f537472696e673b4c000973657373696f6e496471007e000b787074000f303a303a303a303a303a303a303a3174002435366333313962302d363066352d343765312d383331622d6232316565383835653831327073720031636f6d2e6578616d706c652e65717569706563616f2e65636f6d6d657263655f6170692e6d6f64656c2e436c69656e7465fc494225c0e2e26c02000a5a0005617469766f4a000269644c000363706671007e000b4c000e646174614e617363696d656e746f7400154c6a6176612f74696d652f4c6f63616c446174653b4c0005656d61696c71007e000b4c000f656d61696c536563756e646172696f71007e000b4c000667656e65726f71007e000b4c0005677275706f7400314c636f6d2f6578616d706c652f65717569706563616f2f65636f6d6d657263655f6170692f6d6f64656c2f477275706f3b4c000c6e6f6d65436f6d706c65746f71007e000b4c000573656e686171007e000b787001000000000000000174000e3938372e3635342e3332312d30307372000d6a6176612e74696d652e536572955d84ba1b2248b20c00007870770703000007cd090c78740016656374686f722e73696c766140656d61696c2e636f6d740016656374686f722e6e756e657340656d61696c2e636f6d7400094d617363756c696e6f7e72002f636f6d2e6578616d706c652e65717569706563616f2e65636f6d6d657263655f6170692e6d6f64656c2e477275706f00000000000000001200007872000e6a6176612e6c616e672e456e756d00000000000000001200007870740007434c49454e544574000c456374686f722053696c766174003c243261243130244967636c7257554b5750684d613773726a6530315175546e4d6a677363484f336f71717059564c2f5372642e3433574c6d79357875),
('9ed456c4-74a4-48c0-a070-1358413ae707', 'SPRING_SECURITY_SAVED_REQUEST', 0xaced0005737200416f72672e737072696e676672616d65776f726b2e73656375726974792e7765622e7361766564726571756573742e44656661756c74536176656452657175657374000000000000026c02000f49000a736572766572506f72744c000b636f6e74657874506174687400124c6a6176612f6c616e672f537472696e673b4c0007636f6f6b6965737400154c6a6176612f7574696c2f41727261794c6973743b4c00076865616465727374000f4c6a6176612f7574696c2f4d61703b4c00076c6f63616c657371007e00024c001c6d61746368696e6752657175657374506172616d657465724e616d6571007e00014c00066d6574686f6471007e00014c000a706172616d657465727371007e00034c000870617468496e666f71007e00014c000b7175657279537472696e6771007e00014c000a7265717565737455524971007e00014c000a7265717565737455524c71007e00014c0006736368656d6571007e00014c000a7365727665724e616d6571007e00014c000b736572766c65745061746871007e0001787000001f90740000737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a6578700000000077040000000078737200116a6176612e7574696c2e547265654d61700cc1f63e2d256ae60300014c000a636f6d70617261746f727400164c6a6176612f7574696c2f436f6d70617261746f723b78707372002a6a6176612e6c616e672e537472696e672443617365496e73656e736974697665436f6d70617261746f7277035c7d5c50e5ce020000787077040000000e7400066163636570747371007e0006000000017704000000017400032a2f2a7874000f6163636570742d656e636f64696e677371007e000600000001770400000001740017677a69702c206465666c6174652c2062722c207a7374647874000f6163636570742d6c616e67756167657371007e00060000000177040000000174000e70742d42522c70743b713d302e397874000a636f6e6e656374696f6e7371007e00060000000177040000000174000a6b6565702d616c6976657874000c636f6e74656e742d747970657371007e0006000000017704000000017400106170706c69636174696f6e2f6a736f6e78740004686f73747371007e00060000000177040000000174000e6c6f63616c686f73743a3830383078740007726566657265727371007e000600000001770400000001740016687474703a2f2f6c6f63616c686f73743a383038302f787400097365632d63682d75617371007e000600000001770400000001740041224368726f6d69756d223b763d22313330222c2022476f6f676c65204368726f6d65223b763d22313330222c20224e6f743f415f4272616e64223b763d22393922787400107365632d63682d75612d6d6f62696c657371007e0006000000017704000000017400023f30787400127365632d63682d75612d706c6174666f726d7371007e0006000000017704000000017400092257696e646f7773227874000e7365632d66657463682d646573747371007e000600000001770400000001740005656d7074797874000e7365632d66657463682d6d6f64657371007e000600000001770400000001740004636f72737874000e7365632d66657463682d736974657371007e00060000000177040000000174000b73616d652d6f726967696e7874000a757365722d6167656e747371007e00060000000177040000000174006f4d6f7a696c6c612f352e30202857696e646f7773204e542031302e303b2057696e36343b2078363429204170706c655765624b69742f3533372e333620284b48544d4c2c206c696b65204765636b6f29204368726f6d652f3133302e302e302e30205361666172692f3533372e333678787371007e000600000002770400000002737200106a6176612e7574696c2e4c6f63616c657ef811609c30f9ec03000649000868617368636f64654c0007636f756e74727971007e00014c000a657874656e73696f6e7371007e00014c00086c616e677561676571007e00014c000673637269707471007e00014c000776617269616e7471007e00017870ffffffff740002425271007e0005740002707471007e000571007e0005787371007e0038ffffffff71007e000571007e000571007e003b71007e000571007e00057878740008636f6e74696e75657400034745547371007e00087077040000000078707074000c2f6170692f617574682f6d65740021687474703a2f2f6c6f63616c686f73743a383038302f6170692f617574682f6d65740004687474707400096c6f63616c686f737474000c2f6170692f617574682f6d65);

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
(7, b'1', '438.356.350-34', '1222-10-10', 'vitor.maia@email.com', 'vitor.maia2@email.com', 'Masculino', 'CLIENTE', 'Vitor Maia ', '$2a$10$GDdWEREHR.1Lakhuw7yetuoD8xrv9CR0/DesheZuCpniIlnkMutAW');

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
(1, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dba4769702d0a9c4e1100/screenshots/l0aerhu9widfsmt1rbrr.jpg', b'0', 1),
(2, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dba4769702d0a9c4e1100/screenshots/bqzbfxxsbkd4eljyw0h6.jpg', b'0', 1),
(3, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dba4769702d0a9c4e1100/screenshots/d0wfeldnoj0g0to9wvt3.jpg', b'0', 1),
(4, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/575aff17d277343eff0001e9/screenshots/jxpiqejawsjejtfgvzhy.jpg', b'0', 2),
(5, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/575aff17d277343eff0001e9/screenshots/czo3bnid8yqdp8j9zwal.jpg', b'0', 2),
(6, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/575aff17d277343eff0001e9/screenshots/xnox8vgqddtbb3ltfjaw.jpg', b'0', 2),
(7, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dba3269702d0a9c8e0700/screenshots/xlqgoavolhomm4gnizta.jpg', b'0', 3),
(8, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dba3269702d0a9c8e0700/screenshots/thwga4vknyghoznuvccy.jpg', b'0', 3),
(9, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dba3269702d0a9c8e0700/screenshots/cxetr5c8yiztf2bszl0f.jpg', b'0', 3),
(10, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5c0feb8a88102447edfd94fe/screenshots/fdy8jenh1reiq7688md4.jpg', b'0', 4),
(11, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5c0feb8a88102447edfd94fe/screenshots/bm0v3mzlup8nrbmnonqg.jpg', b'0', 4),
(12, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5c0feb8a88102447edfd94fe/screenshots/wkgnhoqhc3k8qnsdcudl.jpg', b'0', 4),
(13, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dbc1e69702d0a9c62d400/screenshots/talxz2xzpc0phiim088v.jpg', b'0', 5),
(14, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dbc1e69702d0a9c62d400/screenshots/l22zmchxtlhmg6h4kmaf.jpg', b'0', 5),
(15, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dbc1e69702d0a9c62d400/screenshots/xrdonsznbhl784axpqil.jpg', b'0', 5),
(16, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dbaf169702d0a9cb55f00/screenshots/lspt1ushlxawg506d04f.jpg', b'0', 6),
(17, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dbaf169702d0a9cb55f00/screenshots/vpa8prhqj0ueqevixwzl.jpg', b'0', 6),
(18, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/557dbaf169702d0a9cb55f00/screenshots/gxekdsnmobh1xxhspwj6.jpg', b'0', 6),
(19, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5c5093428810242173c0bb5c/screenshots/eq7suv6wjzlgu81odiob.jpg', b'0', 7),
(20, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5c5093428810242173c0bb5c/screenshots/kesqotwkspjhulehclqc.jpg', b'0', 7),
(21, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5c5093428810242173c0bb5c/screenshots/uvwltzjkmjvrb9digzjn.jpg', b'0', 7),
(22, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/60087598a3f8b147910a6750/screenshots/khi867gnrpbyhjh41xmn.jpg', b'0', 8),
(23, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/60087598a3f8b147910a6750/screenshots/qkbnzexjvccdp8lvpfok.jpg', b'0', 8),
(24, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/60087598a3f8b147910a6750/screenshots/r6uawqxqtaxbh49hf9px.jpg', b'0', 8),
(25, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/62c7039e4e421d00161d73e6/screenshots/knuzzrcby77cevubdtm6.jpg', b'0', 9),
(26, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/62c7039e4e421d00161d73e6/screenshots/n5tlcvbk1dukzlljlln2.jpg', b'0', 9),
(27, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/62c7039e4e421d00161d73e6/screenshots/hlvck5nojou1hovvnbis.jpg', b'0', 9),
(28, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/60fad187a3f8b14a5deb775b/screenshots/wscv3vrchsopys4mxfpz.jpg', b'0', 10),
(29, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/60fad187a3f8b14a5deb775b/screenshots/y9ba3zqmn34dqgu2druw.jpg', b'0', 10),
(30, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/60fad187a3f8b14a5deb775b/screenshots/jqf2yomz9swp8vzozl9r.jpg', b'0', 10),
(31, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/56d9b255d277346f9f000029/screenshots/gqhir9cgbcbxic9zusdl.jpg', b'0', 11),
(32, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/56d9b255d277346f9f000029/screenshots/c0otak4cvv12w4ss3ulw.jpg', b'0', 11),
(33, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/56d9b255d277346f9f000029/screenshots/kmr82pgbk3udir5sduim.jpg', b'0', 11),
(34, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/60c0dc92c883e604a3e41e46/screenshots/z1og1wcggd7y3xwh10qb.jpg', b'0', 12),
(35, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/60c0dc92c883e604a3e41e46/screenshots/r0wzgpboxfihtgx1rpfl.jpg', b'0', 12),
(36, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/60c0dc92c883e604a3e41e46/screenshots/pf5t1wwzijj3lobucrvj.jpg', b'0', 12),
(37, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/618418052f91a002e3f9cf6b/screenshots/sulcmvodnhfwgc6i8evb.jpg', b'0', 13),
(38, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/618418052f91a002e3f9cf6b/screenshots/dkwnd7zhavqbssv9ic6h.jpg', b'0', 13),
(39, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/618418052f91a002e3f9cf6b/screenshots/crk3pwg0d5gsifh5nazt.jpg', b'0', 13),
(40, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5b0467082a1c6e250aceff3f/screenshots/k504smcadqc1sswiln3o.jpg', b'0', 14),
(41, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5b0467082a1c6e250aceff3f/screenshots/lohsw1grqo7puxdsh74v.jpg', b'0', 14),
(42, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5b0467082a1c6e250aceff3f/screenshots/wblahf6kaneifhuxea27.jpg', b'0', 14),
(43, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/570bab1cf3728033c70005b7/screenshots/an47ohqoftp5shgo3ykw.jpg', b'0', 15),
(44, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/570bab1cf3728033c70005b7/screenshots/oviczlkymrpp9iit4cue.jpg', b'0', 15),
(45, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/570bab1cf3728033c70005b7/screenshots/ihzew4brkj5jrxdolnwu.jpg', b'0', 15),
(46, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5703b71ed277345658000059/screenshots/evoj6uxsj8doaoqnyv20.jpg', b'0', 16),
(47, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5703b71ed277345658000059/screenshots/qbygpigwcj2jhuipdkmj.jpg', b'0', 16),
(48, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/5703b71ed277345658000059/screenshots/radgj9wgujbqd9owa1p5.jpg', b'0', 16),
(49, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/62449221b193230016108781/screenshots/ho676o03v69w1ml6bwfz.jpg', b'0', 17),
(50, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/62449221b193230016108781/screenshots/lhokrodd2lek12k1ckc3.jpg', b'0', 17),
(51, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/62449221b193230016108781/screenshots/n3nxabzcbulzlnaxdfzi.jpg', b'0', 17),
(52, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/62449221b193230016108781/screenshots/mdyibb8gohxpytvsczft.jpg', b'0', 17),
(53, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/66a136e7e4a2a7aa99b76768/screenshot/fy0rdtrl7md1sof726ah.jpg', b'0', 18),
(54, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/66a136e7e4a2a7aa99b76768/screenshot/lshona5mse7qc7opbinz.jpg', b'0', 18),
(55, '/imagens/produtos/', 'https://assets.nuuvem.com/image/upload/t_screenshot_full/v1/products/66a136e7e4a2a7aa99b76768/screenshot/eekmxeow0bdslpjkmw6r.jpg', b'0', 18);

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
(2, 'LEGO Batman', 6, 2, 4.49, 1);

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
  `valor_total` decimal(38,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tb_pedido`
--

INSERT INTO `tb_pedido` (`id`, `cliente_id`, `data_pedido`, `forma_pagamento`, `status`, `valor_total`) VALUES
(1, 4, '2024-11-02 17:08:34.000000', 'CARTAO_CREDITO', 'PAGO', 13.47);

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
(1, b'1', 5.0, 1, 'Far Cry 3 leva os jogadores à pele de Jason Brody, um homem sozinho nos confins do mundo, preso em uma misteriosa ilha tropical isolada da civilização. Neste paraíso selvagem onde ilegalidade e violência são a única certeza, os jogadores vão determinar quando, onde e como os eventos do jogo se desenrolam. Jogadores vão cortar em pedaços, deslocar, detonar e atirar em seus caminhos pela ilha num mundo que perdeu todo o senso do certo e do errado.', 'Ubisoft', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/557dba4769702d0a9c4e1100/banners/nmsyv3r0zp66seeg5g69.jpg', 'Far Cry 3', 3, 59.99, 19.99, 10, b'1'),
(2, b'1', 3.0, 1, 'Bem-vindo a São Francisco! Seu objetivo: a maior operação hacker da história. Jogue como Marcus Holloway, um hacker genial no berço da revolução tecnológica, a área da baía de São Francisco. Junte-se ao Dedsec, um grupo notório de hackers, para executar o maior hack da história; derrube o ctOS 2.0, um sistema operacional invasivo que está sendo usado por um gênio do crime para monitorar e manipular os cidadãos em uma escala massiva.', 'Ubisoft', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/575aff17d277343eff0001e9/banners/pwkjxknabmiwxpjknrws.jpg', 'Watch_Dogs 2', 3, 149.99, 22.49, 10, b'1'),
(3, b'1', 3.5, 1, 'O Príncipe da Pérsia, um experiente guerreiro, retorna da Ilha do Tempo para a Babilônia com seu amor, Kaileena. Mas, em vez da paz que ele anseia, ele encontra sua pátria devastada pela guerra e o reino se volta contra ele. O Príncipe é rapidamente capturado e Kaileena não tem outra escolha a não ser sacrificar-se e libertar as Areias do Tempo, a fim de salvá-lo. Agora expulso nas ruas e caçado como um fugitivo, o Príncipe logo descobre que batalhas do passado deram origem a um mortal Príncipe Negro, cujo espírito gradualmente o possui..', 'Ubisoft', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/557dba3269702d0a9c8e0700/banners/bofbgewhdruwfrjnlx67.jpg', 'Prince of Persia: The Two Thrones', 3, 29.99, 5.99, 10, b'1'),
(4, b'1', 1.5, 1, 'O UNO que você conhece e ama - e muito mais! É uma corrida para terminar conforme você tenta esvaziar sua mão antes de todo mundo. Jogue com amigos e familiares do jeito que quiser com uma gama de regras da casa e, pela primeira vez, temas com visual atualizado e novas cartas temáticas que introduzem efeitos e poderes loucos ao jogo.', 'Ubisoft', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/5c0fed352a1c6e02c3c0c98a/banners/cfci3cqtlyu0znye7gfy.jpg', 'UNO', 3, 29.99, 0.00, 10, b'0'),
(5, b'1', 5.0, 1, 'Recupere o Reino Perdido peça por peça! Junte-se a Bilbo Bolseiro, Gandalf, Thorin e sua companhia de anões em uma aventura épica através da Terra Média para recapturar a Montanha Solitária no jogo da LEGO mais expansivo até hoje.', 'Warner Bros. Games', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/557dbc1e69702d0a9c62d400/banners/jtqzsafetae2lo5vhysp.jpg', 'LEGO The Hobbit', 3, 89.99, 4.49, 10, b'1'),
(6, b'1', 5.0, 1, 'Quando todos os vilões do Arkham Asylum se unem e fogem, somente a dupla dinâmica será capaz de impedi-los e salvar Gotham City. A diversão de LEGO e a história de Batman, essa combinação incomparável faz de LEGO Batman: The Videogame uma aventura cômica e empolgante. Jogue como Batman e seu parceiro Robin enquanto você constrói, dirige, balança e luta em Gotham City capturando vilões incluindo Coringa, Pinguim, Espantalho, entre outros. Então, entre no outro lado da história e jogue como os inimigos do Batman! Aproveite o poder que você possui e confronte Batman enquanto espalha o caos pela cidade. Não existe descanso para quem é bom (ou mal!)', 'Warner Bros. Games', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/557dbaf169702d0a9cb55f00/banners/pcqddpt6bo50hlebrxol.jpg', 'LEGO Batman', 3, 89.99, 4.49, 10, b'1'),
(7, b'1', 2.6, 0, 'Mortal Kombat está de volta, melhor do que nunca, em uma evolução da icônica franquia! Todas as variações de customização de personagens lhe dão liberdade total para personalizar os lutadores e torná-los únicos! MK 11 faz você mergulhar em crânios rachados e uma grande quantidade de partes do corpo do seu oponente voando; com lutadores clássicos, novos e antigos, a incrível cinemática do modo história de Mortal Kombat continua a contar a saga épica de 25 anos atrás.', 'Warner Bros. Games', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/5c5093428810242173c0bb5c/banners/d2m04tkhgphzxvcskrwk.jpg', 'Mortal Kombat 11', 3, 229.99, 20.69, 10, b'1'),
(8, b'1', 3.6, 0, 'Back 4 Blood é um jogo de tiro em primeira pessoa dos criadores da franquia aclamada pela crítica Left 4 Dead. Você está no centro de uma guerra contra os contagiados. Esses humanos portadores de um parasita mortal se transformaram em criaturas assustadoras inclinadas a devorar os restos da civilização. Com a extinção da humanidade em jogo, cabe a você e seus amigos enfrentar esse inimigo, erradicar os corrompidos e reconquistar o mundo.', 'Warner Bros. Games', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/60087598a3f8b147910a6750/banners/dmsyjen4zc3whgheq6x4.jpg', 'Back 4 Blood', 3, 279.99, 25.19, 10, b'1'),
(9, b'1', 5.0, 1, 'Cult of the Lamb coloca o jogador no papel de um cordeiro possuído, que é salvo da aniquilação por um estranho sinistro e precisa quitar sua dívida recrutando seguidores leais em nome dele. Crie seu próprio culto em uma terra de falsos profetas, aventurando-se por regiões misteriosas e diversas para criar uma comunidade fiel de adoradores da floresta e para propagar sua Palavra e se tornar o único culto verdadeiro.', 'Devolver', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/62c7039e4e421d00161d73e6/banners/qfvemajsxksnqg8qn6vd.jpg', 'Cult of the Lamb', 3, 64.95, 0.00, 10, b'0'),
(10, b'1', 5.0, 4, 'Ceifar a alma dos mortos e bater o cartão pode ser uma rotina monótona, mas é o trabalho honesto de um Corvo em Death\'s Door. Mas isso está prestes a mudar, quando sua alma designada é roubada, e você deve perseguir um ladrão desesperado até um reino intocado pela morte, onde criaturas vivem muito além do que deveriam e acumulam ganância e poder.', 'Devolver', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/60fad187a3f8b14a5deb775b/banners/xemvrayuvukttztjdlwn.jpg', 'Death\'s Door', 3, 59.99, 0.00, 10, b'0'),
(11, b'1', 4.0, 3, 'O grande tesouro supremo do lendário Gundeon foi descoberto: Uma arma que pode matar o passado. Hora que pegar o equipamento pesado e reunir a equipe mais desajustada do mundo para poder atirar, pilhar, se esquivar e chutar todas as portas que estiverem no caminho. Escolha entre os grandes heróis e lute avançando até a mais profunda camada do Gundeon, sobrevivendo a séries desafiadoras e evoluindo cada vez mais! Os andares se tornam cada vez mais perigosos e os chefes estão armados até os dentes por todo o caminho... Agarre-se a qualquer possibilidade de vitória e continue atirando mesmo enquanto tenta sobreviver!', 'Devolver', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/56d9b255d277346f9f000029/banners/pue8g7ynwfaddgluwkd9.jpg', 'Enter the Gungeon', 3, 46.99, 0.00, 10, b'0'),
(12, b'1', 4.0, 3, 'Perambule por uma ilha minúscula em um planeta coberto de poluição em Sludge Life, onde você é o promissor grafiteiro GHOST, um tranquilo delinquente que busca seu lugar na elite do grafite. Explore a paisagem repleta de marcas corporativas, junte-se a outros grafiteiros, e roube tranqueiras e corações pelo caminho. Você vai virar o rei da ilha e grafitar tudo quanto é canto, vai se infiltrar na poluente empresa GLUG, ou vai simplesmente tocar o terror?', 'Devolver', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/60c0dc92c883e604a3e41e46/banners/bqbr8crvhjboz2nemg3t.jpg', 'Sludge Life', 3, 46.99, 0.00, 10, b'0'),
(13, b'1', 5.0, 2, 'Levante-se, Maculado, e seja guiado pela graça para portar o poder do Anel Prístino e se tornar um Lorde Prístino nas Terras Intermédias.', 'FromSoftware', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/618418052f91a002e3f9cf6b/banners/bbmglzl5shlmvc7dv2ix.jpg', 'Elden Ring', 3, 229.99, 0.00, 10, b'0'),
(14, b'1', 5.0, 2, 'Então, houve fogo. Vivencie novamente o jogo que iniciou tudo, que definiu o gênero e aclamado pela crítica. Belamente remasterizado e, agora, legendado em português, retorne a Lordran em deslumbrantes detalhes de alta definição a 60 fps. Dark Souls Remastered inclui o jogo principal mais o DLC Atorias of the Abyss.', 'FromSoftware', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/5b0467082a1c6e250aceff3f/banners/t7wk5ojrnuff2osmz28g.jpg', 'Dark Souls Remastered', 3, 154.90, 69.70, 10, b'1'),
(15, b'1', 5.0, 2, 'Os jogadores terão uma grande surpresa em DARK SOULS II: Scholar of the First Sin. Vá além do que pensava ser possível e descubra incríveis desafios e recompensas emocionantes. Independente de você já ter jogado DARK SOULS II antes, ou ser novo na premiada franquia, você terá uma experiência inteiramente diferente com esta exclusiva Versão do Diretor do jogo. O jogo online foi melhorado com a adição de um item especial para regular almas adquiridas em batalha. Agora é possível formar partidas online de forma mais consistente. O número de jogadores que podem participar de uma sessão online também foi aumentado, de 4 para 6 pessoas, mudando completamente a dinâmica do jogo online. DARK SOULS II: Scholar of the First Sin leva a renomada obscuridade e jogabilidade viciante da franquia a um novo nível. Junte-se à jornada sombria e vivencie encontros com inimigos devastadores, perigos diabólicos e o desafio implacável.', 'FromSoftware', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/570bab1cf3728033c70005b7/banners/ljtxgaz9bczx8jyl8nka.jpg', 'DARK SOULS II: Scholar of the First Sin', 3, 154.90, 69.69, 10, b'1'),
(16, b'1', 5.0, 2, 'À medida que o fogo desvanece e o mundo vai à ruína, mergulhe em um universo repleto de cenários e inimigos colossais. Tanto fãs da série quanto novatos se perderão em sua jogabilidade recompensadora e gráficos imersivos. Agora só restam brasas...', 'FromSoftware', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/5703b71ed277345658000059/banners/uhvknekkx3n5nalqlaap.jpg', 'DARK SOULS III', 3, 229.99, 103.45, 10, b'1'),
(17, b'1', 5.0, 1, 'Do lendário diretor Hideo Kojima, surge uma experiência que desafia gêneros, ainda maior em DIRECTOR’S CUT. No futuro, um evento misterioso conhecido como Death Stranding abriu uma passagem entre os vivos e os mortos, resultando em criaturas grotescas do pós-vida andando pelo mundo arruinado, marcado por uma sociedade desolada. Jogando como Sam Bridges, sua missão é entregar esperança à humanidade ao conectar os sobreviventes de uma América devastada. Você conseguirá reunir este mundo destruído, um passo de cada vez?', 'Kojima Productions', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/62449221b193230016108781/banners/gtepjsgkao3hw5inbv7s.jpg', 'Death Stranding Director\'s Cut', 3, 159.00, 0.00, 10, b'0'),
(18, b'1', 5.0, 1, 'Black Myth: Wukong é um RPG de ação inspirado na mitologia chinesa. A história é baseada em Jornada para o Oeste, um dos Quatro Grandes Romances Clássicos da literatura do país. Você assume o papel do Predestinado e tem a responsabilidade de encarar os desafios e as maravilhas do mundo para desvendar a verdade obscura por trás de uma lenda gloriosa do passado.', 'Game Science', 'https://assets.nuuvem.com/image/upload/t_banner_big/v1/products/66a136e7e4a2a7aa99b76768/banner/d6sexkbrkj6kxrhuguq4.jpg', 'Black Myth: Wukong', 3, 229.99, 204.99, 10, b'1');

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `tb_imagem_produto`
--
ALTER TABLE `tb_imagem_produto`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT de tabela `tb_item_pedido`
--
ALTER TABLE `tb_item_pedido`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `tb_pedido`
--
ALTER TABLE `tb_pedido`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `tb_produto`
--
ALTER TABLE `tb_produto`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

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
