library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity currentState is 
	Port(start, door, stop, times : in STD_LOGIC;
	LDNbar, clock_reset, buzzer_enable: out STD_LOGIC);
end currentState;

architecture behavior of currentState is
	type state_type is (loading, cooking, finished, stopped, paused);
	signal present_state, next_state: state_type;
begin

	process(start, door, stop, times)
	
	begin 
		if(stop = '1') then  present_state <= stopped;
		elsif (door = '0' and start ='0') then present_state <= loading;
		elsif (start = '1' and door = '1' and times = '0' and stop = '0') then present_state <= cooking;
		elsif (start = '1' and door = '1' and times = '1') then present_state <= finished;
		elsif (start ='1'and door ='0' and times = '0' ) then present_state <= paused;
		end if;
	end process;
	
	process (present_state)
	begin
		case present_state is 
			
			when stopped => LDNbar <= '1'; clock_reset <= '1'; buzzer_enable <= '0'; 
			
			when loading => LDNbar <= '0'; clock_reset <= '1'; buzzer_enable <= '0'; 
			
			when cooking => LDNbar <= '1'; clock_reset <= '0'; buzzer_enable <= '0'; 
			
			when finished => LDNbar <= '1'; clock_reset <= '1'; buzzer_enable <= '1'; 
			
			when paused => LDNbar <= '1'; clock_reset <= '1'; buzzer_enable <= '0'; 
			
			when others => LDNbar <= '0'; clock_reset <= '1'; buzzer_enable <= '0'; 
			
		end case;
	end process;
	end behavior; 