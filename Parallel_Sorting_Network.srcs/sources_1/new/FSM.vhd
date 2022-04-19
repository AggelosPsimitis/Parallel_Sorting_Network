library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity FSM is
Port ( 
    CLK             :   in  std_logic;
    RESET           :   in  std_logic;
    FLAG_IN         :   in  std_logic_vector(1 downto 0);
    WAKE_UP         :   in  std_logic;
    COUNTER_OUT     :   in  std_logic_vector(2 downto 0);
    EQUAL_CASE_FLAG :   in  std_logic_vector(1 downto 0);
    FLAG_OUT        :   out std_logic_vector(1 downto 0);
    WAKE_NEXT       :   out std_logic;
    WRITE_REG       :   out std_logic;
    COUNTER_ENABLE  :   out std_logic;
    MUX_SEL         :   out std_logic_vector(1 downto 0);
    COMPARE_ENABLE  :   out std_logic
    );
end FSM;

architecture Behavioral of FSM is

type FSM_STATES is (IDLE, EQUAL, LEFT, RIGHT, CLOSED);
signal current_state, next_state : FSM_STATES;
signal FLAG_IN_SIG : std_logic_vector(1 downto 0) := "00";
signal WAKE_UP_SIG : std_logic := '0';
signal COUNTER_OUT_SIG : std_logic_vector(2 downto 0) := "000";
signal EQUAL_CASE_FLAG_sig : std_logic_vector(1 downto 0) := "00";

begin
    
    FLAG_IN_SIG <= FLAG_IN;
    WAKE_UP_SIG <= WAKE_UP;
    COUNTER_OUT_SIG <= COUNTER_OUT;
    EQUAL_CASE_FLAG_SIG <= EQUAL_CASE_FLAG;
    
    SYNC_PROC : process(CLK)
    begin
        if(falling_edge(CLK))then
            if(RESET = '1')then 
                current_state <= CLOSED;
            else 
                current_state <= next_state;
            end if;
        end if;
    end process;

    ASYNC_PROC : process(current_state, FLAG_IN_SIG, WAKE_UP_SIG, COUNTER_OUT_SIG, EQUAL_CASE_FLAG_SIG)
    begin
        next_state <= CLOSED;
        case current_state is
            when CLOSED =>
                FLAG_OUT <= "11";
                WRITE_REG <= '0';
                COUNTER_ENABLE <= '0';
                MUX_SEL <= "11";
                COMPARE_ENABLE <= '0';
                WAKE_NEXT <= '0';
                if(WAKE_UP_SIG = '1' and COUNTER_OUT_SIG = "000")then
                    next_state <= IDLE;
                else
                    next_state <= CLOSED;
                end if;
             when IDLE => 
                FLAG_OUT  <= "11";
                WRITE_REG <= '1';
                COUNTER_ENABLE <= '1';
                MUX_SEL <= "10";
                COMPARE_ENABLE <= '0';
                WAKE_NEXT <= '0';
                if(FLAG_IN_SIG = "00" and WAKE_UP = '1')then
                    next_state <= EQUAL;
                elsif(FLAG_IN_SIG = "01" and WAKE_UP = '1')then
                    next_state <= LEFT;
                elsif(FLAG_IN_SIG = "10" and WAKE_UP = '1')then
                    next_state <= RIGHT;
                else
                    next_state <= CLOSED;
                end if;
             when EQUAL =>
                FLAG_OUT  <= EQUAL_CASE_FLAG_SIG;
                WRITE_REG <= '1';
                COUNTER_ENABLE <= '1';
                MUX_SEL <= "00";
                COMPARE_ENABLE <= '1';
                WAKE_NEXT <= '1';
                if(COUNTER_OUT_SIG = "011")then
                    next_state <= CLOSED;
                else
                    if(FLAG_IN_SIG = "00" and WAKE_UP = '1')then
                        next_state <= EQUAL;
                    elsif(FLAG_IN_SIG = "01" and WAKE_UP = '1')then
                        next_state <= LEFT;
                    elsif(FLAG_IN_SIG = "10" and WAKE_UP = '1')then
                        next_state <= RIGHT;
                    else
                        next_state <= CLOSED;
                    end if;
                end if;
             when LEFT =>
                FLAG_OUT <= "01";
                WRITE_REG <= '0';
                COUNTER_ENABLE <= '1';
                MUX_SEL <= "01";
                COMPARE_ENABLE <= '0';
                WAKE_NEXT <= '1';
                if(COUNTER_OUT_SIG = "011")then
                    next_state <= CLOSED;
                else
                    if(FLAG_IN_SIG = "00" and WAKE_UP = '1')then
                        next_state <= EQUAL;
                    elsif(FLAG_IN_SIG = "01" and WAKE_UP = '1')then
                        next_state <= LEFT;
                    elsif(FLAG_IN_SIG = "10" and WAKE_UP = '1')then
                        next_state <= RIGHT;
                    else
                        next_state <= CLOSED;
                    end if;
                end if;
             when RIGHT =>
                FLAG_OUT <= "10";
                WRITE_REG <= '1';
                COUNTER_ENABLE <= '1';
                MUX_SEL <= "10";
                COMPARE_ENABLE <= '0';
                WAKE_NEXT <= '1';
                if(COUNTER_OUT_SIG = "011")then
                    next_state <= CLOSED;
                else
                    if(FLAG_IN_SIG = "00" and WAKE_UP = '1')then
                        next_state <= EQUAL;
                    elsif(FLAG_IN_SIG = "01" and WAKE_UP = '1')then
                        next_state <= LEFT;
                    elsif(FLAG_IN_SIG = "10" and WAKE_UP = '1')then
                        next_state <= RIGHT;
                    else
                        next_state <= CLOSED;
                    end if;
                end if;
             when others =>
                next_state <= CLOSED;
             end case;
    end process;     
                
                  
                
end Behavioral;
