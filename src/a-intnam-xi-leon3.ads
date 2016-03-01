------------------------------------------------------------------------------
--                                                                          --
--                  GNAT RUN-TIME LIBRARY (GNARL) COMPONENTS                --
--                                                                          --
--                   A D A . I N T E R R U P T S . N A M E S                --
--                                                                          --
--                                  S p e c                                 --
--                                                                          --
--          Copyright (C) 1991-2010, Free Software Foundation, Inc.         --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNARL was developed by the GNARL team at Florida State University.       --
-- Extensive contributions were provided by Ada Core Technologies, Inc.     --
--                                                                          --
------------------------------------------------------------------------------

--  This is the version for LEON3 UT699 targets

package Ada.Interrupts.Names is

   Internal_Bus_Error_Interrupt      : constant Interrupt_ID :=  1;
   UART_RX_TX_Interrupt              : constant Interrupt_ID :=  2;
   PCI_Interrupt                     : constant Interrupt_ID :=  3;
   CAN_1_Interrupt                   : constant Interrupt_ID :=  4;
   CAN_2_Interrupt                   : constant Interrupt_ID :=  5;
   General_Purpose_Timer_1_Interrupt : constant Interrupt_ID :=  6;
   General_Purpose_Timer_2_Interrupt : constant Interrupt_ID :=  7;
   General_Purpose_Timer_3_Interrupt : constant Interrupt_ID :=  8;
   General_Purpose_Timer_4_Interrupt : constant Interrupt_ID :=  9;
   SPW_1_RX_TX_Interrupt             : constant Interrupt_ID := 10;
   SPW_2_RX_TX_Interrupt             : constant Interrupt_ID := 11;
   SPW_3_RX_TX_Interrupt             : constant Interrupt_ID := 12;
   SPW_4_RX_TX_Interrupt             : constant Interrupt_ID := 13;
   ETH_RX_TX_Interrupt               : constant Interrupt_ID := 14;

   General_Purpose_IO_1_Interrupt    : constant Interrupt_ID :=  1;
   General_Purpose_IO_2_Interrupt    : constant Interrupt_ID :=  2;
   General_Purpose_IO_3_Interrupt    : constant Interrupt_ID :=  3;
   General_Purpose_IO_4_Interrupt    : constant Interrupt_ID :=  4;
   General_Purpose_IO_5_Interrupt    : constant Interrupt_ID :=  5;
   General_Purpose_IO_6_Interrupt    : constant Interrupt_ID :=  6;
   General_Purpose_IO_7_Interrupt    : constant Interrupt_ID :=  7;
   General_Purpose_IO_8_Interrupt    : constant Interrupt_ID :=  8;
   General_Purpose_IO_9_Interrupt    : constant Interrupt_ID :=  9;
   General_Purpose_IO_10_Interrupt   : constant Interrupt_ID := 10;
   General_Purpose_IO_11_Interrupt   : constant Interrupt_ID := 11;
   General_Purpose_IO_12_Interrupt   : constant Interrupt_ID := 12;
   General_Purpose_IO_13_Interrupt   : constant Interrupt_ID := 13;
   General_Purpose_IO_14_Interrupt   : constant Interrupt_ID := 14;
   General_Purpose_IO_15_Interrupt   : constant Interrupt_ID := 15;

end Ada.Interrupts.Names;
