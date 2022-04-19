-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity COMP_tb is
end;

architecture bench of COMP_tb is

  component COMP
  Port (
      RESET   :   in  std_logic;
      CLK     :   in  std_logic;
      Enable  :   in  std_logic;
      C1_in   :   in  std_logic;
      C2_in   :   in  std_logic;
      C_max  :   out std_logic;
      C_min  :   out std_logic
      );
  end component;

  signal RESET: std_logic;
  signal CLK: std_logic;
  signal Enable : std_logic;
  signal C1_in: std_logic;
  signal C2_in: std_logic;
  signal C_max: std_logic;
  signal C_min: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: COMP port map ( RESET => RESET,
                       CLK   => CLK,
                       Enable => Enable,
                       C1_in => C1_in,
                       C2_in => C2_in,
                       C_max => C_max,
                       C_min => C_min );

  stimulus: process
  begin
  
    -- Put initialisation code here
    RESET <= '1';
    Enable <= '0';
    C1_in <= '0';
    C2_in <= '0';
    wait for 10*clock_period;
    RESET <= '0';
    C1_in <= '0';
    C2_in <= '1';
    wait for 1*clock_period;
    Enable <= '1';
    wait for 1*clock_period;
    C1_in <= '1';
    C2_in <= '0';
    wait for 1*clock_period;
    C1_in <= '0';
    C2_in <= '0';
    wait for 1*clock_period;
    Enable <= '0';
    wait for 1*clock_period;
    C1_in <= '1';
    C2_in <= '1';
    wait for 1*clock_period;
    Enable <= '1';
    wait for 1*clock_period;
    C1_IN <= '1';
    C2_in <= '0';
    wait for 2*clock_period;
    Enable <= '0';
    wait for 10*clock_period;

    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      CLK <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;