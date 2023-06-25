library ieee;
use ieee.std_logic_1164.all;

entity UlaMips is
    port (
        clk   : in std_logic;
        iniciar : in std_logic;
        reset: in std_logic;
        UlaOp: in std_logic_vector(1 downto 0);
        funct: in std_logic_vector(5 downto 0);
        a: in std_logic_vector(31 downto 0);
        b: in std_logic_vector(31 downto 0);
        c: out std_logic_vector(31 downto 0)
    );
end entity;

architecture rtl of UlaMips is
    component registrador is
        PORT(CLK, r: IN std_logic;
            data: IN std_logic_vector(31 DOWNTO 0);
            q: OUT std_logic_vector(31 DOWNTO 0)
        );
    end component;

    component ula is
        PORT(
            sel: in std_logic_vector(2 downto 0);
            dataA, dataB: in std_logic_vector(31 downto 0);
            resultado: out std_logic_vector(31 downto 0)
        );
    end component;

    component Controle is
        PORT(
            funct: in std_logic_vector(5 downto 0);
            ULAOp: in std_logic_vector(1 downto 0);
            sel: out std_logic_vector(2 downto 0)
        );
    end component;

    signal sel: std_logic_vector(2 downto 0);
    signal regA_to_ula: std_logic_vector(31 downto 0);
    signal regB_to_ula: std_logic_vector(31 downto 0);
    signal ula_to_regC: std_logic_vector(31 downto 0);

begin
    RegA: registrador
        port map(
            CLK => clk,
            r => reset,
            data => a,
            q => regA_to_ula
        );
    RegB: registrador
        port map(
            CLK => clk,
            r => reset,
            data => b,
            q => regB_to_ula
        );
    RegC: registrador
        port map(
            CLK => clk,
            r => reset,
            data => ula_to_regC,
            q => c
        );
    ULA_IMPL: ula
        port map(
            sel => sel,
            dataA => regA_to_ula,
            dataB => regB_to_ula,
            resultado => ula_to_regC
        );
    Ctrl_ULA: Controle
        port map(
            funct => funct,
            ULAOp => ULAOp,
            sel => sel
        );

end architecture;