------------------------------------------------------------------------------
--                                                                          --
--                         GNAT RUN-TIME COMPONENTS                         --
--                                                                          --
--       A D A . W I D E _ T E X T _ I O . E N U M E R A T I O N _ I O      --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--          Copyright (C) 1992-2009, Free Software Foundation, Inc.         --
--                                                                          --
-- This specification is derived from the Ada Reference Manual for use with --
-- GNAT. The copyright notice above, and the license provisions that follow --
-- apply solely to the  contents of the part following the private keyword. --
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
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

--  In Ada 95, the package Ada.Wide_Text_IO.Enumeration_IO is a subpackage
--  of Wide_Text_IO. In GNAT we make it a child package to avoid loading the
--  necessary code if Enumeration_IO is not instantiated. See the routine
--  Rtsfind.Text_IO_Kludge for a description of how we patch up the difference
--  in semantics so that it is invisible to the Ada programmer.

private generic
   type Enum is (<>);

package Ada.Wide_Text_IO.Enumeration_IO is

   Default_Width : Field := 0;
   Default_Setting : Type_Set := Upper_Case;

   procedure Get (File : File_Type; Item : out Enum);
   procedure Get (Item : out Enum);

   procedure Put
     (File  : File_Type;
      Item  : Enum;
      Width : Field := Default_Width;
      Set   : Type_Set := Default_Setting);

   procedure Put
     (Item  : Enum;
      Width : Field := Default_Width;
      Set   : Type_Set := Default_Setting);

   procedure Get
     (From : Wide_String;
      Item : out Enum;
      Last : out Positive);

   procedure Put
     (To   : out Wide_String;
      Item : Enum;
      Set  : Type_Set := Default_Setting);

end Ada.Wide_Text_IO.Enumeration_IO;
