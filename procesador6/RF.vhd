
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use std.textio.all;


entity RF is
    Port ( clkFPGA : in std_logic;
			  rs1 : in  STD_LOGIC_VECTOR (5 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (5 downto 0);
           rd : in  STD_LOGIC_VECTOR (5 downto 0);
			  dwr : in  STD_LOGIC_VECTOR (31 downto 0);
			  reset : in  STD_LOGIC;
           crs1 : out  STD_LOGIC_VECTOR (31 downto 0);
           crs2 : out  STD_LOGIC_VECTOR (31 downto 0);
			  cRD : out  STD_LOGIC_VECTOR (31 downto 0);
			  we : in std_logic);
end RF;

architecture Behavioral of RF is

type ram_type is array (0 to 39) of std_logic_vector (31 downto 0);   --(others => x"00000000")
	signal registers : ram_type :=(x"00000000",x"00000000",x"00000000",x"00000000",
											 x"00000000",x"00000000",x"00000000",x"00000000",
											 x"00000000",x"00000000",x"00000000",x"00000000",
											 x"00000000",x"00000000",x"00000000",x"00000000",
											 x"00000000",x"00000000",x"00000000",x"00000000",
											 x"00000000",x"00000000",x"00000000",x"00000000",
											 x"00000000",x"00000000",x"00000000",x"00000000",
											 x"00000000",x"00000000",x"00000000",x"00000000",
											 x"00000000",x"00000000",x"00000000",x"00000000",
											 x"00000000",x"00000000",x"00000000",x"00000000");

begin
process(reset,rs1,rs2,rd,we,dwr,clkFPGA)--clkFPGA)
	begin
		--if(rising_edge(clkFPGA))then
			if(reset = '1')then
				crs1 <= (others=>'0');
				crs2 <= (others=>'0');
				registers <= (others => x"00000000");
			else
				crs1 <= registers(conv_integer(rs1));
				crs2 <= registers(conv_integer(rs2));
				crd <= registers(conv_integer(rd));
				if (rising_edge(clkFPGA))then
					if((we = '1') and (rd /= "00000"))then
						registers(conv_integer(rd)) <= dwr;
					end if;
				end if;
			end if;
		--end if;
	end process;
		
end Behavioral;

