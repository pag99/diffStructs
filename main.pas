uses listsUnidirectional, Crt;

var 
	head,temp : PtrElementUniList;
	count,i : longint;

begin
	writeln('testing...');
	readln(count);
	head := NIL;
	for i:= 1 to count do
		addElementUniList(head, i);

	temp := head;

	while temp <> NIL do
		begin
			writeln(temp^.val);
			temp := temp^.next;
		end;

	writeln('Find element');
		readln(count);

	if findElementUniList(head, count) = TRUE then
		begin
			removeElementUniList(head,count);
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