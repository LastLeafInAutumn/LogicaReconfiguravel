library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- A entidade bt_debounce recebe um botão, um clock e um reset e retorna um sinal processado.
entity bt_debounce is
    port(
        button  :   in      std_logic; -- Entrada do botão
        q       :   out     std_logic; -- Saída processada do botão
        clk     :   in      std_logic; -- Entrada do clock
        nrst    :   in      std_logic -- Entrada do reset
    );
end entity bt_debounce;

architecture main of bt_debounce is
    
    signal en  : std_logic; -- Sinal interno de enable
    
    signal en_ff    : std_logic_vector(2 downto 0); -- Vetor de sinal de enable para flip flop
    
    signal aux  :   std_logic_vector(3 downto 0); -- Sinal auxiliar
    
    signal xor_out  :   std_logic; -- Saída da operação XOR

begin
    
    en_ff <= (2 => en, others => '1'); -- Mapeia o vetor de enable para flip flop
    
    gen_ff : for i in 0 to 2 generate
        
        -- Mapeamento do flip flop
        ff_bt    : entity work.flip_flop(behav)
            port map(aux(i), aux(i+1), clk, nrst, en_ff(i));
            
    end generate gen_ff;
    
    aux(0) <= button; -- Recebe o valor do botão
    q <= aux(3); -- Saída recebe valor auxiliar
    
    -- Mapeamento do contador
    cont : entity work.count(behavioral)
                generic map(50_000_000, 100)
                port map(clk, xor_out, en);
                
    xor_out <= aux(1) xor aux(2); -- Saída XOR recebe operação entre aux(1) e aux(2)
    

end architecture main;
