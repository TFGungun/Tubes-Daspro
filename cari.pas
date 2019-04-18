unit cari;
{ unit berfungsi untuk mencari buku berdasarkan kategori sesuai input }
interface

uses
	uFileLoader;

function validasi(k: string): boolean;
procedure search(var arrBuku: BArr);

implementation
function validasi(k: string): boolean;
{ menghasilkan true jika input termasuk kategori yang ada dan false jika tidak; dengan menuliskan ekspresi boolean }
	
	{ ALGORITMA }
	begin
		validasi := (k = 'sastra') or (k = 'sains') or (k = 'manga') or (k = 'sejarah') or (k = 'programming');
	end;

procedure search(var arrBuku: BArr);
{ menampilkan daftar buku yang memiliki kategori sesuai input
  I.S. data array sama dengan data pada csv
  F.S. data dari array yang ditampilkan adalah yang sesuai kategori, data pada array tetap sama dengan csv
}
	
	{ KAMUS LOKAL }
	var
	count, i: integer;					{ count jumlah dan i merupakan indeks }
	k : string;							{ read string dari pengguna }

	{ ALGORITMA }
	begin
		i:=1;							{ inisialisasi, i = 1 sebagai indeks pertama pada array }
		count:=0;						{ inisialisasi, count = 0 }
		write('Masukkan kategori: ');
		readln(k);						{ first element }
		while(validasi(k) = false) do 	{ EOP : validasi(k) = true }
			begin
				writeln('Kategori ', k, ' tidak valid.');
				write('Masukkan kategori: ');
				readln(k);				{ next element }
			end;
		while(i<=GetSizeBuku()) do 		{ EOP : i > GetSizeBuku() }
			begin
				if(k = arrBuku[i].Kategori) then { proses kasus kategori pada data sesuai input }
					begin
						writeln(arrBuku[i].ID_Buku, ' | ', arrBuku[i].Judul_Buku, ' | ', arrBuku[i].Author);
						count := count+1;
					end;
				i := i+1;
			end;
		if(count = 0) then 						{ proses kasus tidak ada buku yang sesuai kategori input }
			writeln('Tidak ada buku dalam kategori ini.');
	end;
end.