library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegisterFile_tb is
end RegisterFile_tb;

architecture Behavioral of RegisterFile_tb is
    -- Constants
    constant CLK_PERIOD : time := 10 ns; -- Clock period

    -- Signals
    signal clk : std_logic := '0';                         -- Clock signal
    signal regWrite : std_logic := '0';                    -- RegWrite control line
    signal readReg1, readReg2, writeReg : std_logic_vector(4 downto 0) := "00000"; -- Register numbers
    signal writeData : std_logic_vector(31 downto 0) := (others => '0'); -- Data to be written
    signal dataOut1, dataOut2 : std_logic_vector(31 downto 0); -- Output data from registers

begin
    -- Instantiate the register file module
    UUT : entity work.RegisterFile
        port map (
            clk => clk,
            regWrite => regWrite,
            readReg1 => readReg1,
            readReg2 => readReg2,
            writeReg => writeReg,
            writeData => writeData,
            dataOut1 => dataOut1,
            dataOut2 => dataOut2
        );

    -- Clock process
    clk_process: process
    begin
        while now < 100 ns loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stimulus_process: process
    begin
        -- Write data to register 5 (RegWrite = 1)
        wait for 10 ns;
        regWrite <= '1';
        writeReg <= "00101"; -- Register number 5
        writeData <= "11111111111111111111111111111111"; -- Data to be written
        wait for CLK_PERIOD;
        regWrite <= '0';
        writeReg <= (others => '0');
        writeData <= (others => '0');

        -- Read data from registers 0 and 1 (RegWrite = 0)
        wait for 10 ns;
        regWrite <= '0';
        readReg1 <= "00000"; -- Register number 0
        readReg2 <= "00101"; -- Register number 5
        wait for CLK_PERIOD;

        -- Write and Read from the same register (RegWrite = 1)
        wait for 10 ns;
        regWrite <= '1';
        writeReg <= "00010"; -- Register number 2
        writeData <= "10101010101010101010101010101010"; -- Data to be written
        readReg1 <= "00010"; -- Register number 2
        readReg2 <= "00010"; -- Register number 2
        wait for CLK_PERIOD;
        regWrite <= '0';
        writeReg <= (others => '0');
        writeData <= (others => '0');

        -- Read from the same registers (RegWrite = 0)
        wait for 10 ns;
        regWrite <= '0';
        readReg1 <= "00010"; -- Register number 2
        readReg2 <= "00010"; -- Register number 2
        wait for CLK_PERIOD;

        wait;
    end process;

end Behavioral;
