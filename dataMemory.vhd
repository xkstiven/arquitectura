----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:34:55 11/12/2012 
-- Design Name: 
-- Module Name:    dataMemory - arqDataMemory 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dataMemory is
    Port ( 
			  WriteEnable : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (31 downto 0);
           Address : in  STD_LOGIC_VECTOR (4 downto 0);
           DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end dataMemory;

architecture arqDataMemory of dataMemory is

	type ram_type is array(0 to 32) of std_logic_vector (31 downto 0);
	signal Data_Memory : ram_type := (others => x"00000000");

begin
	process(WriteEnable,Rst,Data,Address)
	begin
		if(Rst = '1')then
			Dataout <= (others =>'0');
		else
			if(WriteEnable = '1')then
				Data_Memory(conv_integer(Address)) <= Data;
			else
				DataOut <= Data_Memory(conv_integer(Address));
			end if;
		end if;
	end process;
end arqDataMemory;
