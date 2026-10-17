library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UniversalShiftReg_tb is
-- Testbench entity has no ports
end UniversalShiftReg_tb;

architecture Behavioral of UniversalShiftReg_tb is

    -- Component Declaration
    component UniversalShiftReg
        Port (
            clk          : in  STD_LOGIC;
            reset        : in  STD_LOGIC;
            sel          : in  STD_LOGIC_VECTOR (1 downto 0);
            serial_in    : in  STD_LOGIC;
            parallel_in  : in  STD_LOGIC_VECTOR (3 downto 0);
            serial_out   : out STD_LOGIC;
            parallel_out : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    -- Testbench Signals
    signal clk          : STD_LOGIC := '0';
    signal reset        : STD_LOGIC := '0';
    signal sel          : STD_LOGIC_VECTOR (1 downto 0) := "00";
    signal serial_in    : STD_LOGIC := '0';
    signal parallel_in  : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal serial_out   : STD_LOGIC;
    signal parallel_out : STD_LOGIC_VECTOR (3 downto 0);

    -- Clock Period Definition
    constant clk_period : time := 10 ns;

begin

    -- Instantiate Unit Under Test (UUT)
    uut: UniversalShiftReg
        port map (
            clk          => clk,
            reset        => reset,
            sel          => sel,
            serial_in    => serial_in,
            parallel_in  => parallel_in,
            serial_out   => serial_out,
            parallel_out => parallel_out
        );

    -- Clock Generation Process
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Stimulus Process
    stim_proc: process
    begin
        -- Apply Reset
        reset <= '1';
        wait for clk_period;
        reset <= '0';

        -- Mode "00" - SISO: Serial In, Serial Out
        sel <= "00";
        serial_in <= '1'; wait for clk_period;
        serial_in <= '0'; wait for clk_period;
        serial_in <= '1'; wait for clk_period;
        serial_in <= '1'; wait for clk_period;
        serial_in <= '0'; wait for clk_period;

        -- Mode "01" - SIPO: Serial In, Parallel Out
        sel <= "01";
        serial_in <= '1'; wait for clk_period;
        serial_in <= '0'; wait for clk_period;
        serial_in <= '1'; wait for clk_period;
        serial_in <= '1'; wait for clk_period;

        -- Mode "10" - PISO: Parallel In, Serial Out
        sel <= "10";
        parallel_in <= "1010";
        wait for clk_period;
        
        -- Shift out bits serially
        sel <= "00";
        wait for clk_period * 4;

        -- Mode "11" - PIPO: Parallel In, Parallel Out
        sel <= "11";
        parallel_in <= "1100";
        wait for clk_period;

        -- End Simulation
        wait for 20 ns;
        assert false report "Simulation End" severity failure;
        wait;
    end process;

end Behavioral;