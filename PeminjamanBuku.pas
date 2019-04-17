unit PeminjamanBuku;
uses udate;

interface
	

	type
		Buku = record
			ID_Buku 		: string;
			Judul_Buku		: string;
			Author 			: string;
			Jumlah_Buku		: integer;
			Tahun_Penerbit	: integer;
			Kategori 		: string;
		end;

		Date = record
			DD 		: integer;
			MM 		: integer;
			YYYY 	: integer;
		end;

		HistoryPeminjaman = record
			Username					: string;
			ID_Buku						: string;
			Tanggal_Peminjaman 			: Date;
			Tanggal_Batas_Pengembalian 	: Date;
			Status_Pengembalian 		: boolean;
		end;




implementation

var
	found := boolean;
	i, id := integer;
	

begin
	write('Masukkan id buku yang ingin dipinjam : ');
	readln(id); 
	found := false;
	for i := 1 to (size.arrBuku);
	begin
		if  (arrBuku[i].ID_Buku = id) and (arrBuku[i].Jumlah_Buku > 0) then
		begin
			found := true;
		end else
		begin
			found := false;
		end;
	end;	
	write('Masukkan tanggal hari ini: ');
	WriteDate(var HistoryPeminjaman.Tanggal_Peminjaman : Date);
	Tahun := HistoryPeminjaman.Tanggal_Peminjaman.YYYY;
	Bulan := HistoryPeminjaman.Tanggal_Peminjaman.MM;
	Hari := HistoryPeminjaman.Tanggal_Peminjaman.DD;
	

		if (Bulan = 1) or (Bulan = 3) or (Bulan = 5) or (Bulan = 7) or (Bulan = 8) or (Bulan = 10) then
		begin
			if (Hari >= 1) and (Hari <= 24) then
			begin
				HistoryPeminjaman.Tanggal_Batas_Pengembalian.DD := Hari + 7;
				HistoryPeminjaman.Tanggal_Batas_Pengembalian.MM := Bulan;
				HistoryPeminjaman.Tanggal_Batas_Pengembalian.YYYY := Tahun;
			end else if (Hari > 24) and (Hari <= 31) then
			begin
				HistoryPeminjaman.Tanggal_Batas_Pengembalian.DD := Hari - 24;
				HistoryPeminjaman.Tanggal_Batas_Pengembalian.MM := Bulan + 1;
				HistoryPeminjaman.Tanggal_Batas_Pengembalian.YYYY := Tahun;
			end;
		end else if (Bulan = 4) or (Bulan = 6) or (Bulan = 9) or (Bulan = 11) then
		begin
			if (Hari >= 1) and (Hari <= 23) then
			begin
				HistoryPeminjaman.Tanggal_Batas_Pengembalian.DD := Hari + 7;
				HistoryPeminjaman.Tanggal_Batas_Pengembalian.MM := Bulan;
				HistoryPeminjaman.Tanggal_Batas_Pengembalian.YYYY := Tahun;
			end else if (Hari > 23) and (Hari <= 30) then
			begin
				HistoryPeminjaman.Tanggal_Batas_Pengembalian.DD := Hari - 23;
				HistoryPeminjaman.Tanggal_Batas_Pengembalian.MM := Bulan + 1;
				HistoryPeminjaman.Tanggal_Batas_Pengembalian.YYYY := Tahun;
			end;
		end else if (Bulan = 2) then
		begin
			if ((Tahun mod 4 = 0) and (Tahun mod 100 <> 0)) or (Tahun mod 400 = 0) then
			begin
				if (Hari >= 1) and (Hari <= 21) then
				begin
					HistoryPeminjaman.Tanggal_Batas_Pengembalian.DD := Hari + 7;
					HistoryPeminjaman.Tanggal_Batas_Pengembalian.MM := Bulan;
					HistoryPeminjaman.Tanggal_Batas_Pengembalian.YYYY := Tahun;
				end else if (Hari > 21) and (Hari <= 28) then
				begin
					HistoryPeminjaman.Tanggal_Batas_Pengembalian.DD := Hari - 21;
					HistoryPeminjaman.Tanggal_Batas_Pengembalian.MM := Bulan + 1;
					HistoryPeminjaman.Tanggal_Batas_Pengembalian.YYYY := Tahun;
				end;
			end else 
			begin
				if (Hari >= 1) and (Hari <= 22) then
				begin
					HistoryPeminjaman.Tanggal_Batas_Pengembalian.DD := Hari + 7;
					HistoryPeminjaman.Tanggal_Batas_Pengembalian.MM := Bulan;
					HistoryPeminjaman.Tanggal_Batas_Pengembalian.YYYY := Tahun;
				end else if (Hari > 22) and (Hari <= 29) then
				begin
					HistoryPeminjaman.Tanggal_Batas_Pengembalian.DD := Hari - 22;
					HistoryPeminjaman.Tanggal_Batas_Pengembalian.MM := Bulan + 1;
					HistoryPeminjaman.Tanggal_Batas_Pengembalian.YYYY := Tahun;
				end;
			end;
		end else if (Bulan = 12) then
		begin
		
		
		
		end;
	
	
	if (found = true) then
	begin
		arrHistoryPeminjaman[i].ID_Buku := id;
		writeln('Buku ', arrBuku[i].Judul_Buku, 'berhasil dipinjam!');
		arrBuku[i].Jumlah_Buku := arrBuku[i].Jumlah_Buku - 1;
		writeln('Tersisa ', arrBuku[i].Jumlah_Buku,' ', arrBuku[i].Judul_Buku);
		writeln('Terima kasih sudah meminjam');
	end else
	begin
		writeln('Buku ', arrBuku[i].Judul_Buku, 'sedang habis!');
		writeln('Coba lain kali');
	end;

end.











