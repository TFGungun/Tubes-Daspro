unit caritahunterbit;
{ unit untuk mencari buku berdasarkan tahun terbit sesuai input }
interface
	uses
		uFileLoader;

procedure year(var arrBuku: BArr);

implementation
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
		while(i<=GetSizeBuku()) do { EOP : i > GetSizeBuku }
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
					}
					end else if(k = '>=') then 					{ proses kasus input k adalah >= (lebih besar sama dengan) }
						begin
							if(arrBuku[i].Tahun_Penerbit >= t) then { proses kasus tahun terbit data lebih besar sama dengan input t }
							begin
								count := count+1;
								writeln(arrBuku[i].ID_Buku, ' | ', arrBuku[i].Judul_Buku, ' | ', arrBuku[i].Author);
							end;
					}
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

end.