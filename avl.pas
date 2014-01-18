{*********************************************************************** 
*                                                                      * 
*      AVL.PAS                                                         * 
*                                                                      * 
*      Implements a structure and routines manipulate the balanced     * 
*      AVL tree.                                                       * 
*                                                                      * 
*      Modifications                                                   * 
*      =============                                                   * 
*                                                                      * 
***********************************************************************} 
Unit AVL ; 
  Interface 
    Uses 
      Printer ; 
  Const 
    Max_Tree_Nodes = 500 ;  { Constant is significant only if an ordered } 
                            { array of the AVL tree nodes is desired.    } 
  Type 

    BalanceSet = (Left_Tilt , Neutral , Right_Tilt) ; 

    AVLPtr = ^AVL_Tree_Rec ; 
    AVL_Tree_Rec = Record 
                     TreeData : longint ; 
                     Balance  : BalanceSet ; 
                     Left  , 
                     Right    : AVLPtr     ; 
                   End ; 

    Procedure Insert_AVLTree(Var Root : AVLPtr;X : longint ); 
    Function Search_AVLTree(Var Root       : AVLPtr     ; 
                                X          : longint  ) : Boolean ; 
    Function Search(Root : AVLPtr; X: longint):Boolean ; 

    procedure Delete_AVLTree(Var Root  : AVLPtr; X: longint );
  
  Implementation 

{*********************************************************************** 
*                                                                      * 
*      Rotate_Right                                                    * 
*                                                                      * 
*      Re-arranges tree nodes by rotating them to the right.           * 
*                                                                      * 
*      Modifications                                                   * 
*      =============                                                   * 
*                                                                      * 
***********************************************************************} 
    Procedure Rotate_Right(Var Root : AVLPtr) ; 
      Var 
        Ptr2 , 
        Ptr3   : AVLPtr ; 
      Begin  { Rotate_Right } 
        Ptr2 := Root^.Right ; 
        If Ptr2^.Balance = Right_Tilt then 
          Begin 
            Root^.Right   := Ptr2^.Left ; 
            Ptr2^.Left    := Root       ; 
            Root^.Balance := Neutral    ; 
            Root          := Ptr2       ; 
          End 
        Else 
          Begin 
            Ptr3        := Ptr2^.Left  ; 
            Ptr2^.Left  := Ptr3^.Right ; 
            Ptr3^.Right := Ptr2        ; 
            Root^.Right := Ptr3^.Left  ; 
            Ptr3^.Left  := Root        ; 
            If Ptr3^.Balance = Left_Tilt then 
              Ptr2^.Balance := Right_Tilt 
            Else 
              Ptr2^.Balance := Neutral ; 
            If Ptr3^.Balance = Right_Tilt then 
              Root^.Balance := Left_Tilt 
            Else 
              Root^.Balance := Neutral ; 
            Root := Ptr3 ; 
          End ; 
        Root^.Balance := Neutral ; 
      End ;  { Rotate_Right } 

{*********************************************************************** 
*                                                                      * 
*      Rotate_Left                                                     * 
*                                                                      * 
*      Re-arranges tree nodes by rotating them to the left.            * 
*                                                                      * 
*      Modifications                                                   * 
*      =============                                                   * 
*                                                                      * 
***********************************************************************} 
    Procedure Rotate_Left(Var Root : AVLPtr) ; 
      Var 
        Ptr2 , 
        Ptr3   : AVLPtr ; 
      Begin  { Rotate_Left } 
        Ptr2 := Root^.Left ; 
        If Ptr2^.Balance = Left_Tilt then 
          Begin 
            Root^.Left    := Ptr2^.Right; 
            Ptr2^.Right   := Root       ; 
            Root^.Balance := Neutral    ; 
            Root          := Ptr2       ; 
          End 
        Else 
          Begin 
            Ptr3        := Ptr2^.Right ; 
            Ptr2^.Right := Ptr3^.Left  ; 
            Ptr3^.Left  := Ptr2        ; 
            Root^.Left  := Ptr3^.Right ; 
            Ptr3^.Right := Root        ; 
            If Ptr3^.Balance = Right_Tilt then 
              Ptr2^.Balance := Left_Tilt 
            Else 
              Ptr2^.Balance := Neutral ; 
            If Ptr3^.Balance = Left_Tilt then 
              Root^.Balance := Right_Tilt 
            Else 
              Root^.Balance := Neutral ; 
            Root := Ptr3 ; 
          End ; 
        Root^.Balance := Neutral ; 
      End ;  { Rotate_Left } 
{.PA} 
{*********************************************************************** 
*                                                                      * 
*      Insert_AVL                                                      * 
*                                                                      * 
*      Workhouse routine to perform node insertion in an AVL tree.     * 
*                                                                      * 
*      Modifications                                                   * 
*      =============                                                   * 
*                                                                      * 
***********************************************************************} 
    Procedure Insert_AVL(Var Root: AVLPtr; X : longint; Var InsertedOK : Boolean); 
      Begin  { Insert_AVL } 
        If Root = Nil then 
          Begin 
            New(Root) ; 
            With Root^ do 
              Begin 
                TreeData := X       ; 
                Left     := Nil     ; 
                Right    := Nil     ; 
                Balance  := Neutral ; 
              End ; 
            InsertedOK := True ; 
          End 
        Else 
          If X = Root^.TreeData then 
            Begin 
              InsertedOK := False ; 
              Exit ; 
            End 
          Else 
            If X <= Root^.TreeData then 
              Begin 
                Insert_AVL(Root^.Left , X , InsertedOK) ; 
                If InsertedOK then 
                  Case Root^.Balance of 
                    Left_Tilt  : Begin 
                                   Rotate_Left(Root) ; 
                                   InsertedOK := False ; 
                                 End ; 
                    Neutral    : Root^.Balance := Left_Tilt ; 
                    Right_Tilt : Begin 
                                   Root^.Balance := Neutral ; 
                                   InsertedOK    := False   ; 
                                 End ; 
                  End ; { Case Root^.Balance of } 
              End 
            Else 
              Begin 
                Insert_AVL(Root^.Right , X , InsertedOK) ; 
                If InsertedOK then 
                  Case Root^.Balance of 
                    Left_Tilt  : Begin 
                                   Root^.Balance := Neutral ; 
                                   InsertedOk    := False   ; 
                                 End ; 
                    Neutral    : Root^.Balance := Right_Tilt ; 
                    Right_Tilt : Begin 
                                   Rotate_Right(Root) ; 
                                   InsertedOK := False ; 
                                 End ; 
                  End ;  { Case Root^.Balance of } 
              End ; 
      End ;  { Insert_AVL } 
{.PA} 
{*********************************************************************** 
*                                                                      * 
*      Insert_AVLTree                                                  * 
*                                                                      * 
*      Insert a datum into the AVL tree.                               * 
*                                                                      * 
*      Modifications                                                   * 
*      =============                                                   * 
*                                                                      * 
***********************************************************************} 
    Procedure Insert_AVLTree(Var Root : AVLPtr; X : longint); 
      Var 
        InsertedOK : Boolean ; 
      Begin  { Insert_AVLTree } 
        InsertedOK := False ; 
        Insert_AVL(Root , X , InsertedOK) ; 
      End ;  { Insert_AVLTree } 
{*********************************************************************** 
*                                                                      * 
*      Search                                                          * 
*                                                                      * 
*      Search for datum in the AVL tree.  This interface routine is    * 
*      needed because of the recursion involved in Search_AVLTree.     * 
*                                                                      * 
*      Modifications                                                   * 
*      =============                                                   * 
*                                                                      * 
***********************************************************************} 
    Function Search( Root: AVLPtr; X : longint): Boolean; 
      Begin 
        If Search_AVLTree(Root , X) then 
          Begin 
            Search := True ; 
          End 
        Else 
          Search := False ; 
      End ; 
{*********************************************************************** 
*                                                                      * 
*      Search_AVLTree                                                  * 
*                                                                      * 
*      Search for datum in the AVL tree.                               * 
*                                                                      * 
*      Modifications                                                   * 
*      =============                                                   * 
*                                                                      * 
***********************************************************************} 
    Function Search_AVLTree(Var Root: AVLPtr;X: longint):Boolean; 
      Var
        temp : AVLPtr;
      Begin  { Search_AVLTree } 
        temp := Root;
        Search_AVLTree := False ; 
        While temp <> Nil do 
          Begin 
            If X > temp^.TreeData then 
              temp := temp^.Right 
            Else 
              Begin 
                If X < temp^.TreeData then 
                  temp := temp^.Left 
                Else 
                  {                         } 
                  { A match has been found. } 
                  {                         } 
                  Begin 
                    Search_AVLTree := True ; 
                    Exit ; 
                  End ; 
              End ; 
          End ; 
      End ;  { Search_AVLTree } 
 

{*********************************************************************** 
*                                                                      * 
*      Balance_Right                                                   * 
*                                                                      * 
*      Restores the balanced/near balanced state of an AVL tree by     * 
*      rebalancing a right subtree.                                    * 
*                                                                      * 
*      Modifications                                                   * 
*      =============                                                   * 
*                                                                      * 
***********************************************************************} 
    Procedure Balance_Right(Var Root  : AVLPtr  ; 
                            Var DelOK : Boolean  ) ; 
      Var 
        Ptr2 , 
        Ptr3   : AVLPtr ; 
        Balnc2 , 
        Balnc3   : BalanceSet ; 
      Begin  { Balance_Right } 
      writeln('123');
        Case Root^.Balance of 
          Left_Tilt  : Root^.Balance := Neutral ; 
          Neutral    : Begin 
                         Root^.Balance := Right_Tilt ; 
                         DelOk := False ; 
                       End ; 
          Right_Tilt : Begin 
                         Ptr2 := Root^.Right ; 
                         Balnc2 := Ptr2^.Balance ; 
                         If not (Balnc2 = Left_Tilt) then 
                           Begin 
                             Root^.Right := Ptr2^.Left ; 
                             Ptr2^.Left := Root ; 
                             If Balnc2 = Neutral then 
                               Begin 
                                 Root^.Balance := Right_Tilt ; 
                                 Ptr2^.Balance := Left_Tilt  ; 
                                 DelOk := False ; 
                               End 
                             Else 
                               Begin 
                                 Root^.Balance := Neutral ; 
                                 Ptr2^.Balance := Neutral ; 
                               End ; 
                             Root := Ptr2 ; 
                           End 
                         Else 
                           Begin 
                             Ptr3        := Ptr2^.Left    ; 
                             Balnc3      := Ptr3^.Balance ; 
                             Ptr2^.Left  := Ptr3^.Right   ; 
                             Ptr3^.Right := Ptr2          ; 
                             Root^.Right := Ptr3^.Left    ; 
                             Ptr3^.Left  := Root          ; 
                             If Balnc3 = Left_Tilt then 
                               Ptr2^.Balance := Right_Tilt 
                             Else 
                               Ptr2^.Balance := Neutral ; 
                             If Balnc3 = Right_Tilt then 
                               Root^.Balance := Left_Tilt 
                             Else 
                               Root^.Balance := Neutral ; 
                             Root := Ptr3 ; 
                             Ptr3^.Balance := Neutral ; 
                           End ; 
                       End ; 
        End ;  { CAse Root^.Balance of } 
      End ;  { Balance_Right } 
{.PA} 
{*********************************************************************** 
*                                                                      * 
*      Balance_Left                                                    * 
*                                                                      * 
*      Restores the balanced/near balanced state of an AVL tree by     * 
*      rebalancing a left subtree.                                     * 
*                                                                      * 
*      Modifications                                                   * 
*      =============                                                   * 
*                                                                      * 
***********************************************************************} 
    Procedure Balance_Left(Var Root  : AVLPtr  ; 
                           Var DelOK : Boolean  ) ; 
      Var 
        Ptr2 , 
        Ptr3   : AVLPtr ; 
        Balnc2 , 
        Balnc3   : BalanceSet ; 
      Begin  { Balance_Left } 
        Case Root^.Balance of 
          Left_Tilt  : Root^.Balance := Neutral ; 
          Neutral    : Begin 
                         Root^.Balance := Left_Tilt ; 
                         DelOk := False ; 
                       End ; 
          Right_Tilt : Begin  { Right_Tilt } 
                         Ptr2 := Root^.Left ; 
                         Balnc2 := Ptr2^.Balance ; 
                         If not (Balnc2 = Right_Tilt) then 
                           Begin 
                             Root^.Left  := Ptr2^.Right ; 
                             Ptr2^.Right := Root        ; 
                             If Balnc2 = Neutral then 
                               Begin 
                                 Root^.Balance := Left_Tilt  ; 
                                 Ptr2^.Balance := Right_Tilt ; 
                                 DelOk := False ; 
                               End 
                             Else 
                               Begin 
                                 Root^.Balance := Neutral ; 
                                 Ptr2^.Balance := Neutral ; 
                               End ; 
                             Root := Ptr2 ; 
                           End 
                         Else 
                           Begin 
                             Ptr3        := Ptr2^.Right   ; 
                             Balnc3      := Ptr3^.Balance ; 
                             Ptr2^.Right := Ptr3^.Left    ; 
                             Ptr3^.Left  := Ptr2          ; 
                             Root^.Left  := Ptr3^.Right   ; 
                             Ptr3^.Right := Root          ; 
                             If Balnc3 = Right_Tilt then 
                               Ptr2^.Balance := Left_Tilt 
                             Else 
                               Ptr2^.Balance := Neutral ; 
                             If Balnc3 = Left_Tilt then 
                               Root^.Balance := Right_Tilt 
                             Else 
                               Root^.Balance := Neutral ; 
                             Root := Ptr3 ; 
                             Ptr3^.Balance := Neutral ; 
                           End ; 
                       End ;  { Right_Tilt } 
        End ;  { Case Root^.Balance of } 
      End ;  { Balance_Left } 
{.PA} 
{*********************************************************************** 
*                                                                      * 
*      Delete_Both_Children                                            * 
*                                                                      * 
*        Delete a node with two empty subtrees.                        * 
*                                                                      * 
*      Modifications                                                   * 
*      =============                                                   * 
*                                                                      * 
***********************************************************************} 
  Procedure Delete_Both_Children(Var Root , 
                                     Ptr    : AVLPtr  ; 
                                 Var DelOK  : Boolean  ) ; 
    Begin  { Delete_Both_Children } 
      If Ptr^.Right = Nil then 
        Begin 
          Root^.TreeData := Ptr^.TreeData ; 
          Ptr   := Ptr^.Left ; 
          DelOk := True ; 
        End 
      Else 
        Begin 
          Delete_Both_Children(Root , Ptr^.Right , DelOK) ; 
          If DelOk then 
            Balance_Left(Ptr , DelOK) ; 
        End ; 
    End ;  { Delete_Both_Children } 
{.PA} 
{*********************************************************************** 
*                                                                      * 
*      Delete_AVL                                                      * 
*                                                                      * 
*        Recursive routine used for node deletion.                     * 
*                                                                      * 
*      Modifications                                                   * 
*      =============                                                   * 
*                                                                      * 
***********************************************************************} 
    Procedure Delete_AVL(Var Root: AVLPtr;X: longint) ; 
      Var 
        child, parent, temp : AVLPtr;
      Begin  { Delete_AVL } 
        if Root <> NIL then
        begin
          if Root^.TreeData = X then
            begin
              child   := Root;
              temp    := Root;
              if (child^.left <> NIL) then
                begin
                  parent  := Root;
                  child   := child^.left;

                  while child^.right <> NIL do
                    begin
                      parent  := child;
                      child   := child^.right;
                    end;

                  if parent = Root then
                    begin
                      child^.right := Root^.right;
                      temp := Root;
                      Root := child;

                      dispose(temp);
                    end
                  else
                    begin
                      parent^.right   := child^.left;
                      child^.right  := Root^.right;
                      child^.left   := Root^.left;
                      
                      temp := Root;
                      Root := child;

                      dispose(temp);
                    end;
                end
              else if (temp^.right <> NIL) then
                begin
                  parent  := Root;
                  child   := child^.right;

                  while child^.left <> NIL do
                    begin
                      parent  := child;
                      child   := child^.left;
                    end;

                  if parent = Root then
                    begin
                      child^.left := Root^.left;
                      temp := Root;
                      Root := child;

                      dispose(temp);
                    end
                  else
                    begin
                      parent^.left  := child^.right;
                      child^.left   := Root^.left;
                      child^.right  := Root^.right;

                      temp := Root;
                      Root := child;

                      dispose(temp);
                    end;
                end
              else
                Root := NIL;
            end
          else
            begin
              if (X < Root^.TreeData) then
                Delete_AVL(Root^.left,X)
              else if (X > Root^.TreeData) then
                Delete_AVL(Root^.right,X);
            end;
        end;

      End ;  { Delete_AVL } 
{.PA} 
{*********************************************************************** 
*                                                                      * 
*      Delete_AVLTree                                                  * 
*                                                                      * 
*      Deletes the key of X if it is present in the AVL tree.          * 
*                                                                      * 
*      Modifications                                                   * 
*      =============                                                   * 
*                                                                      * 
***********************************************************************} 
    Procedure Delete_AVLTree(Var Root  : AVLPtr; X: longint );
      Begin  { Delete_AVLTree }  
        Delete_AVL(Root , X) ; 
      End ;  { Delete_AVLTree } 

end.