LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_procesador6 IS
END tb_procesador6;
 
ARCHITECTURE behavior OF tb_procesador6 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT procesador6
    PORT(
         sumador : IN  std_logic_vector(31 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic;
         Salida : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal sumador : std_logic_vector(31 downto 0) := x"00000001";
   signal clk : std_logic := '0';
   signal reset : std_logic := '1';

 	--Outputs
   signal Salida : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: procesador6 PORT MAP (
          sumador => sumador,
          clk => clk,
          reset => reset,
          Salida => Salida
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
      wait for 100 ns;	
		reset<='0';
      

      -- insert stimulus here 

      wait;
   end process;

END;
