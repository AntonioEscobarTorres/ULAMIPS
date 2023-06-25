library ieee;
use ieee.std_logic_1164.all;

entity Controle is
	port(
        funct: in std_logic_vector(5 downto 0);
        ULAOp: in std_logic_vector(1 downto 0);
        sel: out std_logic_vector(2 downto 0)
	);
end entity;

architecture comportamento of Controle is
begin
    sel <= 
        "000" when Funct = "100100" else "001" when Funct = "100101" else 
        "010" when ULAOp = "00" or (ULAOp = "10" and Funct = "100000") else
        "110" when ULAOp = "01" or (ULAOp = "10" and Funct = "100010") else
        "111";
end architecture;