LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY tb_registerFile IS
END tb_registerFile;
 
ARCHITECTURE behavior OF tb_registerFile IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT registerFile
    PORT(
         reset : IN  std_logic;
         registerSource1 : IN  std_logic_vector(4 downto 0);
         registerSource2 : IN  std_logic_vector(4 downto 0);
         registerDestination : IN  std_logic_vector(4 downto 0);
         writeEnable : IN  std_logic;
         dataToWrite : IN  std_logic_vector(31 downto 0);
         contentRegisterSource1 : OUT  std_logic_vector(31 downto 0);
         contentRegisterSource2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal registerSource1 : std_logic_vector(4 downto 0) := (others => '0');
   signal registerSource2 : std_logic_vector(4 downto 0) := (others => '0');
   signal registerDestination : std_logic_vector(4 downto 0) := (others => '0');
   signal writeEnable : std_logic := '0';
   signal dataToWrite : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal contentRegisterSource1 : std_logic_vector(31 downto 0);
   signal contentRegisterSource2 : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: registerFile PORT MAP (
          reset => reset,
          registerSource1 => registerSource1,
          registerSource2 => registerSource2,
          registerDestination => registerDestination,
          writeEnable => writeEnable,
          dataToWrite => dataToWrite,
          contentRegisterSource1 => contentRegisterSource1,
          contentRegisterSource2 => contentRegisterSource2
        );

   -- Clock process definitions

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		registerSource1 <= "00000";
		registerSource2 <= "00001";
		wait for 100 ns;	
		registerSource1 <= "00010";
		registerSource2 <= "00011";
		wait for 100 ns;	
		registerSource1 <= "00100";
		registerSource2 <= "00101";
		wait for 40 ns;
		
		registerDestination <= "00010";
		dataToWrite <= x"00000aaa";
		
		wait for 40 ns;
		
		writeEnable <= '1';
		
		wait for 40 ns;
		writeEnable <= '0';
		registerSource1 <= "00010";
		

      wait;
   end process;

END;
