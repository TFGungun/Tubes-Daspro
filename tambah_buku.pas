unit tambah_buku;
{ unit untuk memasukkan data buku baru ke dalam array buku }
interface
uses
	uFileLoader;

procedure add(var arrBuku: BArr);
	
implementation

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
end.