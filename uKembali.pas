//====================================================================//
//                              uKembali                              //
//--------------------------------------------------------------------//
//  Unit yang menangani hal-hal yang berhubungan dengan pengembalian  //
//====================================================================//
unit uKembali;

interface
	uses uFileLoader, udate, Crt;

	function isThnKabisat(j:integer): boolean;
	{ Menghasilkan true jika tahun adalah tahun kabisat dan false jika tidak }
	
	function convertBulantoHari(m, y: integer): integer;
	{ Mengkonversikan bulan menjadi hari }
	
	function convertTahuntoHari(y: integer): Integer;
	{ Mngkonversikan tahun menjadi hari }
	
	procedure denda(var tk, bk, hk, tbk, bbk, hbk: integer);
	{ Menampilkan jumlah hari keterlambatan dan besar dendanya }
	{I.S. : input tahun, bulan, dan hari pengembalian serta batas pengembalian belum berupa hari }
	{F.S. : input tahun, bulan, dan hari pengembalian serta batas pengembalian telah dikonversikan menjadi hari dan
			menampilkan selisihnya (jumlah hari keterlambatan) dan dikali 2000 sebagai besar dendanya }

	procedure KembalikanBuku (var arrHistoryPengembalian : KembaliArr ; var arrHistoryPeminjaman : PinjamArr; var arrBuku : BArr ; UserIn : User);
	{Mengisi data yang diinputkan oleh pengguna ke dalam arrHistoryPengembalian}
	{I.S. : arrHistoryPengembalian sudah berisi data dari file riwayat peminjaman dan/atau modifikasi di main program}
	{F.S. :	arrHistoryPengembalian tercetak ke layar sesuai format data riwayat pengembalian}

	procedure PrintHistoryPengembalian (var arrHistoryPengembalian : KembaliArr);
	{Menulis elemen-elemen dari arrHistoryPengembalian ke layar dengan format sesuai data riwayat pengembalian}
	{I.S. : arrHistoryPengembalian sudah berisi data dari file riwayat pengembalian dan/atau modifikasi di main program}
	{F.S. :	arrHistoryPengembalian tercetak ke layar sesuai format data riwayat pengembalian}

implementation

	function isThnKabisat(j:integer): boolean;
	{ Menghasilkan true jika tahun adalah tahun kabisat dan false jika tidak }

	{ ALGORITMA }
	begin
		isThnKabisat := (j mod 4 = 0) and (j mod 100 <> 0) or (j mod 400 = 0);
	end;

	function convertBulantoHari(m, y: integer): integer;
	{ Mengkonversikan bulan menjadi hari }

	{ KAMUS LOKAL }
	var
		jml_hari, i: Integer;

	{ ALGORITMA }
	begin
		if(m = 1) then
			begin
				convertBulantoHari := 0; { fungsi mengembalikan 0 jika input bulan = 1 }
			end
		else
			begin
				jml_hari := 0;			{ inisialisasi }
				for i:=1 to (m-1) do 	{ EOP: i = m-1 }
					begin
						if((i = 2) and (isThnKabisat(y))) then { proses kasus jika bulan = Februari dan tahun adalah kabisat }
							begin
								jml_hari := jml_hari + 29;
							end
						else if((i=2) and (not isThnKabisat(y))) then { proses kasus jika bulan = Februari dan tahun bukan kabisat }
							begin
								jml_hari := jml_hari + 28;
							end
						else if((i<=7) and (i mod 2 = 1)) then { proses kasus jika bulan <= Juli dan merupakan bulan ganjil }
							begin
								jml_hari := jml_hari + 31;
							end
						else if((i>7) and (i mod 2 = 0)) then { proses kasus jika bulan > Juli dan merupakan bulan genap }
							begin
								jml_hari := jml_hari + 31;
							end
						else { bulan genap <= Juli atau bulan ganjil > Juli }
							begin
								jml_hari := jml_hari + 30;
							end;
					end;
				convertBulantoHari := jml_hari; { fungsi mengembalikan jumlah hari }
			end;
	end;

	function convertTahuntoHari(y: integer): Integer;
	{ Mngkonversikan tahun menjadi hari }
	
	{ KAMUS LOKAL }
	var
		jml_hari, i: Integer;

	{ ALGORITMA }
	begin
		jml_hari:=0;		{ inisialisasi }
		for i:=0 to y do 	{ EOP : i = y }
			begin
				if(isThnKabisat(y)) then	{ proses kasus tahun adalah kabisat }
					begin
						jml_hari := jml_hari + 366;
						end
				else						{ proses kasus tahun bukan kabisat }
					begin
						jml_hari := jml_hari + 365;
					end;
			end;
		convertTahuntoHari := jml_hari; { fungsi mengembalikan jumlah hari }
	end;

	procedure denda(var tk, bk, hk, tbk, bbk, hbk: integer);
	{ Menampilkan jumlah hari keterlambatan dan besar dendanya }
	{I.S. : input tahun, bulan, dan hari pengembalian serta batas pengembalian belum berupa hari }
	{F.S. : input tahun, bulan, dan hari pengembalian serta batas pengembalian telah dikonversikan menjadi hari dan
			menampilkan selisihnya (jumlah hari keterlambatan) dan dikali 2000 sebagai besar dendanya }

	{ KAMUS LOKAL }
	var
		fine, days : integer;

	{ ALGORITMA }
	begin
		days:= (convertTahuntoHari(tk) + hk + convertBulantoHari(bk, tk) - convertTahuntoHari(tbk) -
		hbk - convertBulantoHari(bbk, tbk));
		begin
			fine:=days*2000;
			writeln('Anda terlambat mengembalikan buku ', days, ' hari.');
			writeln('Anda terkena denda ', fine, ' rupiah.');
		end;		
	end;

	procedure KembalikanBuku (var arrHistoryPengembalian : KembaliArr ; var arrHistoryPeminjaman : PinjamArr; var arrBuku : BArr ; UserIn : User);
	{Mengisi data yang diinputkan oleh pengguna ke dalam arrHistoryPengembalian}
	{I.S. : arrHistoryPengembalian sudah berisi data dari file riwayat peminjaman dan/atau modifikasi di main program}
	{F.S. :	arrHistoryPengembalian tercetak ke layar sesuai format data riwayat pengembalian}

	{ KAMUS LOKAL }
	var 
	idkembali, judulbuku : string;
	i, TahunKembali, BulanKembali, HariKembali, TahunBatasKembali, BulanBatasKembali, HariBatasKembali : integer;
	tanggalkembalistring : string;

	{ ALGORITMA }
	begin
		// Pengguna menginput id buku yang bertype string yang kemudian disimpan
		// di array History Peminjaman
		write('Masukkan id buku yang ingin dikembalikan: ');
		readln(idkembali);
		arrHistoryPengembalian[lenhistorypengembalian + 1].ID_Buku := idkembali;
		writeln('Data Peminjam: ');

		// For loop untuk mencari data buku
		for i := 1 to (lenbuku) do
		begin
			if arrBuku[i].ID_Buku = idkembali then
			begin
				judulbuku := arrBuku[i].Judul_Buku;
				arrBuku[i].Jumlah_Buku := arrBuku[i].Jumlah_Buku + 1;
			end;
		end;

		// Untuk menampilkan Username, Judul Buku, Tanggal Peminjaman, serta Tanggal Batas Pengembalian 
		for i:= 1 to (lenhistorypeminjaman) do
		begin
			if (arrHistoryPeminjaman[i].ID_Buku = idkembali) and (arrHistoryPeminjaman[i].Username = UserIn.Username) then // tambah username untuk mengantisipasi ada 1 buku yang dipinjam 2 user
			begin
			writeln('Username: ', arrHistoryPeminjaman[i].Username);
			writeln('Judul_Buku: ', judulbuku);
			write('Tanggal Peminjaman: ');
			writelnDate(arrHistoryPeminjaman[i].Tanggal_Peminjaman);
			write('Tanggal Batas Pengembalian: ');
			writelnDate(arrHistoryPeminjaman[i].Tanggal_Batas_Pengembalian);
			TahunBatasKembali := arrHistoryPeminjaman[i].Tanggal_Batas_Pengembalian.YYYY;
			BulanBatasKembali := arrHistoryPeminjaman[i].Tanggal_Batas_Pengembalian.MM;
			HariBatasKembali := arrHistoryPeminjaman[i].Tanggal_Batas_Pengembalian.DD;
			arrHistoryPeminjaman[i].Status_Pengembalian := true;
			end;
		end;

		// Pengguna menginput tanggal bertipe string
		write('Masukkan tanggal hari ini: ');
		readln(tanggalkembalistring);

		// untuk mengubah type tanggal yang berbentuk string menjadi type date 
		arrHistoryPengembalian[lenhistorypengembalian + 1].Tanggal_Pengembalian := ParseDate(tanggalkembalistring);
		arrHistoryPengembalian[lenhistorypengembalian + 1].Username := UserIn.Username;
		TahunKembali := arrHistoryPengembalian[lenhistorypengembalian + 1].Tanggal_Pengembalian.YYYY;
		BulanKembali := arrHistoryPengembalian[lenhistorypengembalian + 1].Tanggal_Pengembalian.MM;
		HariKembali := arrHistoryPengembalian[lenhistorypengembalian + 1].Tanggal_Pengembalian.DD;
		lenhistorypengembalian := lenhistorypengembalian + 1;

		// Membandingkan tanggal batas kembali dengan tanggal kembali untuk mengeluarkan output
		// berupa message yang telah ditentukan
		if (TahunBatasKembali = TahunKembali) then
		begin
			if (BulanBatasKembali = BulanKembali) then
			begin
				if (HariBatasKembali >= HariKembali) then
				begin
					writeln('Terima kasih sudah meminjam');
				end else
				begin
					denda(TahunKembali, BulanKembali, HariKembali, TahunBatasKembali, BulanBatasKembali, HariBatasKembali);
				end;
			end else if (BulanBatasKembali > BulanKembali) then
			begin
				writeln('Terima kasih sudah meminjam');
			end else
			begin
				denda(TahunKembali, BulanKembali, HariKembali, TahunBatasKembali, BulanBatasKembali, HariBatasKembali);
			end;
		end else if (TahunBatasKembali > TahunKembali) then
		begin
			writeln('Terima kasih sudah meminjam');
		end else
		begin
			denda(TahunKembali, BulanKembali, HariKembali, TahunBatasKembali, BulanBatasKembali, HariBatasKembali);
		end;
	writeln();
	writeln('Ketik 0 untuk kembali ke menu.');
	readln();
	ClrScr;
	end;

	procedure PrintHistoryPengembalian (var arrHistoryPengembalian : KembaliArr);
	{Menulis elemen-elemen dari arrHistoryPengembalian ke layar dengan format sesuai data riwayat pengembalian}
	{I.S. : arrHistoryPengembalian sudah berisi data dari file riwayat pengembalian dan/atau modifikasi di main program}
	{F.S. :	arrHistoryPengembalian tercetak ke layar sesuai format data riwayat pengembalian}
	{' | ' digunakan untuk pemisah antar kolom}
	
	{ KAMUS LOKAL }
	var
		k : integer;
	
	{ ALGORITMA }
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
	writeln();
	writeln('Ketik 0 untuk kembali ke menu.');
	readln();
	ClrScr;
	end;
end.
