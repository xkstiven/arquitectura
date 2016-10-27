LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY tb_procesador4 IS
END tb_procesador4;
 
ARCHITECTURE behavior OF tb_procesador4 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT procesador4
    PORT(
         clkfpga : IN  std_logic;
         reset : IN  std_logic;
         opAdd : IN  std_logic_vector(31 downto 0);
         AluResult : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clkfpga : std_logic := '0';
   signal reset : std_logic := '1';
   signal opAdd : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal AluResult : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clkfpga_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: procesador4 PORT MAP (
          clkfpga => clkfpga,
          reset => reset,
          opAdd => opAdd,
          AluResult => AluResult
        );

   -- Clock process definitions
   clkfpga_process :process
   begin
		clkfpga <= '0';
		wait for clkfpga_period/2;
		clkfpga <= '1';
		wait for clkfpga_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		reset <= '0';
		
		wait for 30 ns;
		
		opAdd <= x"00000001";

      wait;
   end process;

END;
