Program ABC;

//uses //uFileLoader, cari, uDate, sysutilsmanual;
uses uFileLoader, uAnggota, uHilang, uFileSaver, tambah_buku, registrasi, PeminjamanBuku, riwayat_peminjaman;

var
	arrBuku : array[1..1000] of Buku;
	arrUser : array[1..1000] of User;
	arrHistoryPeminjaman : array[1..1000] of HistoryPeminjaman;
	arrHistoryPengembalian : array[1..1000] of HistoryPengembalian;
	arrLaporanHilang : array[1..1000] of LaporanHilang;
	k : integer;
	//a,d : Date;
	b,c, bukufilename : string;

begin
	{
	write('Masukkan nama file buku: ');
	readln(bukufilename);
	writeln('Data Buku');
	LoadBuku(arrBuku, bukufilename);
	PrintBuku(arrBuku);
	add(arrBuku);
	writeln(lenBuku);
	PrintBuku(arrBuku);
	write('Masukkan nama file Buku: ');
	readln(bukufilename);
	SaveBuku(arrBuku, bukufilename);
}
	{
	write('Masukkan nama file user: ');
	readln(bukufilename);
	writeln('Data User');
	LoadUser(arrUser, bukufilename);
	Printuser(arrUser);
	regis(arrUser);
	writeln(lenUser);
	PrintUser(arrUser);

    writeln(arrUser[lenUser-1].Nama);
    writeln(arrUser[lenUser-1].Alamat);
    writeln(arrUser[lenUser-1].Username);
    writeln(arrUser[lenUser-1].Password);
    writeln(arrUser[lenUser-1].Role);

	write('Masukkan nama file user: ');
	readln(bukufilename);
	SaveUser(arrUser, bukufilename);
}
	write('Masukkan nama file user: ');
	readln(bukufilename);
	writeln('Data User');
	LoadUser(arrUser, bukufilename);
	Printuser(arrUser);
	CariAnggota(arrUser);
{
	write('Masukkan nama file buku: ');
	readln(bukufilename);
	writeln('Data Buku');
	LoadBuku(arrBuku, bukufilename);
	PrintBuku(arrBuku);

	write('Masukkan nama file Peminjaman: ');
	readln(bukufilename);
	writeln('Data Peminjaman');
	LoadHistoryPeminjaman(arrHistoryPeminjaman, bukufilename);
	PrintHistoryPeminjaman(arrHistoryPeminjaman);
	cek_riwayat(arrHistoryPeminjaman, arrBuku);
	writeln(lenHistoryPeminjaman);
	PrintHistoryPeminjaman(arrHistoryPeminjaman);

	write('Masukkan nama file Peminjaman: ');
	readln(bukufilename);
	SaveHistoryPeminjaman(arrHistoryPeminjaman, bukufilename);
}
{
	write('Masukkan nama file buku: ');
	readln(bukufilename);
	writeln('Data Buku');
	LoadBuku(arrBuku, bukufilename);
	PrintBuku(arrBuku);

	write('Masukkan nama file Peminjaman: ');
	readln(bukufilename);
	writeln('Data Peminjaman');
	LoadHistoryPeminjaman(arrHistoryPeminjaman, bukufilename);
	PrintHistoryPeminjaman(arrHistoryPeminjaman);

	write('Masukkan nama file Pengembalian: ');
	readln(bukufilename);
	writeln('Data Pengembalian');
	LoadHistoryPengembalian(arrHistoryPengembalian, bukufilename);
	PrintHistoryPengembalian(arrHistoryPengembalian);
	//cek_riwayat(arrHistoryPengembalian, arrBuku);
	//writeln(lenHistoryPengembalian);
	//PrintHistoryPengembalian(arrHistoryPengembalian);

	write('Masukkan nama file Pengembalian: ');
	readln(bukufilename);
	SaveHistoryPengembalian(arrHistoryPengembalian, bukufilename);}

{
	write('Masukkan nama file buku: ');
	readln(bukufilename);
	writeln('Data Buku');
	LoadBuku(arrBuku, bukufilename);
	PrintBuku(arrBuku);

	write('Masukkan nama file Peminjaman: ');
	readln(bukufilename);
	writeln('Data Peminjaman');
	LoadHistoryPeminjaman(arrHistoryPeminjaman, bukufilename);
	PrintHistoryPeminjaman(arrHistoryPeminjaman);

	write('Masukkan nama file Laporan Hilang: ');
	readln(bukufilename);
	writeln('Data Laporan Hilang');
	LoadLaporanHilang(arrLaporanHilang, bukufilename);
	PrintLaporanHilang(arrLaporanHilang);
	//cek_riwayat(arrHistoryPengembalian, arrBuku);
	//writeln(lenHistoryPengembalian);
	//PrintHistoryPengembalian(arrHistoryPengembalian);

	write('Masukkan nama file Laporan Hilang: ');
	readln(bukufilename);
	SaveLaporanHilang(arrLaporanHilang, bukufilename);
}

{
	writeln('');
	writeln('Data User');
	LoadUser(arrUser);

	PrintUser(arrUser);
	writeln('');
	writeln('Data History Peminjaman');
	LoadHistoryPeminjaman(arrHistoryPeminjaman);
	PrintHistoryPeminjaman(arrHistoryPeminjaman);
	writeln('');
	writeln('Data History Pengembalian');
	LoadHistoryPengembalian(arrHistoryPengembalian);
	PrintHistoryPengembalian(arrHistoryPengembalian);
	writeln('');

	writeln('Data Laporan Kehilangan');
	LoadLaporanHilang(arrLaporanHilang);
	PrintLaporanHilang(arrLaporanHilang);
	PrintLaporanWithJudul(arrLaporanHilang)
	writeln('');}
	{
	for k := 1 to (uFileLoader.GetSizeBuku()) do
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
	LoadUser(arrUser);
	PrintUser(arrUser);
	for k := 1 to (GetSizeUser()) do
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
	}
end.