unit tambah_jumlah_buku;

interface
uses
	uFileLoader;

procedure amount(var arrBuku: BArr);

implementation

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
end.