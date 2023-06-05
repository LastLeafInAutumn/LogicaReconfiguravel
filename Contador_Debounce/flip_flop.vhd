library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- A entidade flip_flop é um flip flop D com enable.
entity flip_flop is
    port(
            d       :   in      std_logic; -- Entrada de dados
            q       :   out     std_logic; -- Saída de dados
            clk :   in  std_logic; -- Entrada de clock
            nRst    :   in      std_logic; -- Entrada de reset
            en      :   in      std_logic -- Entrada de enable
            );

end entity flip_flop;

architecture behav of flip_flop is

begin

    process(clk, nRst, en)
    begin
        if en = '1' then
            if nRst = '0' then
            
                q <= '0'; -- Se reset é 0, a saída é resetada
                
            elsif rising_edge(clk) then
                
                q <= d; -- Se há uma borda de subida do clock, a saída recebe o valor de entrada
                
            end if;
        end if;
    end process;
    
end architecture;
