UNIT listsBidirectional;

{**
 *  List bidirectional (with sort from min to max value)
 *	
 *	List is balanced ( head is always in center position of list)
 *	
 * 	In one element of list is only one integer 
 * 	(make this to check speed witch struct is faster)
 *}



INTERFACE
	
	type

		PtrElementBiList = ^ElementBiList;

		ElementBiList = record
			val: longint;
			next: PtrElementBiList;
			prev: PtrElementBiList;
		end;


		procedure addElementBiList(var head: PtrElementBiList; newVal: longint);

		procedure removeElementBiList(var head: PtrElementBiList; Val: longint);

		function findElementBiList(var head: PtrElementBiList; Val: longint):boolean;
		
		procedure setHeadInMiddle(var head:PtrElementBiList);
		
		function countNextElementsBiList(var head: PtrElementBiList):longint;

		function countPrevElementsBiList(var head: PtrElementBiList):longint;


IMPLEMENTATION

{**
 * Add one element to list
 *}
		procedure addElementBiList(var head: PtrElementBiList; newVal: longint);
			var
				newElement, temp: PtrElementBiList;
			begin

				new(newElement);
				newElement^.val 	:= newVal;
				newElement^.next 	:= NIL;
				newElement^.prev 	:= NIL;

				if head = NIL then
					head := newElement
				else 
					begin
						temp := head;
						
						if newVal < head^.val then
							begin
								while (( temp^.prev <> NIL ) AND ( newVal < temp^.val )) do
									begin
										temp := temp^.prev;
									end;

								if temp^.val <> newVal then
									begin
										newElement^.prev 	:= temp^.prev;
										newElement^.next	:= temp;
										temp^.prev 			:= newElement;

										if ( temp^.prev <> NIL ) then
											temp^.prev^.next 	:= newElement;
									end;
							end
						else
							begin
								while ((temp^.next <> NIL) AND ( newVal > temp^.val )) do
									begin
										temp := temp^.next;
									end;
								
								if (( temp^.val <> newVal )) then
									begin
										newElement^.next 	:= temp^.next;
										newElement^.prev	:= temp;
										temp^.next 			:= newElement;

										if ( temp^.next <> NIL ) then
											temp^.next^.prev 	:= newElement;
										
									end;
							end;				
						setHeadInMiddle(head);	
					end;
			end;


{**
 * Remove one element from list
 *}

		procedure removeElementBiList(var head: PtrElementBiList; Val : longint);
			var
				temp: PtrElementBiList;				
			begin
				temp := head;	
				if ( temp^.val = Val ) then
					begin
						if ( temp^.next = NIL ) AND ( temp^.prev = NIL ) then	
							begin
								head := NIL;
								dispose(temp);
							end
						else if ( temp^.next = NIL ) then
							begin
								head := temp^.prev;
								temp^.prev^.next := NIL;
								dispose(temp);
							end						
						else if ( temp^.prev = NIL ) then
							begin
								head := temp^.next;
								temp^.next^.prev := NIL;
								dispose(temp);
							end
						else 
							begin
								head := temp^.prev;
								temp^.prev^.next := temp^.next;
								temp^.next^.prev := temp^.prev;
								dispose(temp);
								setHeadInMiddle(head);
							end;
					end
				else
					begin
						 if Val < head^.val then
							begin
								while (( temp^.prev <> NIL ) AND ( Val <> temp^.val )) do
									begin
										temp := temp^.prev;
									end;

								if temp^.prev <> NIL then
									temp^.prev^.next := temp^.next;

								temp^.next^.prev := temp^.prev;

							end
						else 
							begin
								while (( temp^.next <> NIL ) AND ( Val <> temp^.val )) do
									begin
										temp := temp^.next;
									end;

								if temp^.next <> NIL then
									temp^.next^.prev := temp^.prev;

								temp^.prev^.next := temp^.next;
							end;

						dispose(temp);
						setHeadInMiddle(head);
					end;
			end;

{**
 * Find element in list
 *}
		function findElementBiList(var head: PtrElementBiList; Val: longint):boolean;
			var
				temp: PtrElementBiList;
			begin

				temp := head;	
				
				{*findElementBiList := FALSE;*}
				
				if ( Val <= temp^.val ) then 
					begin
						while (( temp^.prev <> NIL ) AND ( Val <> temp^.val )) do
							begin
								if temp^.val = Val then
									begin
										findElementBiList := TRUE;
									end;
								temp := temp^.prev;
							end;
					end
				else
					begin
						while (( temp^.next <> NIL ) AND ( Val <> temp^.val )) do
							begin
								if temp^.val = Val then
									begin
										findElementBiList := TRUE;
									end;
								temp := temp^.next;
							end;
					end;
			end;


{**
 * Get length left and right and set head in middle of list
 *}

		procedure setHeadInMiddle(var head: PtrElementBiList);
			var
				prev, next 	: longint;
				temp  		: PtrElementBiList;
			begin

				prev := countPrevElementsBiList(head);
				next := countNextElementsBiList(head);

writeln(head^.val);
writeln(prev);
writeln(next);
writeln('****');

				if (prev - 2) = next then
					begin
						head := head^.prev;
					end
				else if (next - 2) = prev then
					begin
						head := head^.next;
					end;
			end;

{**
 * Count length right list
 *}
		function countNextElementsBiList(var head: PtrElementBiList):longint;
			var
				temp  : PtrElementBiList;
				count : longint;
			begin
				temp := head;
				count := 0;

				while temp^.next <> NIL do
					begin
						count 	:= count + 1;
						temp 	:= temp^.next;
					end;

				countNextElementsBiList := count;
			end;

{**
 * Count length left list
 *}
		function countPrevElementsBiList(var head: PtrElementBiList):longint;
			var
				temp  : PtrElementBiList;
				count : longint;
			begin
				temp := head;
				count := 0;

				while temp^.prev <> NIL do
					begin
						count 	:= count + 1;
						temp 	:= temp^.prev;
					end;

				countPrevElementsBiList := count;
			end;


end.