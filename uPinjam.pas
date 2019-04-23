//====================================================================//
//                              uPinjam                               //
//--------------------------------------------------------------------//
//   Unit yang menangani hal-hal yang berhubungan dengan peminjaman   //
//====================================================================//
unit uPinjam;

interface
	uses uFileLoader, uDate, Crt;

	procedure PinjamBuku (var arrHistoryPeminjaman : PinjamArr ; var arrBuku : BArr ; UserIn : User);
	{Mengisi data yang diinputkan oleh pengguna ke dalam arrHistoryPeminjaman}
	{I.S. : arrHistoryPeminjaman sudah berisi data dari file riwayat peminjaman dan/atau modifikasi di main program}
	{F.S. :	arrHistoryPeminjaman tercetak ke layar sesuai format data riwayat peminjaman}

	procedure cek_riwayat(var arrHistoryPeminjaman: PinjamArr; var arrBuku: BArr);
	{ mencetak riwayat peminjaman input username dengan format 
	  tanggal pengembalian | ID Buku | Judul Buku }

	procedure PrintHistoryPeminjaman (var arrHistoryPeminjaman : PinjamArr);
	{Menulis elemen-elemen dari arrHistoryPeminjaman ke layar dengan format sesuai data riwayat peminjaman}
	{I.S. : arrHistoryPeminjaman sudah berisi data dari file riwayat peminjaman dan/atau modifikasi di main program}
	{F.S. :	arrHistoryPeminjaman tercetak ke layar sesuai format data riwayat peminjaman}


implementation
	
	procedure PinjamBuku (var arrHistoryPeminjaman : PinjamArr ; var arrBuku : BArr ; UserIn : User);
	{Mengisi data yang diinputkan oleh pengguna ke dalam arrHistoryPeminjaman}
	{I.S. : arrHistoryPeminjaman sudah berisi data dari file riwayat peminjaman dan/atau modifikasi di main program}
	{F.S. :	arrHistoryPeminjaman tercetak ke layar sesuai format data riwayat peminjaman}

	{ KAMUS LOKAL }
	var
		found : boolean;
		i, Tahun, Bulan, Hari : integer; 
		tanggalpinjamstring, id, judul_buku : string; //  variabel tanggalpinjam untuk menyimpan tanggal peminjaman

	{ ALGORITMA }
	begin
		write('Masukkan id buku yang ingin dipinjam : ');
		readln(id); 
		found := false;
		i := 1;
		judul_buku := '';
		while (not found) and (i <= lenBuku) do 
		// Pengulangan iterate-stop ketika data belum 
		// ditemukan dan indeks i kurang dari sama dengan lenbuku
		// Pengulangan dicari untuk memastikan buku yang ingin dipinjam masih tersedia atau
		// sudah habis
		begin
			if  (arrBuku[i].ID_Buku = id) then
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
		begin
			// Jika jumlah buku lebih dari 0 dan masih tersedia
			judul_buku := arrBuku[i].Judul_Buku;
			if (arrBuku[i].Jumlah_Buku > 0) then
				begin
				arrHistoryPeminjaman[lenHistoryPeminjaman + 1].Tanggal_Peminjaman := ParseDate(tanggalpinjamstring); 
				// Mengubah masukan tanggal yang berupa string menjadi type yang berbentuk Date
				
				arrHistoryPeminjaman[lenHistoryPeminjaman + 1].ID_Buku := id;
				
				writeln('Buku ', judul_buku, ' berhasil dipinjam!');
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
				writeln('Buku ', judul_buku, ' sedang habis!');
				writeln('Coba lain kali');
			end;
		end;
	end;

	procedure cek_riwayat(var arrHistoryPeminjaman: PinjamArr; var arrBuku: BArr);
	{ mencetak riwayat peminjaman input username dengan format 
	  tanggal pengembalian | ID Buku | Judul Buku }

	{ KAMUS LOKAL }
	var
		i, j, c, x: integer; { i indeks array pengembalian,
							   j indeks array buku,
							   c indeks counter untuk diset 0 semua,
							   x indeks counter
							 }
		uname, judul_buku: string; { uname input username,
									 judul buku variabel sementara untuk
									 menampilkan judul buku dari array buku
								   }
		found : boolean;
		counter : array[1..1000] of integer; { array untuk menampung indeks
											   username untuk mencari judul buku }
		tgl : Date; { variabel untuk menuliskan tanggal }
	
	{ ALGORITMA }
	begin
	
	write('Masukkan username pengunjung : '); readln(uname);
	writeln('Riwayat: ');
	{ inisialisasi }
	i := 0;
	j := 1;
	c := 0;
	x := 1;
	
	for c:=1 to 1000 do { EOP : c=1000 }
		begin
		counter[c]:=0; { inisialisasi isi array 0 semua }
		end;
	
	for i:=1 to lenHistoryPeminjaman do { EOP : i = lenHistoryPengembalian }
		begin
		if (uname = arrHistoryPeminjaman[i].Username) then { Proses kasus uname = username pada array pengembalian}
			begin
			counter[j] := i;
			j := j+1;
			end;
		end;
	
	
	
	while (counter[x]<>0) do { EOP : elemen array counter = 0 }
		begin
		j:=0;	{ inisialisasi ulang untuk indeks j }
		found := false;		 { inisialisasi found = false }
		while (not found) do { EOP : found = true }
			begin
			j:=j+1;
			if (arrHistoryPeminjaman[counter[x]].ID_Buku = arrBuku[j].ID_Buku) then { proses kasus ID buku pada array pengembalian = ID buku array buku }
				begin
				judul_buku := arrBuku[j].Judul_Buku;
				found := true;
				end;
			end;
		tgl := arrHistoryPeminjaman[counter[x]].Tanggal_Peminjaman;
		writeln(tgl.DD, '/', tgl.MM, '/', tgl.YYYY 	,' | ',arrHistoryPeminjaman[counter[x]].ID_Buku,' | ',judul_buku);
		x := x+1;
		end;
	end;

	procedure PrintHistoryPeminjaman (var arrHistoryPeminjaman : PinjamArr);
	{Menulis elemen-elemen dari arrHistoryPeminjaman ke layar dengan format sesuai data riwayat peminjaman}
	{I.S. : arrHistoryPeminjaman sudah berisi data dari file riwayat peminjaman dan/atau modifikasi di main program}
	{F.S. :	arrHistoryPeminjaman tercetak ke layar sesuai format data riwayat peminjaman}
	{' | ' digunakan untuk pemisah antar kolom}

	{ KAMUS LOKAL }
	var
		k : integer;

	{ ALGORITMA }
	begin
		for k := 1 to (lenHistoryPeminjaman) do
		begin
			write(k);
			write(' | ');
			write(arrHistoryPeminjaman[k].Username);
			write(' | ');
			write(arrHistoryPeminjaman[k].ID_Buku);
			write(' | ');
			WriteDate(arrHistoryPeminjaman[k].Tanggal_Peminjaman);
			write(' | ');
			WriteDate(arrHistoryPeminjaman[k].Tanggal_Batas_Pengembalian);
			write(' | ');
			if (arrHistoryPeminjaman[k].Status_Pengembalian) then
			begin
				write('Sudah Kembali');
			end else
			begin
				write('Belum Kembali');
			end;
			writeln();
		end;
	writeln();
	writeln('Ketik 0 untuk kembali ke menu.');
	readln();
	ClrScr;
	end;
end.

