library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity buzzerTimer is
    port (
        clock, time_input : in std_logic;
        buzzer : out std_logic
    );
end entity buzzerTimer;

architecture Behavioral of buzzerTimer is
    signal counter : integer := 0;
    constant two_seconds : integer := 100_000_000 ; -- 50MHz * 2 seconds

    signal buzzer_internal : std_logic := '0';
    signal last_time_input : std_logic := '0';
    signal timeIn_falling_edge : std_logic := '0';
begin
    process(clock)
    begin
        if rising_edge(clock) then
            if time_input = '1' and last_time_input = '0' then
                timeIn_falling_edge <= '1';  -- Detect the falling edge of timeIn
            else
                timeIn_falling_edge <= '0';
            end if;

            last_time_input <= time_input;

            if timeIn_falling_edge = '1' then
                counter <= 0;  -- Start the counter when timeIn transitions from low to high
                buzzer <= '1';  -- Turn on buzzer when timeIn transitions from low to high
            elsif counter /= two_seconds then
                counter <= counter + 1;  -- Increment counter until 2 seconds
            else
                buzzer <= '0';  -- Turn off buzzer after 2 seconds
            end if;
        end if;
    end process;

    
end Behavioral;



