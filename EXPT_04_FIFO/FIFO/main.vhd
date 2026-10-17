library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity main is
    Port (
        d     : in  STD_LOGIC_VECTOR (3 downto 0);
        enq   : in  STD_LOGIC;
        deq   : in  STD_LOGIC;
        rst   : in  STD_LOGIC;
        clk   : in  STD_LOGIC;
        q     : out STD_LOGIC_VECTOR (3 downto 0) := "0000";
        full  : out STD_LOGIC;
        empty : out STD_LOGIC
    );
end main;

architecture Behavioral of main is
    type memory_type is array (0 to 3) of std_logic_vector(3 downto 0);
    signal memory : memory_type := (others => (others => '0'));
begin
    process (clk, rst)
        variable front : integer range 0 to 4 := 0;
        variable rear  : integer range 0 to 4 := 0;
    begin
        if rst = '1' then
            front := 0;
            rear  := 0;
            q     <= "0000";
        elsif rising_edge(clk) then
            if enq = '1' and rear /= 4 then
                memory(rear) <= d;
                rear := rear + 1;
            elsif deq = '1' and front /= 4 then
                q <= memory(front);
                front := front + 1;
            end if;
        end if;

        -- Flag logic
        if front = rear then
            empty <= '1';
            full  <= '0';
        elsif front /= 4 and rear = 4 then
            empty <= '0';
            full  <= '1';
        else
            empty <= '0';
            full  <= '0';
        end if;
    end process;
end Behavioral;