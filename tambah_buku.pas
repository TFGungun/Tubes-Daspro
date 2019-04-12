unit tambah_buku;

interface
uses
	uFileLoader;

procedure add(var arrBuku: BArr);
function GetSize(): Integer;

implementation

function GetSize(): Integer;
	begin
		GetSize := lenBuku;
	end;


procedure add(var arrBuku: BArr);
	begin
		writeln('Masukkan Informasi buku yang ditambahkan: ');
		write('Masukkan id buku: ');
		readln(arrBuku[GetSizeBuku()+1].ID_Buku);
		write('Masukkan judul buku: ');
		readln(arrBuku[GetSizeBuku()+1].Judul_Buku);
		write('Masukkan pengarang buku: ');
		readln(arrBuku[GetSizeBuku()+1].Author);
		write('Masukkan jumlah buku: ');
		readln(arrBuku[GetSizeBuku()+1].Jumlah_Buku);
		write('Masukkan tahun terbit buku: ');
		readln(arrBuku[GetSizeBuku()+1].Tahun_penerbit);
		write('Masukkan kategori: ');
		readln(arrBuku[GetSizeBuku()+1].Kategori);
		writeln();
		writeln('Buku berhasil ditambahkan ke dalam sistem!');
		lenBuku := lenBuku + 1;
	end;
end.