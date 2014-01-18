UNIT tree;

interface

	type
		PtrElementTree = ^ElementTree;

		ElementTree = record
			val: longint;
			left,right: PtrElementTree;
		end;



	procedure addElementTree(var head:PtrElementTree; Val: longint);

	procedure removeElementTree(var head: PtrElementTree; Val: longint);

	function findElementTree(var head: PtrElementTree; Val: longint):boolean;

implementation
	
	procedure addElementTree(var head:PtrElementTree; Val: longint);
	var
		newElement :PtrElementTree; 
	begin

		if (head = NIL) then
			begin
				new(newElement);
				newElement^.val 	:= Val;
				newElement^.left 	:= NIL;
				newElement^.right 	:= NIL;
				head := newElement;
			end
		else
			begin
				if val < head^.val then
					begin
						if head^.left = NIL then
							begin
								new(newElement);
								newElement^.val 	:= Val;
								newElement^.left 	:= NIL;
								newElement^.right 	:= NIL;
								head^.left 			:= newElement;
							end
						else
							addElementTree(head^.left, val);

					end
				else if val > head^.val then
					begin
						if head^.right = NIL then
							begin
								new(newElement);
								newElement^.val 	:= Val;
								newElement^.left 	:= NIL;
								newElement^.right 	:= NIL;
								head^.right 		:= newElement;
							end
						else
							addElementTree(head^.right, val);
					end;
			end;
	end;



	procedure removeElementTree(var head: PtrElementTree; Val: longint);
	var
		child, parent, temp : PtrElementTree;
	begin
		if head <> NIL then
			begin
				if head^.val = Val then
					begin
						child 	:= head;
						temp 	:= head;
						if (child^.left <> NIL) then
							begin
								parent 	:= head;
								child 	:= child^.left;

								while child^.right <> NIL do
									begin
										parent 	:= child;
										child 	:= child^.right;
									end;

								if parent = head then
									begin
										child^.right := head^.right;
										temp := head;
										head := child;

										dispose(temp);
									end
								else
									begin
										parent^.right 	:= child^.left;
										child^.right 	:= head^.right;
										child^.left 	:= head^.left;
										
										temp := head;
										head := child;

										dispose(temp);
									end;
							end
						else if (temp^.right <> NIL) then
							begin
								parent 	:= head;
								child 	:= child^.right;

								while child^.left <> NIL do
									begin
										parent 	:= child;
										child 	:= child^.left;
									end;

								if parent = head then
									begin
										child^.left := head^.left;
										temp := head;
										head := child;

										dispose(temp);
									end
								else
									begin
										parent^.left 	:= child^.right;
										child^.left 	:= head^.left;
										child^.right 	:= head^.right;

										temp := head;
										head := child;

										dispose(temp);
									end;
							end
						else
							head := NIL;
					end
				else
					begin
						if (Val < head^.val) then
							removeElementTree(head^.left,Val)
						else if (Val > head^.val) then
							removeElementTree(head^.right,Val);
					end;
			end;
	end;

	function findElementTree(var head: PtrElementTree; Val: longint):boolean;
	begin
		if head <> NIL then
		begin
			if head^.val = Val then
				findElementTree := TRUE
			else if head^.val > Val then
				findElementTree := findElementTree(head^.left, Val)
			else if head^.val < Val then
				findElementTree := findElementTree(head^.right, Val);
		end
		else
			findElementTree := FALSE;
	end;

end.