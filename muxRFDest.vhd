----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:18:37 05/23/2013 
-- Design Name: 
-- Module Name:    muxRFDest - arqMuxRFDest 
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

entity muxRFDest is
    Port ( RD : in  STD_LOGIC_VECTOR (5 downto 0);
           register07 : in  STD_LOGIC_VECTOR (5 downto 0);
           RfDest : in  STD_LOGIC;
           Mux_out : out  STD_LOGIC_VECTOR (5 downto 0));
end muxRFDest;

architecture arqMuxRFDest of muxRFDest is

begin
	process(RD,Register07,RfDest)
	begin
		if(RfDest = '1')then
			Mux_out <= Register07;
		else
			Mux_out <= RD;
		end if;
	end process;
end arqMuxRFDest;

