unit lapor_hilang;


interface

uses uDate, uFileLoader;
		
	procedure LaporKehilangan(var arrlaporanHilang : HilangArr ; arrBuku : BArr; UserIn : User);
	{Mengisi data yang diinputkan oleh pengguna untuk melaporkan buku yang hilang ke dalam 
	array Laporan Hilang}
	{I.S. : arrLaporanHilang sudah berisi data dari file riwayat laporan hilang dan/atau modifikasi di main program}
	{F.S. :	arrLaporanHilang tercetak ke layar sesuai format data riwayat laporan hilang}
	
implementation

	procedure LaporKehilangan(var arrlaporanHilang : HilangArr ; arrBuku : BArr; UserIn : User);

	var
		tanggallaporstring, judulbukuhilang, idhilang : string;
		i, indexlost : integer;

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
		
		
	end;
end.