////////////////////////////////////////////////////
//					uFileLoader                   //
////////////////////////////////////////////////////
//Unit yang menangani loading data ke main program//
////////////////////////////////////////////////////

unit uFileLoader;

interface

	Uses uDate, parsertuanyon;

	{* KAMUS *}
	
	{ *** Definisi ABSTRACT DATA TYPE BUKU, USER, HISTORYPEMINJAMAN, 
	HISTORYPENGEMBALIAN, LAPORANHILANG ***}
	type
		Buku = record
				ID_Buku 		: string;	{ID Unik buku}
				Judul_Buku		: string;	{Judul dari buku}
				Author 			: string;	{Penulis buku}
				Jumlah_Buku		: integer;	{Jumlah buku yang tersedia (tidak dipinjam ataupun hilang)}
				Tahun_Penerbit	: integer;	{Tahun terbit buku}
				Kategori 		: string;	{Jenis buku}
			end;

		User = record
			Nama	 	: string;	{Nama dari user}
			Alamat		: string;	{Alamat user}
			Username 	: string;	{Username untuk login user}
			Password	: string;	{Password untuk login user}
			Role		: string;	{Privilege user (admin / pengunjung)}
			Status 		: boolean; 	{Status login user}
		end;

		HistoryPeminjaman = record
			Username	 				: string;	{Username dari user peminjam buku}
			ID_Buku						: string;	{ID buku yang dipinjam}
			Tanggal_Peminjaman 			: Date;		{Tanggal buku dipinjam}
			Tanggal_Batas_Pengembalian	: Date;		{Tanggal paling lambat buku harus dikembalikan}
			Status_Pengembalian			: boolean;	{Status pengembalian buku}
		end;

		HistoryPengembalian = record
			Username	 					: string;	{Username dari user yang mengembalian buku}
			ID_Buku							: string;	{ID buku yang dikembalikan}
			Tanggal_Pengembalian 			: Date;		{Tanggal buku dikembalikan}
		end;

		LaporanHilang = record
			Username	 					: string;	{Username dari yang melaporan buku hilang (harus peminjam)}
			ID_Buku_Hilang					: string;	{ID dari buku yang hilang}
			Tanggal_Laporan		 			: Date;		{Tanggal kehilangan dilaporkan}
		end;


		BArr = array[1..1000] of Buku;						{Tipe bentukan array Buku}
		UArr = array[1..1000] of User;						{Tipe bentukan array User}
		PinjamArr = array[1..1000] of HistoryPeminjaman;	{Tipe bentukan array HistoryPeminjaman}
		KembaliArr = array[1..1000] of HistoryPengembalian;	{Tipe bentukan array HistoryPengembalian}
		HilangArr = array[1..1000] of LaporanHilang;		{Tipe bentukan array LaporanHilang}
	

	{*** Konstruktor membentuk array berisi data Buku, User, HistoryPeminjaman,
	 HistoryPengembalian, LaporanHilang ***}

	procedure LoadBuku (var arrBuku: BArr ; filename : string);
	{Mengisi masukan arrBuku yang kosong dengan elemen-elemen bertipe Buku 
	dari file data buku dengan nama filename}
	{I.S. : arrBuku kosong}
	{F.S. : arrBuku berisi elemen bertipe Buku dari data buku bernama filename}

	procedure LoadUser (var arrUser : UArr; filename : string);
	{Mengisi masukan arrUser yang kosong dengan elemen-elemen bertipe User 
	dari file data user dengan nama filename}
	{I.S. : arrUser kosong}
	{F.S. : arrUser berisi elemen bertipe User dari data user bernama filename}

	procedure LoadHistoryPeminjaman (var arrHistoryPeminjaman : PinjamArr ; filename : string);
	{Mengisi masukan arrHistoryPeminajman yang kosong dengan elemen-elemen bertipe HistoryPeminjaman 
	dari file data riwayat peminjaman dengan nama filename}
	{I.S. : arrHistoryPeminjaman kosong}
	{F.S. : arrHistoryPeminjaman berisi elemen bertipe HistoryPeminjaman dari data riwayat peminjaman bernama filename}

	procedure LoadHistoryPengembalian (var arrHistoryPengembalian : KembaliArr ;  filename : string);
	{Mengisi masukan arrHistoryPengembalian yang kosong dengan elemen-elemen bertipe HistoryPengembalian 
	dari file data riwayat pengembalian dengan nama filename}
	{I.S. : arrHistoryPengembalian kosong}
	{F.S. : arrHistoryPengembalian berisi elemen bertipe HistoryPengembalian dari data riwayat pengembalian bernama filename}

	procedure LoadLaporanHilang (var arrLaporanHilang : HilangArr; filename : string);
	{Mengisi masukan arrLaporanHilang yang kosong dengan elemen-elemen bertipe LaporanHilang 
	dari file data laporan hilang dengan nama filename}
	{I.S. : arrLaporanHilang kosong}
	{F.S. : arrLaporanHilang berisi elemen bertipe LaporanHilang dari data laporan hilang bernama filename}

	{*** KELOMPOK Interaksi dengan I/O device, BACA / TULIS ***}

	procedure PrintBuku (var arrBuku : BArr);
	{Menulis elemen-elemen dari arrBuku ke layar dengan format sesuai data buku}
	{I.S. : arrBuku sudah berisi data dari file buku dan/atau modifikasi di main program}
	{F.S. :	arrBuku tercetak ke layar sesuai format data buku}

	procedure PrintUser (var arrUser : UArr);
	{Menulis elemen-elemen dari arrUser ke layar dengan format sesuai data user}
	{I.S. : arrUser sudah berisi data dari file user dan/atau modifikasi di main program}
	{F.S. :	arrUser tercetak ke layar sesuai format data user}

	procedure PrintHistoryPeminjaman (var arrHistoryPeminjaman : PinjamArr);
	{Menulis elemen-elemen dari arrHistoryPeminjaman ke layar dengan format sesuai data riwayat peminjaman}
	{I.S. : arrHistoryPeminjaman sudah berisi data dari file riwayat peminjaman dan/atau modifikasi di main program}
	{F.S. :	arrHistoryPeminjaman tercetak ke layar sesuai format data riwayat peminjaman}

	procedure PrintHistoryPengembalian (var arrHistoryPengembalian : KembaliArr);
	{Menulis elemen-elemen dari arrHistoryPengembalian ke layar dengan format sesuai data riwayat pengembalian}
	{I.S. : arrHistoryPengembalian sudah berisi data dari file riwayat pengembalian dan/atau modifikasi di main program}
	{F.S. :	arrHistoryPengembalian tercetak ke layar sesuai format data riwayat pengembalian}

	procedure PrintLaporanHilang (var arrLaporanHilang : HilangArr);
	{Menulis elemen-elemen dari arrLaporanHilang ke layar dengan format sesuai data laporan hilang}
	{I.S. : arrLaporanHilang sudah berisi data dari file laporan hilang dan/atau modifikasi di main program}
	{F.S. :	arrLaporanHilang tercetak ke layar sesuai format data laporan hilang}

	{KAMUS GLOBAL}
	var
		lenBuku : longint;					{Penanda banyaknya elemen arrBuku}
		lenUser : longint;					{Penanda banyaknya elemen arrUser}
		lenHistoryPeminjaman : longint;		{Penanda banyaknya elemen arrHistoryPeminjaman}
		lenHistoryPengembalian : longint;	{Penanda banyaknya elemen arrHistoryPengembalian}
		lenLaporanHilang : longint;			{Penanda banyaknya elemen arrLaporanHilang}
	}

implementation
	
	

	procedure LoadBuku (var arrBuku: BArr; filename : string);
	{Mengisi masukan arrBuku yang kosong dengan elemen-elemen bertipe Buku 
	dari file data buku dengan nama filename}
	{I.S. : arrBuku kosong}
	{F.S. : arrBuku berisi elemen bertipe Buku dari data buku bernama filename}

	{KAMUS LOKAL}
	var
		UserFile : Text;
		i, j, comcount, linecount : integer; 
		temp_string,readstring : string;

	begin

		{INISIALISASI FILE UNTUK DIBACA}
		system.Assign(UserFile, filename);
		system.Reset(UserFile);

		{INISIALISASI VARIABEL}
		i := 1;
		j := 1;
		comcount := 0; 		// Penghitung Koma
		linecount := 0; 	// Penghitung Baris
		readstring := '';	// String yang dibaca dari file
		temp_string := '';	// Variabel sementara untuk menyimpan string 
	
		{MULAI LOAD FILE}
		while(not Eof(UserFile)) do
		begin
			// If pertama dimaksudkan untuk mengacuhkan baris pertama pada file .csv (baris header)
			if (linecount = 0) then
			begin
				readln(UserFile,readstring);
				while(j <= length(readstring)) do
				begin
					inc(j);
				end;
				inc(linecount);
				j := 1;
			end else // Else mulai mengambil baris selain baris header
			begin
				readln(UserFile, readstring);
				while (j <= length(readstring)) do
				begin
					// While loop 1 untuk mengambil char selain ',' dan memasukkan ke atribut tipe sesuai letaknya
					while (readstring[j] <> ',') and (j <= length(readstring)) do
					begin
						// Case berguna untuk menentukan setiap char akan dimasukkan ke atribut mana dalam tipe Buku
						// Penentuan menggunakan jumlah koma pada saat char tersebut diolah
						// Jika jumlah koma = 0, maka char tersebut akan dimasukkan ke atribut sesuai kolom pertama pada format data .csv
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
							end; 
						4 : begin
							temp_string := temp_string + readstring[j];
							end; 
						5 : begin
							arrBuku[i].Kategori := arrBuku[i].Kategori + readstring[j];
							end;  
						end;
					inc(j);
					end;

					// If 1 dimanfaatkan untuk berpindah antara 1 kolom (atribut) ke kolom selanjutnya dengan menambah jumlah koma
					// Jika string (gabungan char pada loop sebelumnya) sudah sesuai dengan tipe atribut yang dimaksudkan, misalnya Judul_Buku : string
					// Maka if ini hanya akan menambahkan jumlah koma, tetapi jika tidak akan dilakukan parsing (perubahan tipe) dari string yang disimpan
					// dalam temp_string menjadi tipe data yang seharusnya untuk atribut tersebut, misalnya Jumlah_Buku : integer
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
		end;

		Close(UserFile);

		

		lenBuku := (linecount-1);
	end;

	procedure PrintBuku (var arrBuku : BArr);
	{Menulis elemen-elemen dari arrBuku ke layar dengan format sesuai data buku}
	{I.S. : arrBuku sudah berisi data dari file buku dan/atau modifikasi di main program}
	{F.S. :	arrBuku tercetak ke layar sesuai format data buku}
	{' | ' digunakan untuk pemisah antar kolom}
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

	procedure LoadUser (var arrUser: UArr; filename : string);
	{Mengisi masukan arrUser yang kosong dengan elemen-elemen bertipe User 
	dari file data user dengan nama filename}
	{I.S. : arrUser kosong}
	{F.S. : arrUser berisi elemen bertipe User dari data user bernama filename}

	{KAMUS LOKAL}
	var
		UserFile : Text;
		i, j, comcount, linecount : integer;
		readstring : string;

	begin

		{INISIALISASI FILE UNTUK DIBACA}
		system.Assign(UserFile, filename);
		system.Reset(UserFile);

		{INISIALISASI VARIABEL}
		i := 1;
		j := 1;
		comcount := 0; 	// Penghitung Koma
		linecount := 0; // Penghitung Baris
		readstring := '';	// String yang dibaca dari file

		{MULAI LOAD FILE}
		while(not Eof(UserFile)) do
		begin
			// If pertama dimaksudkan untuk mengacuhkan baris pertama pada file .csv (baris header)
			if (linecount = 0) then
			begin
				readln(UserFile,readstring);
				while(j <= length(readstring)) do
				begin
					inc(j);
				end;
				inc(linecount);
				j := 1;
			end else // Else mulai mengambil baris selain baris header
			begin
				readln(UserFile, readstring);
				while (j <= length(readstring)) do
				begin
					// While loop 1 untuk mengambil char selain ',' dan memasukkan ke atribut tipe sesuai letaknya
					while (readstring[j] <> ',') and (j <= length(readstring)) do
					begin
						// If untuk menangani cell alamat yang memiliki koma di dalamnya
						if (readstring[j] = '"') then
						begin
							inc(j);
							while (readstring[j] <> '"') do
							begin
								arrUser[i].Alamat := arrUser[i].Alamat + readstring[j];
								inc(j);
							end;
						end else // Else untuk menangani cell yang tidak memiliki koma di dalamnya
						begin
							// Case berguna untuk menentukan setiap char akan dimasukkan ke atribut mana dalam tipe User
							// Penentuan menggunakan jumlah koma pada saat char tersebut diolah
							// Jika jumlah koma = 0, maka char tersebut akan dimasukkan ke atribut sesuai kolom pertama pada format data .csv
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
						end;
					inc(j);
					end;

					// If dimanfaatkan untuk berpindah antara 1 kolom (atribut) ke kolom selanjutnya dengan menambah jumlah koma
					// Jika string (gabungan char pada loop sebelumnya) sudah sesuai dengan tipe atribut yang dimaksudkan, misalnya Judul_Buku : string
					// Maka if ini hanya akan menambahkan jumlah koma, tetapi jika tidak akan dilakukan parsing (perubahan tipe) dari string yang disimpan
					// dalam temp_string menjadi tipe data yang seharusnya untuk atribut tersebut, misalnya Jumlah_Buku : integer
					if (readstring[j] = ',') then
					begin
						inc(j);
						inc(comcount);
					end;
				end;
				comcount := 0;
				j := 1;
				arrUser[i].Status := false;	// Inisialisasi status login user
				inc(i);
				inc(linecount);
			end;
		end;

		Close(UserFile);

		

		lenUser := (linecount-1); // Inisialisasi variabel panjang array
	end;

	procedure PrintUser (var arrUser : UArr);
	{Menulis elemen-elemen dari arrUser ke layar dengan format sesuai data user}
	{I.S. : arrUser sudah berisi data dari file user dan/atau modifikasi di main program}
	{F.S. :	arrUser tercetak ke layar sesuai format data user}
	{' | ' digunakan untuk pemisah antar kolom}
	var
		k : integer;
	begin
		writeln(lenUser);
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

	procedure LoadHistoryPeminjaman (var arrHistoryPeminjaman : PinjamArr ; filename : string);
	{Mengisi masukan arrHistoryPeminajman yang kosong dengan elemen-elemen bertipe HistoryPeminjaman 
	dari file data riwayat peminjaman dengan nama filename}
	{I.S. : arrHistoryPeminjaman kosong}
	{F.S. : arrHistoryPeminjaman berisi elemen bertipe HistoryPeminjaman dari data riwayat peminjaman bernama filename}

	{KAMUS LOKAL}
	var
		UserFile : Text;
		i, j, comcount, linecount : integer;
		temp_string,readstring : string;

	begin

		{INISIALISASI FILE UNTUK DIBACA}
		system.Assign(UserFile, filename);
		system.Reset(UserFile);

		i := 1;
		j := 1;
		comcount := 0; 		// Penghitung Koma
		linecount := 0; 	// Penghitung Baris
		readstring := '';	// String yang dibaca dari file		
		temp_string := '';	// Variabel sementara untuk menyimpan string	

		{MULAI LOAD FILE}
		while(not Eof(UserFile)) do
		begin
			// If pertama dimaksudkan untuk mengacuhkan baris pertama pada file .csv (baris header)
			if (linecount = 0) then
			begin
				readln(UserFile,readstring);
				while(j <= length(readstring)) do
				begin
					inc(j);
				end;
				inc(linecount);
				j := 1;
			end else // Else mulai mengambil baris selain baris header
			begin
				readln(UserFile, readstring);
				while (j <= length(readstring)) do
				begin
					// While loop untuk mengambil char selain ',' dan memasukkan ke atribut tipe sesuai letaknya
					while (readstring[j] <> ',') and (j <= length(readstring)) do
					begin
						// Case berguna untuk menentukan setiap char akan dimasukkan ke atribut mana dalam tipe HistoryPeminjaman
						// Penentuan menggunakan jumlah koma pada saat char tersebut diolah
						// Jika jumlah koma = 0, maka char tersebut akan dimasukkan ke atribut sesuai kolom pertama pada format data .csv
						case comcount of
						0 : begin
							arrHistoryPeminjaman[i].Username := arrHistoryPeminjaman[i].Username + readstring[j];
							end;
						1 : begin
							arrHistoryPeminjaman[i].ID_Buku := arrHistoryPeminjaman[i].ID_Buku + readstring[j];
							end; 
						2 : begin
							temp_string := temp_string + readstring[j];
							end; 
						3 : begin
							temp_string := temp_string + readstring[j];
							end; 
						4 : begin
							temp_string := temp_string + readstring[j];
							end; 
						end;
					inc(j);
					end;

					// If dimanfaatkan untuk berpindah antara 1 kolom (atribut) ke kolom selanjutnya dengan menambah jumlah koma
					// Jika string (gabungan char pada loop sebelumnya) sudah sesuai dengan tipe atribut yang dimaksudkan, misalnya Judul_Buku : string
					// Maka if ini hanya akan menambahkan jumlah koma, tetapi jika tidak akan dilakukan parsing (perubahan tipe) dari string yang disimpan
					// dalam temp_string menjadi tipe data yang seharusnya untuk atribut tersebut, misalnya Jumlah_Buku : integer
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
								arrHistoryPeminjaman[i].Status_Pengembalian := StrToBool(temp_string);
								temp_string := '';
								end;
						end;
						inc(j);
						inc(comcount);
					end;

					// If dimanfaatkan untuk mengindentifikasi kolom terakhir yang tidak memiliki koma, tetapi harus diparse
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

		end;

		Close(UserFile);

		lenHistoryPeminjaman := (linecount-1); // Inisialisasi variabel panjang array
	end;

	procedure PrintHistoryPeminjaman (var arrHistoryPeminjaman : PinjamArr);
	{Menulis elemen-elemen dari arrHistoryPeminjaman ke layar dengan format sesuai data riwayat peminjaman}
	{I.S. : arrHistoryPeminjaman sudah berisi data dari file riwayat peminjaman dan/atau modifikasi di main program}
	{F.S. :	arrHistoryPeminjaman tercetak ke layar sesuai format data riwayat peminjaman}
	{' | ' digunakan untuk pemisah antar kolom}
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

	procedure LoadHistoryPengembalian (var arrHistoryPengembalian : KembaliArr; filename : string);
	{Mengisi masukan arrHistoryPengembalian yang kosong dengan elemen-elemen bertipe HistoryPengembalian 
	dari file data riwayat pengembalian dengan nama filename}
	{I.S. : arrHistoryPengembalian kosong}
	{F.S. : arrHistoryPengembalian berisi elemen bertipe HistoryPengembalian dari data riwayat pengembalian bernama filename}

	{KAMUS LOKAL}
	var
		UserFile : Text;
		i, j, comcount, linecount : integer;
		temp_string,readstring : string;

	begin

		{INISIALISASI FILE UNTUK DIBACA}
		system.Assign(UserFile, filename);
		system.Reset(UserFile);

		{INISIALISASI VARIABEL}
		i := 1;
		j := 1;
		comcount := 0; 		// Penghitung Koma
		linecount := 0; 	// Penghitung Baris
		readstring := '';	// String yang dibaca dari file
		temp_string := '';	// Variabel sementara untuk menyimpan string 

		{MULAI LOAD FILE}
		while(not Eof(UserFile)) do
		begin
			// If pertama dimaksudkan untuk mengacuhkan baris pertama pada file .csv (baris header)
			if (linecount = 0) then
			begin
				readln(UserFile,readstring);
				while(j <= length(readstring)) do
				begin
					inc(j);
				end;
				inc(linecount);
				j := 1;
			end else // Else mulai mengambil baris selain baris header
			begin
				readln(UserFile, readstring);
				while (j <= length(readstring)) do
				begin
					// While loop untuk mengambil char selain ',' dan memasukkan ke atribut tipe sesuai letaknya
					while (readstring[j] <> ',') and (j <= length(readstring)) do
					begin
						// Case berguna untuk menentukan setiap char akan dimasukkan ke atribut mana dalam tipe HistoryPengembalian
						// Penentuan menggunakan jumlah koma pada saat char tersebut diolah
						// Jika jumlah koma = 0, maka char tersebut akan dimasukkan ke atribut sesuai kolom pertama pada format data .csv
						case comcount of
						0 : begin
							arrHistoryPengembalian[i].Username := arrHistoryPengembalian[i].Username + readstring[j];
							end;
						1 : begin
							arrHistoryPengembalian[i].ID_Buku := arrHistoryPengembalian[i].ID_Buku + readstring[j];
							end; 
						2 : begin
							temp_string := temp_string + readstring[j];
							end;
						end;
					inc(j);
					end;

					// If dimanfaatkan untuk berpindah antara 1 kolom (atribut) ke kolom selanjutnya dengan menambah jumlah koma
					// Jika string (gabungan char pada loop sebelumnya) sudah sesuai dengan tipe atribut yang dimaksudkan, misalnya Judul_Buku : string
					// Maka if ini hanya akan menambahkan jumlah koma, tetapi jika tidak akan dilakukan parsing (perubahan tipe) dari string yang disimpan
					// dalam temp_string menjadi tipe data yang seharusnya untuk atribut tersebut, misalnya Jumlah_Buku : integer
					if (readstring[j] = ',') then
					begin
						inc(j);
						inc(comcount);
					end;

					// If dimanfaatkan untuk mengindentifikasi kolom terakhir yang tidak memiliki koma, tetapi harus diparse
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
		end;

		Close(UserFile);

		lenHistoryPengembalian := (linecount-1); // Inisialisasi variabel panjang array
	end;

	procedure PrintHistoryPengembalian (var arrHistoryPengembalian : KembaliArr);
	{Menulis elemen-elemen dari arrHistoryPengembalian ke layar dengan format sesuai data riwayat pengembalian}
	{I.S. : arrHistoryPengembalian sudah berisi data dari file riwayat pengembalian dan/atau modifikasi di main program}
	{F.S. :	arrHistoryPengembalian tercetak ke layar sesuai format data riwayat pengembalian}
	{' | ' digunakan untuk pemisah antar kolom}
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

	procedure LoadLaporanHilang(var arrLaporanHilang : HilangArr; filename : string);
	{Mengisi masukan arrLaporanHilang yang kosong dengan elemen-elemen bertipe LaporanHilang 
	dari file data laporan hilang dengan nama filename}
	{I.S. : arrLaporanHilang kosong}
	{F.S. : arrLaporanHilang berisi elemen bertipe LaporanHilang dari data laporan hilang bernama filename}

	{KAMUS LOKAL}
	var
		UserFile : Text;
		i, j, comcount, linecount : integer;
		temp_string,readstring : string;

	begin

		{INISIALISASI FILE UNTUK DIBACA}
		system.Assign(UserFile, filename);
		system.Reset(UserFile);

		{INISIALISASI VARIABEL}
		i := 1;
		j := 1;
		comcount := 0; 		// Penghitung Koma
		linecount := 0; 	// Penghitung Baris
		readstring := '';	// String yang dibaca dari file
		temp_string := '';	// Variabel sementara untuk menyimpan string

		{MULAI LOAD FILE}
		while(not Eof(UserFile)) do
		begin
			// If pertama dimaksudkan untuk mengacuhkan baris pertama pada file .csv (baris header)
			if (linecount = 0) then
			begin
				readln(UserFile,readstring);
				while(j <= length(readstring)) do
				begin
					inc(j);
				end;
				inc(linecount);
				j := 1;
			end else // Else mulai mengambil baris selain baris header
			begin
				readln(UserFile, readstring);
				while (j <= length(readstring)) do
				begin
					// While loop untuk mengambil char selain ',' dan memasukkan ke atribut tipe sesuai letaknya
					while (readstring[j] <> ',') and (j <= length(readstring)) do
					begin
						// Case berguna untuk menentukan setiap char akan dimasukkan ke atribut mana dalam tipe user
						// Penentuan menggunakan jumlah koma pada saat char tersebut diolah
						// Jika jumlah koma = 0, maka char tersebut akan dimasukkan ke atribut sesuai kolom pertama pada format data .csv
						case comcount of
						0 : begin
							arrLaporanHilang[i].Username := arrLaporanHilang[i].Username + readstring[j];
							end;
						1 : begin
							arrLaporanHilang[i].ID_Buku_Hilang := arrLaporanHilang[i].ID_Buku_Hilang + readstring[j];
							end; 
						2 : begin
							temp_string := temp_string + readstring[j];
							end;
						end;
					inc(j);
					end;

					// If dimanfaatkan untuk berpindah antara 1 kolom (atribut) ke kolom selanjutnya dengan menambah jumlah koma
					// Jika string (gabungan char pada loop sebelumnya) sudah sesuai dengan tipe atribut yang dimaksudkan, misalnya Judul_Buku : string
					// Maka if ini hanya akan menambahkan jumlah koma, tetapi jika tidak akan dilakukan parsing (perubahan tipe) dari string yang disimpan
					// dalam temp_string menjadi tipe data yang seharusnya untuk atribut tersebut, misalnya Jumlah_Buku : integer
					if (readstring[j] = ',') then
					begin
						inc(j);
						inc(comcount);
					end;

					// If dimanfaatkan untuk mengindentifikasi kolom terakhir yang tidak memiliki koma, tetapi harus diparse
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
		end;

		Close(UserFile);

		lenLaporanHilang := (linecount-1); // Inisialisasi variabel panjang array
	end;

	procedure PrintLaporanHilang(var arrLaporanHilang : HilangArr);
	{Menulis elemen-elemen dari arrLaporanHilang ke layar dengan format sesuai data laporan hilang}
	{I.S. : arrLaporanHilang sudah berisi data dari file laporan hilang dan/atau modifikasi di main program}
	{F.S. :	arrLaporanHilang tercetak ke layar sesuai format data laporan hilang}
	{' | ' digunakan untuk pemisah antar kolom}
	var
		k : integer;
	begin
		for k := 1 to (lenLaporanHilang) do
		begin
			write(k);
			write(' | ');
			write(arrLaporanHilang[k].Username);
			write(' | ');
			write(arrLaporanHilang[k].ID_Buku_Hilang);
			write(' | ');
			WriteDate(arrLaporanHilang[k].Tanggal_Laporan);
			writeln();
		end;
	end;

end. 