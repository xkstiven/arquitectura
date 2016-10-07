--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:13:22 10/05/2016
-- Design Name:   
-- Module Name:   D:/vga/procesador2/arquitectura/tb_muxALU.vhd
-- Project Name:  arquitectura
-- Target Device:  
-- Tool versions:  
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY tb_muxALU IS
END tb_muxALU;
 
ARCHITECTURE behavior OF tb_muxALU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT muxALU
    PORT(
         Crs2 : IN  std_logic_vector(31 downto 0);
         SEUOperando : IN  std_logic_vector(31 downto 0);
         selImmediate : IN  std_logic;
         OperandoALU : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Crs2 : std_logic_vector(31 downto 0) := (others => '0');
   signal SEUOperando : std_logic_vector(31 downto 0) := (others => '0');
   signal selImmediate : std_logic := '0';

 	--Outputs
   signal OperandoALU : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: muxALU PORT MAP (
          Crs2 => Crs2,
          SEUOperando => SEUOperando,
          selImmediate => selImmediate,
          OperandoALU => OperandoALU
        );

   -- Clock process definition

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		Crs2 <= x"00120041";
		
		SEUOperando <= x"00450120";
		
		wait for 100 ns;
		
		selImmediate <= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
