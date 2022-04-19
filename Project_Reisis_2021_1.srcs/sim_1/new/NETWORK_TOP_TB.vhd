
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity NETWORK_TOP_tb is
end;

architecture bench of NETWORK_TOP_tb is

  component NETWORK_TOP
  Port (
      CLK     :   in  std_logic;
      RESET   :   in  std_logic;
      X       :   in  std_logic_vector(2 downto 0);
      Y       :   out std_logic
      );
  end component;

  signal CLK: std_logic;
  signal RESET: std_logic;
  signal X: std_logic_vector (2 downto 0);
  signal Y: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: NETWORK_TOP port map ( CLK   => CLK,
                              RESET => RESET,
                              X     => X,
                              Y     => Y );

  stimulus: process
  begin
  
    -- Put initialisation code here
    RESET <= '1';
    X <= "000";
    wait for 10*clock_period;
    RESET <= '0';
    X<="110";
    wait for 1 *clock_period;
    X <= "111";
    wait for 1*clock_period;
    X <= "001";
    wait for 1*clock_period;
    X <= "101";
    wait for 10*clock_period;
    RESET <= '1';
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
  