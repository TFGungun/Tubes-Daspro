//==============================================================//
//                       ParserTuanYon                          //
//--------------------------------------------------------------//
//  Unit yang menangani parsing tipe data untuk unit-unit lain  //
//==============================================================//
unit parsertuanyon;

interface

	function StrToInt (str : string) : integer;
	{Menghasilkan str dalam tipe integer}

	function StrToBool (str : string) : boolean;
	{Menghasilkan str dalam tipe boolean}

	function IntToHex (number : Int64 ; digits : integer) : string;
	{Menghasilkan int dalam bentuk hexadecimal bertipe string}
	{Sumber Ide : https://www.geeksforgeeks.org/program-decimal-hexadecimal-conversion/}


implementation
	function StrToInt (str : string) : integer;
	{Menghasilkan str dalam tipe integer}

	{ KAMUS LOKAL }
	var
		i, int : integer;

	{ ALGORITMA }
	begin
		int := 0;
		for i := 1 to Length(str) do
		begin
			int := (int * 10) + ord(str[i]) - 48;
		end;
		StrToInt := int;
	end;

	function StrToBool (str : string) : boolean;
	{Menghasilkan str dalam tipe boolean}

	{ ALGORITMA }
	begin
		if (str = 'TRUE') then
		begin
			StrToBool := true;
		end else if (str = 'FALSE') then
		begin
			StrToBool := false;
		end;
	end;
	
	function IntToHex (number : Int64; digits : integer) : string;
	{Menghasilkan int dalam bentuk hexadecimal bertipe string}
	{Sumber Ide : https://www.geeksforgeeks.org/program-decimal-hexadecimal-conversion/}

	{ KAMUS LOKAL }
    var
        remainder: Int64;
        i, counter : integer;

    { ALGORITMA }
    begin
        IntToHex := '';
        counter := 0;

        while (number <> 0) do
        begin
            remainder := number mod 16;
            if (remainder < 10) then
            begin
                IntToHex := chr(remainder + 48) + IntToHex;
            end else
            begin
                IntToHex := chr(remainder + 55) + IntToHex;
            end;
            counter := counter + 1;
            number := number div 16;
        end;
        for i := 1 to (digits-counter) do
        begin
            IntToHex := '0' + IntToHex;
        end;
    end;
end.