
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity WE_REG is
Port (
    CLK     :   in  std_logic;
    RESET   :   in  std_logic;
    WE      :   in  std_logic;
    Din     :   in  std_logic;
    Dout    :   out std_logic 
    );
end WE_REG;

architecture Behavioral of WE_REG is

begin
    process(CLK)
    begin
        if(falling_edge(CLK))then
            if(RESET = '1')then Dout <= '0';  
            elsif(WE = '1')then Dout <= Din;
            end if;
        end if;     
    end process; 
end Behavioral;
