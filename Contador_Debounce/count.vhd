library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- A entidade count é um contador genérico com frequências de clock e de saída configuráveis.
entity count is

    generic(
            clk_frq :   integer := 50_000_000; -- Frequência do clock em Hz
            out_frq :   integer := 10 -- Frequência de saída
            );

    port(

        clk     :   in std_logic; -- Entrada do clock
        sClr    :   in std_logic; -- Entrada do clear
        output  :   out std_logic -- Saída do contador
    );

end entity count;

architecture behavioral of count is

    -- O valor máximo que o contador pode atingir é determinado pela frequência do clock e pela frequência de saída
    constant max : integer range 0 to clk_frq := clk_frq / out_frq;

    signal counter: integer range 0 to clk_frq := 0; -- Contador interno

    signal hit : std_logic := '0'; -- Sinal que indica que o contador atingiu o máximo
	 
    signal en_sgn : std_logic; -- Sinal de enable

begin

    process(clk, sClr)
    begin
    
        if sClr = '1' then
            counter <= 0; -- Se clear for 1, contador é resetado
            hit <= '0'; -- Se clear for 1, hit é resetado
        elsif rising_edge(clk) then
                
                if en_sgn = '0' then
                    if counter = max then
                        hit <= '1'; -- Se contador atinge máximo, hit vai para 1						
                    else				
                        counter <= counter + 1; -- Se não, incrementa o contador				
                    end if;
                end if;

        end if;
        
    end process;
    
    en_sgn <= hit; -- Sinal de enable recebe valor de hit
    output <= hit; -- Saída recebe valor de hit

end behavioral;
