------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                                 S C O S                                  --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--          Copyright (C) 2009-2011, Free Software Foundation, Inc.         --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License --
-- for  more details.  You should have  received  a copy of the GNU General --
-- Public License  distributed with GNAT; see file COPYING3.  If not, go to --
-- http://www.gnu.org/licenses for a complete copy of the license.          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

package body SCOs is

   -------------
   -- Add_SCO --
   -------------

   procedure Add_SCO
     (From        : Source_Location := No_Source_Location;
      To          : Source_Location := No_Source_Location;
      C1          : Character       := ' ';
      C2          : Character       := ' ';
      Last        : Boolean         := False;
      Pragma_Sloc : Source_Ptr      := No_Location)
   is
   begin
      SCO_Table.Append ((From, To, C1, C2, Last, Pragma_Sloc));
   end Add_SCO;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize is
   begin
      SCO_Table.Init;
      SCO_Unit_Table.Init;

      --  Set dummy zeroth entry for sort routine, real entries start at 1

      SCO_Unit_Table.Increment_Last;
   end Initialize;

end SCOs;
