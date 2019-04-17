unit PengembalianBuku;
uses PeminjamanBuku, udate;



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
		
		HistoryPengembalian = record
			Username					: string;
			ID_Buku						: string;
			Tanggal_Pengembalian		: Date;
		end;



implementation
var 
	idkembali : string;



begin
	write('Masukkan id buku yang ingin dikembalikan ');
	readln(idkembali);
	arrHistoryPengembalian.ID_Buku := idkembali; // array harus ada index cth arrHistoryPengembalian[index]
	writeln('Data Peminjam: ');
	writeln('Username: ', arrUser.Username); // Username yang direfer harusnya dari arrHistoryPeminjaman
	writeln('Judul_Buku: ', arrBuku.Judul_Buku); // Harus diketahui index arrBuku mana yang diambil judul_Bukunya
	writeln('Tanggal Peminjaman: ', writeDate(var arrHistoryPeminjaman.Tanggal_Peminjaman: Date); // writedate enggak ngembaliin nilai, kita gabisa masukkin procedure ke dalem writeln
	writeln('Tanggal Batas Pengembalian: ', arrHistoryPeminjaman.Tanggal_Batas_Pengembalian); // Tanggal gabisa diwriteln langsung, harus pake writedate karena tanggal itu type Date (terdiri dari 3 atribut)
	
	writeln('Masukkan tanggal hari ini: ');
	WriteDate(var HistoryPeminjaman.Tanggal_Peminjaman : Date); // di sini harusnya bukan write date tanggal peminjaman, karena program meminta tanggal hari ini untuk dicocokkan

	if (HistoryPeminjaman.Tanggal_Batas_Pengembalian.YYYY = HistoryPengembalian.Tanggal_Pengembalian.YYYY) then
	begin
		if (HistoryPeminjaman.Tanggal_Batas_Pengembalian.MM = HistoryPengembalian.Tanggal_Pengembalian.MM) then
		begin
			if (HistoryPeminjaman.Tanggal_Batas_Pengembalian.DD >= HistoryPengembalian.Tanggal_Pengembalian.DD) then
			begin
				writeln('Terima kasih sudah meminjam');
			end else
			begin
				writeln('Anda terlambat mengembalikan buku');
			end;
		end else if (HistoryPeminjaman.Tanggal_Batas_Pengembalian.MM > HistoryPengembalian.Tanggal_Pengembalian.MM) then
			begin
				writeln('Terima kasih sudah meminjam');
			end;
		end else
			begin
				writeln('Anda terlambat mengembalikan buku');
			end;
		end;
	end else if (HistoryPeminjaman.Tanggal_Batas_Pengembalian.YYYY > HistoryPengembalian.Tanggal_Pengembalian.YYYY) then
	begin
		writeln('Terima kasih sudah meminjam');
	end else
	begin
		writeln('Anda terlambat mengembalikan buku');
	end;
end.
