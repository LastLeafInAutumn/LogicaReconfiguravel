library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- A entidade debounce implementa um filtro de debounce em um sinal rx.
entity debounce is
    
    generic(
                n       : integer   := 7); -- Número de flip flops na cadeia de debounce

    port(

    rx      :       in      std_logic; -- Sinal de entrada
    tx      :       out     std_logic; -- Sinal de saída
    
    clkbt   :       in      std_logic; -- Clock do botão
    clk50   :       in      std_logic; -- Clock de 50MHz
    nRst    :       in  std_logic; -- Reset
    
    led :       out std_logic_vector(n downto 0)); -- Saída para leds

end entity;

architecture main of debounce is

    signal aux  :   std_logic_vector(n+1 downto 0); -- Sinal auxiliar
    signal clkde    : std_logic; -- Clock de debounce

begin

    aux(0) <= rx; -- Auxiliar recebe sinal de entrada
    led <= aux(n+1 downto 1); -- Leds recebem valores de auxiliar
    tx <= aux(n+1); -- Saída recebe valor auxiliar   

    flip_flops: for i in 0 to n generate
        
        -- Mapeamento dos flip flops
        ff  :   entity work.flip_flop(behav)
            port map(aux(i),aux(i+1), clkde, nRst,'1');
        
    end generate flip_flops;
    
    -- Mapeamento do debouncer do botão
    bt_db : entity work.bt_debounce(main)
            port map(clkbt, clkde, clk50, nRst);
    

end architecture;
