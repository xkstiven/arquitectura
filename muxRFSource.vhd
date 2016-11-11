----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:10:38 05/23/2013 
-- Design Name: 
-- Module Name:    muxRFSource - arqMuxRFSource 
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

entity muxRFSource is
    Port ( dataMemory : in  STD_LOGIC_VECTOR (31 downto 0);
           aluResult : in  STD_LOGIC_VECTOR (31 downto 0);
           pc : in  STD_LOGIC_VECTOR (31 downto 0);
           rfSource : in  STD_LOGIC_VECTOR (1 downto 0);
           outMux : out  STD_LOGIC_VECTOR (31 downto 0));
end muxRFSource;

architecture arqMuxRFSource of muxRFSource is

begin
process(rfSource,dataMemory,aluResult,pc)
	begin
		if(rfSource = "00")then -- Let pass data memory
			outMux <= dataMemory;
		elsif(rfSource = "01")then -- Let pass alu result
			outMux <= aluResult;
		elsif(rfSource = "10")then -- Let pass pc
			outMux <= pc;
		end if;
	end process;

end arqMuxRFSource;

