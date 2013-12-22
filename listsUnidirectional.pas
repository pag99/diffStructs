UNIT listsUnidirectional;

{**
 *  List unidirectional (with sort from min to max value)
 *
 * 	In one element of list is only one integer 
 * 	(make this to check speed witch struct is faster)
 *}

INTERFACE
	
	type

		PtrElementUniList = ^ElementUniList;

		ElementUniList = record
			val: integer;
			next: PtrElementUniList;
		end;


		procedure addElementUniList(var head: PtrElementUniList; newVal: integer);

		procedure removeElementUniList(var head: PtrElementUniList; Val: integer);

		function findElementUniList(var head: PtrElementUniList; Val: integer):boolean;

IMPLEMENTATION

{**
 * Add one element to list
 *}
		procedure addElementUniList(var head: PtrElementUniList; newVal: integer);
			var
				newElement, temp: PtrElementUniList;
			begin

				new(newElement);
				newElement^.val 	:= newVal;
				newElement^.next 	:= NIL;

				if head = NIL then
					head := newElement
				else if head^.val > newVal then
					begin
						newElement^.next := head;
						head := newElement;
					end
				else 
					begin
						
						temp := head;
						
						while ((temp^.next <> NIL) OR (temp^.next^.val < newVal)) do
							begin
								temp := temp^.next;
							end;

						newElement^.next 	:= temp^.next;
						temp^.next 			:= newElement;
					end;

			end;


{**
 * Remove one element from list
 *}

		procedure removeElementUniList(var head: PtrElementUniList; Val: integer);
			var
				temp, temp2: PtrElementUniList;				
			begin
				temp := head;
				if temp^.val = Val then
					begin
						head := temp^.next;
						dispose(temp);
					end
				else
					while ((temp^.next <> NIL) OR (temp^.next^.val = Val)) do
						begin
							temp2 := temp^.next;
							temp^.next := temp2^.next;
							dispose(temp2);
						end; 
			end;

{**
 * Find element in list
 *}
		function findElementUniList(var head: PtrElementUniList; Val: integer):boolean;
			var
				temp: PtrElementUniList;
			begin
				if head^.val = Val then
					findElementUniList := TRUE
				else
					begin
						temp := head;				
						while temp^.next <> NIL do
							begin
								temp := temp^.next;

								if temp^.val = Val then
									findElementUniList := TRUE;

							end;
					end;

				findElementUniList := FALSE;
			end;


end.