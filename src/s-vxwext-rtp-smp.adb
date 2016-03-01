------------------------------------------------------------------------------
--                                                                          --
--                  GNAT RUN-TIME LIBRARY (GNARL) COMPONENTS                --
--                                                                          --
--                     S Y S T E M . V X W O R K S . E X T                  --
--                                                                          --
--                                   B o d y                                --
--                                                                          --
--            Copyright (C) 2008-2010, Free Software Foundation, Inc.       --
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
------------------------------------------------------------------------------

--  This package provides VxWorks specific support functions needed
--  by System.OS_Interface.

--  This is the VxWorks 6 RTP/SMP version of this package

package body System.VxWorks.Ext is

   ERROR : constant := -1;

   --------------
   -- Int_Lock --
   --------------

   function Int_Lock return int is
   begin
      return ERROR;
   end Int_Lock;

   ----------------
   -- Int_Unlock --
   ----------------

   function Int_Unlock return int is
   begin
      return ERROR;
   end Int_Unlock;

   -----------------------
   -- Interrupt_Connect --
   -----------------------

   function Interrupt_Connect
     (Vector    : Interrupt_Vector;
      Handler   : Interrupt_Handler;
      Parameter : System.Address := System.Null_Address) return int
   is
      pragma Unreferenced (Vector, Handler, Parameter);
   begin
      return ERROR;
   end Interrupt_Connect;

   -----------------------
   -- Interrupt_Context --
   -----------------------

   function Interrupt_Context return int is
   begin
      --  For RTPs, never in an interrupt context

      return 0;
   end Interrupt_Context;

   --------------------------------
   -- Interrupt_Number_To_Vector --
   --------------------------------

   function Interrupt_Number_To_Vector
     (intNum : int) return Interrupt_Vector
   is
      pragma Unreferenced (intNum);
   begin
      return 0;
   end Interrupt_Number_To_Vector;

   ---------------
   -- semDelete --
   ---------------

   function semDelete (Sem : SEM_ID) return int is
      function OS_semDelete (Sem : SEM_ID) return int;
      pragma Import (C, OS_semDelete, "semDelete");
   begin
      return OS_semDelete (Sem);
   end semDelete;

   --------------------
   -- Set_Time_Slice --
   --------------------

   function Set_Time_Slice (ticks : int) return int is
      pragma Unreferenced (ticks);
   begin
      return ERROR;
   end Set_Time_Slice;

   ------------------------
   -- taskCpuAffinitySet --
   ------------------------

   function taskCpuAffinitySet (tid : t_id; CPU : int) return int
   is
      function Set_Affinity (tid : t_id; CPU : int) return int;
      pragma Import (C, Set_Affinity, "__gnat_set_affinity");
   begin
      return Set_Affinity (tid, CPU);
   end taskCpuAffinitySet;

end System.VxWorks.Ext;
