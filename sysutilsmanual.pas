unit parsertuanyon;

interface
	function StrToInt (str : string) : integer;

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
end.