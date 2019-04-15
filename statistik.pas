unit statistik;

interface
	// here comes stuff that the unit publicly offers
uses uFileLoader;

procedure countPengguna(arrUser: UArr);
procedure countBuku(arrBuku: BArr);
procedure list_statistik (var arrBuku: BArr; var arrUser: UArr);


implementation
	// here comes the implementation of offered stuff and
	// optionally internal stuff (only known in the unit)
procedure countPengguna(arrUser: UArr);
	var
		a, p, i: Integer;
	begin
		a := 0;
		p := 0;
		for i:= 1 to lenUser do
			begin
				if(arrUser[i].Role = 'Admin') then
					begin
						a:=a+1;
					end
				else // arrUser[i].Role = 'Pengunjung'
					begin
						p:=p+1;
					end;
			end;
		writeln('Admin | ', a);
		writeln('Pengunjung | ', p);
		writeln('Total | ', a+p);
	end;

procedure countBuku(arrBuku: BArr);
	var
	i, sastra, sains, sejarah, manga, programming : integer;
	
	begin
	sastra := 0;
	sains := 0;
	sejarah := 0;
	manga := 0;
	programming := 0;
	
	for i:=1 to lenBuku do
		begin
		if (arrBuku[i].Kategori = 'sastra') then
			begin
			sastra := sastra + 1;
			end
		
		else if (arrBuku[i].Kategori = 'sains') then
			begin
			sains := sains + 1;
			end
		
		else if (arrBuku[i].Kategori = 'sejarah') then
			begin
			sejarah := sejarah + 1;
			end
	
		else if (arrBuku[i].Kategori = 'manga') then
			begin
			manga := manga + 1;
			end
	
		else //if (arrBuku[i].Kategori = programming)
			begin
			programming := programming + 1;
			end;
		end;

	writeln('sastra | ',sastra);
	writeln('sains | ',sains);
	writeln('sejarah | ',sejarah);
	writeln('manga | ',manga);
	writeln('programming | ',programming);
	writeln('Total | ', sastra+sains+sejarah+manga+programming);
	end;

procedure list_statistik( var arrBuku: BArr; var arrUser: UArr);
	begin
		writeln('Pengguna: ');
		countPengguna(arrUser);
		writeln('Buku:');
		countBuku(arrBuku);
	end;
end.