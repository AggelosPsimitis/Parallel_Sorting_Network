library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity COMP is
Port (
    RESET   :   in  std_logic;
    CLK     :   in  std_logic;
    Enable  :   in  std_logic;
    C1_in   :   in  std_logic;
    C2_in   :   in  std_logic;
    C_max   :   out std_logic;
    C_min   :   out std_logic;
    Comp_flag : out std_logic_vector(1 downto 0)
    );
end COMP;

architecture Behavioral of COMP is

begin
    process(RESET, Enable, C1_in, C2_in)
    begin
            if(RESET = '1')then
                C_max <= '0';
                C_min <= '0';
                Comp_flag <= "11";
            elsif(Enable = '1')then
                if(C1_in > C2_in)then
                    C_max <= C1_in;
                    C_min <= C2_in;
                    Comp_flag <= "01";
                elsif(C1_in = C2_in) then
                    C_max <= C1_in;
                    C_min <= C2_in;
                    Comp_flag <= "00";
                else
                    C_max <= C2_in;
                    C_min <= C1_in;
                    Comp_flag <= "10";
                end if;
            end if;
    end process;
           
end Behavioral;
