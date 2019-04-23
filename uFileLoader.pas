//====================================================//
//                    uFileLoader                     //
//----------------------------------------------------//
//  Unit yang menangani loading data ke main program  //
//====================================================//

unit uFileLoader;

interface
	uses uDate, parsertuanyon, Crt;

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

	procedure countPengguna(arrUser: UArr);
	{ menghitung dan mencetak jumlah anggota; admin dan pengunjung }

	procedure countBuku(arrBuku: BArr);
	{ menghitung dan mencetak jumlah buku berdasarkan kategori }

	procedure list_statistik (var arrBuku: BArr; var arrUser: UArr);
	{ memanggil prosedur countPengguna dan countBuku }

	{KAMUS GLOBAL}
	var
		lenBuku : longint;					{Penanda banyaknya elemen arrBuku}
		lenUser : longint;					{Penanda banyaknya elemen arrUser}
		lenHistoryPeminjaman : longint;		{Penanda banyaknya elemen arrHistoryPeminjaman}
		lenHistoryPengembalian : longint;	{Penanda banyaknya elemen arrHistoryPengembalian}
		lenLaporanHilang : longint;			{Penanda banyaknya elemen arrLaporanHilang}

implementation
	
	procedure LoadBuku (var arrBuku: BArr; filename : string);
	{Mengisi masukan arrBuku yang kosong dengan elemen-elemen bertipe Buku 
	dari file data buku dengan nama filename}
	{I.S. : arrBuku kosong}
	{F.S. : arrBuku berisi elemen bertipe Buku dari data buku bernama filename}

	{ KAMUS LOKAL }
	var
		UserFile : Text;
		i, j, comcount, linecount : integer; 
		temp_string,readstring : string;

	{ ALGORITMA }
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

	procedure LoadUser (var arrUser: UArr; filename : string);
	{Mengisi masukan arrUser yang kosong dengan elemen-elemen bertipe User 
	dari file data user dengan nama filename}
	{I.S. : arrUser kosong}
	{F.S. : arrUser berisi elemen bertipe User dari data user bernama filename}

	{ KAMUS LOKAL }
	var
		UserFile : Text;
		i, j, comcount, linecount : integer;
		readstring : string;

	{ ALGORITMA }
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

	procedure LoadHistoryPeminjaman (var arrHistoryPeminjaman : PinjamArr ; filename : string);
	{Mengisi masukan arrHistoryPeminajman yang kosong dengan elemen-elemen bertipe HistoryPeminjaman 
	dari file data riwayat peminjaman dengan nama filename}
	{I.S. : arrHistoryPeminjaman kosong}
	{F.S. : arrHistoryPeminjaman berisi elemen bertipe HistoryPeminjaman dari data riwayat peminjaman bernama filename}

	{ KAMUS LOKAL }
	var
		UserFile : Text;
		i, j, comcount, linecount : integer;
		temp_string,readstring : string;

	{ ALGORITMA }
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

	procedure LoadHistoryPengembalian (var arrHistoryPengembalian : KembaliArr; filename : string);
	{Mengisi masukan arrHistoryPengembalian yang kosong dengan elemen-elemen bertipe HistoryPengembalian 
	dari file data riwayat pengembalian dengan nama filename}
	{I.S. : arrHistoryPengembalian kosong}
	{F.S. : arrHistoryPengembalian berisi elemen bertipe HistoryPengembalian dari data riwayat pengembalian bernama filename}

	{ KAMUS LOKAL }
	var
		UserFile : Text;
		i, j, comcount, linecount : integer;
		temp_string,readstring : string;

	{ ALGORITMA }
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

	procedure LoadLaporanHilang(var arrLaporanHilang : HilangArr; filename : string);
	{Mengisi masukan arrLaporanHilang yang kosong dengan elemen-elemen bertipe LaporanHilang 
	dari file data laporan hilang dengan nama filename}
	{I.S. : arrLaporanHilang kosong}
	{F.S. : arrLaporanHilang berisi elemen bertipe LaporanHilang dari data laporan hilang bernama filename}

	{ KAMUS LOKAL }
	var
		UserFile : Text;
		i, j, comcount, linecount : integer;
		temp_string,readstring : string;

	{ ALGORITMA }
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

	procedure countPengguna(arrUser: UArr);
	{ menghitung dan mencetak jumlah anggota; admin dan pengunjung }

	{ KAMUS }
	var
		a, p, i: Integer; { a untuk menghitung jumlah admin, p untuk pengurus, i sebagai indeks array user}

	{ ALGORITMA }
	begin
		a := 0;					{ inisialisasi }
		p := 0;
		for i:= 1 to lenUser do { EOP : i = banyak data user }
			begin
				if(arrUser[i].Role = 'Admin') then { proses kasus role user = Admin }
					begin
						a:=a+1;
					end
				else { arrUser[i].Role = 'Pengunjung'; proses kasus role user = Pengunjung }
					begin
						p:=p+1;
					end;
			end;
		writeln('Admin | ', a);
		writeln('Pengunjung | ', p);
		writeln('Total | ', a+p);
	end;

	procedure countBuku(arrBuku: BArr);
	{ menghitung dan mencetak jumlah buku berdasarkan kategori }
	
	{ KAMUS }
	var
	i, sastra, sains, sejarah, manga, programming : integer;
	{ i indeks array buku, sastra menghitung jumlah buku kategori sastra,
	  sains menghitung jumlah buku kategori sains,
	  sejarah menghitung jumlah buku kategori sejarah,
	  manga menghitung jumlah buku kategori manga,
	  programming menghitung jumlah buku kategori programming
	}
	
	{ ALGORITMA }
	begin

	{ inisialisasi }
	sastra := 0;
	sains := 0;
	sejarah := 0;
	manga := 0;
	programming := 0;
	
	for i:=1 to lenBuku do { EOP : i = banyak data buku}
		begin
		if (arrBuku[i].Kategori = 'sastra') then { proses kasus kategori pada array = sastra }
			begin
			sastra := sastra + 1;
			end
		
		else if (arrBuku[i].Kategori = 'sains') then { proses kasus kategori pada array = sains }
			begin
			sains := sains + 1;
			end
		
		else if (arrBuku[i].Kategori = 'sejarah') then { proses kasus kategori pada array = sejarah }
			begin
			sejarah := sejarah + 1;
			end
	
		else if (arrBuku[i].Kategori = 'manga') then { proses kasus kategori pada array = manga }
			begin
			manga := manga + 1;
			end
	
		else if (arrBuku[i].Kategori = 'programming') then { proses kasus kategori pada array = programming }
			begin
			programming := programming + 1;
			end;
		end;

	writeln('sastra | ',sastra);
	writeln('sains | ',sains);
	writeln('sejarah | ',sejarah);
	writeln('manga | ',manga);
	writeln('programming | ',programming);
	writeln('Total | ', sastra+sains+sejarah+manga+programming);
	end;

	procedure list_statistik( var arrBuku: BArr; var arrUser: UArr);
	{ memanggil prosedur countPengguna dan countBuku }

	{ ALGORITMA }
	begin
		writeln('Pengguna: ');
		countPengguna(arrUser);
		writeln('Buku:');
		countBuku(arrBuku);
		writeln();
		writeln('Ketik 0 untuk kembali ke menu.');
		readln();
		ClrScr;
	end;

end. 