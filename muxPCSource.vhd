----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:37:28 05/23/2013 
-- Design Name: 
-- Module Name:    muxPCSource - arqMuxPCSource 
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

entity muxPCSource is
    Port ( PcDisp30 : in  STD_LOGIC_VECTOR (31 downto 0);
           PcDisp22 : in  STD_LOGIC_VECTOR (31 downto 0);
           Pc : in  STD_LOGIC_VECTOR (31 downto 0);
           AluResult : in  STD_LOGIC_VECTOR (31 downto 0);
           PcSource : in  STD_LOGIC_VECTOR (1 downto 0);
           OutMux : out  STD_LOGIC_VECTOR (31 downto 0));
end muxPCSource;

architecture arqMuxPCSource of muxPCSource is

begin

process(PcSource,PcDisp30,PcDisp22,Pc,AluResult)
begin
	case PcSource is
		when "00" => -- CALL and LinkInstruction
			OutMux <= PcDisp30;
		when "01" =>-- Saltos
			OutMux <= PcDisp22;
		when "10"=> -- PC
			OutMux <= Pc;
		when "11" =>	-- AluResult
			OutMux <= AluResult;
		when others =>
			OutMux <= Pc;
		end case;
		
end process;

end arqMuxPCSource;

