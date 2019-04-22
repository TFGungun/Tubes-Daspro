unit statistik;
{ mencetak jumlah admin, pengguna, dan buku berdasarkan kategorinya }
interface

uses uFileLoader;

procedure countPengguna(arrUser: UArr);
procedure countBuku(arrBuku: BArr);
procedure list_statistik (var arrBuku: BArr; var arrUser: UArr);


implementation

procedure countPengguna(arrUser: UArr);
{ menghitung dan mencetak jumlah anggota; admin dan pengunjung }

	{ KAMUS }
	var
		a, p, i: Integer; { a untuk menghitung jumlah admin, p untuk pengurus, i sebagai indeks array user}

	{ ALGORITMA }
	begin
		a := 0;					{ inisialisasi }
		p := 0;
		for i:= 1 to lenUser do { EOP : i = banyak data user }
			begin
				if(arrUser[i].Role = 'Admin') then { proses kasus role user = Admin }
					begin
						a:=a+1;
					end
				else { arrUser[i].Role = 'Pengunjung'; proses kasus role user = Pengunjung }
					begin
						p:=p+1;
					end;
			end;
		writeln('Admin | ', a);
		writeln('Pengunjung | ', p);
		writeln('Total | ', a+p);
	end;

procedure countBuku(arrBuku: BArr);
{ menghitung dan mencetak jumlah buku berdasarkan kategori }
	
	{ KAMUS }
	var
	i, sastra, sains, sejarah, manga, programming : integer;
	{ i indeks array buku, sastra menghitung jumlah buku kategori sastra,
	  sains menghitung jumlah buku kategori sains,
	  sejarah menghitung jumlah buku kategori sejarah,
	  manga menghitung jumlah buku kategori manga,
	  programming menghitung jumlah buku kategori programming
	}
	
	{ ALGORITMA }
	begin
	{ inisialisasi }
	sastra := 0;
	sains := 0;
	sejarah := 0;
	manga := 0;
	programming := 0;
	
	for i:=1 to lenBuku do { EOP : i = banyak data buku}
		begin
		if (arrBuku[i].Kategori = 'sastra') then { proses kasus kategori pada array = sastra }
			begin
			sastra := sastra + 1;
			end
		
		else if (arrBuku[i].Kategori = 'sains') then { proses kasus kategori pada array = sains }
			begin
			sains := sains + 1;
			end
		
		else if (arrBuku[i].Kategori = 'sejarah') then { proses kasus kategori pada array = sejarah }
			begin
			sejarah := sejarah + 1;
			end
	
		else if (arrBuku[i].Kategori = 'manga') then { proses kasus kategori pada array = manga }
			begin
			manga := manga + 1;
			end
	
		else {if (arrBuku[i].Kategori = programming); { proses kasus kategori pada array = programming }}
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
{ memanggil prosedur countPengguna dan countBuku }

	{ ALGORITMA }
	begin
		writeln('Pengguna: ');
		countPengguna(arrUser);
		writeln('Buku:');
		countBuku(arrBuku);
	end;
end.