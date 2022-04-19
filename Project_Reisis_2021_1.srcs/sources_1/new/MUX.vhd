library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MUX is
Port (
    A    :  in  std_logic;
    B    :  in  std_logic;
    C    :  in  std_logic;
    SEL  :  in  std_logic_vector(1 downto 0);
    Y    :  out std_logic
    );
end MUX;

architecture Behavioral of MUX is

begin

    process (A, B, C, SEL)
    begin
        if(SEL = "00")then  -- FLAG IN EQUAL
            Y <= A;
        elsif(SEL = "01")then -- FLAG IN LEFT
            Y <= B;
        elsif(SEL = "10")then -- FLAG IN RIGHT
            Y <= C;
        else
            Y <= '0';
        end if;
    end process;
            
end Behavioral;
