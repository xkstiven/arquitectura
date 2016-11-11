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

		if(PcSource = "00")then -- CALL and LinkInstruction
			OutMux <= PcDisp30;
		elsif(PcSource = "01")then -- Saltos
			OutMux <= PcDisp22;
		elsif(PcSource = "10")then -- PC
			OutMux <= Pc;
		elsif(PcSource = "11")then	-- AluResult
			OutMux <= AluResult;
		end if;
		
end process;

end arqMuxPCSource;

