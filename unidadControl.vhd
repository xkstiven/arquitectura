library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unidadControl is
    Port ( 
			  op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           wrEnRF : out  STD_LOGIC;
           ALUOP : out  STD_LOGIC_VECTOR (5 downto 0));
end unidadControl;

architecture arqUnidadControl of unidadControl is

begin
	
	process(op,op3)
	
	begin
		ALUOP <= "000000";
					if(op = "10")then				
						case op3 is
							when "000000" => -- ADD
								wrEnRF <= '1';
								ALUOP <= "000000";							
							when "000100"=> --sub
								wrEnRF <= '1';
								ALUOP <= "000100";							
							when "000001" => --and
								wrEnRF <= '1';
								ALUOP <= "000001";	
							when "000101" => --andn
								wrEnRF <= '1';
								ALUOP <= "000101";
							when "000010" => -- or
								wrEnRF <= '1';
								ALUOP <= "000010";
							when "000110" => -- orn
								wrEnRF <= '1';
								ALUOP <= "000110";
							when "000011" => -- xor	
								wrEnRF <= '1';
								ALUOP <= "000011";
							when "000111" => -- xnor
								wrEnRF <= '1';
								ALUOP <= "000111";
								
							when others => -- Implementar demas instrucciones
								wrEnRF <= '0';
								ALUOP <= "000000";
						end case;
					else
						ALUOP <= "000000";
						wrEnRF <= '0';
					end if;
	
	end process;
end arqUnidadControl;
