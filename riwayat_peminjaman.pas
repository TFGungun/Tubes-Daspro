unit riwayat_peminjaman;
	
	
interface
	// here comes stuff that the unit publicly offers
uses 
	uFileLoader, uDate;
	
	procedure cek_riwayat(var arrPeminjaman: PinjamArr; var arrBuku: BArr);
implementation
	// here comes the implementation of offered stuff and
	// optionally internal stuff (only known in the unit)
	procedure cek_riwayat(var arrPeminjaman: PinjamArr; var arrBuku: BArr);
	
	var
		i, j, c, x: integer;
		uname, judul_buku: string;
		found : boolean;
		counter : array[1..1000] of integer;
		tgl : Date;
	
	begin
	
	write('Masukkan username pengunjung : '); readln(uname);
	writeln('Riwayat: ');
	i := 0;
	j := 1;
	c := 0;
	x := 1;
	
	for c:=1 to 1000 do
		begin
		counter[c]:=0;
		end;
	
	for i:=1 to lenHistoryPeminjaman do
		begin
		if (uname = arrPeminjaman[i].Username) then
			begin
			counter[j] := i;
			j := j+1;
			end;
		end;
	
	j:=0;
	
	while (counter[x]<>0) do
		begin
		found := false;
		while (not found) do
			begin
			j:=j+1;
			if (arrPeminjaman[counter[x]].ID_Buku = arrBuku[j].ID_Buku) then
				begin
				judul_buku := arrBuku[j].Judul_Buku;
				found := true;
				end;
			end;
		tgl := arrPeminjaman[counter[x]].Tanggal_Peminjaman;
		writeln(tgl.DD, '/', tgl.MM, '/', tgl.YYYY 	,' | ',arrPeminjaman[counter[x]].ID_Buku,' | ',judul_buku);
		x := x+1;
		end;
	end;
end.
