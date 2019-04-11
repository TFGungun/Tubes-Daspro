unit uFileLoader;

interface
	
	Uses uDate, parsertuanyon;

	type
		Buku = record
				ID_Buku : string;
				Judul_Buku		: string;
				Author 			: string;
				Jumlah_Buku		: integer;
				Tahun_Penerbit	: integer;
				Kategori 		: string;
			end;

		User = record
			Nama	 	: string;
			Alamat		: string;
			Username 	: string;
			Password	: string;
			Role		: string;
		end;

		HistoryPeminjaman = record
			Username	 				: string;
			ID_Buku						: string;
			Tanggal_Peminjaman 			: Date;
			Tanggal_Batas_Pengembalian	: Date;
			Status_Pengembalian			: boolean;
		end;

		HistoryPengembalian = record
			Username	 					: string;
			ID_Buku							: string;
			Tanggal_Pengembalian 			: Date;
		end;

		LaporanHilang = record
			Username	 					: string;
			ID_Buku							: string;
			Tanggal_Laporan		 			: Date;
		end;

		BArr = array[1..1000] of Buku;
		UArr = array[1..1000] of User;
		PinjamArr = array[1..1000] of HistoryPeminjaman;
		KembaliArr = array[1..1000] of HistoryPengembalian;
		HilangArr = array[1..1000] of LaporanHilang;
	

	procedure LoadBuku (var arrBuku: BArr);

	procedure PrintBuku (var arrBuku : BArr);

	function GetSizeBuku ()	: longint;

	procedure LoadUser (var arrUser : UArr);

	procedure PrintUser (var arrUser : UArr);

	function GetSizeUser () : longint;

	procedure LoadHistoryPeminjaman(var arrHistoryPeminjaman : PinjamArr);

	procedure PrintHistoryPeminjaman (var arrHistoryPeminjaman : PinjamArr);

	procedure LoadHistoryPengembalian(var arrHistoryPengembalian : KembaliArr);

	procedure PrintHistoryPengembalian (var arrHistoryPengembalian : KembaliArr);

	procedure LoadLaporanHilang(var arrLaporanHilang : HilangArr);

	procedure PrintLaporanHilang(var arrLaporanHilang : HilangArr);

	//function GetSizeHistoryPeminjaman () : longint;



	var
		lenBuku : longint;
		lenUser : longint;
		lenHistoryPeminjaman : longint;
		lenHistoryPengembalian : longint;
		lenLaporanHilang : longint;

implementation
	
	

	procedure LoadBuku (var arrBuku: BArr);

	var

		// variables to write
		UserFile : Text;

		// variables to read
		F : file of char;
		readChar : Char;
		i, j, k, comcount, linecount : integer;
		temp_string,readstring : string;

	begin

		// Get buku.csv file size
		system.Assign(F, 'buku.csv');
		system.Reset(F);
		lenBuku := FileSize(F);
		Close(F);

		system.Assign(UserFile, 'buku.csv');
		system.Reset(UserFile);

		i := 1;
		j := 1;
		comcount := 0; // comma counter
		linecount := 0; // line counter
		readstring := '';
		temp_string := '';

		while(not Eof(UserFile)) do
		begin
			if (linecount = 0) then
			begin
				readln(UserFile,readstring);
				while(j <= length(readstring)) do
				begin
					while (readstring[j] <> ',') and (j <= length(readstring)) do
					begin
						inc(j);
					end;
					if (readstring[j] = ',') and (j <= length(readstring)) then
					begin
						inc(j);
					end;
				end;
				inc(linecount);
				j := 1;
			end else
			begin
				readln(UserFile, readstring);
				while (j <= length(readstring)) do
				begin
					while (readstring[j] <> ',') and (j <= length(readstring)) do
					begin
						case comcount of
						0 : begin
							arrBuku[i].ID_Buku := arrBuku[i].ID_Buku + readstring[j];
							end;
						1 : begin
							arrBuku[i].Judul_Buku := arrBuku[i].Judul_Buku + readstring[j];
							end; 
						2 : begin
							arrBuku[i].Author := arrBuku[i].Author + readstring[j];
							end; 
						3 : begin
							temp_string := temp_string + readstring[j];
							//arrBuku[i].Jumlah_Buku := arrBuku[i].Jumlah_Buku + readchar;
							end; 
						4 : begin
							temp_string := temp_string + readstring[j];
							//arrBuku[i].Tahun_Penerbit := arrBuku[i].Tahun_Penerbit + readchar;
							end; 
						5 : begin
							arrBuku[i].Kategori := arrBuku[i].Kategori + readstring[j];
							end;  
						end;
					inc(j);
					end;

					if (readstring[j] = ',') then
					begin
						case comcount of
							3 : begin
								arrBuku[i].Jumlah_Buku := StrToInt(temp_string);
								temp_string := '';
								end;
							4 : begin
								arrBuku[i].Tahun_Penerbit := StrToInt(temp_string);
								temp_string := '';
								end;
						end;
						inc(j);
						inc(comcount);
					end;
				end;
				comcount := 0;
				j := 1;
				inc(i);
				inc(linecount);
			end;

			//while (j <= length(readstring)) do
			//begin
			//	while
			//end;
		end;

		Close(UserFile);

		

		lenBuku := (linecount-1);
	end;

	function GetSizeBuku()	: longint;
	begin
		GetSizeBuku := lenBuku;
	end;

	procedure PrintBuku (var arrBuku : BArr);
	var
		k : integer;
	begin
		for k := 1 to (lenBuku) do
		begin
			write(k);
			write(' | ');
			write(arrBuku[k].ID_Buku);
			write(' | ');
			write(arrBuku[k].Judul_Buku);
			write(' | ');
			write(arrBuku[k].Author);
			write(' | ');
			write(arrBuku[k].Jumlah_Buku);
			write(' | ');
			write(arrBuku[k].Tahun_Penerbit);
			write(' | ');
			write(arrBuku[k].Kategori);
			writeln();
		end;
	end;

	procedure LoadUser (var arrUser: UArr);

	var

		// variables to write
		UserFile : Text;

		// variables to read
		F : file of char;
		readChar : Char;
		i, j, k, comcount, linecount : integer;
		temp_string,readstring : string;

	begin

		// Get buku.csv file size
		system.Assign(F, 'user.csv');
		system.Reset(F);
		lenUser := FileSize(F);
		Close(F);

		system.Assign(UserFile, 'user.csv');
		system.Reset(UserFile);

		i := 1;
		j := 1;
		comcount := 0; // comma counter
		linecount := 0; // line counter
		readstring := '';
		temp_string := '';

		while(not Eof(UserFile)) do
		begin
			if (linecount = 0) then
			begin
				readln(UserFile,readstring);
				while(j <= length(readstring)) do
				begin
					while (readstring[j] <> ',') and (j <= length(readstring)) do
					begin
						inc(j);
					end;
					if (readstring[j] = ',') and (j <= length(readstring)) then
					begin
						inc(j);
					end;
				end;
				inc(linecount);
				j := 1;
			end else
			begin
				readln(UserFile, readstring);
				while (j <= length(readstring)) do
				begin
					while (readstring[j] <> ',') and (j <= length(readstring)) do
					begin
						case comcount of
						0 : begin
							arrUser[i].Nama := arrUser[i].Nama + readstring[j];
							end;
						1 : begin
							arrUser[i].Alamat := arrUser[i].Alamat + readstring[j];
							end; 
						2 : begin
							arrUser[i].Username := arrUser[i].Username + readstring[j];
							end; 
						3 : begin
							arrUser[i].Password := arrUser[i].Password + readstring[j];
							end; 
						4 : begin
							arrUser[i].Role := arrUser[i].Role + readstring[j];
							end; 
						end;
					inc(j);
					end;

					if (readstring[j] = ',') then
					begin
						inc(j);
						inc(comcount);
					end;
				end;
				comcount := 0;
				j := 1;
				inc(i);
				inc(linecount);
			end;

			//while (j <= length(readstring)) do
			//begin
			//	while
			//end;
		end;

		Close(UserFile);

		

		lenUser := (linecount-1);
	end;

	procedure PrintUser (var arrUser : UArr);
	var
		k : integer;
	begin
		for k := 1 to (lenUser) do
		begin
			write(k);
			write(' | ');
			write(arrUser[k].Nama);
			write(' | ');
			write(arrUser[k].Alamat);
			write(' | ');
			write(arrUser[k].Username);
			write(' | ');
			write(arrUser[k].Password);
			write(' | ');
			write(arrUser[k].Role);
			writeln();
		end;
	end;

	function GetSizeUser () : longint;
	begin
		GetSizeUser := lenUser;
	end;

	procedure LoadHistoryPeminjaman (var arrHistoryPeminjaman : PinjamArr);

	var

		// variables to write
		UserFile : Text;

		// variables to read
		F : file of char;
		readChar : Char;
		i, j, k, comcount, linecount : integer;
		temp_string,readstring : string;

	begin

		// Get buku.csv file size
		system.Assign(F, 'peminjaman.csv');
		system.Reset(F);
		lenUser := FileSize(F);
		Close(F);

		system.Assign(UserFile, 'peminjaman.csv');
		system.Reset(UserFile);

		i := 1;
		j := 1;
		comcount := 0; // comma counter
		linecount := 0; // line counter
		readstring := '';
		temp_string := '';

		while(not Eof(UserFile)) do
		begin
			if (linecount = 0) then
			begin
				readln(UserFile,readstring);
				while(j <= length(readstring)) do
				begin
					while (readstring[j] <> ',') and (j <= length(readstring)) do
					begin
						inc(j);
					end;
					if (readstring[j] = ',') and (j <= length(readstring)) then
					begin
						inc(j);
					end;
				end;
				inc(linecount);
				j := 1;
			end else
			begin
				readln(UserFile, readstring);
				while (j <= length(readstring)) do
				begin
					while (readstring[j] <> ',') and (j <= length(readstring)) do
					begin
						case comcount of
						0 : begin
							arrHistoryPeminjaman[i].Username := arrHistoryPeminjaman[i].Username + readstring[j];
							end;
						1 : begin
							arrHistoryPeminjaman[i].ID_Buku := arrHistoryPeminjaman[i].ID_Buku + readstring[j];
							end; 
						2 : begin
							temp_string := temp_string + readstring[j];
							//arrHistoryPeminjaman[i].Username := arrHistoryPeminjaman[i].Username + readstring[j];
							end; 
						3 : begin
							temp_string := temp_string + readstring[j];
							//arrHistoryPeminjaman[i].Password := arrHistoryPeminjaman[i].Password + readstring[j];
							end; 
						4 : begin
							temp_string := temp_string + readstring[j];
							//arrHistoryPeminjaman[i].Role := arrHistoryPeminjaman[i].Role + readstring[j];
							end; 
						end;
					inc(j);
					end;

					if (readstring[j] = ',') then
					begin
						case comcount of
							2 : begin
								arrHistoryPeminjaman[i].Tanggal_Peminjaman := ParseDate(temp_string);
								temp_string := '';
								end;
							3 : begin
								arrHistoryPeminjaman[i].Tanggal_Batas_Pengembalian := ParseDate(temp_string);
								temp_string := '';
								end;
							4 : begin
								writeln('MAJU JALAN');
								arrHistoryPeminjaman[i].Status_Pengembalian := StrToBool(temp_string);
								temp_string := '';
								end;
						end;
						inc(j);
						inc(comcount);
					end;

					if (j = length(readstring) + 1) then
					begin
						arrHistoryPeminjaman[i].Status_Pengembalian := StrToBool(temp_string);
						temp_string := '';
						inc(j);
						inc(comcount);
					end;
				end;
				comcount := 0;
				j := 1;
				inc(i);
				inc(linecount);
			end;

			//while (j <= length(readstring)) do
			//begin
			//	while
			//end;
		end;

		Close(UserFile);

		lenHistoryPeminjaman := (linecount-1);
	end;

	procedure PrintHistoryPeminjaman (var arrHistoryPeminjaman : PinjamArr);
	var
		k : integer;
	begin
		for k := 1 to (lenHistoryPeminjaman) do
		begin
			write(k);
			write(' | ');
			write(arrHistoryPeminjaman[k].Username);
			write(' | ');
			write(arrHistoryPeminjaman[k].ID_Buku);
			write(' | ');
			WriteDate(arrHistoryPeminjaman[k].Tanggal_Peminjaman);
			write(' | ');
			WriteDate(arrHistoryPeminjaman[k].Tanggal_Batas_Pengembalian);
			write(' | ');
			if (arrHistoryPeminjaman[k].Status_Pengembalian) then
			begin
				write('Sudah Kembali');
			end else
			begin
				write('Belum Kembali');
			end;
			writeln();
		end;
	end;

	procedure LoadHistoryPengembalian (var arrHistoryPengembalian : KembaliArr);

	var

		// variables to write
		UserFile : Text;

		// variables to read
		F : file of char;
		readChar : Char;
		i, j, k, comcount, linecount : integer;
		temp_string,readstring : string;

	begin

		// Get buku.csv file size
		system.Assign(F, 'pengembalian.csv');
		system.Reset(F);
		lenUser := FileSize(F);
		Close(F);

		system.Assign(UserFile, 'pengembalian.csv');
		system.Reset(UserFile);

		i := 1;
		j := 1;
		comcount := 0; // comma counter
		linecount := 0; // line counter
		readstring := '';
		temp_string := '';

		while(not Eof(UserFile)) do
		begin
			if (linecount = 0) then
			begin
				readln(UserFile,readstring);
				while(j <= length(readstring)) do
				begin
					while (readstring[j] <> ',') and (j <= length(readstring)) do
					begin
						inc(j);
					end;
					if (readstring[j] = ',') and (j <= length(readstring)) then
					begin
						inc(j);
					end;
				end;
				inc(linecount);
				j := 1;
			end else
			begin
				readln(UserFile, readstring);
				while (j <= length(readstring)) do
				begin
					while (readstring[j] <> ',') and (j <= length(readstring)) do
					begin
						case comcount of
						0 : begin
							arrHistoryPengembalian[i].Username := arrHistoryPengembalian[i].Username + readstring[j];
							end;
						1 : begin
							arrHistoryPengembalian[i].ID_Buku := arrHistoryPengembalian[i].ID_Buku + readstring[j];
							end; 
						2 : begin
							temp_string := temp_string + readstring[j];
							//arrHistoryPengembalian[i].Username := arrHistoryPengembalian[i].Username + readstring[j];
							end;
						end;
					inc(j);
					end;

					if (readstring[j] = ',') then
					begin
						inc(j);
						inc(comcount);
					end;

					if (j = length(readstring) + 1) then
					begin
						arrHistoryPengembalian[i].Tanggal_Pengembalian := ParseDate(temp_string);
						temp_string := '';
						inc(j);
						inc(comcount);
					end;
				end;
				comcount := 0;
				j := 1;
				inc(i);
				inc(linecount);
			end;

			//while (j <= length(readstring)) do
			//begin
			//	while
			//end;
		end;

		Close(UserFile);

		lenHistoryPengembalian := (linecount-1);
	end;

	procedure PrintHistoryPengembalian (var arrHistoryPengembalian : KembaliArr);
	var
		k : integer;
	begin
		for k := 1 to (lenHistoryPengembalian) do
		begin
			write(k);
			write(' | ');
			write(arrHistoryPengembalian[k].Username);
			write(' | ');
			write(arrHistoryPengembalian[k].ID_Buku);
			write(' | ');
			WriteDate(arrHistoryPengembalian[k].Tanggal_Pengembalian);
			writeln();
		end;
	end;

	procedure LoadLaporanHilang(var arrLaporanHilang : HilangArr);

	var

		// variables to write
		UserFile : Text;

		// variables to read
		F : file of char;
		readChar : Char;
		i, j, k, comcount, linecount : integer;
		temp_string,readstring : string;

	begin

		// Get buku.csv file size
		system.Assign(F, 'kehilangan.csv');
		system.Reset(F);
		lenUser := FileSize(F);
		Close(F);

		system.Assign(UserFile, 'kehilangan.csv');
		system.Reset(UserFile);

		i := 1;
		j := 1;
		comcount := 0; // comma counter
		linecount := 0; // line counter
		readstring := '';
		temp_string := '';

		while(not Eof(UserFile)) do
		begin
			if (linecount = 0) then
			begin
				readln(UserFile,readstring);
				while(j <= length(readstring)) do
				begin
					while (readstring[j] <> ',') and (j <= length(readstring)) do
					begin
						inc(j);
					end;
					if (readstring[j] = ',') and (j <= length(readstring)) then
					begin
						inc(j);
					end;
				end;
				inc(linecount);
				j := 1;
			end else
			begin
				readln(UserFile, readstring);
				while (j <= length(readstring)) do
				begin
					while (readstring[j] <> ',') and (j <= length(readstring)) do
					begin
						case comcount of
						0 : begin
							arrLaporanHilang[i].Username := arrLaporanHilang[i].Username + readstring[j];
							end;
						1 : begin
							arrLaporanHilang[i].ID_Buku := arrLaporanHilang[i].ID_Buku + readstring[j];
							end; 
						2 : begin
							temp_string := temp_string + readstring[j];
							//arrLaporanHilang[i].Username := arrLaporanHilang[i].Username + readstring[j];
							end;
						end;
					inc(j);
					end;

					if (readstring[j] = ',') then
					begin
						inc(j);
						inc(comcount);
					end;

					if (j = length(readstring) + 1) then
					begin
						arrLaporanHilang[i].Tanggal_Laporan := ParseDate(temp_string);
						temp_string := '';
						inc(j);
						inc(comcount);
					end;
				end;
				comcount := 0;
				j := 1;
				inc(i);
				inc(linecount);
			end;

			//while (j <= length(readstring)) do
			//begin
			//	while
			//end;
		end;

		Close(UserFile);

		lenLaporanHilang := (linecount-1);
	end;

	procedure PrintLaporanHilang(var arrLaporanHilang : HilangArr);
	var
		k : integer;
	begin
		for k := 1 to (lenLaporanHilang) do
		begin
			write(k);
			write(' | ');
			write(arrLaporanHilang[k].Username);
			write(' | ');
			write(arrLaporanHilang[k].ID_Buku);
			write(' | ');
			WriteDate(arrLaporanHilang[k].Tanggal_Laporan);
			writeln();
		end;
	end;
end.