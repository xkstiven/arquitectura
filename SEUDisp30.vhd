----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:04:06 11/11/2016 
-- Design Name: 
-- Module Name:    SEUDisp30 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SEUDisp30 is
    Port ( SEU30 : in  STD_LOGIC_VECTOR (29 downto 0);
           SEU32 : out  STD_LOGIC_VECTOR (31 downto 0));
end SEUDisp30;

architecture Behavioral of SEUDisp30 is

begin
process(SEU30)
	begin
		if(SEU30(29) = '1')then
			SEU32(29 downto 0) <= SEU30;
			SEU32(31 downto 30) <= (others=>'1');
		else
			SEU32(29 downto 0) <= SEU30;
			SEU32(31 downto 30) <= (others=>'0');
		end if;
	end process;


end Behavioral;

