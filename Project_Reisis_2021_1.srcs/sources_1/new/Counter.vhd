library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter is
Port (
    CLK     :   in  std_logic;
    RESET   :   in  std_logic;
    SET     :   in  std_logic;
    C_OUT   :   out std_logic_vector (2 downto 0)
    );
end Counter;

architecture Behavioral of Counter is

signal temp : unsigned(2 downto 0) := "000";
begin
process(CLK)
begin
    if(falling_edge(CLK))then
        if(RESET = '1')then
            temp <= "000";
        else
            if(SET = '1')then
                temp <= temp +1;
            else
                null;
            end if;
        end if;
     end if;
 end process;

C_OUT <= std_logic_vector(temp);

end Behavioral;
