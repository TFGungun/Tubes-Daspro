unit kembalikan_buku;

interface
	uses
		uFileLoader,
		uDate;

function isThnKabisat(j:integer): boolean;
procedure denda(var arrPeminjaman: PinjamArr; var arrBuku: BArr);
function convertBulantoHari(m, y: integer): integer;
function convertTahuntoHari(y: integer): Integer;

implementation
function isThnKabisat(j:integer): boolean;
	begin
		isThnKabisat := (j mod 4 = 0) and (j mod 100 <> 0) or (j mod 400 = 0);
	end;

function convertBulantoHari(m, y: integer): integer;
	var
		jml_hari, i: Integer;

	begin
		if(m = 1) then
			begin
				convertBulantoHari := 0;
			end
		else
			begin
				jml_hari := 0;
				for i:=1 to (m-1) do
					begin
						if((i = 2) and (isThnKabisat(y))) then
							begin
								jml_hari := jml_hari + 29;
							end
						else if((i=2) and (not isThnKabisat(y))) then
							begin
								jml_hari := jml_hari + 28;
							end
						else if((i<=7) and (i mod 2 = 1)) then
							begin
								jml_hari := jml_hari + 31;
							end
						else if((i>7) and (i mod 2 = 0)) then
							begin
								jml_hari := jml_hari + 31;
							end
						else
							begin
								jml_hari := jml_hari + 30;
							end;
					end;
				convertBulantoHari := jml_hari;
			end;
	end;

function convertTahuntoHari(y: integer): Integer;
	var
		jml_hari, i: Integer;

	begin
		jml_hari:=0;
		for i:=0 to y do
			begin
				if(isThnKabisat(y)) then
					begin
						jml_hari := jml_hari + 366;
						end
				else
					begin
						jml_hari := jml_hari + 365;
					end;
			end;
		convertTahuntoHari := jml_hari;
	end;

procedure denda(var arrPeminjaman: PinjamArr; var arrBuku: BArr);
	var
		i, j, fine, days : integer;
		stop : boolean;
		datestring, id : string;
		dateint : Date;

	begin
		write('Masukkan id buku yang dikembalikan: ');
		readln(id);
		writeln('Data peminjaman:');
		i:=0;
		stop:= false;
		while((i<=lenHistoryPeminjaman) and (not stop)) do
			begin
				i := i+1;
				if(id = arrPeminjaman[i].ID_Buku) then
					begin
						stop := true;
					end;
			end;
		stop:=false;
		j:=0;
		while((j<=lenBuku) and (not stop)) do
			begin
				j := j+1;
				if(id = arrBuku[j].ID_Buku) then
					begin
						stop := true;
					end;
			end;

		write('Username: '); writeln(arrPeminjaman[i].Username);
		write('Judul buku: '); writeln(arrBuku[j].Judul_Buku);
		write('Tanggal peminjaman: '); writeln(arrPeminjaman[i].Tanggal_Peminjaman.DD, '/', arrPeminjaman[i].Tanggal_Peminjaman.MM, '/', arrPeminjaman[i].Tanggal_Peminjaman.YYYY);
		write('Tanggal batas: '); writeln(arrPeminjaman[i].Tanggal_Batas_Pengembalian.DD, '/', arrPeminjaman[i].Tanggal_Batas_Pengembalian.MM, '/', arrPeminjaman[i].Tanggal_Batas_Pengembalian.YYYY);
		writeln();
		write('Masukkan tanggal hari ini: '); readln(datestring);
		dateint := ParseDate(datestring);
		days:= (convertTahuntoHari(dateint.YYYY) + dateint.DD + convertBulantoHari(dateint.MM, dateint.YYYY) - convertTahuntoHari(arrPeminjaman[i].Tanggal_Batas_Pengembalian.YYYY) -
			arrPeminjaman[i].Tanggal_Batas_Pengembalian.DD - convertBulantoHari(arrPeminjaman[i].Tanggal_Batas_Pengembalian.MM, arrPeminjaman[i].Tanggal_Batas_Pengembalian.YYYY));
		fine:=days*2000;
		writeln('Anda terlambat mengembalikan buku ', days, ' hari.');
		writeln('Anda terkena denda ', fine, ' rupiah.');
	end;
end.