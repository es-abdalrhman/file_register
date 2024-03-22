library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegisterFile is
    Port ( clk : in STD_LOGIC;                         -- Clock input
           regWrite : in STD_LOGIC;                    -- RegWrite control line
           readReg1 : in STD_LOGIC_VECTOR(4 downto 0); -- First register number for reading
           readReg2 : in STD_LOGIC_VECTOR(4 downto 0); -- Second register number for reading
           writeReg : in STD_LOGIC_VECTOR(4 downto 0); -- Register number for writing
           writeData : in STD_LOGIC_VECTOR(31 downto 0); -- Data to be written
           dataOut1 : out STD_LOGIC_VECTOR(31 downto 0); -- Output of read register 1
           dataOut2 : out STD_LOGIC_VECTOR(31 downto 0)); -- Output of read register 2
end RegisterFile;

architecture Behavioral of RegisterFile is
    type reg_array is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0); -- Array to hold 32 registers
    signal registers : reg_array := (others => (others => '0')); -- Initialize registers with all zeros

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if regWrite = '1' then
                registers(conv_integer(writeReg)) <= writeData; -- Write data to specified register
            end if;
        end if;
    end process;

    -- Output the data from the specified read registers
    dataOut1 <= registers(conv_integer(readReg1));
    dataOut2 <= registers(conv_integer(readReg2));

end Behavioral;

