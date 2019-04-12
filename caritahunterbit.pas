unit caritahunterbit;

interface
	uses
		uFileLoader;

procedure year(var arrBuku: BArr);

implementation
procedure year(var arrBuku: BArr);
	var
	count, i, t: integer;
	k: string;

	begin
		i:=1;
		count:=0;
		write('Masukkan tahun: ');
		readln(t);
		write('Masukkan kategori: ');
		readln(k);
		writeln();
		writeln('Buku yang terbit ', k, ' ', t, ' :');
		while(i<=GetSizeBuku()) do
			begin
				if(k = '=') then
				begin
					if(arrBuku[i].Tahun_Penerbit = t) then
						begin
							count := count+1;
							writeln(arrBuku[i].ID_Buku, ' | ', arrBuku[i].Judul_Buku, ' | ', arrBuku[i].Author);
						end;
				end else if(k = '<') then
				begin
					if(arrBuku[i].Tahun_Penerbit < t) then
						begin
							count := count+1;
							writeln(arrBuku[i].ID_Buku, ' | ', arrBuku[i].Judul_Buku, ' | ', arrBuku[i].Author);
						end;
					end else if(k = '>') then
						begin
							if(arrBuku[i].Tahun_Penerbit > t) then
							begin
								count := count+1;
								writeln(arrBuku[i].ID_Buku, ' | ', arrBuku[i].Judul_Buku, ' | ', arrBuku[i].Author);
							end;
					end else if(k = '>=') then
						begin
							if(arrBuku[i].Tahun_Penerbit >= t) then
							begin
								count := count+1;
								writeln(arrBuku[i].ID_Buku, ' | ', arrBuku[i].Judul_Buku, ' | ', arrBuku[i].Author);
							end;
					end else if(k = '<=') then
						begin
							if(arrBuku[i].Tahun_Penerbit > t) then
								begin
									count := count+1;
									writeln(arrBuku[i].ID_Buku, ' | ', arrBuku[i].Judul_Buku, ' | ', arrBuku[i].Author);
								end;
						end;
				i := i+1;
			end;
		if(count = 0) then
			begin
				writeln('Tidak ada buku yang sesuai.');
			end;
			
	end;

end.