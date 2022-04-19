library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity NETWORK_TOP is
Port (
    CLK     :   in  std_logic;
    RESET   :   in  std_logic;
    X       :   in  std_logic_vector(2 downto 0);
    Y       :   out std_logic
    );
end NETWORK_TOP;

architecture Structural of NETWORK_TOP is

component PE is
Port (
    CLK       : in  std_logic;
    RESET     : in  std_logic;
    WAKE_UP   : in  std_logic;
    X         : in  std_logic;
    FLAG_IN   : in  std_logic_vector(1 downto 0);
    WAKE_NEXT : out std_logic;
    Y         : out std_logic;
    FLAG_OUT  : out std_logic_vector(1 downto 0)
    );
end component;

signal wake_0 , wake_1, wake_2, wake_3, wake_4, wake_4_temp, wake_5, wake_6, wake_7, wake_8, wake_8_temp,wake_8_temp1, wake_9, wake_10, wake_11 : std_logic := '0';
signal X_0, X_1, X_2, X_3, X_4, X_5, X_6, X_7, X_8, X_9, X_10, X_11  : std_logic := '0';
signal flag_in4, flag_in5, flag_in6, flag_in7, flag_in8, flag_in9, flag_in10, flag_in11 : std_logic_vector(1 downto 0) := "00";
signal q0, q1, q2, q3, q4, q5 : std_logic := '0'; 

begin

FirstRow_Input_Buffer : process(CLK)
begin
    if(falling_edge(CLK))then
        q0 <= X(2);
    end if;
end process;

SecondRow_Input_Buffer : process(CLK)
begin
    if(falling_edge(CLK))then
        q1 <= X(1);
        q2 <= q1;
    end if;
end process;

ThirdRow_Input_Buffer : process(CLK)
begin
    if(falling_edge(CLK))then
        q3 <= X(0);
        q4 <= q3;
        q5 <= q4;
    end if;
end process;
    

Second_Row_Wake_up_proc :process(CLK)
begin
    if(falling_edge(CLK))then
        wake_4_temp <= not(RESET);
        wake_4 <= wake_4_temp;
    end if;
end process;

Third_Row_Wake_up_proc : process(CLK)
begin
    if(falling_edge(CLK))then
        wake_8_temp <= not(RESET);
        wake_8_temp1 <= wake_8_temp;
        wake_8 <= wake_8_temp1;
    end if;
end process;


X_0 <= q0;
X_4 <= q2;
X_8 <= q5;
wake_0 <= not(RESET);


PE0 : PE port map ( 
            CLK       => CLK,
            RESET     => RESET,
            WAKE_UP   => wake_0,
            X         => X_0,
            FLAG_IN   => "00",
            WAKE_NEXT => wake_1,
            Y         => X_1,
            FLAG_OUT  => flag_in4
            );

PE1 : PE port map ( 
            CLK       => CLK,
            RESET     => RESET,
            WAKE_UP   => wake_1,
            X         => X_1,
            FLAG_IN   => "00",
            WAKE_NEXT => wake_2,
            Y         => X_2,
            FLAG_OUT  => flag_in5
            );
            
PE2 : PE port map ( 
            CLK       => CLK,
            RESET     => RESET,
            WAKE_UP   => wake_2,
            X         => X_2,
            FLAG_IN   => "00",
            WAKE_NEXT => wake_3,
            Y         => X_3,
            FLAG_OUT  => flag_in6
            );

PE3 : PE port map ( 
            CLK       => CLK,
            RESET     => RESET,
            WAKE_UP   => wake_3,
            X         => X_3,
            FLAG_IN   => "00",
            WAKE_NEXT => open,
            Y         => open,
            FLAG_OUT  => flag_in7
            );
            
PE4 : PE port map ( 
            CLK       => CLK,
            RESET     => RESET,
            WAKE_UP   => wake_4,
            X         => X_4,
            FLAG_IN   => flag_in4,
            WAKE_NEXT => wake_5,
            Y         => X_5,
            FLAG_OUT  => flag_in8
            );
            
PE5 : PE port map ( 
            CLK       => CLK,
            RESET     => RESET,
            WAKE_UP   => wake_5,
            X         => X_5,
            FLAG_IN   => flag_in5,
            WAKE_NEXT => wake_6,
            Y         => X_6,
            FLAG_OUT  => flag_in9
            );
            
PE6 : PE port map ( 
            CLK       => CLK,
            RESET     => RESET,
            WAKE_UP   => wake_6,
            X         => X_6,
            FLAG_IN   => flag_in6,
            WAKE_NEXT => wake_7,
            Y         => X_7,
            FLAG_OUT  => flag_in10
            );
            
PE7 : PE port map ( 
            CLK       => CLK,
            RESET     => RESET,
            WAKE_UP   => wake_7,
            X         => X_7,
            FLAG_IN   => flag_in7,
            WAKE_NEXT => open,
            Y         => open,
            FLAG_OUT  => flag_in11
            );

PE8 : PE port map ( 
            CLK       => CLK,
            RESET     => RESET,
            WAKE_UP   => wake_8,
            X         => X_8,
            FLAG_IN   => flag_in8,
            WAKE_NEXT => wake_9,
            Y         => X_9,
            FLAG_OUT  => open
            );
            
PE9 : PE port map ( 
            CLK       => CLK,
            RESET     => RESET,
            WAKE_UP   => wake_9,
            X         => X_9,
            FLAG_IN   => flag_in9,
            WAKE_NEXT => wake_10,
            Y         => X_10,
            FLAG_OUT  => open
            );
            
PE10 : PE port map ( 
            CLK       => CLK,
            RESET     => RESET,
            WAKE_UP   => wake_10,
            X         => X_10,
            FLAG_IN   => flag_in10,
            WAKE_NEXT => wake_11,
            Y         => X_11,
            FLAG_OUT  => open
            );
            
PE11 : PE port map ( 
            CLK       => CLK,
            RESET     => RESET,
            WAKE_UP   => wake_11,
            X         => X_11,
            FLAG_IN   => flag_in11,
            WAKE_NEXT => open,
            Y         => open,
            FLAG_OUT  => open
            );

end Structural;
