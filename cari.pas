unit cari;

interface

uses
	uFileLoader;

function validasi(k: string): boolean;
procedure search(var arrBuku: BArr);

implementation
function validasi(k: string): boolean;
//menghasilkan value 0 jika input tidak valid dan value 1 jika valid
	begin
		validasi := (k = 'sastra') or (k = 'sains') or (k = 'manga') or (k = 'sejarah') or (k = 'programming');
	end;

procedure search(var arrBuku: BArr);
//menghasilkan daftar buku yang memiliki kategori sesuai input
	var
	count, i: integer;
	k : string;

	begin
		i:=1;
		count:=0;
		write('Masukkan kategori: ');
		readln(k);
		while(validasi(k) = false) do
			begin
				writeln('Kategori ', k, ' tidak valid.');
				write('Masukkan kategori: ');
				readln(k);
			end;
		while(i<=GetSizeBuku()) do
			begin
				if(k = arrBuku[i].Kategori) then
					begin
						writeln(arrBuku[i].ID_Buku, ' | ', arrBuku[i].Judul_Buku, ' | ', arrBuku[i].Author);
						count := count+1;
					end;
				i := i+1;
			end;
		if(count = 0) then
			writeln('Tidak ada buku dalam kategori ini.');
	end;
end.
