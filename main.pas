Program main;

uses
	uAnggota, uBuku, uDate, uFileLoader, uFileSaver, uHilang, uKembali, uPinjam,
	crt;

var
	arrBuku : array[1..1000] of Buku;
	arrUser : array[1..1000] of User;
	arrHistoryPeminjaman : array[1..1000] of HistoryPeminjaman;
	arrHistoryPengembalian : array[1..1000] of HistoryPengembalian;
	arrLaporanHilang : array[1..1000] of LaporanHilang;
	k : integer;
	x, filename : string;
	userIn : User;
	isProgramRunning : boolean;

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

procedure Save_File();
begin
	write('Masukkan nama File Buku: ');
	readln(filename);
	SaveBuku(arrBuku, filename);
	writeln('');


	write('Masukkan nama File User: ');
	readln(filename);
	SaveUser(arrUser, filename);
	writeln('');


	write('Masukkan nama File Peminjaman: ');
	readln(filename);
	SaveHistoryPeminjaman(arrHistoryPeminjaman, filename);
	writeln('');

	write('Masukkan nama File Pengembalian: ');
	readln(filename);
	SaveHistoryPengembalian(arrHistoryPengembalian, filename);
	writeln('');

	write('Masukkan nama File Buku hilang: ');
	readln(filename);
	SaveLaporanHilang(arrLaporanHilang, filename);
	writeln('');

	writeln('File perpustakaan berhasil disimpan!');
end;


procedure LogoutUser();
begin
	userIn.Nama := '';
	userIn.Alamat := '';
	userIn.Username := '';
	userIn.Password := '';
	userIn.Role := '';
	userIn.Status := false;
end;

procedure Exit();
begin
	writeln('Apakah anda mau melakukan penyimpanan file yang sudah dilakukan? (Y/N)');
	readln(x);
	if (x = 'Y') then
	begin
		Save_File();
	end;
	isProgramRunning := false;
	writeln('Selamat Tinggal');
end;

procedure Menu_Admin();
begin
	writeln('---------------------------------------------------------');
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
	writeln('---------------------------------------------------------');
	write('> ');
	readln(x);
	ClrScr;
	writeln('> ',x);
	case x of
		'register' : begin
						regis(arrUser);
					 end;
		'cari': begin
					search(arrBuku);			
				end;
		'caritahunterbit': begin
								year(arrBuku);
							end;
		'lihat_laporan': begin
							PrintLaporanWithJudul(arrLaporanHilang, arrBuku);
						end;
		'tambah_buku': begin
							add(arrBuku);
						end;
		'tambah_jumlah_buku': begin
								amount(arrBuku);
								end;
		'riwayat': begin
						cek_riwayat(arrHistoryPeminjaman, arrBuku);
					end;
		'statistik': begin
						list_statistik(arrBuku, arrUser);
					end;
		'cari_anggota': begin
							CariAnggota(arrUser);
						end;
		'save': begin
					Save_File()
				end;
		'logout': begin
						LogoutUser()
					end;
		'exit': begin
					Exit();
				end;
	end;
end;

procedure Menu_Pengunjung();
begin
	writeln('---------------------------------------------------------');
	writeln('$ cari : cari buku berdasarkan kategori');
	writeln('$ caritahunterbit : cari buku berdasarkan tahun terbit');
	writeln('$ pinjam_buku : isi data untuk meminjam buku');
	writeln('$ kembalikan_buku : isi data untuk mengembalikan buku');
	writeln('$ lapor_hilang : mengajukan laporan buku hilang');
	writeln('$ save : menyimpan data');
	writeln('$ logout : keluar');
	writeln('$ exit : keluar program');
	writeln('---------------------------------------------------------');
	writeln('> '); 
	readln(x);
	ClrScr;
	writeln('> ',x);
	case x of
		'cari': begin
					search(arrBuku);			
				end;
		'caritahunterbit': begin
								year(arrBuku);
							end;
		'pinjam_buku': begin
							PinjamBuku(arrHistoryPeminjaman, arrBuku, userIn);
						end;
		'kembalikan_buku' : begin
								KembalikanBuku(arrHistoryPengembalian, arrHistoryPeminjaman, arrBuku, UserIn);
							end;
		'lapor_hilang': begin
							LaporKehilangan(arrLaporanHilang, arrBuku, UserIn);
						end;
		'save': begin
					Save_File();
				end;
		'logout': begin
						LogoutUser();
					end;
		'exit': begin
					Exit();
				end;
	end;
end;



procedure Menu_User();
begin
	writeln('---------------------------------------------------------');
	writeln('$ login : login anggota perpustakaan');
	writeln('$ cari : cari buku berdasarkan kategori');
	writeln('$ caritahunterbit : cari buku berdasarkan tahun terbit');
	writeln('$ save : menyimpan data');
	writeln('$ exit : keluar program');
	writeln('---------------------------------------------------------');
	write('> ');
	readln(x);
	ClrScr;
	writeln('> ',x);
	case x of
		'login': begin
					log_in(arrUser, userIn);
					if(userIn.Role = 'Admin') then
						begin
							while((isProgramRunning) and (userIn.Status)) do
							begin
								Menu_Admin();
							end;
						end
					else
						begin
							while((isProgramRunning) and (userIn.Status)) do
							begin
								Menu_Pengunjung();
							end;
						end;
				 end;
		'cari': begin
					search(arrBuku);			
				end;
		'caritahunterbit': begin
								year(arrBuku);
							end;
		'save': begin
					Save_File();
				end;
		'exit': begin
					Exit();
				end;
	end;
end;

begin

	// Memulai program dengan me-load semua file data perpustakaan
	textbackground(red);
	ClrScr;
	Load_File();
	textbackground(blue); {background colour}
	ClrScr; {Clear screen with a brown colour. Try run the program without this..}
	TextColor(yellow);

	// Set isProgramRunning True untuk menandakan program sedang berjalan
	writeln('         ,'' ``'',');
	writeln('        ''  (o)(o)');
	writeln('       `       > ;');
	writeln('       '',     . ...-''"""""`''.');
	writeln('     .''`'',`''''`________:   ":''');
	writeln('   (`''. ''.;  |           ;/\;\;');
	writeln('  (`'',.'',.;  | SELAMAT DATANG |');
	writeln(' (,''` .`.,''  |       DI       |');
	writeln(' (,.'',.'',''   |  PERPUSTAKAAN  |');
	writeln('(,.'',.-`_____|  BA SING TSE!  |');
	writeln('    __\_ _\_ |       :)       |');
	writeln('             |________________|');
	isProgramRunning := true;

	// Menjalankan Menu User sebagai program utama
	while (isProgramRunning) do
	begin
		Menu_User();
	end;
end.