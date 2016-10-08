----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:39:26 10/28/2012 
-- Design Name: 
-- Module Name:    registerFile - arqRegisterFile 
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

entity registerFile is
    Port ( --clkFPGA : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           registerSource1 : in  STD_LOGIC_VECTOR (4 downto 0);
           registerSource2 : in  STD_LOGIC_VECTOR (4 downto 0);
           registerDestination : in  STD_LOGIC_VECTOR (4 downto 0);
           writeEnable : in  STD_LOGIC;
			  dataToWrite : in STD_LOGIC_VECTOR (31 downto 0);
           contentRegisterSource1 : out  STD_LOGIC_VECTOR (31 downto 0);
           contentRegisterSource2 : out  STD_LOGIC_VECTOR (31 downto 0));
end registerFile;

architecture arqRegisterFile of registerFile is

	type ram_type is array (0 to 31) of std_logic_vector (31 downto 0);   --(others => x"00000000")
	signal registers : ram_type :=(x"00000000",x"00000001",x"00000002",x"00000003",
											 x"00000004",x"00000005",x"00000006",x"00000007",
											 x"00000008",x"00000009",x"0000000a",x"0000000b",
											 x"0000000c",x"0000000d",x"0000000e",x"0000000f",
											 x"00000010",x"00000011",x"00000012",x"00000013",
											 x"00000014",x"00000015",x"00000016",x"00000017",
											 x"00000018",x"00000019",x"0000001a",x"0000001b",
											 x"0000001c",x"0000001d",x"0000001e",x"0000001f");

begin
--,reset,registerSource1,registerSource2,registerDestination,writeEnable,dataToWrite
	process(reset,registerSource1,registerSource2,registerDestination,writeEnable,dataToWrite)--clkFPGA)
	begin
			if(reset = '1')then
				contentRegisterSource1 <= (others=>'0');
				contentRegisterSource2 <= (others=>'0');
				registers <= (others => x"00000000");
			else
				contentRegisterSource1 <= registers(conv_integer(registerSource1));
				contentRegisterSource2 <= registers(conv_integer(registerSource2));
				if(writeEnable = '1' and registerDestination /= "00000")then
					registers(conv_integer(registerDestination)) <= dataToWrite;
				end if;
			end if;
	end process;
end arqRegisterFile;

