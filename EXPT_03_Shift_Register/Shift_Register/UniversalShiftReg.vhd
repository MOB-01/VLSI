library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UniversalShiftReg is
    Port (
        clk          : in  STD_LOGIC;
        reset        : in  STD_LOGIC;
        sel          : in  STD_LOGIC_VECTOR (1 downto 0);
        serial_in    : in  STD_LOGIC;
        parallel_in  : in  STD_LOGIC_VECTOR (3 downto 0);
        serial_out   : out STD_LOGIC;
        parallel_out : out STD_LOGIC_VECTOR (3 downto 0)
    );
end UniversalShiftReg;

architecture Behavioral of UniversalShiftReg is
    signal reg : STD_LOGIC_VECTOR (3 downto 0) := "0000";
begin
    process(clk, reset)
    begin
        if reset = '1' then
            reg <= (others => '0');
        elsif rising_edge(clk) then
            case sel is
                when "00" => -- Mode "00": SISO (Serial In, Serial Out)
                    reg <= serial_in & reg(3 downto 1);
                
                when "01" => -- Mode "01": SIPO (Serial In, Parallel Out)
                    reg <= serial_in & reg(3 downto 1);
                
                when "10" => -- Mode "10": PISO (Parallel In, Serial Out)
                    reg <= parallel_in;
                
                when "11" => -- Mode "11": PIPO (Parallel In, Parallel Out)
                    reg <= parallel_in;
                
                when others =>
                    reg <= reg;
            end case;
        end if;
    end process;

    -- Output Assignments
    serial_out   <= reg(0); -- LSB as serial output
    parallel_out <= reg;
end Behavioral;