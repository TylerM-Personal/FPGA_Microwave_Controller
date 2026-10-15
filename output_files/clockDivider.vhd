library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clockDivider is
    Port (
        clk : in  std_logic;     -- 50 MHz input clock
        rst : in  std_logic;     -- Reset signal
        div_out : out std_logic  -- 1 Hz output
    );
end clockDivider;

architecture Behavioral of clockDivider is
    constant CLOCK_FREQUENCY : integer := 25000000; 
    constant DIVIDER_VALUE : integer := CLOCK_FREQUENCY - 1; -- Divide by this value to get 1 Hz

    signal counter : integer range 0 to DIVIDER_VALUE := 0;
    signal output_tick : std_logic := '0';

begin
    process(clk, rst)
    begin
        if rst = '1' then
            counter <= 0;
            output_tick <= '0';
        elsif rising_edge(clk) then
            if counter = DIVIDER_VALUE then
                counter <= 0;
                output_tick <= not output_tick; -- Toggle output every time the counter reaches the divider value
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    div_out <= output_tick;

end Behavioral;