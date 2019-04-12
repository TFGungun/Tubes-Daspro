unit tambah_jumlah_buku;

interface
uses
	uFileLoader;

procedure amount(var arrBuku: BArr);

implementation

procedure amount(var arrBuku: BArr);
	var
		found: Boolean;
		i, n: integer;
		id: string;
	begin
		found := false;
		i:=1;
		write('Masukan ID Buku: ');
		readln(id);
		write('Masukan jumlah buku yang ditambahkan: ');
		readln(n);
		while((i<=lenBuku)  and (not found)) do
			begin
				if(arrBuku[i].ID_Buku = id) then
				begin
					found := true;
				end
				else
					i:= i+1;
			end;
		arrBuku[i].Jumlah_buku := arrBuku[i].Jumlah_Buku + n;
		writeln('Pembaharuan jumlah buku berhasil dilakukan, total buku ', arrBuku[i].Judul_Buku, ' di perpustakaan menjadi ', arrBuku[i].Jumlah_Buku);
	end;
end.