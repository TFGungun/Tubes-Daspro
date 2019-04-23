//==================================================================//
//                              uHilang                             //
//------------------------------------------------------------------//
//  Unit yang menangani hal-hal yang berhubungan dengan kehilangan  //
//==================================================================//
unit uHilang;

interface
	uses uFileLoader, uDate, Crt;

	procedure PrintLaporanWithJudul(var arrLaporanHilang : HilangArr ; arrBuku : BArr);
	{Menulis laporan hilang dengan format
	 ID_Buku_Hilang | Judul_Buku | Tanggal_Laporan}
	{I.S. : arrLaporanHilang dan arrBuku sudah berisi data dari file laporan hilang serta buku 
	dan/atau modifikasi di main program}
	{F.S. : laporan hilang tercetak ke layar sesuai format
	ID_Buku_Hilang | Judul_Buku | Tanggal_Laporan}

	function CariJudulBuku(var arrBuku : Barr ; ID_Buku : string) : string;
	{Menghasilkan string Judul_Buku dari buku dengan id ID_Buku}

	procedure LaporKehilangan(var arrlaporanHilang : HilangArr ; arrBuku : BArr; UserIn : User);
	{Mengisi data yang diinputkan oleh pengguna untuk melaporkan buku yang hilang ke dalam 
	array Laporan Hilang}
	{I.S. : arrLaporanHilang sudah berisi data dari file riwayat laporan hilang dan/atau modifikasi di main program}
	{F.S. :	arrLaporanHilang tercetak ke layar sesuai format data riwayat laporan hilang}
	
	procedure PrintLaporanHilang(var arrLaporanHilang : HilangArr);
	{Menulis elemen-elemen dari arrLaporanHilang ke layar dengan format sesuai data laporan hilang}
	{I.S. : arrLaporanHilang sudah berisi data dari file laporan hilang dan/atau modifikasi di main program}
	{F.S. :	arrLaporanHilang tercetak ke layar sesuai format data laporan hilang}
	{' | ' digunakan untuk pemisah antar kolom}

implementation
	
	procedure PrintLaporanWithJudul(var arrLaporanHilang : HilangArr ; arrBuku : BArr);
	{Menulis laporan hilang dengan format
	 ID_Buku_Hilang | Judul_Buku | Tanggal_Laporan}
	{I.S. : arrLaporanHilang dan arrBuku sudah berisi data dari file laporan hilang serta buku 
	dan/atau modifikasi di main program}
	{F.S. : laporan hilang tercetak ke layar sesuai format
	ID_Buku_Hilang | Judul_Buku | Tanggal_Laporan}

	{ KAMUS LOKAL }
	var
		i : integer;

	{ ALGORITMA }
	begin
		writeln('Buku yang hilang');
		
		for i := 1 to lenLaporanHilang do
		begin
			write(arrLaporanHilang[i].ID_Buku_Hilang);
			write(' | ');
			write(CariJudulBuku(arrBuku, arrLaporanHilang[i].ID_Buku_Hilang));
			write(' | ');
			WritelnDate(arrLaporanHilang[i].Tanggal_Laporan);
		end;

		writeln();
		writeln('Ketik 0 untuk kembali ke menu.');
		readln();
		ClrScr;
	end;

	function CariJudulBuku(var arrBuku : Barr ; ID_Buku : string) : string;
	{Menghasilkan string Judul_Buku dari buku dengan id ID_Buku}
	
	{ KAMUS LOKAL }
	var
		i : integer;
		isfound : boolean;

	{ ALGORITMA }
	begin
		i := 1;
		isfound := false;
		while ((not isfound) and (i <= lenBuku)) do
		begin
			if(arrBuku[i].ID_Buku = ID_Buku) then
			begin
				CariJudulBuku := arrBuku[i].Judul_Buku;
				isfound := true;
			end else
			begin
				inc(i);
			end;
		end;

	end;

	procedure LaporKehilangan(var arrlaporanHilang : HilangArr ; arrBuku : BArr; UserIn : User);
	{Mengisi data yang diinputkan oleh pengguna untuk melaporkan buku yang hilang ke dalam 
	array Laporan Hilang}
	{I.S. : arrLaporanHilang sudah berisi data dari file riwayat laporan hilang dan/atau modifikasi di main program}
	{F.S. :	arrLaporanHilang tercetak ke layar sesuai format data riwayat laporan hilang}

	{ KAMUS LOKAL }
	var
		tanggallaporstring, judulbukuhilang, idhilang : string;
		i, indexlost : integer;

	{ ALGORITMA }
	begin
		// Pengguna menginput id buku yang berbentuk string yang kemudian disimpan
		// di array LaporanHilang
		write('Masukkan id buku: ');
		readln(idhilang);
		arrLaporanHilang[lenLaporanHilang + 1].ID_Buku_Hilang := idhilang;
		
		// untuk mencari indeks ke-i dari buku yang hilang
		for i := 1 to lenBuku do
		begin
			if arrBuku[i].ID_Buku = idhilang then
			begin
				indexlost := i;
			end;
		end;
		
		
		write('Masukkan judul buku: ');
		readln(judulbukuhilang);
		
		// Pengguna menginput tanggal laporan kehilangan yang berbentuk string dan menyimpan
		// nilainya ke dalam array LaporanHilang
		write('Masukkan tanggal pelaporan: ');
		readln(tanggallaporstring);
		arrLaporanHilang[lenLaporanHilang + 1].Tanggal_Laporan := ParseDate(tanggallaporstring);

		// Username pengguna diimpor dari program utama
		arrLaporanHilang[lenLaporanHilang + 1].Username := UserIn.username;
		
		// Setiap penggguna melakukan laporan, panjang array bertambah 1
		lenLaporanHilang := lenLaporanHilang + 1;
		
		writeln('Laporan Berhasil Diterima');
		
		writeln();
		writeln('Ketik 0 untuk kembali ke menu.');
		readln();
		ClrScr;
		
	end;

	procedure PrintLaporanHilang(var arrLaporanHilang : HilangArr);
	{Menulis elemen-elemen dari arrLaporanHilang ke layar dengan format sesuai data laporan hilang}
	{I.S. : arrLaporanHilang sudah berisi data dari file laporan hilang dan/atau modifikasi di main program}
	{F.S. :	arrLaporanHilang tercetak ke layar sesuai format data laporan hilang}
	{' | ' digunakan untuk pemisah antar kolom}

	{KAMUS LOKAL}
	var
		k : integer;

	{ALGORITMA}
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
