-- Importa a biblioteca IEEE
library IEEE;

-- Utiliza o pacote IEEE.STD_LOGIC_1164
use IEEE.STD_LOGIC_1164.ALL;

-- Define a entidade p_register_tb com uma constante n (tamanho do registrador)
entity p_register_tb is
    constant n : integer := 8;
end p_register_tb;

-- Define a arquitetura sim da entidade p_register_tb
architecture sim of p_register_tb is

    -- Declara sinais de clock, reset, data e q
    signal clk        : std_logic := '0';
    signal reset      : std_logic := '0';
    signal data       : std_logic_vector(n-1 downto 0) := (others => '0');
    signal q          : std_logic_vector(n-1 downto 0);
    
    -- Declara uma constante para o período do clock
    constant clk_period : time := 1 ms;
    
begin

    -- Instanciação da unidade sob teste (uut): registrador paralelo parametrizado
    uut : entity work.parametrized_parallel_register generic map (n) port map(clk, reset, data, q);

    -- Processo para gerar o clock
    clk_process: process
    begin
        clk <= not clk;
        wait for clk_period / 2;
    end process;

    -- Processo para simular o comportamento do sistema
    simul: process
    begin
        -- Espera 3 ciclos de clock
        wait for clk_period * 3;
        -- Altera a entrada de dados para todos '1's
        data <= (others => '1');

        -- Espera 3 ciclos de clock
        wait for clk_period * 3;
        -- Altera a entrada de dados para todos '0's
        data <= (others => '0');

        -- Ativa o sinal de reset
        reset <= '1';

        -- Relatório de fim de simulação
        assert false report "End of simulation" severity NOTE;

    end process;

end sim;
