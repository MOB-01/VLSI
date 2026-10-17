library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mod_n_counter is
    generic ( N : integer := 4 ); -- Objective: Mod 4 counter
    Port (
        clk   : in  STD_LOGIC;
        rst   : in  STD_LOGIC;
        count : out STD_LOGIC_VECTOR (3 downto 0) -- 4-bit output as per theory
    );
end mod_n_counter;

architecture Behavioral of mod_n_counter is
    signal temp_count : STD_LOGIC_VECTOR(3 downto 0) := "0000";
begin
    process(clk, rst)
    begin
        if rst = '1' then
            temp_count <= "0000";
        elsif rising_edge(clk) then
            -- Resets the counter when it reaches N-1 (e.g., 3 for Mod-4)
            if temp_count = N-1 then
                temp_count <= "0000";
            else
                temp_count <= temp_count + 1;
            end if;
        end if;
    end process;
    
    count <= temp_count;
end Behavioral;