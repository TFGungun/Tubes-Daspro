unit PeminjamanBuku;
// PeminjamanBuku
// Unit yang menangani data peminjaman buku

interface
	
	
uses uFileLoader, uDate;

	procedure PinjamBuku (var arrHistoryPeminjaman : PinjamArr ; var arrBuku : BArr ; UserIn : User); // tambah procedure agar bisa digunakan lebih mudah
	{Mengisi data yang diinputkan oleh pengguna ke dalam arrHistoryPeminjaman}
	{I.S. : arrHistoryPeminjaman sudah berisi data dari file riwayat peminjaman dan/atau modifikasi di main program}
	{F.S. :	arrHistoryPeminjaman tercetak ke layar sesuai format data riwayat peminjaman}


implementation
	
	procedure PinjamBuku (var arrHistoryPeminjaman : PinjamArr ; var arrBuku : BArr ; UserIn : User);

	var
		found : boolean;
		i, Tahun, Bulan, Hari : integer; 
		tanggalpinjamstring, id : string; //  variabel tanggalpinjam untuk menyimpan tanggal peminjaman

	begin
		write('Masukkan id buku yang ingin dipinjam : ');
		readln(id); 
		found := false;
		i := 1;
		while (not found) and (i <= lenBuku) do 
		// Pengulangan iterate-stop ketika data belum 
		// ditemukan dan indeks i kurang dari sama dengan lenbuku
		// Pengulangan dicari untuk memastikan buku yang ingin dipinjam masih tersedia atau
		// sudah habis
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
		readln(tanggalpinjamstring); // Data tanggal yang dimasukkan berupa string


		if (found = true) then
		// Jika jumlah buku lebih dari 0 dan masih terjadi
		begin
			arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Peminjaman := ParseDate(tanggalpinjamstring); 
			// Mengubah masukan tanggal yang berupa string menjadi type yang berbentuk Date
			
			arrHistoryPeminjaman[lenHistoryPeminjaman + 1].ID_Buku := id;
	
			
			writeln('Buku ', arrBuku[i].Judul_Buku, ' berhasil dipinjam!');
			arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Peminjaman := ParseDate(tanggalpinjamstring);
			 
			
			Tahun := arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Peminjaman.YYYY;
			Bulan := arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Peminjaman.MM;
			Hari := arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Peminjaman.DD;
			
			
			// Program yang digunakan untuk menangani Tanggal Batas Pengembalian yaitu 7 hari setelah
			// Tanggal Peminjaman
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
			// Data username diimpor dari file uFileLoader
			
			writeln('Tersisa ', arrBuku[i].Jumlah_Buku,' ', arrBuku[i].Judul_Buku);
			writeln('Terima kasih sudah meminjam');
			lenHistoryPeminjaman := lenHistoryPeminjaman + 1
		end else // Jika jumlah buku tidak lebih besar dari 0 (tidak tersedia)
		begin
			writeln('Buku ', arrBuku[i].Judul_Buku, ' sedang habis!');
			writeln('Coba lain kali');
		end;
	end;
end.

