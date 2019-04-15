Program main;

uses
	uFileLoader, uDate,
	cari, caritahunterbit, login, pencarian_kategori, riwayat_peminjaman, statistik,
	tambah_buku, tambah_jumlah_buku;

var
	arrBuku : array[1..1000] of Buku;
	arrUser : array[1..1000] of User;
	arrHistoryPeminjaman : array[1..1000] of HistoryPeminjaman;
	arrHistoryPengembalian : array[1..1000] of HistoryPengembalian;
	arrLaporanHilang : array[1..1000] of LaporanHilang;
	k : integer;
	x, filename : string;

procedure Load_File();
begin
	write('Masukkan nama File Buku: ');
	readln(filename);
	LoadBuku(arrBuku, filename);
	writeln('');


	write('Masukkan nama File User: ');
	readln(filename);
	LoadUser(arrUser, filename);
	writeln('');


	write('Masukkan nama File Peminjaman: ');
	readln(filename);
	LoadHistoryPeminjaman(arrHistoryPeminjaman, filename);
	writeln('');

	write('Masukkan nama File Pengembalian: ');
	readln(filename);
	LoadHistoryPengembalian(arrHistoryPengembalian, filename);
	writeln('');

	write('Masukkan nama File Buku hilang: ');
	readln(filename);
	LoadLaporanHilang(arrLaporanHilang, filename);
	writeln('');
end;
procedure Menu_Admin();
begin
	writeln('$ register : daftar anggota perpustakaan baru');
	writeln('$ cari : cari buku berdasarkan kategori');
	writeln('$ caritahunterbit : cari buku berdasarkan tahun terbit');
	writeln('$ lihat_laporan : melihat daftar laporan buku hilang');
	writeln('$ tambah_buku : isi untuk mendata buku baru');
	writeln('$ tambah_jumlah_buku : isi untuk mendata tambahan jumlah buku');
	writeln('$ riwayat : melihat riwayat peminjaman user');
	writeln('$ statistik : melihat statistik pengguna dan buku');
	writeln('$ cari_anggota : melihat data anggota perpustakaan');
	writeln('$ save : menyimpan data');
	writeln('$ logout : keluar');
	writeln('$ exit : keluar program');
	readln(x);
	case x of
		'cari': begin
					search(arrBuku);			
				end;
		'caritahunterbit': begin
								year(arrBuku);
							end;
		'lihat_laporan': begin
						
						end;
		'tambah_buku': begin
							add(arrBuku);
						end;
		'tambah_jumlah_buku': begin
								amount(arrBuku);
								end;
		'riwayat': begin
						cek_riwayat(arrPeminjaman, arrBuku);
					end;
		'statisik': begin
						list_statistik(arrBuku, arrUser);
					end;
		'cari_anggota': begin
							
						end;
		'save': begin
				
				end;
		'logout': begin
			
					end;
		'exit': begin
			
				end;
end;

procedure Menu_Pengunjung_L();
begin
	writeln('$ cari : cari buku berdasarkan kategori');
	writeln('$ caritahunterbit : cari buku berdasarkan tahun terbit');
	writeln('$ pinjam_buku : isi data untuk meminjam buku');
	writeln('$ kembalikan_buku : isi data untuk mengembalikan buku');
	writeln('$ lapor_hilang : mengajukan laporan buku hilang');
	writeln('$ save : menyimpan data');
	writeln('$ logout : keluar');
	writeln('$ exit : keluar program');
	readln(x);
	case x of
		'cari': begin
					search(arrBuku);			
				end;
		'caritahunterbit': begin
								year(arrBuku);
							end;
		'pinjam_buku': begin
						
						end;
		'lapor_hilang': begin
						
						end;
		'save': begin
			
				end;
		'logout': begin
			
					end;
		'exit': begin
			
				end;
end;

procedure Menu_Pengunjung();
begin
	writeln('$ login : login anggota perpustakaan');
	writeln('$ cari : cari buku berdasarkan kategori');
	writeln('$ caritahunterbit : cari buku berdasarkan tahun terbit');
	writeln('$ lapor_hilang : mengajukan laporan buku hilang');
	writeln('$ save : menyimpan data');
	writeln('$ exit : keluar program');
	readln(x);
	case x of
		'login': begin
					log_in(arrUser);
					if(arrUser[i].Role = 'Admin') then
						begin
							Menu_Admin();
						end
					else
						begin
							Menu_Pengunjung_L();
						end;
				 end;
		'cari': begin
					search(arrBuku);			
				end;
		'caritahunterbit': begin
								year(arrBuku);
							end;
		'lapor_hilang': begin
			
						end;
		'save': begin
			
				end;
		'exit': begin
			
				end;
end;

begin
	writeln('Data Buku');
	LoadBuku(arrBuku, filename);
	PrintBuku(arrBuku);
	writeln('');
	writeln('Data User');
	LoadUser(arrUser, filename);
	PrintUser(arrUser);
	writeln('');
	writeln('Data History Peminjaman');
	LoadHistoryPeminjaman(arrHistoryPeminjaman, filename);
	PrintHistoryPeminjaman(arrHistoryPeminjaman);
	writeln('');
	writeln('Data History Pengembalian');
	LoadHistoryPengembalian(arrHistoryPengembalian, filename);
	PrintHistoryPengembalian(arrHistoryPengembalian);
	writeln('');
	writeln('Data Laporan Kehilangan');
	LoadLaporanHilang(arrLaporanHilang, filename);
	PrintLaporanHilang(arrLaporanHilang);
	writeln('');
	{load dulu}
	Menu_Pengunjung();

	{LoadBuku(arrBuku);
	LoadUser(arrUser);
	list_statistik(arrBuku, arrUser);}
end.
