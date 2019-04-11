unit uDate;

interface
	
	Uses sysutils;

	type
		Date = record
				DD 		: integer;
				MM 		: integer;
				YYYY	: integer;
		end;

	function ParseDate(var dateString : string) : Date;

	function GetIntervalInDay(var date1, date2 : Date ) : integer;

	procedure WriteDate(var dateofdate : Date);

	procedure WritelnDate(var dateofdate : Date);

implementation

	function ParseDate(var datestring : string) : Date;
	var
		i, slashcount : integer;
		temp_string : string;
	begin
		i := 1;
		slashcount := 0;
		temp_string := ' ';
		while (i <= Length(datestring)) do
		begin
			while (datestring[i] <> '/') and (i < Length(datestring)) do
			begin
				//case slashcount of
					//0 : begin
				temp_string := temp_string + dateString[i];
					//	end;
					//1 : eg
				//end;
				inc(i);
			end;
			if (datestring[i] = '/') then
			begin
				case slashcount of
					0 : begin
							ParseDate.DD := StrToInt(temp_string);
							inc(slashcount);
							temp_string := '';
						end;
					1 : begin
							ParseDate.MM := StrToInt(temp_string);
							inc(slashcount);
							temp_string := '';
						end;
				end;
				inc(i);
			end;
			if (i = Length(datestring)) then
			begin
				temp_string := temp_string + dateString[i];
				ParseDate.YYYY := StrToInt(temp_string);
				slashcount := 0;
				temp_string := '';
				inc(i);
			end; 
		end;
	end;

	function GetIntervalInDay(var date1, date2 : Date ) : integer;
	begin
		GetIntervalInDay := date1.DD - date2.DD;
	end;

	procedure WriteDate(var dateofdate : Date);
	begin
		write(dateofdate.DD);
		write('/');
		write(dateofdate.MM);
		write('/');
		write(dateofdate.YYYY);
	end;

	procedure WritelnDate(var dateofdate : Date);
	begin
		write(dateofdate.DD);
		write('/');
		write(dateofdate.MM);
		write('/');
		write(dateofdate.YYYY);
		writeln('');
	end;
end.