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


		procedure addElementUniuList()

IMPLEMENTATION


