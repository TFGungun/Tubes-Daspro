////////////////////////////////////////////////
//			       uFileSaver                 //
////////////////////////////////////////////////
//Unit yang menangani penyimpanan kembali data//
////////////////////////////////////////////////
unit uFileSaver;

interface

	Uses uFileLoader;

	procedure SaveBuku(var arrBuku : BArr ; filename : string);
	{Mengisi ulang file filename dengan elemen-elemen dari arrBuku
	dengan format sesuai format awal file Buku}
	{I.S. : file filename berisi elemen arrBuku pada awal program}
	{F.S. : file filename berisi elemen arrBuku paling baru pada saat save}

	procedure SaveUser(var arrUser : UArr ; filename : string);
	{Mengisi ulang file filename dengan elemen-elemen dari arrUser
	dengan format sesuai format awal file User}
	{I.S. : file filename berisi elemen arrUser pada awal program}
	{F.S. : file filename berisi elemen arrUser paling baru pada saat save}

	procedure SaveHistoryPeminjaman(var arrHistoryPeminjaman : PinjamArr ; filename : string);
	{Mengisi ulang file filename dengan elemen-elemen dari arrHistoryPeminjaman
	dengan format sesuai format awal file Riwayat Peminjaman}
	{I.S. : file filename berisi elemen arrHistoryPeminjaman pada awal program}
	{F.S. : file filename berisi elemen arrHistoryPeminjaman paling baru pada saat save}

	procedure SaveHistoryPengembalian(var arrHistoryPengembalian : KembaliArr ; filename : string);
	{Mengisi ulang file filename dengan elemen-elemen dari arrHistoryPengembalian
	dengan format sesuai format awal file Riwayat Pengembalian}
	{I.S. : file filename berisi elemen arrHistoryPengembalian pada awal program}
	{F.S. : file filename berisi elemen arrHistoryPengembalian paling baru pada saat save}

	procedure SaveLaporanHilang(var arrLaporanHilang : HilangArr ; filename : string);
	{Mengisi ulang file filename dengan elemen-elemen dari arrLaporanHilang
	dengan format sesuai format awal file Laporan Hilang}
	{I.S. : file filename berisi elemen arrLaporanHilang pada awal program}
	{F.S. : file filename berisi elemen arrLaporanHilang paling baru pada saat save}

implementation

	procedure SaveBuku(var arrBuku : BArr ; filename : string);
	{Mengisi ulang file filename dengan elemen-elemen dari arrBuku
	dengan format sesuai format awal file Buku}
	{I.S. : file filename berisi elemen arrBuku pada awal program}
	{F.S. : file filename berisi elemen arrBuku paling baru pada saat save}

	{KAMUS LOKAL}
	var
		UserFile : Text;
		i : integer;
		header : string;

	{ALGORITMA}
	begin

		{INISIALISASI FILE UNTUK DIBACA}
		system.Assign(UserFile, filename);
		system.Rewrite(UserFile);

		// header adalah bagian baris atas file .csv (nama kolom)
		header := 'ID_Buku,Judul_Buku,Author,Jumlah_Buku,Tahun_Penerbit,Kategori';
		writeln(UserFile, header);

		// For loop untuk menulis elemen array sesuai format .csv
		for i := 1 to lenBuku do
		begin
			writeln(UserFile, arrBuku[i].ID_Buku, ',', arrBuku[i].Judul_Buku, ',', arrBuku[i].Author, ',',
			 arrBuku[i].Jumlah_Buku, ',', arrBuku[i].Tahun_Penerbit, ',', arrBuku[i].Kategori);
		end;

		Close(UserFile);
	end;

	procedure SaveUser(var arrUser : UArr ; filename : string);
	{Mengisi ulang file filename dengan elemen-elemen dari arrUser
	dengan format sesuai format awal file User}
	{I.S. : file filename berisi elemen arrUser pada awal program}
	{F.S. : file filename berisi elemen arrUser paling baru pada saat save}

	{KAMUS LOKAL}
	var
		UserFile : Text;
		i : integer;
		header, alamat : string;

	{ALGORITMA}
	begin

		{INISIALISASI FILE UNTUK DIBACA}
		system.Assign(UserFile, filename);
		system.Rewrite(UserFile);

		// header adalah bagian baris atas file .csv (nama kolom)
		header := 'Nama,Alamat,Username,Password,Role';
		writeln(UserFile, header);

		// For loop untuk menulis elemen array sesuai format .csv
		for i := 1 to lenUser do
		begin
			alamat := '"' + arrUser[i].Alamat + '"';
			writeln(UserFile, arrUser[i].Nama, ',', alamat, ',',
				arrUser[i].Username, ',', arrUser[i].Password, ',', 
				arrUser[i].Role);
		end;

		Close(UserFile);
	end;

	procedure SaveHistoryPeminjaman(var arrHistoryPeminjaman : PinjamArr ; filename : string);
	{Mengisi ulang file filename dengan elemen-elemen dari arrHistoryPeminjaman
	dengan format sesuai format awal file Riwayat Peminjaman}
	{I.S. : file filename berisi elemen arrHistoryPeminjaman pada awal program}
	{F.S. : file filename berisi elemen arrHistoryPeminjaman paling baru pada saat save}

	{KAMUS LOKAL}
	var
		UserFile : Text;
		i : integer;
		header: string;

	{ALGORITMA}
	begin

		{INISIALISASI FILE UNTUK DIBACA}
		system.Assign(UserFile, filename);
		system.Rewrite(UserFile);

		// header adalah bagian baris atas file .csv (nama kolom)
		header := 'Username,ID_Buku,Tanggal_Peminjaman,Tanggal_Batas_Pengembalian,Status_Pengembalian';
		writeln(UserFile, header);

		
		// For loop untuk menulis elemen array sesuai format .csv
		for i := 1 to lenHistoryPeminjaman do
		begin
			writeln(UserFile, arrHistoryPeminjaman[i].Username, ',', arrHistoryPeminjaman[i].ID_Buku, ',', 
				arrHistoryPeminjaman[i].Tanggal_Peminjaman.DD, '/',arrHistoryPeminjaman[i].Tanggal_Peminjaman.MM, '/',
				arrHistoryPeminjaman[i].Tanggal_Peminjaman.YYYY, ',',
				arrHistoryPeminjaman[i].Tanggal_Batas_Pengembalian.DD, '/', arrHistoryPeminjaman[i].Tanggal_Batas_Pengembalian.MM, '/',
				arrHistoryPeminjaman[i].Tanggal_Batas_Pengembalian.YYYY, ',',
				arrHistoryPeminjaman[i].Status_Pengembalian);
		end;

		Close(UserFile);
	end;

	procedure SaveHistoryPengembalian(var arrHistoryPengembalian : KembaliArr ; filename : string);
	{Mengisi ulang file filename dengan elemen-elemen dari arrHistoryPengembalian
	dengan format sesuai format awal file Riwayat Pengembalian}
	{I.S. : file filename berisi elemen arrHistoryPengembalian pada awal program}
	{F.S. : file filename berisi elemen arrHistoryPengembalian paling baru pada saat save}

	{KAMUS LOKAL}
	var
		UserFile : Text;
		i : integer;
		header: string;

	{ALGORITMA}
	begin

		{INISIALISASI FILE UNTUK DIBACA}
		system.Assign(UserFile, filename);
		system.Rewrite(UserFile);

		// header adalah bagian baris atas file .csv (nama kolom)
		header := 'Username,ID_Buku,Tanggal_Pengembalian';
		writeln(UserFile, header);

		// For loop untuk menulis elemen array sesuai format .csv
		for i := 1 to lenHistoryPengembalian do
		begin
			writeln(UserFile, arrHistoryPengembalian[i].Username, ',', arrHistoryPengembalian[i].ID_Buku, ',', 
				arrHistoryPengembalian[i].Tanggal_Pengembalian.DD, '/',arrHistoryPengembalian[i].Tanggal_Pengembalian.MM, '/',
				arrHistoryPengembalian[i].Tanggal_Pengembalian.YYYY);
		end;

		Close(UserFile);
	end;

	procedure SaveLaporanHilang(var arrLaporanHilang : HilangArr ; filename : string);
	{Mengisi ulang file filename dengan elemen-elemen dari arrLaporanHilang
	dengan format sesuai format awal file Laporan Hilang}
	{I.S. : file filename berisi elemen arrLaporanHilang pada awal program}
	{F.S. : file filename berisi elemen arrLaporanHilang paling baru pada saat save}

	{KAMUS LOKAL}
	var
		UserFile : Text;
		i : integer;
		header: string;

	{ALGORITMA}
	begin

		{INISIALISASI FILE UNTUK DIBACA}
		system.Assign(UserFile, filename);
		system.Rewrite(UserFile);

		// header adalah bagian baris atas file .csv (nama kolom)
		header := 'Username,ID_Buku_Hilang,Tanggal_Laporan';
		writeln(UserFile, header);

		// For loop untuk menulis elemen array sesuai format .csv
		for i := 1 to lenLaporanHilang do
		begin
			writeln(UserFile, arrLaporanHilang[i].Username, ',', arrLaporanHilang[i].ID_Buku_Hilang, ',', 
				arrLaporanHilang[i].Tanggal_Laporan.DD, '/',arrLaporanHilang[i].Tanggal_Laporan.MM, '/',
				arrLaporanHilang[i].Tanggal_Laporan.YYYY);
		end;

		Close(UserFile);
	end;


end.