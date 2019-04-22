unit PengembalianBuku;
// PengembaliannBuku
// Unit yang menangani data pengembalian buku

interface
	
	
uses uFileLoader, udate, PeminjamanBuku;


procedure KembalikanBuku (var arrHistoryPengembalian : KembaliArr ; var arrHistoryPeminjaman : PinjamArr; var arrBuku : BArr ; UserIn : User);
{Mengisi data yang diinputkan oleh pengguna ke dalam arrHistoryPengembalian}
	{I.S. : arrHistoryPengembalian sudah berisi data dari file riwayat peminjaman dan/atau modifikasi di main program}
	{F.S. :	arrHistoryPengembalian tercetak ke layar sesuai format data riwayat pengembalian}

implementation

procedure KembalikanBuku (var arrHistoryPengembalian : KembaliArr ; var arrHistoryPeminjaman : PinjamArr; var arrBuku : BArr ; UserIn : User);

var 
	idkembali, judulbuku : string;
	i, TahunKembali, BulanKembali, HariKembali, TahunBatasKembali, BulanBatasKembali, HariBatasKembali : integer;
	tanggalkembalistring : string;
	

begin
	// Pengguna menginput id buku yang bertype string yang kemudian disimpan
	// di array History Peminjaman
	write('Masukkan id buku yang ingin dikembalikan: ');
	readln(idkembali);
	arrHistoryPengembalian[lenhistorypengembalian + 1].ID_Buku := idkembali;
	writeln('Data Peminjam: ');
	
	// For loop untuk mencari data buku
	for i := 1 to (lenbuku) do
	begin
		if arrBuku[i].ID_Buku = idkembali then
		begin
			judulbuku := arrBuku[i].Judul_Buku;
			arrBuku[i].Jumlah_Buku := arrBuku[i].Jumlah_Buku + 1;
		end;
	end;

	// Untuk menampilkan Username, Judul Buku, Tanggal Peminjaman, serta Tanggal Batas Pengembalian 
	for i:= 1 to (lenhistorypeminjaman) do
	begin
		if (arrHistoryPeminjaman[i].ID_Buku = idkembali) and (arrHistoryPeminjaman[i].Username = UserIn.Username) then // tambah username untuk mengantisipasi ada 1 buku yang dipinjam 2 user
		begin
		writeln('Username: ', arrHistoryPeminjaman[i].Username);
		writeln('Judul_Buku: ', judulbuku);
		write('Tanggal Peminjaman: ');
		writelnDate(arrHistoryPeminjaman[i].Tanggal_Peminjaman);
		write('Tanggal Batas Pengembalian: ');
		writelnDate(arrHistoryPeminjaman[i].Tanggal_Batas_Pengembalian);
		TahunBatasKembali := arrHistoryPeminjaman[i].Tanggal_Batas_Pengembalian.YYYY;
		BulanBatasKembali := arrHistoryPeminjaman[i].Tanggal_Batas_Pengembalian.MM;
		HariBatasKembali := arrHistoryPeminjaman[i].Tanggal_Batas_Pengembalian.DD;
		arrHistoryPeminjaman[i].Status_Pengembalian := true;
		end;
	end;
	
	// Pengguna menginput tanggal bertipe string
	write('Masukkan tanggal hari ini: ');
	readln(tanggalkembalistring);
	
	// untuk mengubah type tanggal yang berbentuk string menjadi type date 
	arrHistoryPengembalian[lenhistorypengembalian + 1].Tanggal_Pengembalian := ParseDate(tanggalkembalistring);
	arrHistoryPengembalian[lenhistorypengembalian + 1].Username := UserIn.Username;
	TahunKembali := arrHistoryPengembalian[lenhistorypengembalian + 1].Tanggal_Pengembalian.YYYY;
	BulanKembali := arrHistoryPengembalian[lenhistorypengembalian + 1].Tanggal_Pengembalian.MM;
	HariKembali := arrHistoryPengembalian[lenhistorypengembalian + 1].Tanggal_Pengembalian.DD;
	lenhistorypengembalian := lenhistorypengembalian + 1;

	// Membandingkan tanggal batas kembali dengan tanggal kembali untuk mengeluarkan output
	// berupa message yang telah ditentukan
	if (TahunBatasKembali = TahunKembali) then
	begin
		if (BulanBatasKembali = BulanKembali) then
		begin
			if (HariBatasKembali >= HariKembali) then
			begin
				writeln('Terima kasih sudah meminjam');
			end else
			begin
				writeln('Anda terlambat mengembalikan buku');
			end;
		end else if (BulanBatasKembali > BulanKembali) then
		begin
			writeln('Terima kasih sudah meminjam');
		end else
		begin
			writeln('Anda terlambat mengembalikan buku');
		end;
	end else if (TahunBatasKembali > TahunKembali) then
	begin
		writeln('Terima kasih sudah meminjam');
	end else
	begin
		writeln('Anda terlambat mengembalikan buku');
	end;
	end;
end.
