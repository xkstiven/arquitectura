LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
  
ENTITY tb_instructionMemory IS
END tb_instructionMemory;
 
ARCHITECTURE behavior OF tb_instructionMemory IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT instructionMemory
    PORT(
         clk : IN  std_logic;
         address : IN  std_logic_vector(31 downto 0);
         reset : IN  std_logic;
         outInstruction : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal address : std_logic_vector(31 downto 0) := (others => '0');
   signal reset : std_logic := '0';

 	--Outputs
   signal outInstruction : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: instructionMemory PORT MAP (
          clk => clk,
          address => address,
          reset => reset,
          outInstruction => outInstruction
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
      reset <= '1';
		wait for 40 ns;
		reset <= '0';
		
		address <= x"00000001";
		
		wait for 40 ns;
		reset <= '1';
		wait for 40 ns;
		reset <= '0';
		
		wait for 40 ns;		
		address <= x"00000002";
		
		wait for 40 ns;		
		address <= x"00000003";
		
		wait for 40 ns;		
		address <= x"00000004";

		wait for 40 ns;		
		address <= x"00000005";
		
		wait for 40 ns;		
		address <= x"0000000a";



      wait;
   end process;

END;
