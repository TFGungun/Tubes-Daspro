//////////////////////////////////////////////
//					uDate                   //
//////////////////////////////////////////////
//Unit yang menangani tanggal dalam program	//
//////////////////////////////////////////////
unit uDate;

interface
	uses
		parsertuanyon;

	{* KAMUS *}
	
	{ *** Definisi ABSTRACT DATA TYPE Date  ***}
	type
		Date = record
				DD 		: integer;
				MM 		: integer;
				YYYY	: integer;
		end;

	function ParseDate(var dateString : string) : Date;
	{Menghasilkan tanggal bertipe Date dari string tanggal berformat DD/MM/YYYY}

	procedure WriteDate(var dateofdate : Date);
	{Menulis tanggal bertipe Date ke layar dengan format DD/MM/YYYY tanpa akhiran End of Line}
	{I.S. : Atribut Date lengkap}
	{F.S. :	Date tercetak ke layar sesuai format DD/MM/YYYY tanpa akhiran End of Line}

	procedure WritelnDate(var dateofdate : Date);
	{Menulis tanggal bertipe Date ke layar dengan format DD/MM/YYYY dengan akhiran End of Line}
	{I.S. : Atribut Date lengkap}
	{F.S. :	Date tercetak ke layar sesuai format DD/MM/YYYY dengan akhiran End of Line}

	procedure ProcessDate(dateComponent : integer);
	{Memroses atribut Date (DD atau MM) yang hanya terdiri dari 1 digit menjadi 2 digit (1 -> 01)
	dan mencetaknya ke layar}
	{I.S. : Atribut Date hanya terdiri dari 1 digit}
	{F.S. :	Atribut Date tercetak ke layar dalam format 2 digit tanpa akhiran End of Line}

implementation

	function ParseDate(var datestring : string) : Date;
	{Menghasilkan tanggal bertipe Date dari string tanggal berformat DD/MM/YYYY}

	{KAMUS LOKAL}
	var
		i, slashcount : integer;
		temp_string : string;

	{ALGORITMA}
	begin
		i := 1;
		slashcount := 0;	// Penanda banyak garis miring yang telah ditemukan
		temp_string := '';	// Variabel sementara untuk menyimpan string 
		while (i <= Length(datestring)) do
		begin
			// While loop untuk mengambil bagian string tanggal yang bukan '/'
			// dan menyimpannya ke variabel temp_string
			while (datestring[i] <> '/') and (i < Length(datestring)) do
			begin
				temp_string := temp_string + dateString[i];
				inc(i);
			end;
			// If digunakan untuk menentukan ke atribut Date mana (DD/MM)
			// temp_string akan dimasukkan
			// Penentuan menggunakan variabel slashcount sebagai penanda banyaknya
			// garis miring yang telah ditemukan
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
			// If terakhir digunakan untuk bagian atribut Date YYYY dengan kondisi iterasi telah
			// mencapai char terakhir, sehingga dipastikan bagian terakhir adalah tahun
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

	procedure ProcessDate(dateComponent : integer);
	{Memroses atribut Date (DD atau MM) yang hanya terdiri dari 1 digit menjadi 2 digit (1 -> 01)
	dan mencetaknya ke layar}
	{I.S. : Atribut Date hanya terdiri dari 1 digit}
	{F.S. :	Atribut Date tercetak ke layar dalam format 2 digit tanpa akhiran End of Line}
	
	{ALGORITMA}
	begin
		if((dateComponent/10) < 1) then
		begin
			write('0',dateComponent);
		end else
		begin
			write(dateComponent);
		end;
	end;

	procedure WriteDate(var dateofdate : Date);
	{Menulis tanggal bertipe Date ke layar dengan format DD/MM/YYYY tanpa akhiran End of Line}
	{I.S. : Atribut Date lengkap}
	{F.S. :	Date tercetak ke layar sesuai format DD/MM/YYYY tanpa akhiran End of Line}
	
	{ALGORITMA}
	begin
		ProcessDate(dateofdate.DD);
		write('/');
		ProcessDate(dateofdate.MM);
		write('/');
		ProcessDate(dateofdate.YYYY);
	end;

	procedure WritelnDate(var dateofdate : Date);
	{Menulis tanggal bertipe Date ke layar dengan format DD/MM/YYYY dengan akhiran End of Line}
	{I.S. : Atribut Date lengkap}
	{F.S. :	Date tercetak ke layar sesuai format DD/MM/YYYY dengan akhiran End of Line}
	
	{ALGORITMA}
	begin
		ProcessDate(dateofdate.DD);
		write('/');
		ProcessDate(dateofdate.MM);
		write('/');
		ProcessDate(dateofdate.YYYY);
		writeln('');
	end;
end.