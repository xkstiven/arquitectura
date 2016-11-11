library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PSR is
    Port ( CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           NZVC : in  STD_LOGIC_VECTOR (3 downto 0);
           ICC:out std_logic_vector (3 downto 0);
			  nCWP : in  STD_LOGic;
           CWP : out  STD_LOGIC;
           Carry : out  STD_LOGIC
          
			 );
end PSR;

architecture arqPSR of PSR is

-- [31:28], [27:24], [23:20], [19:14],  [13], [12], [11:8], [7], [6], [5], [4:0]
-- [Impl],   [Ver],   [ICC], [Reserved],[EC], [EF], [PIL],  [S], [PS],[ET],[CWP]

begin
	process(CLK,Reset,nCWP,NZVC)
	begin
		if(Reset = '1') then
			Carry <= '0'; -- Default value
			CWP <= '0'; -- Windows 0 ; Default value
			ICC <= "0000"; -- Default value
		else
			if(rising_edge(CLK)) then
				Carry <= NZVC(0); -- C bit
				CWP <= nCWP; -- CWP bit
				ICC <= NZVC;  --NZVC
			end if;
		end if;
	end process;
end arqPSR;

