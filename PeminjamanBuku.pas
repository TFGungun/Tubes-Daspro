unit PeminjamanBuku;

interface
	
	
uses uFileLoader, uDate;
	{ // Dipersingkat dengan menggunakan uFileLoader dan uDate
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
	}

	procedure PinjamBuku (var arrHistoryPeminjaman : PinjamArr ; arrBuku : BArr ; UserIn : User); // tambah procedure agar bisa digunakan lebih mudah



implementation
	
	procedure PinjamBuku (var arrHistoryPeminjaman : PinjamArr ; arrBuku : BArr ; UserIn : User);

	var
		found : boolean;
		i, Tahun, Bulan, Hari : integer; // tambah Tahun Bulan hari karena dipakai di bawah
		tanggalpinjamstring, id : string; // tambah variabel tanggalpinjam untuk menyimpan tanggal peminjaman
		tanggalpinjam : Date;

	begin
		write('Masukkan id buku yang ingin dipinjam : ');
		readln(id); 
		found := false;
		i := 1;
		while (not found) and (i <= lenBuku) do// (size.arrBuku) diganti lenBuku karena sudah dibuat global variable
		begin
			if  (arrBuku[i].ID_Buku = id) and (arrBuku[i].Jumlah_Buku > 0) then
			begin
				found := true;
			end else
			begin
				found := false;
				inc(i);
			end;
		end;	
		write('Masukkan tanggal hari ini: ');
		readln(tanggalpinjamstring);
		//WriteDate(arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Peminjamane);

		// Dipindahin dari atas biar menjamin hanya nambah ketika found
		
		if (found = true) then
		begin
			arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Peminjaman := ParseDate(tanggalpinjamstring);

			arrHistoryPeminjaman[lenHistoryPeminjaman + 1].ID_Buku := id;
			writeln('Buku ', arrBuku[i].Judul_Buku, ' berhasil dipinjam!');
			arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Peminjaman := ParseDate(tanggalpinjamstring);
			// Dipindahin dari atas biar menjamin hanya nambah ketika found
			Tahun := arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Peminjaman.YYYY;
			Bulan := arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Peminjaman.MM;
			Hari := arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Peminjaman.DD;
			

			if (Bulan = 1) or (Bulan = 3) or (Bulan = 5) or (Bulan = 7) or (Bulan = 8) or (Bulan = 10) then
			begin
				if (Hari >= 1) and (Hari <= 24) then
				begin
					arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.DD := Hari + 7;
					arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.MM := Bulan;
					arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.YYYY := Tahun;
				end else if (Hari > 24) and (Hari <= 31) then
				begin
					arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.DD := Hari - 24;
					arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.MM := Bulan + 1;
					arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.YYYY := Tahun;
				end;
			end else if (Bulan = 4) or (Bulan = 6) or (Bulan = 9) or (Bulan = 11) then
			begin
				if (Hari >= 1) and (Hari <= 23) then
				begin
					arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.DD := Hari + 7;
					arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.MM := Bulan;
					arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.YYYY := Tahun;
				end else if (Hari > 23) and (Hari <= 30) then
				begin
					arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.DD := Hari - 23;
					arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.MM := Bulan + 1;
					arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.YYYY := Tahun;
				end;
			end else if (Bulan = 2) then
			begin
				if ((Tahun mod 4 = 0) and (Tahun mod 100 <> 0)) or (Tahun mod 400 = 0) then
				begin
					if (Hari >= 1) and (Hari <= 22) then
					begin
						arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.DD := Hari + 7;
						arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.MM := Bulan;
						arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.YYYY := Tahun;
					end else if (Hari > 22) and (Hari <= 29) then
					begin
						arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.DD := Hari - 22;
						arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.MM := Bulan + 1;
						arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.YYYY := Tahun;
					end;
				end else 
				begin
					if (Hari >= 1) and (Hari <= 21) then
					begin
						arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.DD := Hari + 7;
						arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.MM := Bulan;
						arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.YYYY := Tahun;
					end else if (Hari > 21) and (Hari <= 28) then
					begin
						arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.DD := Hari - 21;
						arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.MM := Bulan + 1;
						arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.YYYY := Tahun;
					end;
				end;
			end else if (Bulan = 12) then
			begin
				if (Hari >= 1) and (Hari <= 24) then
				begin
					arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.DD := Hari + 7;
					arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.MM := Bulan;
					arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.YYYY := Tahun;
				end else if (Hari > 24) and (Hari <= 31) then
				begin
					arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.DD := Hari - 24;
					arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.MM := 1;
					arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Batas_Pengembalian.YYYY := Tahun + 1;
				end;
			end;
			arrBuku[i].Jumlah_Buku := arrBuku[i].Jumlah_Buku - 1;
			arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Username := UserIn.Username;
			writeln('Tersisa ', arrBuku[i].Jumlah_Buku,' ', arrBuku[i].Judul_Buku);
			writeln('Terima kasih sudah meminjam');
			lenHistoryPeminjaman := lenHistoryPeminjaman + 1
		end else
		begin
			writeln('Buku ', arrBuku[i].Judul_Buku, ' sedang habis!');
			writeln('Coba lain kali');
		end;
	end;
end.











