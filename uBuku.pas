//==============================================================//
//                             uBuku                            //
//--------------------------------------------------------------//
//   Unit yang menangani hal-hal yang berhubungan dengan buku   //
//==============================================================//
unit uBuku;

interface
	uses uFileLoader;

type
	indexarr = array[1..1000] of integer;

	function validasi(k: string): boolean;
	{ menghasilkan true jika input termasuk kategori yang ada dan false jika tidak; dengan menuliskan ekspresi boolean }

	procedure search(var arrBuku: BArr);
	{ menampilkan daftar buku yang memiliki kategori sesuai input
	  I.S. data array sama dengan data pada csv
	  F.S. data dari array yang ditampilkan adalah yang sesuai kategori, data pada array tetap sama dengan csv
	}

	function isMember(index : integer ; indexarray : indexarr; count : integer) : boolean;
	{ menghasilkan true jika index termasuk anggota dari indexarray ; dengan menuliskan ekspresi boolean }

	procedure sortIndexArray(var indexarray : indexarr ; temparr : BArr; count : integer);
	{ mengurutkan index dari temparr dan menyimpannya dalam indexarray
	  I.S. indexarray kosong, temparr berisi data yang belum urut
	  F.S. indexarray berisi index temparr yang sudah terurut (menurut atribut Judul_Buku tiap elemen temparr)
	}

	procedure year(var arrBuku: BArr);
	{ menampilkan daftar buku yang memiliki tahun terbit sesuai input
	  I.S. data buku sesuai array
	  F.S. data yang ditampilkan hanya buku yang memiliki tahun terbit sesuai input
	}

	procedure add(var arrBuku: BArr);
	{ Memasukkan data buku baru ke dalam array buku
	  I.S. data array sama dengan data pada csv
	  F.S. index array bertambah 1 dengan data baru
	}

	procedure amount(var arrBuku: BArr);
	{ Menambahkan jumlah buku baru ke dalam array buku sesuai jumlah input
	  I.S. data jumlah buku pada array sama dengan data pada csv
	  F.S. data jumlah buku bertambah sesuai input
	}

	procedure PrintBuku (var arrBuku : BArr);
	{Menulis elemen-elemen dari arrBuku ke layar dengan format sesuai data buku}
	{I.S. : arrBuku sudah berisi data dari file buku dan/atau modifikasi di main program}
	{F.S. :	arrBuku tercetak ke layar sesuai format data buku}

implementation
	function validasi(k: string): boolean;
	{ menghasilkan true jika input termasuk kategori yang ada dan false jika tidak; dengan menuliskan ekspresi boolean }
		
	{ ALGORITMA }
	begin
		validasi := (k = 'sastra') or (k = 'sains') or (k = 'manga') or (k = 'sejarah') or (k = 'programming');
	end;

	procedure search(var arrBuku: BArr);
	{ menampilkan daftar buku yang memiliki kategori sesuai input
	  I.S. data array sama dengan data pada csv
	  F.S. data dari array yang ditampilkan adalah yang sesuai kategori, data pada array tetap sama dengan csv
	}
	
	{ KAMUS LOKAL }
	var
	count, i, index: integer;					{ count jumlah dan i merupakan indeks }
	k : string;							{ read string dari pengguna }
	temparr : BArr;
	indexarray : indexarr;

	{ ALGORITMA }
	begin
		i:=1;							{ inisialisasi, i = 1 sebagai indeks pertama pada array }
		count:=0;						{ inisialisasi, count = 0 }
		write('Masukkan kategori: ');
		readln(k);						{ first element }
		while(validasi(k) = false) do 	{ EOP : validasi(k) = true }
			begin
				writeln('Kategori ', k, ' tidak valid.');
				write('Masukkan kategori: ');
				readln(k);				{ next element }
			end;
		while(i<=lenBuku) do 		{ EOP : i > lenBuku }
			begin
				if(k = arrBuku[i].Kategori) then { proses kasus kategori pada data sesuai input }
					begin
						count := count+1;
						temparr[count] := arrBuku[i];
					end;
				i := i+1;
			end;
		if(count = 0) then 						{ proses kasus tidak ada buku yang sesuai kategori input }
			writeln('Tidak ada buku dalam kategori ini.');

		sortIndexArray(indexarray, temparr, count); { proses sorting untuk tampilan }

		for i := 1 to count do { proses pencetakan ke layar sesuai urutan sorting }
		begin
			index := indexarray[i];
			writeln(temparr[index].ID_Buku, ' | ', temparr[index].Judul_Buku, ' | ', temparr[index].Author);
		end;
	end;

	function isMember(index : integer ; indexarray : indexarr; count : integer) : boolean;
	{ menghasilkan true jika index termasuk anggota dari indexarray ; dengan menuliskan ekspresi boolean }
		
	{ KAMUS LOKAL }
	var
		i : integer;
	
	{ ALGORITMA }
	begin
		isMember := false;
		i := 1;
		while ((not isMember) and (i <= count)) do
		begin
			if (indexarray[i] = index) then
			begin
				isMember := true
			end else
			begin
				inc(i);
			end;
		end;
	end;

	procedure sortIndexArray(var indexarray : indexarr ; temparr : BArr; count : integer);
	{ mengurutkan index dari temparr dan menyimpannya dalam indexarray
	  I.S. indexarray kosong, temparr berisi data yang belum urut
	  F.S. indexarray berisi index temparr yang sudah terurut (menurut atribut Judul_Buku tiap elemen temparr)
	}

	{ KAMUS LOKAL }
	var
		i, j, k, dec, min, indexmin : integer;	// dec adalah penyimpan nilai sementara, min adalah nilai minimum sementara, indexmin adalah index minimum sementara
		advancedcheck : boolean;				// Penanda perlu dilakukan penyocokan lebih dalam				
	
	{ ALGORITMA }
	begin
		// For loop utama untuk mengiterasi sepanjang array temparr
		for i := 1 to count do
		begin
			advancedcheck := false;

			// Set indexmin 1 agar tiap iterasi tidak melewatkan elemen array manapun
			indexmin := 1;

			// While loop untuk mengecek apakah indexmin sudah ada di indexarray
			// Jika sudah, berarti indexmin sudah terurut dan dilanjutkan untuk mengurut index selanjutnya
			while (isMember(indexmin, indexarray, count)) do
			begin
				inc(indexmin);
			end;

			min := ord(temparr[indexmin].Judul_Buku[1]);
			
			// If berguna untuk mengecek apakah decimal lebih dari 90 (huruf kecil)
			// Jika lebih dari 90, diconvert ke huruf kapitalnya agar penyocokan serasi
			if(min > 90) then 
			begin
				min := min - 32
			end;

			// For loop untuk membandingkan tiap huruf depan dari judul buku
			for j := indexmin + 1 to count do
			begin
				dec := ord(temparr[j].Judul_Buku[1]);

				if (dec > 90) then
				begin
					dec := dec - 32
				end;

				// Jika nilai decimal sementara lebih kecil dari minimum dan index penandanya belum ada di indexarray,
				// maka dianggap minimum sementara dan indexmin diset index
				// Nilai decimal lebih kecil berarti secara leksikografis lebih dulu muncul
				if ((dec < min) and (not isMember(j,indexarray, count))) then
				begin
					min := dec;
					indexmin := j;
				end 

				// Jika nilai decimal dan minimum sama, dilakukan pengecekan lebih dalam untuk huruf selanjutnya
				else if ((dec = min) and (not isMember(j,indexarray, count))) then
				begin
					advancedcheck := true;
					k := 2;

					// While loop berjalan untuk mengecek tiap huruf selanjutnya sampai ditemukan yang lebih awal
					while (advancedcheck) do
					begin
						// Minimum diset decimal jika memang benar decimal lebih kecil
						if(ord(temparr[j].Judul_Buku[k]) < ord(temparr[indexmin].Judul_Buku[k])) then
						begin
							min := dec;
							indexmin := j;
							advancedcheck := false;
						end 
						// Minimum tetap jika decimal lebih besar dari minimum
						else if (ord(temparr[j].Judul_Buku[k]) > ord(temparr[indexmin].Judul_Buku[k])) then
						begin
							advancedcheck := false;
						end else
						begin
							inc(k);
						end;
					end;
				end;
			end;
		indexarray[i] := indexmin // Setting indexarray urutan ke [i] dengan indexmin
		end; 
	end;

	procedure year(var arrBuku: BArr);
	{ menampilkan daftar buku yang memiliki tahun terbit sesuai input
	  I.S. data buku sesuai array
	  F.S. data yang ditampilkan hanya buku yang memiliki tahun terbit sesuai input
	}

   { KAMUS LOKAL }
	var
	count, i, t: integer; { count adalah jumlah; i adalah indeks; t adalah input tahun }
	k: string;			  { k adalah input kategori }

	{ ALGORITMA }
	begin
		i:=1;			  { inisialisasi i = 1 sebagai indeks pertama array }
		count:=0;		  { inisialisasi count = 0 sebagai variabel jumlah }
		write('Masukkan tahun: ');
		readln(t);
		write('Masukkan kategori: ');
		readln(k);
		writeln();
		writeln('Buku yang terbit ', k, ' ', t, ' :');
		while(i<=lenBuku) do { EOP : i > GetSizeBuku }
			begin
				if(k = '=') then 								{ proses kasus input k adalah = (sama dengan) }
				begin
					if(arrBuku[i].Tahun_Penerbit = t) then 		{ proses kasus tahun terbit data sesuai input }
						begin
							count := count+1;
							writeln(arrBuku[i].ID_Buku, ' | ', arrBuku[i].Judul_Buku, ' | ', arrBuku[i].Author);
						end;
				end else if(k = '<') then   					{ proses kasus input k adalah < (lebih kecil) }
				begin
					if(arrBuku[i].Tahun_Penerbit < t) then 		{ proses kasus tahun terbit data lebih kecil dari input t }
						begin
							count := count+1;
							writeln(arrBuku[i].ID_Buku, ' | ', arrBuku[i].Judul_Buku, ' | ', arrBuku[i].Author);
						end;
					end else if(k = '>') then 					{ proses kasus input k adalah > (lebih besar) }
						begin
							if(arrBuku[i].Tahun_Penerbit > t) then { proses kasus tahun terbit data lebih besar dari input t }
							begin
								count := count+1;
								writeln(arrBuku[i].ID_Buku, ' | ', arrBuku[i].Judul_Buku, ' | ', arrBuku[i].Author);
							end;
					end else if(k = '>=') then 					{ proses kasus input k adalah >= (lebih besar sama dengan) }
						begin
							if(arrBuku[i].Tahun_Penerbit >= t) then { proses kasus tahun terbit data lebih besar sama dengan input t }
							begin
								count := count+1;
								writeln(arrBuku[i].ID_Buku, ' | ', arrBuku[i].Judul_Buku, ' | ', arrBuku[i].Author);
							end;
					end else if(k = '<=') then 					{ proses kasus input k adalah <= (lebih kecil sama dengan) }
						begin
							if(arrBuku[i].Tahun_Penerbit <= t) then { proses kasus tahun terbit data lebih kecil sama dengan input t }
								begin
									count := count+1;
									writeln(arrBuku[i].ID_Buku, ' | ', arrBuku[i].Judul_Buku, ' | ', arrBuku[i].Author);
								end;
						end;
				i := i+1;
			end;
		if(count = 0) then 								{ proses kasus count di akhir = 0 }
			begin
				writeln('Tidak ada buku yang sesuai.');
			end;
			
	end;

	procedure add(var arrBuku: BArr);
	{ Memasukkan data buku baru ke dalam array buku
	  I.S. data array sama dengan data pada csv
	  F.S. index array bertambah 1 dengan data baru
	}

	{ ALGORITMA }
	begin
		writeln('Masukkan Informasi buku yang ditambahkan: ');
		write('Masukkan id buku: ');
		lenBuku := lenBuku + 1; { panjang data bertambah 1 }
		readln(arrBuku[lenBuku+1].ID_Buku); {memasukkan ID Buku baru dengan indeks jumlah data bertambah 1}
		write('Masukkan judul buku: ');
		readln(arrBuku[lenBuku+1].Judul_Buku); {memasukkan Judul Buku baru dengan indeks jumlah data bertambah 1}
		write('Masukkan pengarang buku: ');
		readln(arrBuku[lenBuku+1].Author); {memasukkan Author baru dengan indeks jumlah data bertambah 1} 
		write('Masukkan jumlah buku: ');
		readln(arrBuku[lenBuku+1].Jumlah_Buku); {memasukkan Jumlah Buku baru dengan indeks jumlah data bertambah 1}
		write('Masukkan tahun terbit buku: ');
		readln(arrBuku[lenBuku+1].Tahun_penerbit); {memasukkan Tahun penerbit baru dengan indeks jumlah data bertambah 1}
		write('Masukkan kategori: ');
		readln(arrBuku[lenBuku+1].Kategori); {memasukkan Kategori baru dengan indeks jumlah data bertambah 1}
		writeln();
		writeln('Buku berhasil ditambahkan ke dalam sistem!');
		lenBuku := lenBuku + 1; { panjang data bertambah 1 }
	end;

	procedure amount(var arrBuku: BArr);
	{ Menambahkan jumlah buku baru ke dalam array buku sesuai jumlah input
	  I.S. data jumlah buku pada array sama dengan data pada csv
	  F.S. data jumlah buku bertambah sesuai input
	}

	{ KAMUS LOKAL }
	var
		found: Boolean;
		i, n: integer;
		id: string;

	{ ALGORTIMA }
	begin
		found := false; 			{ inisialisasi, found = false }
		i:=1; 						{ inisialisasi, i = 1 sebagai indeks }
		write('Masukan ID Buku: ');
		readln(id);
		write('Masukan jumlah buku yang ditambahkan: ');
		readln(n);
		while((i<=lenBuku)  and (not found)) do    { EOP : i > ukuran data (lenBuku) atau found = true }
			begin
				if(arrBuku[i].ID_Buku = id) then	{ proses kasus id buku pada array sama dengan input }
				begin
					found := true;
				end
				else
					i:= i+1;
			end; 					{ i akhir adalah indeks buku yang memiliki id input }
		arrBuku[i].Jumlah_buku := arrBuku[i].Jumlah_Buku + n;	{ jumlah buku menjadi jumlah buku awal ditambah input }
		writeln('Pembaharuan jumlah buku berhasil dilakukan, total buku ', arrBuku[i].Judul_Buku, ' di perpustakaan menjadi ', arrBuku[i].Jumlah_Buku);
	end;

	procedure PrintBuku (var arrBuku : BArr);
	{Menulis elemen-elemen dari arrBuku ke layar dengan format sesuai data buku}
	{I.S. : arrBuku sudah berisi data dari file buku dan/atau modifikasi di main program}
	{F.S. :	arrBuku tercetak ke layar sesuai format data buku}
	{' | ' digunakan untuk pemisah antar kolom}

	{ KAMUS LOKAL }
	var
		k : integer;
	
	{ ALGORITMA }
	begin
		for k := 1 to (lenBuku) do
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
	end;
end.