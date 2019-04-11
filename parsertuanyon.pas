unit parsertuanyon;

interface
	function StrToInt (str : string) : integer;

	function StrToBool (str : string) : boolean;

implementation
	function StrToInt (str : string) : integer;
	var
		i, int : integer;

	begin
		int := 0;
		for i := 1 to Length(str) do
		begin
			int := (int * 10) + ord(str[i]) - 48;
		end;
		StrToInt := int;
	end;

	function StrToBool (str : string) : boolean;
	begin
		if (str = 'TRUE') then
		begin
			StrToBool := true;
		end else if (str = 'FALSE') then
		begin
			StrToBool := false;
		end;
	end;
end.