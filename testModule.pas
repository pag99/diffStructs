unit testModule;

interface 

	{$mode objfpc}

	uses 
		Crt, Classes, SysUtils, DateUtils,
		listsUnidirectional, tree,  avl;
	
	const
		Elements = 500000;
		Part	 = 100;



	type
		IntP = ^longint;
		tab = array[1..Elements] of longint;
		returns = array[1..4] of TTimeStamp;

	var 
		tableOfRandomVaule: tab;
		FileVar: TextFile;
		Str: String;


	procedure startTest();

	procedure generateRandomValues();

	function List(howMuch: longint):returns;
	function Tree(howMuch: longint):returns;
	function Avl(howMuch: longint):returns;

implementation

	function timestampToStr(x:TTimeStamp):comp;
	begin
		timestampToStr := TimeStampToMSecs(x);
	end;

	procedure startTest();
	var
		increment	: longint;
		interval 	: longint;
		arr 		: array [1..3,1..Part] of returns;

	begin

		generateRandomValues();

		interval := Elements div Part;

		writeln(interval);

		for increment := 1 to Part do
		begin
			writeln(increment);
			writeln('List');
				arr[1][increment] := List( interval * increment);

			writeln('Tree');	
				arr[2][increment] := Tree( interval * increment);

			writeln('Avl');
				arr[3][increment] := Avl( interval * increment);
		end;
			
		writeln('save to file');

		AssignFile (FileVar, 'Results.csv');

		Rewrite(FileVar);  


		for increment := 1 to Part do
		begin
	    	Writeln(FileVar,
	    		timestampToStr(arr[1][increment][1]),'; ',
	    		timestampToStr(arr[1][increment][2]),'; ',
	    		timestampToStr(arr[1][increment][3]),'; ',
	    		timestampToStr(arr[1][increment][4]),'; ',
	    		timestampToStr(arr[2][increment][1]),'; ',
	    		timestampToStr(arr[2][increment][2]),'; ',
	    		timestampToStr(arr[2][increment][3]),'; ',
	    		timestampToStr(arr[2][increment][4]),'; ',
	    		timestampToStr(arr[3][increment][1]),'; ',
	    		timestampToStr(arr[3][increment][2]),'; ',
	    		timestampToStr(arr[3][increment][3]),'; ',
	    		timestampToStr(arr[3][increment][4]));
   		end;
   		CloseFile(FileVar);

   		writeln('saved');
	end;	

	procedure generateRandomValues();
	var
		increment	: longint;
		number 		: longint;
	begin
		
		Randomize;

		for increment := 1 to Elements do
		begin
			number := random(Elements * 2);
			
			if ((( number >> 1 ) << 1 ) = number ) then
				tableOfRandomVaule[increment] := number
			else
				tableOfRandomVaule[increment] := number - 1;
		end;
	end;

	function List(howMuch: longint):returns;
	var
		head : PtrElementUniList;
		i, temp: longint;
		time : array[1..5] of TDateTime;
		results : returns;
	begin	

		temp := howMuch div 2;

		head := NIL;

		time[1] := Now;
			
			for i := 1 to howMuch do
			begin
				addElementUniList(head,tableOfRandomVaule[i]);
			end;

		time[2] := Now;

			findElementUniList(head,tableOfRandomVaule[temp]);

		time[3] := Now;

			findElementUniList(head,tableOfRandomVaule[temp] + 1);

		time[4] := Now;

			removeElementUniList(head, tableOfRandomVaule[temp]);

		time[5] := Now;

		results[1] := MSecsToTimeStamp(MilliSecondsBetween(time[2],time[1]));
		results[2] := MSecsToTimeStamp(MilliSecondsBetween(time[3],time[2]));
		results[3] := MSecsToTimeStamp(MilliSecondsBetween(time[4],time[3]));
		results[4] := MSecsToTimeStamp(MilliSecondsBetween(time[5],time[4]));


		List := results;
	end;	

	function Tree(howMuch: longint):returns;
	var
		head : PtrElementTree;
		i, temp: longint;
		time : array[1..5] of TDateTime;
		results : returns;
	begin	

		temp := howMuch div 2;

		head := NIL;

		time[1] := Now;
			
			for i := 1 to howMuch do
			begin
				addElementTree(head,tableOfRandomVaule[i]);
			end;

		time[2] := Now;

			findElementTree(head,tableOfRandomVaule[temp]);

		time[3] := Now;

			findElementTree(head,tableOfRandomVaule[temp] + 1);

		time[4] := Now;

			removeElementTree(head, tableOfRandomVaule[temp]);

		time[5] := Now;

		results[1] := MSecsToTimeStamp(MilliSecondsBetween(time[2],time[1]));
		results[2] := MSecsToTimeStamp(MilliSecondsBetween(time[3],time[2]));
		results[3] := MSecsToTimeStamp(MilliSecondsBetween(time[4],time[3]));
		results[4] := MSecsToTimeStamp(MilliSecondsBetween(time[5],time[4]));


		Tree := results;
	end;	


	function Avl(howMuch: longint):returns;
	var
		head : AVLPtr;
		i, temp: longint;
		time : array[1..5] of TDateTime;
		results : returns;
	begin	

		temp := howMuch div 2;

		head := NIL;

		time[1] := Now;
			
			for i := 1 to howMuch do
			begin
				Insert_AVLTree(head,tableOfRandomVaule[i]);
			end;

		time[2] := Now;

			Search_AVLTree(head,tableOfRandomVaule[temp]);

		time[3] := Now;

			Search_AVLTree(head,tableOfRandomVaule[temp] + 1);

		time[4] := Now;

			Delete_AVLTree(head, tableOfRandomVaule[temp]);

		time[5] := Now;

		results[1] := MSecsToTimeStamp(MilliSecondsBetween(time[2],time[1]));
		results[2] := MSecsToTimeStamp(MilliSecondsBetween(time[3],time[2]));
		results[3] := MSecsToTimeStamp(MilliSecondsBetween(time[4],time[3]));
		results[4] := MSecsToTimeStamp(MilliSecondsBetween(time[5],time[4]));


		Avl := results;
	end;


end.