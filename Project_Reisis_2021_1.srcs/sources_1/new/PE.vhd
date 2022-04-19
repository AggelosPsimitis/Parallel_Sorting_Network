library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity PE is
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
end PE;

architecture Structural of PE is

component WE_REG
Port(
    CLK     :   in  std_logic;
    RESET   :   in  std_logic;
    WE      :   in  std_logic;
    Din     :   in  std_logic;
    Dout    :   out std_logic
    );
end component;

component COMP
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
  end component;
  
component MUX
    Port(
      A    :  in  std_logic;
      B    :  in  std_logic;
      C    :  in  std_logic;
      SEL  :  in  std_logic_vector(1 downto 0);
      Y    :  out std_logic
      );
end component;

component Counter 
Port (
    CLK     :   in  std_logic;
    RESET   :   in  std_logic;
    SET     :   in  std_logic;
    C_OUT   :   out std_logic_vector (2 downto 0)
    );
end component;

component FSM 
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
end component;


signal Write_Reg_sig, RegIn_sig, RegOut_sig, X_sig, X_sig_Delayed, Y_sig : std_logic := '0';
signal Comp_Max_sig, Comp_Min_sig : std_logic := '0';
signal Mux_Sel_sig : std_logic_vector(1 downto 0):= "00";
signal Equal_Case_Flag_sig : std_logic_vector(1 downto 0) := "00";
signal Compare_Enable_sig : std_logic := '0';
signal Counter_sig : std_logic_vector(2 downto 0) := "000";
signal Counter_enable_sig : std_logic := '0';

begin

    COMP_inst: COMP port map( 
                       RESET     => RESET,
                       CLK       => CLK,
                       Enable    => Compare_Enable_sig,
                       C1_in     => X_sig_Delayed,
                       C2_in     => RegOut_sig,
                       C_max     => Comp_Max_sig,
                       C_min     => Comp_Min_sig, 
                       Comp_flag => Equal_Case_Flag_sig
                       );
    
    WE_REG_inst : WE_REG port map(
                        CLK   => CLK,
                        RESET => RESET,
                        WE    => Write_reg_sig,
                        Din   => RegIn_sig,
                        Dout  => RegOut_sig
                        );

    MUXOUT_inst : MUX port map(
                        A   => Comp_Max_sig ,
                        B   => X_sig_Delayed,
                        C   => RegOut_sig,
                        SEL => mux_sel_sig,
                        Y   => Y_sig
                        );  
                        
    MUXREG_inst : MUX port map(
                        A   => Comp_Min_sig,
                        B   => RegOut_sig,
                        C   => X_sig_Delayed,
                        SEL => Mux_Sel_sig,
                        Y   => RegIn_sig
                        );
                           
    Couter_inst : Counter port map(
                        CLK   => CLK,
                        RESET => RESET,
                        SET   => Counter_enable_sig,
                        C_out => Counter_sig
                        );
      
    FSM_inst : FSM port map(
                    CLK             =>  CLK,
                    RESET           =>  RESET,
                    FLAG_IN         => FLAG_IN,
                    WAKE_UP         => WAKE_UP,
                    COUNTER_OUT     => Counter_sig,
                    EQUAL_CASE_FLAG => equal_case_flag_sig,
                    FLAG_OUT        => FLAG_OUT,
                    WAKE_NEXT       => WAKE_NEXT,
                    WRITE_REG       => Write_Reg_sig,
                    COUNTER_ENABLE  => Counter_enable_sig,
                    MUX_SEL         => Mux_Sel_sig,
                    COMPARE_ENABLE  => Compare_Enable_sig
                    );
                    
   INREG: process(CLK)
   begin
        if(falling_edge(CLK))then
            if(RESET = '1')then
                X_sig_Delayed <= '0';
            else
                X_sig_delayed <= X;
            end if;
        end if;
   end process;      

   Y <= Y_sig;

end Structural;
