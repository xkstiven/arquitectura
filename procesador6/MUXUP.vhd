library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MUXUP is
    Port ( a : in  STD_LOGIC_VECTOR (31 downto 0);
           b : in  STD_LOGIC_VECTOR (31 downto 0);
           c : in  STD_LOGIC_VECTOR (31 downto 0);
           d : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC_VECTOR (1 downto 0);
           salida : out  STD_LOGIC_VECTOR (31 downto 0));
end MUXUP;

architecture Behavioral of MUXUP is

begin
process(a,b,c,d,sel)
	begin
		if (sel="00") then
			salida <= a;
		elsif (sel="01") then
			salida <= b;
		elsif (sel="10") then
			salida <= c;
		elsif (sel="11") then
			salida <= d;
		end if;
end process;

end Behavioral;

