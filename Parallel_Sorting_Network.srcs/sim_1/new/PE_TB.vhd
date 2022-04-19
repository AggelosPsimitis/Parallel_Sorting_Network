
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity PE_tb is
end;

architecture bench of PE_tb is

  component PE
  Port (
      CLK       :   in  std_logic;
      RESET     :   in  std_logic;
      WAKE_UP   :   in  std_logic;
      X         :   in  std_logic;
      FLAG_IN   :   in  std_logic_vector(1 downto 0);
      WAKE_NEXT :   out std_logic;
      Y         :   out std_logic;
      FLAG_OUT  :   out std_logic_vector(1 downto 0)
      );
  end component;

  signal CLK        : std_logic;
  signal RESET      : std_logic;
  signal WAKE_UP    : std_logic;
  signal X          : std_logic;
  signal FLAG_IN    : std_logic_vector(1 downto 0);
  signal WAKE_NEXT  : std_logic;
  signal Y          : std_logic;
  signal FLAG_OUT   : std_logic_vector(1 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: PE port map ( CLK       => CLK,
                     RESET     => RESET,
                     WAKE_UP   => WAKE_UP,
                     X         => X,
                     FLAG_IN   => FLAG_IN,
                     WAKE_NEXT => WAKE_NEXT,
                     Y         => Y,
                     FLAG_OUT  => FLAG_OUT );

  stimulus: process
  begin
  
    RESET <= '1';
    WAKE_UP <= '0';
    FLAG_IN <= "01";
    X <= '0';
    wait for 10*clock_period;
    RESET <= '0';
    WAKE_UP <= '1';
    X <= '1';
    wait for 1*clock_period;
    X <= '0';
    wait for 1*clock_period;
    X <= '0';
    FLAG_IN <= "10";
    wait for 1*clock_period;
    X <= '1';
    wait for 10*clock_period;
    RESET <= '1';
    wait for 10*clock_period;

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
  