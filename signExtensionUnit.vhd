library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity signExtensionUnit is
    Port (
			  simm13 : in  STD_LOGIC_VECTOR (12 downto 0);
           simm32 : out  STD_LOGIC_VECTOR (31 downto 0));
end signExtensionUnit;

architecture arqSignExtensionUnit of signExtensionUnit is

begin
	process(simm13)
	begin
			if(simm13(12) = '1')then
				simm32(12 downto 0) <= simm13;
				simm32(31 downto 13) <= (others=>'1');
			else
				simm32(12 downto 0) <= simm13;
				simm32(31 downto 13) <= (others=>'0');
			end if;
	end process;

end arqSignExtensionUnit;

