LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY tb_procesador2_top IS
END tb_procesador2_top;
 
ARCHITECTURE behavior OF tb_procesador2_top IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT procesador2_top
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         sum1 : IN  std_logic_vector(31 downto 0);
         ALUresult : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal sum1 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal ALUresult : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: procesador2_top PORT MAP (
          clk => clk,
          reset => reset,
          sum1 => sum1,
          ALUresult => ALUresult
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;
		
		reset <= '1';
		
		wait for 10 ns;
		
		reset <= '0';
		sum1 <= "00000000000000000000000000000001";

      -- insert stimulus here 

      wait;
   end process;

END;
