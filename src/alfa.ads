------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                                 A L F A                                  --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--             Copyright (C) 2011, Free Software Foundation, Inc.           --
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

--  This package defines tables used to store information needed for the ALFA
--  mode. It is used by procedures in Lib.Xref.ALFA to build the ALFA
--  information before writing it out to the ALI file, and by Get_ALFA/Put_ALFA
--  to read and write the text form that is used in the ALI file.

with Types;      use Types;
with GNAT.Table;

package ALFA is

   --  ALFA information can exist in one of two forms. In the ALI file, it is
   --  represented using a text format that is described in this specification.
   --  Internally it is stored using three tables ALFA_Xref_Table,
   --  ALFA_Scope_Table and ALFA_File_Table, which are also defined in this
   --  unit.

   --  Lib.Xref.ALFA is part of the compiler. It extracts ALFA information from
   --  the complete set of cross-references generated during compilation.

   --  Get_ALFA reads the text lines in ALI format and populates the internal
   --  tables with corresponding information.

   --  Put_ALFA reads the internal tables and generates text lines in the ALI
   --  format.

   ---------------------
   -- ALFA ALI Format --
   ---------------------

   --  ALFA information is generated on a unit-by-unit basis in the ALI file,
   --  using lines that start with the identifying character F ("Formal").
   --  These lines are generated if one of the -gnatd.E (SPARK generation mode)
   --  or gnatd.F (Why generation mode) switches is set.

   --  The ALFA information follows the cross-reference information, so it
   --  needs not be read by tools like gnatbind, gnatmake etc.

   --  -------------------
   --  -- Scope Section --
   --  -------------------

   --  A first section defines the scopes in which entities are defined and
   --  referenced. A scope is a package/subprogram declaration/body. Note that
   --  a package declaration and body define two different scopes. Similarly, a
   --  subprogram declaration and body, when both present, define two different
   --  scopes.

   --    FD dependency-number filename

   --      This header precedes scope information for the unit identified by
   --      dependency number and file name. The dependency number is the index
   --      into the generated D lines and is ones-origin (e.g. 2 = reference to
   --      second generated D line).

   --      The list of FD lines should match the list of D lines defined in the
   --      ALI file, in the same order.

   --      Note that the filename here will reflect the original name if a
   --      Source_Reference pragma was encountered (since all line number
   --      references will be with respect to the original file).

   --      Note: the filename is redundant in that it could be deduced from the
   --      corresponding D line, but it is convenient at least for human
   --      reading of the ALFA information, and means that the ALFA information
   --      can stand on its own without needing other parts of the ALI file.

   --    FS . scope line type col entity (-> spec-file . spec-scope)?

   --      What is the ? marke here, is it part of the actual syntax, or is
   --      it a query about a problem, in which case it should be ???

   --      scope is the ones-origin scope number for the current file (e.g. 2 =
   --      reference to the second FS line in this FD block).

   --      line is the line number of the scope entity. The name of the entity
   --      starts in column col. Columns are numbered from one, and if
   --      horizontal tab characters are present, the column number is computed
   --      assuming standard 1,9,17,.. tab stops. For example, if the entity is
   --      the first token on the line, and is preceded by space-HT-space, then
   --      the column would be column 10.

   --      type is a single letter identifying the type of the entity, using
   --      the same code as in cross-references:

   --        K = package
   --        V = function
   --        U = procedure

   --      col is the column number of the scope entity

   --      entity is the name of the scope entity, with casing in the canonical
   --      casing for the source file where it is defined.

   --      spec-file and spec-scope are respectively the file and scope for the
   --      spec corresponding to the current body scope, when they differ.

   --  ------------------
   --  -- Xref Section --
   --  ------------------

   --  A second section defines cross-references useful for computing the set
   --  of global variables read/written in each subprogram/package.

   --    FX dependency-number filename . entity-number entity

   --      dependency-number and filename identity a file in FD lines

   --      entity-number and identity identify a scope entity in FS lines for
   --      the file previously identified.

   --    line typ col entity ref*

   --      line is the line number of the referenced entity

   --      typ is the type of the referenced entity, using a code similar to
   --      the one used for cross-references:

   --        > = IN parameter
   --        < = OUT parameter
   --        = = IN OUT parameter
   --        * = all other cases

   --      col is the column number of the referenced entity

   --      entity is the name of the referenced entity as written in the source
   --      file where it is defined.

   --  There may be zero or more ref entries on each line

   --    (file |)? ((. scope :)? line type col)*

   --      file is the dependency number of the file with the reference. It and
   --      the following vertical bar are omitted if the file is the same as
   --      the previous ref, and the refs for the current file are first (and
   --      do not need a bar).

   --      scope is the scope number of the scope with the reference. It and
   --      the following colon are omitted if the scope is the same as the
   --      previous ref, and the refs for the current scope are first (and do
   --      not need a colon).

   --      line is the line number of the reference

   --      col is the column number of the reference

   --      type is one of the following, using the same code as in
   --      cross-references:

   --        m = modification
   --        r = reference
   --        s = subprogram reference in a static call

   --    Examples: ??? add examples here

   ----------------
   -- Xref Table --
   ----------------

   --  The following table records ALFA cross-references

   type Xref_Index is new Int;
   --  Used to index values in this table. Values start at 1 and are assigned
   --  sequentially as entries are constructed.

   type ALFA_Xref_Record is record
      Entity_Name : String_Ptr;
      --  Pointer to entity name in ALI file

      Entity_Line : Nat;
      --  Line number for the entity referenced

      Etype : Character;
      --  Indicates type of entity, using code used in ALI file:
      --    > = IN parameter
      --    < = OUT parameter
      --    = = IN OUT parameter
      --    * = all other cases

      Entity_Col : Nat;
      --  Column number for the entity referenced

      File_Num : Nat;
      --  Set to the file dependency number for the cross-reference. Note
      --  that if no file entry is present explicitly, this is just a copy
      --  of the reference for the current cross-reference section.

      Scope_Num : Nat;
      --  Set to the scope number for the cross-reference. Note that if no
      --  scope entry is present explicitly, this is just a copy of the
      --  reference for the current cross-reference section.

      Line : Nat;
      --  Line number for the reference

      Rtype : Character;
      --  Indicates type of reference, using code used in ALI file:
      --    r = reference
      --    m = modification
      --    s = call

      Col : Nat;
      --  Column number for the reference
   end record;

   package ALFA_Xref_Table is new GNAT.Table (
     Table_Component_Type => ALFA_Xref_Record,
     Table_Index_Type     => Xref_Index,
     Table_Low_Bound      => 1,
     Table_Initial        => 2000,
     Table_Increment      => 300);

   -----------------
   -- Scope Table --
   -----------------

   --  This table keeps track of the scopes and the corresponding starting and
   --  ending indexes (From, To) in the Xref table.

   type Scope_Index is new Int;
   --  Used to index values in this table. Values start at 1 and are assigned
   --  sequentially as entries are constructed.

   type ALFA_Scope_Record is record
      Scope_Name : String_Ptr;
      --  Pointer to scope name in ALI file

      File_Num : Nat;
      --  Set to the file dependency number for the scope

      Scope_Num : Nat;
      --  Set to the scope number for the scope

      Spec_File_Num : Nat;
      --  Set to the file dependency number for the scope corresponding to the
      --  spec of the current scope entity, if different, or else 0.

      Spec_Scope_Num : Nat;
      --  Set to the scope number for the scope corresponding to the spec of
      --  the current scope entity, if different, or else 0.

      Line : Nat;
      --  Line number for the scope

      Stype : Character;
      --  Indicates type of scope, using code used in ALI file:
      --    K = package
      --    V = function
      --    U = procedure

      Col : Nat;
      --  Column number for the scope

      From_Xref : Xref_Index;
      --  Starting index in Xref table for this scope

      To_Xref : Xref_Index;
      --  Ending index in Xref table for this scope

      --  The following component is only used in-memory, not printed out in
      --  ALI file.

      Scope_Entity : Entity_Id := Empty;
      --  Entity (subprogram or package) for the scope
   end record;

   package ALFA_Scope_Table is new GNAT.Table (
     Table_Component_Type => ALFA_Scope_Record,
     Table_Index_Type     => Scope_Index,
     Table_Low_Bound      => 1,
     Table_Initial        => 200,
     Table_Increment      => 300);

   ----------------
   -- File Table --
   ----------------

   --  This table keeps track of the units and the corresponding starting and
   --  ending indexes (From, To) in the Scope table.

   type File_Index is new Int;
   --  Used to index values in this table. Values start at 1 and are assigned
   --  sequentially as entries are constructed.

   type ALFA_File_Record is record
      File_Name : String_Ptr;
      --  Pointer to file name in ALI file

      File_Num : Nat;
      --  Dependency number in ALI file

      From_Scope : Scope_Index;
      --  Starting index in Scope table for this unit

      To_Scope : Scope_Index;
      --  Ending index in Scope table for this unit
   end record;

   package ALFA_File_Table is new GNAT.Table (
     Table_Component_Type => ALFA_File_Record,
     Table_Index_Type     => File_Index,
     Table_Low_Bound      => 1,
     Table_Initial        => 20,
     Table_Increment      => 200);

   -----------------
   -- Subprograms --
   -----------------

   procedure Initialize_ALFA_Tables;
   --  Reset tables for a new compilation

   procedure dalfa;
   --  Debug routine to dump internal ALFA tables. This is a raw format dump
   --  showing exactly what the tables contain.

   procedure palfa;
   --  Debugging procedure to output contents of ALFA binary tables in the
   --  format in which they appear in an ALI file.

end ALFA;
