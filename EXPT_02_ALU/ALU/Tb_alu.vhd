library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Tb_alu is
end Tb_alu;

architecture behavior of Tb_alu is

    -- Component Declaration
    component alu
        port(
            inp_a   : in  signed(3 downto 0);
            inp_b   : in  signed(3 downto 0);
            sel     : in  std_logic_vector(1 downto 0);
            out_alu : out signed(3 downto 0)
        );
    end component;

    -- Inputs
    signal inp_a : signed(3 downto 0) := (others => '0');
    signal inp_b : signed(3 downto 0) := (others => '0');
    signal sel   : std_logic_vector(1 downto 0) := (others => '0');

    -- Outputs
    signal out_alu : signed(3 downto 0);

begin

    -- Instantiate Unit Under Test (UUT)
    uut: alu port map (
        inp_a   => inp_a,
        inp_b   => inp_b,
        sel     => sel,
        out_alu => out_alu
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- Hold reset state
        wait for 100 ns;

        -- Apply Test Inputs
        inp_a <= "1001";
        inp_b <= "0101";

        -- Test AND operation (sel = 00)
        sel <= "00";
        wait for 100 ns;

        -- Test OR operation (sel = 01)
        sel <= "01";
        wait for 100 ns;

        -- Test ADD operation (sel = 10)
        sel <= "10";
        wait for 100 ns;

        -- Test XOR operation (sel = 11)
        sel <= "11";
        wait for 100 ns;

        wait; -- Stop process
    end process;

end behavior;