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
						
						if head^.val > newVal then
							begin
								while ((temp^.prev <> NIL) AND (temp^.prev^.val < newVal)) do
									begin
										temp := temp^.prev;
									end;

								newElement^.prev 	:= temp^.prev;
								newElement^.next	:= temp;
								temp^.prev^.next 	:= newElement;
								temp^.prev 			:= newElement;

							end
						else
							begin
								while ((temp^.next <> NIL) AND (temp^.next^.val < newVal)) do
									begin
										temp := temp^.next;
									end;

								newElement^.next 	:= temp^.next;
								newElement^.prev	:= temp;
								temp^.next^.prev 	:= newElement;
								temp^.next 			:= newElement;
							end;

					end;

			end;


{**
 * Remove one element from list
 *}

		procedure removeElementBiList(var head: PtrElementBiList; Val: longint);
			var
				temp: PtrElementBiList;				
			begin
				temp := head;	
				if temp^.val = Val then
					begin
						head := temp^.next;
						head^.prev := NIL;
						dispose(temp);
					end
				else
					begin
						while ((temp^.next <> NIL) AND (temp^.val <> Val)) do
							begin
								temp := temp^.next;
							end; 
						
						if ((temp^.next <> NIL) AND (temp^.next^.val = Val)) then
							begin
								temp2 := temp^.next;
								temp^.next := temp2^.next;
								dispose(temp2);
							end;
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
				
				findElementBiList := FALSE;
				
				while temp <> NIL do
					begin
						if temp^.val = Val then
							begin
								findElementBiList := TRUE;
							end;
						temp := temp^.next;
					end;
			end;


end.