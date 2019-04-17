unit uFileSaver;

interface

	Uses uFileLoader;

	procedure SaveBuku(var arrBuku : BArr ; filename : string);

	procedure SaveUser(var arrUser : UArr ; filename : string);

	procedure SaveHistoryPeminjaman(var arrHistoryPeminjaman : PinjamArr ; filename : string);

	procedure SaveHistoryPengembalian(var arrHistoryPengembalian : KembaliArr ; filename : string);

	procedure SaveLaporanHilang(var arrLaporanHilang : HilangArr ; filename : string);

implementation

	procedure SaveBuku(var arrBuku : BArr ; filename : string);

	var
		UserFile : Text;
		i : integer;
		header : string;

	begin
		system.Assign(UserFile, filename);
		system.Rewrite(UserFile);

		header := 'ID_Buku,Judul_Buku,Author,Jumlah_Buku,Tahun_Penerbit,Kategori';
		writeln(UserFile, header);

		for i := 1 to lenBuku do
		begin
			writeln(UserFile, arrBuku[i].ID_Buku, ',', arrBuku[i].Judul_Buku, ',', arrBuku[i].Author, ',',
			 arrBuku[i].Jumlah_Buku, ',', arrBuku[i].Tahun_Penerbit, ',', arrBuku[i].Kategori);
		end;

		Close(UserFile);
	end;

	procedure SaveUser(var arrUser : UArr ; filename : string);

	var
		UserFile : Text;
		i : integer;
		header, alamat : string;

	begin
		system.Assign(UserFile, filename);
		system.Rewrite(UserFile);

		header := 'Nama,Alamat,Username,Password,Role';
		writeln(UserFile, header);

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

	var
		UserFile : Text;
		i : integer;
		header: string;

	begin
		system.Assign(UserFile, filename);
		system.Rewrite(UserFile);

		header := 'Username,ID_Buku,Tanggal_Peminjaman,Tanggal_Batas_Pengembalian,Status_Pengembalian';
		writeln(UserFile, header);

		for i := 1 to lenHistoryPeminjaman do
		begin
			writeln(UserFile, arrHistoryPeminjaman[i].Username, ',', arrHistoryPeminjaman[i].ID_Buku, ',', 
				arrHistoryPeminjaman[i].Tanggal_Peminjaman.DD, '/',arrHistoryPeminjaman[i].Tanggal_Peminjaman.MM, '/',
				arrHistoryPeminjaman[i].Tanggal_Peminjaman.YYYY, '/', ',',
				arrHistoryPeminjaman[i].Tanggal_Batas_Pengembalian.DD, '/', arrHistoryPeminjaman[i].Tanggal_Batas_Pengembalian.MM, '/',
				arrHistoryPeminjaman[i].Tanggal_Batas_Pengembalian.YYYY, '/', ',',
				arrHistoryPeminjaman[i].Status_Pengembalian);
		end;

		Close(UserFile);
	end;

	procedure SaveHistoryPengembalian(var arrHistoryPengembalian : KembaliArr ; filename : string);

	var
		UserFile : Text;
		i : integer;
		header: string;

	begin
		system.Assign(UserFile, filename);
		system.Rewrite(UserFile);

		header := 'Username,ID_Buku,Tanggal_Pengembalian';
		writeln(UserFile, header);

		for i := 1 to lenHistoryPengembalian do
		begin
			writeln(UserFile, arrHistoryPengembalian[i].Username, ',', arrHistoryPengembalian[i].ID_Buku, ',', 
				arrHistoryPengembalian[i].Tanggal_Pengembalian.DD, '/',arrHistoryPengembalian[i].Tanggal_Pengembalian.MM, '/',
				arrHistoryPengembalian[i].Tanggal_Pengembalian.YYYY);
		end;

		Close(UserFile);
	end;

	procedure SaveLaporanHilang(var arrLaporanHilang : HilangArr ; filename : string);

	var
		UserFile : Text;
		i : integer;
		header: string;

	begin
		system.Assign(UserFile, filename);
		system.Rewrite(UserFile);

		header := 'Username,ID_Buku,Tanggal_Laporan';
		writeln(UserFile, header);

		for i := 1 to lenLaporanHilang do
		begin
			writeln(UserFile, arrLaporanHilang[i].Username, ',', arrLaporanHilang[i].ID_Buku, ',', 
				arrLaporanHilang[i].Tanggal_Laporan.DD, '/',arrLaporanHilang[i].Tanggal_Laporan.MM, '/',
				arrLaporanHilang[i].Tanggal_Laporan.YYYY);
		end;

		Close(UserFile);
	end;


end.