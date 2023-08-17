-- Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
-- Date        : Tue Jan 17 23:27:55 2023
-- Host        : DESKTOP-VOAD3NC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -mode funcsim -nolib -force -file {C:/Vivado Projects/ECGR
--               5146/Lab-2-FullAdder/Lab-2-FullAdder.sim/sim_1/synth/func/xsim/FullAdderSim_func_synth.vhd}
-- Design      : FullAdder
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity FullAdder is
  port (
    A : in STD_LOGIC_VECTOR ( 1 downto 0 );
    B : in STD_LOGIC_VECTOR ( 1 downto 0 );
    sum : out STD_LOGIC_VECTOR ( 1 downto 0 );
    carry : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of FullAdder : entity is true;
end FullAdder;

architecture STRUCTURE of FullAdder is
  signal A_IBUF : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal B_IBUF : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal carry_OBUF : STD_LOGIC;
  signal sum_OBUF : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of carry_OBUF_inst_i_1 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \sum_OBUF[1]_inst_i_1\ : label is "soft_lutpair0";
begin
\A_IBUF[0]_inst\: unisim.vcomponents.IBUF
     port map (
      I => A(0),
      O => A_IBUF(0)
    );
\A_IBUF[1]_inst\: unisim.vcomponents.IBUF
     port map (
      I => A(1),
      O => A_IBUF(1)
    );
\B_IBUF[0]_inst\: unisim.vcomponents.IBUF
     port map (
      I => B(0),
      O => B_IBUF(0)
    );
\B_IBUF[1]_inst\: unisim.vcomponents.IBUF
     port map (
      I => B(1),
      O => B_IBUF(1)
    );
carry_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => carry_OBUF,
      O => carry
    );
carry_OBUF_inst_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E888"
    )
        port map (
      I0 => B_IBUF(1),
      I1 => A_IBUF(1),
      I2 => A_IBUF(0),
      I3 => B_IBUF(0),
      O => carry_OBUF
    );
\sum_OBUF[0]_inst\: unisim.vcomponents.OBUF
     port map (
      I => sum_OBUF(0),
      O => sum(0)
    );
\sum_OBUF[0]_inst_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => A_IBUF(0),
      I1 => B_IBUF(0),
      O => sum_OBUF(0)
    );
\sum_OBUF[1]_inst\: unisim.vcomponents.OBUF
     port map (
      I => sum_OBUF(1),
      O => sum(1)
    );
\sum_OBUF[1]_inst_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8778"
    )
        port map (
      I0 => A_IBUF(0),
      I1 => B_IBUF(0),
      I2 => B_IBUF(1),
      I3 => A_IBUF(1),
      O => sum_OBUF(1)
    );
end STRUCTURE;
