library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSRModifier is
    Port ( Crs1 : in  STD_LOGIC_VECTOR (31 downto 0);
           operand2 : in  STD_LOGIC_vector (31 downto 0);
           AluOp : in  STD_LOGIC_vector (5 downto 0);
           AluResult : in  STD_LOGIC_VECTOR (31 downto 0);
			  NZVC : out std_logic_vector(3 downto 0));
end PSRModifier;

architecture Behavioral of PSRModifier is


begin

	process(CRs1,Operand2,AluOp,AluResult)--reset
	begin					-- Logical Instructions
							-- Andcc, Nandcc, Orcc, Norcc, Xorcc, Xnorcc
		--if(reset = '1')then
		--		NZVC <= (others=>'0');
		--else
			case AluOp is
		when "010000" =>--ADDCC
			NZVC(3) <= aluResult(31);--n
			if(aluResult = X"00000000") then
				NZVC(2) <= '1';--z
			else
				NZVC(2) <= '0';--z
			end if;
			NZVC(1) <= (Crs1(31) and operand2(31) and (not aluResult(31))) or ((Crs1(31) ) and (not operand2(31)) and aluResult(31));--v
			NZVC(0) <= (Crs1(31) and operand2(31)) or ((not aluResult(31)) and (Crs1(31) or operand2(31)));--c
		when "011000" => --ADDxCC
			NZVC(3) <= aluResult(31);
			if(aluResult = X"00000000") then
				NZVC(2) <= '1';
			else
				NZVC(2) <= '0';
			end if;
			NZVC(1) <= (Crs1(31) and operand2(31) and (not aluResult(31))) or ((Crs1(31) ) and (not operand2(31)) and aluResult(31));--v
			NZVC(0) <= (Crs1(31) and operand2(31)) or ((not aluResult(31)) and (Crs1(31) or operand2(31)));--c
		
		when "010100" => --subCC
			NZVC(3) <= aluResult(31);
			if(aluResult = X"00000000") then
				NZVC(2) <= '1';
			else
				NZVC(2) <= '0';
			end if;
			NZVC(1) <= (Crs1(31) and operand2(31) and (not aluResult(31))) or ((Crs1(31) ) and (not operand2(31)) and aluResult(31));--v
			NZVC(0) <= (Crs1(31) and operand2(31)) or ((not aluResult(31)) and (Crs1(31) or operand2(31)));--c

		when "011100" => --subxCC
			NZVC(3) <= aluResult(31);
			if(aluResult = X"00000000") then
				NZVC(2) <= '1';
			else
				NZVC(2) <= '0';
			end if;
			NZVC(1) <= (Crs1(31) and operand2(31) and (not aluResult(31))) or ((Crs1(31) ) and (not operand2(31)) and aluResult(31));--v
			NZVC(0) <= (Crs1(31) and operand2(31)) or ((not aluResult(31)) and (Crs1(31) or operand2(31)));--c
		when "010001" => --andCC
			NZVC(3) <= aluResult(31);
			if(aluResult = X"00000000") then
				NZVC(2) <= '1';
			else
				NZVC(2) <= '0';
			end if;
			NZVC(1) <= (Crs1(31) and operand2(31) and (not aluResult(31))) or ((Crs1(31) ) and (not operand2(31)) and aluResult(31));--v
			NZVC(0) <= (Crs1(31) and operand2(31)) or ((not aluResult(31)) and (Crs1(31) or operand2(31)));--c
			
		when "010010" => --orCC
			NZVC(3) <= aluResult(31);
			if(aluResult = X"00000000") then
				NZVC(2) <= '1';
			else
				NZVC(2) <= '0';
			end if;
			NZVC(1) <= (Crs1(31) and operand2(31) and (not aluResult(31))) or ((Crs1(31) ) and (not operand2(31)) and aluResult(31));--v
			NZVC(0) <= (Crs1(31) and operand2(31)) or ((not aluResult(31)) and (Crs1(31) or operand2(31)));--c
		when "010110" => --ornCC
			NZVC(3) <= aluResult(31);
			if(aluResult = X"00000000") then
				NZVC(2) <= '1';
			else
				NZVC(2) <= '0';
			end if;
			NZVC(1) <= (Crs1(31) and operand2(31) and (not aluResult(31))) or ((Crs1(31) ) and (not operand2(31)) and aluResult(31));--v
			NZVC(0) <= (Crs1(31) and operand2(31)) or ((not aluResult(31)) and (Crs1(31) or operand2(31)));--c
		when "010011" => --xorCC
			NZVC(3) <= aluResult(31);
			if(aluResult = X"00000000") then
				NZVC(2) <= '1';
			else
				NZVC(2) <= '0';
			end if;
			NZVC(1) <= (Crs1(31) and operand2(31) and (not aluResult(31))) or ((Crs1(31) ) and (not operand2(31)) and aluResult(31));--v
			NZVC(0) <= (Crs1(31) and operand2(31)) or ((not aluResult(31)) and (Crs1(31) or operand2(31)));--c
		when "010111" => --xnorCC
			NZVC(3) <= aluResult(31);
			if(aluResult = X"00000000") then
				NZVC(2) <= '1';
			else
				NZVC(2) <= '0';
			end if;
			NZVC(1) <= (Crs1(31) and operand2(31) and (not aluResult(31))) or ((Crs1(31) ) and (not operand2(31)) and aluResult(31));--v
			NZVC(0) <= (Crs1(31) and operand2(31)) or ((not aluResult(31)) and (Crs1(31) or operand2(31)));--c
		when others =>
			NZVC <= "0000";
	end case;
		--end if;
	end process;

end Behavioral;