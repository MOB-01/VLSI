library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mod_n_counter is
end tb_mod_n_counter;

architecture Behavior of tb_mod_n_counter is
    component mod_n_counter
        generic ( N : integer := 4 );
        Port (
            clk   : in  STD_LOGIC;
            rst   : in  STD_LOGIC;
            count : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    signal clk   : std_logic := '0';
    signal rst   : std_logic := '0';
    signal count : std_logic_vector(3 downto 0);
    
    constant clk_period : time := 20 ns;
begin
    -- Instantiate the Mod-4 counter
    uut: mod_n_counter generic map ( N => 4 )
                       port map ( clk => clk, rst => rst, count => count );

    -- Bounded Clock Process
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus Process
    stim_proc: process
    begin
        rst <= '1'; -- Initial reset
        wait for 20 ns;
        rst <= '0'; -- Let the counter run
        
        wait for 200 ns; 
        wait; -- Stop execution
    end process;
end Behavior;