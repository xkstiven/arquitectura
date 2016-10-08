LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_singExtensionUnit IS
END tb_singExtensionUnit;
 
ARCHITECTURE behavior OF tb_singExtensionUnit IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT signExtensionUnit
    PORT(
         simm13 : IN  std_logic_vector(12 downto 0);
         simm32 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal simm13 : std_logic_vector(12 downto 0) := (others => '0');

 	--Outputs
   signal simm32 : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: signExtensionUnit PORT MAP (
          simm13 => simm13,
          simm32 => simm32
        );

   -- Clock process definitions
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		simm13 <= "0000000000000";
		wait for 40 ns;
		
		simm13 <= "0000000000001";
		wait for 40 ns;
		
		simm13 <= "1000000000001";
		wait for 40 ns;
		
		simm13 <= "1000000000111";

      wait;
   end process;

END;
