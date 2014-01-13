uses listsUnidirectional, listsBidirectional, Crt;

var 
	head,temp : PtrElementBiList;
	count,i : longint;

begin
	writeln('testing...');
	readln(count);
	head := NIL;

	for i:= 1 to count do
	begin

		addElementBiList(head, i);

	end;
	
	temp := head;

	writeln('added');

	while temp <> NIL do
		begin

			writeln(temp^.val);
			temp := temp^.next;
		end;

	writeln('Find element');
		readln(count);

	if findElementBiList(head, count) = TRUE then
		begin
			removeElementBiList(head,count);
			writeln('remove');
		end
	else
		writeln('not found');

	temp := head;

	while temp <> NIL do
		begin
			writeln(temp^.val);
			temp := temp^.next;
		end;

end.