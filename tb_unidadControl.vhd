LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
  
ENTITY tb_unidadControl IS
END tb_unidadControl;
 
ARCHITECTURE behavior OF tb_unidadControl IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT unidadControl
    PORT(
         op : IN  std_logic_vector(1 downto 0);
         op3 : IN  std_logic_vector(5 downto 0);
         wrEnRF : OUT  std_logic;
         ALUOP : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal op : std_logic_vector(1 downto 0) := (others => '0');
   signal op3 : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal wrEnRF : std_logic;
   signal ALUOP : std_logic_vector(5 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: unidadControl PORT MAP (
          op => op,
          op3 => op3,
          wrEnRF => wrEnRF,
          ALUOP => ALUOP
        );

   -- Clock process definitions
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		op <= "10";
		wait for 40 ns;
		op3 <= "000100";
		wait for 40 ns;
		op3 <= "000101";
		wait for 40 ns;
		op3 <= "000011";
		wait for 40 ns;
		op <= "11";


      -- insert stimulus here 

      wait;
   end process;

END;
