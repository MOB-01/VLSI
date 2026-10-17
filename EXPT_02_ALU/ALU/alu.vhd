library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu is
    Port (
        inp_a   : in  signed(3 downto 0);
        inp_b   : in  signed(3 downto 0);
        sel     : in  std_logic_vector(1 downto 0);
        out_alu : out signed(3 downto 0)
    );
end alu;

architecture Behavioral of alu is
begin
    process(inp_a, inp_b, sel)
    begin
        case sel is
            when "00" =>
                out_alu <= inp_a and inp_b; -- Bitwise AND
            when "01" =>
                out_alu <= inp_a or inp_b;  -- Bitwise OR
            when "10" =>
                out_alu <= inp_a + inp_b;   -- Addition
            when "11" =>
                out_alu <= inp_a xor inp_b; -- Bitwise XOR
            when others =>
                out_alu <= (others => '0');
        end case;
    end process;
end Behavioral;