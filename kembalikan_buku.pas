unit kembalikan_buku;

interface
	uses
		uFileLoader;

function isThnKabisat(j:integer): boolean;
procedure denda();
function convertBulantoHari(m, y: integer): integer;
function convertTahuntoHari(y1, y2: integer): Integer;

implementation
function isThnKabisat(j:integer): boolean;
	var
		flag: boolean;
	begin
		if((j%4) = 0) and ((j%100) <> 0) or ((j%400) = 0)) then
			begin
				flag:=true;
			end
		else
			begin
				flag:=false;
			end;
		isThnKabisat := flag;
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
						if((i = 2) and (isThnKabisat(y)) then
							begin
								jml_hari := jml_hari + 29;
							end
						else if((i=2) and (not isThnKabisat(y)) then
							begin
								jml_hari := jml_hari + 28;
							end
						else if((i<=7) and (i%2 = 1)) then
							begin
								jml_hari := jml_hari + 31;
							end
						else if((i>7) and (i%2 = 0)) then
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

function convertTahuntoHari(y1, y2: integer): Integer;
	var
		jml_hari, i: Integer;

	begin
		if( y2-y1 = 0 ) then
			begin
				convertTahuntoHari := 0;
			end
		else
			begin
				for i:=y1 to y2 do
					begin
						if(isThnKabisat(i)) then
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
	end;

procedure denda(var arrPeminjaman: PinjamArr; var arrBuku: BArr);
	var
		i, denda : integer;
		stop : boolean;
		date : string;
		dateint : Date;

	begin
		write('Masukkan id buku yang dikembalikan: ');
		readln(id);
		writeln('Data peminjaman:');
		i:=0;
		j:=0;
		stop:= false;
		while(i<=lenHistoryPeminjaman) and (not stop)) do
			begin
				i := i+1;
				if(id = arrPeminjaman[i].ID_Buku) then
					begin
						stop := true;
					end;
			end;
		while((j<=ukuran_arrBuku) and (not stop)) do
			begin
				j := j+1;
				if(id = arrBuku[j].ID_Buku) then
					begin
						stop := true;
					end;
			end;

		write('Username: '); writeln(arrPeminjaman[i].Username);
		write('Judul buku: '); writeln(arrBuku[j].Judul_Buku);
		write('Tanggal peminjaman: '); writeln(arrPeminjaman[i].Tanggal_Peminjaman);
		write('Tanggal batas: '); writeln(arrPeminjaman[i].Tanggal_Batas_Pengembalian);
		writeln();
		write('Masukkan tanggal hari ini: '); readln(date);
		dateint := ParseDate(date);
		denda:= (convertTahuntoHari(arrPeminjaman[i].Tanggal_Batas_Pengembalian.YYYY, dateint.YYYY) +
				dateint.DD + convertBulantoHari(dateint.MM, dateint.YYYY) -
				(arrPeminjaman[i].Tanggal_Batas_Pengembalian.YYYY + convertBulantoHari(arrPeminjaman[i].Tanggal_Batas_Pengembalian.MM, arrPeminjaman[i].Tanggal_Batas_Pengembalian.YYYY)))*2000;
		writeln('Anda terlambat mengembalikan buku.');
		writeln('Anda terkena denda ', denda, '.');
	end;
end.