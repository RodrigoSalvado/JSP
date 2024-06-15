-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 07-Jun-2024 às 18:45
-- Versão do servidor: 10.4.28-MariaDB
-- versão do PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `TrabalhoLPI`
--

    CREATE DATABASE TrabalhoLPI;
    USE TrabalhoLPI;

-- --------------------------------------------------------

--
-- Estrutura da tabela `curso`
--

CREATE TABLE `curso` (
                         `id_curso` int(11) NOT NULL,
                         `docente` varchar(100) NOT NULL,
                         `nome` varchar(50) NOT NULL,
                         `descricao` text NOT NULL,
                         `max_num` int(10) NOT NULL DEFAULT 10
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `curso`
--

INSERT INTO `curso` (`id_curso`, `docente`, `nome`, `descricao`, `max_num`) VALUES
                                                                                (1, 'Windoh', 'Curso básico de investimentos em criptomoedas', 'Este curso aborda os conceitos basicos de investimentos em criptomoedas e é o curso ideal para iniciar a sua jornada no mundo das criptomoedas.', 10),
                                                                                (2, 'Tiago Paiva', 'Análise técnica para investimentos em criptomoedas', 'Este curso explora tecnicas de analise avançadas aplicadas ao mercado de criptomoedas. Neste curso aprenderá a interpretar graficos, identificar tendencias entre outros conceitos.\r\n', 10),
                                                                                (3, 'Gabriel Ferreira', 'Curso básico sobre ETFs', 'Este curso aborda os conceitos básicos sobre ETFs e é o curso ideal para iniciar a sua jornada no mundo dos investmentos.', 10),
                                                                                (4, 'Bernardo Almeida', 'Curso básico sobre ações', 'Este curso aborda os conceitos básicos sobre investimentos em ações e sobre o mercado financeiro e é o curso ideal para iniciar a sua jornada no mundo das ações.', 10),
                                                                                (5, 'RicFazeres', 'Fundamentos de blockchain e criptomoedas', 'Este cruso oferece uma introdução abrangente aos fundamentos da tecnologia blockchain e o seu papel nas criptomoedas.', 10),
                                                                                (6, 'Numeiro', 'Gestão de risco em investimentos de criptomoedas', 'Este curso centra-se na gestão eficaz de riscos ao investir me criptomoedas. Aqui os alunos podem aprender controlo de perdas, analise de riscos/recompensa e muito mais.', 10);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipo_utilizador`
--

CREATE TABLE `tipo_utilizador` (
                                   `id` int(11) NOT NULL,
                                   `cargo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `tipo_utilizador`
--

INSERT INTO `tipo_utilizador` (`id`, `cargo`) VALUES
                                                  (1, 'cliente'),
                                                  (2, 'aluno'),
                                                  (3, 'docente'),
                                                  (4, 'administrador'),
                                                  (5, 'apagado');

-- --------------------------------------------------------

--
-- Estrutura da tabela `utilizador`
--

CREATE TABLE `utilizador` (
                              `id_utilizador` int(11) NOT NULL,
                              `username` varchar(50) NOT NULL,
                              `password` varchar(100) NOT NULL,
                              `email` varchar(150) NOT NULL,
                              `tipo_utilizador` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `utilizador`
--

INSERT INTO `utilizador` (`id_utilizador`, `username`, `password`, `email`, `tipo_utilizador`) VALUES
                                                                                                   (1, 'admin', 'admin', 'admin@admin.com', 4),
                                                                                                   (2, 'docente', 'docente', 'docente@docente.com', 3),
                                                                                                   (3, 'aluno', 'aluno', 'aluno@aluno.com', 2),
                                                                                                   (4, 'Windoh', '123', 'windoh@gmail.com', 3),
                                                                                                   (5, 'Tiago Paiva', '123', 'tiagopaiva@gmail.com', 3),
                                                                                                   (6, 'Gabriel Ferreira', '123', 'gabrielferreira@gmail.com', 3),
                                                                                                   (7, 'Bernardo Almeida', '123', 'bernardoalmeida@gmail.com', 3),
                                                                                                   (8, 'RicFazeres', '123', 'ricfazeres@gmail.com', 3),
                                                                                                   (9, 'Numeiro', '123', 'numeiro@gmail.com', 3);

-- --------------------------------------------------------

--
-- Estrutura da tabela `util_curso`
--

CREATE TABLE `util_curso` (
                              `id_inscricao` int(11) NOT NULL,
                              `id_utilizador` int(11) NOT NULL,
                              `id_curso` varchar(100) NOT NULL,
                              `aceite` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `curso`
--
ALTER TABLE `curso`
    ADD PRIMARY KEY (`id_curso`);

--
-- Índices para tabela `tipo_utilizador`
--
ALTER TABLE `tipo_utilizador`
    ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `utilizador`
--
ALTER TABLE `utilizador`
    ADD PRIMARY KEY (`id_utilizador`);

--
-- Índices para tabela `util_curso`
--
ALTER TABLE `util_curso`
    ADD PRIMARY KEY (`id_inscricao`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `curso`
--
ALTER TABLE `curso`
    MODIFY `id_curso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `tipo_utilizador`
--
ALTER TABLE `tipo_utilizador`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `utilizador`
--
ALTER TABLE `utilizador`
    MODIFY `id_utilizador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `util_curso`
--
ALTER TABLE `util_curso`
    MODIFY `id_inscricao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
