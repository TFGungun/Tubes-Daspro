unit riwayat_peminjaman;
{ unit menerima input username dan menampilkan riwayat peminjaman }
	
interface
uses 
	uFileLoader, uDate;
	
	procedure cek_riwayat(var arrPengembalian: KembaliArr; var arrBuku: BArr);

implementation
	procedure cek_riwayat(var arrPengembalian: KembaliArr; var arrBuku: BArr);
	{ mencetak riwayat peminjaman input username dengan format 
	  tanggal pengembalian | ID Buku | Judul Buku }
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
	
	for i:=1 to lenHistoryPengembalian do { EOP : i = lenHistoryPengembalian }
		begin
		if (uname = arrPengembalian[i].Username) then { Proses kasus uname = username pada array pengembalian}
			begin
			counter[j] := i;
			j := j+1;
			end;
		end;
	
	j:=0;	{ inisialisasi ulang untuk indeks j }
	
	while (counter[x]<>0) do { EOP : elemen array counter = 0 }
		begin
		found := false;		 { inisialisasi found = false }
		while (not found) do { EOP : found = true }
			begin
			j:=j+1;
			if (arrPengembalian[counter[x]].ID_Buku = arrBuku[j].ID_Buku) then { proses kasus ID buku pada array pengembalian = ID buku array buku }
				begin
				judul_buku := arrBuku[j].Judul_Buku;
				found := true;
				end;
			end;
		tgl := arrPengembalian[counter[x]].Tanggal_Pengembalian;
		writeln(tgl.DD, '/', tgl.MM, '/', tgl.YYYY 	,' | ',arrPengembalian[counter[x]].ID_Buku,' | ',judul_buku);
		x := x+1;
		end;
	end;
end.
