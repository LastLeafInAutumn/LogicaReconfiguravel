-- Importa a biblioteca IEEE
library IEEE;

-- Utiliza o pacote IEEE.STD_LOGIC_1164
use IEEE.STD_LOGIC_1164.ALL;

-- Define a entidade parametrized_parallel_register com um parâmetro genérico n (tamanho do registrador)
entity parametrized_parallel_register is
    generic( n : integer := 4);
    port(
        -- Sinais de entrada: clock, reset e data
        clk     : in std_logic;
        reset   : in std_logic;
        data    : in std_logic_vector(n-1 downto 0);
        
        -- Sinal de saída: q
        q       : out std_logic_vector(n-1 downto 0)
    );
end parametrized_parallel_register;

-- Define a arquitetura behav da entidade parametrized_parallel_register
architecture behav of parametrized_parallel_register is
begin

    -- Processo que responde aos sinais de reset, clock e data
    process (reset, clk, data)
    begin
        -- Se o sinal de reset estiver ativo ('1'), limpa o registrador
        if reset = '1' then
            q <= (others => '0');
        
        -- Se houver uma borda de subida no sinal de clock, atribui o valor do sinal de data ao registrador
        elsif rising_edge(clk) then
            q <= data;
        end if;
    end process;

end behav;
