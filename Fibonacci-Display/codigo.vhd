library IEEE;  -- Biblioteca padrão para VHDL
use IEEE.std_logic_1164.all;  -- Biblioteca para operações lógicas
use IEEE.numeric_std.all;  -- Biblioteca para operações numéricas
use work.display.all;  -- Biblioteca de exibição personalizada

-- Declaração da entidade, incluindo frequência de entrada e portas de E/S para os displays
entity teste is
		 -- Frquência de Entrada
		 generic(input_freq  :   integer := 50e6); -- 50e6 ciclos para 1 segundo

		 -- Interfaces da máquina de estados
		 port (
			  clk     :		in    std_logic;
			  nRst    :		in    std_logic;
			  HEX0	 :		out 	std_logic_vector(0 to 6);
			  HEX1	 :		out 	std_logic_vector(0 to 6);
			  HEX2	 :		out 	std_logic_vector(0 to 6);
			  HEX3	 :		out 	std_logic_vector(0 to 6);
			  HEX4	 :		out 	std_logic_vector(0 to 6);
			  HEX5	 :		out 	std_logic_vector(0 to 6)
		
		 );
	end entity teste;
	
	
-- A arquitetura declara os sinais internos e variáveis que serão usadas.
	architecture rtl of teste is

		 -- Quantidade de ciclos para gerar um segundo
		 constant    segundo    :   integer := input_freq / 1;   -- freq_entrada/freq_desejada = contador

		 -- Estados
		 type fsm_state is (s0, s1, s2, s3, s4, s5, s6); -- Declaração dos estados da máquina de estados
		 signal estado       : fsm_state := s0;
		 signal contador     : integer range 0 to segundo := 0;
		 signal p	: integer	range 0 to 832041 := 0;
		 signal a 	: integer := 0;
		 signal b 	: integer := 1;
		 signal c	: integer;
		 signal digits 		: 	display_vector(5 downto 0);
		 
	begin

		HEX0 <= digits(0);
		HEX1 <= digits(1);
		HEX2 <= digits(2);
		HEX3 <= digits(3);
		HEX4 <= digits(4);
		HEX5 <= digits(5);
		digits <= display(p, 6, 10, anode);

-- Este processo descreve a máquina de estados finitos que controla a sequência de Fibonacci.
		fsm: process(clk, nRst) is        
		begin
		
		 if nRst = '0' then
				estado <= s0;
				contador <= 0;
				p <= 0;
		
		 elsif rising_edge(clk) then    
			  

					-- Incrementa o contador
					contador <= contador + 1;
					
					case estado is
						 -- Estado 0
						 when s0 =>
							  a <= 0;
							  b <= 1;
							  estado <= s1;
							  contador <= 0;
							  

						 -- Estado 1
						 when s1 =>
							  p <= a;
							  if contador = segundo - 1 then
									contador <= 0;
									estado <= s2;
							  end if;

						 -- Estado 2
						 when s2 =>
							  p <= b;
							  if contador = segundo - 1 then
									contador <= 0;
									estado <= s3;
							  end if;

						 -- Estado 3  
						 when s3 =>
							  c <= a + b;
							  contador <= 0;
							  estado <= s4;
							  

						 -- Estado 4    
						 when s4 =>
							  p <= c;
							  if contador = segundo - 1 then
									contador <= 0;
									estado <= s5;
							  end if;
							  
						 -- Estado 5
						 when s5 =>
							  a <= b;
							  contador <= 0;
							  estado <= s6;
							  
						 -- Estado 6
						 when s6 =>
								b <= c;
								contador <= 0;
								estado <= s3;
					
						 when others =>
							  contador <= 0;
							  estado <= s0;
							  
					
					end case;
					
			  
		 end if;
		end process fsm;
		 
		 
		 
	end architecture rtl;