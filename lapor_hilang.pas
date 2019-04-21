unit lapor_hilang;


interface

uses uDate, uFileLoader;
		
	procedure LaporKehilangan(var arrlaporanHilang : HilangArr ; arrBuku : BArr; UserIn : User);

implementation

	procedure LaporKehilangan(var arrlaporanHilang : HilangArr ; arrBuku : BArr; UserIn : User);

	var
		tanggallaporstring, judulbukuhilang, idhilang : string;
		i, indexlost : integer;

	begin
		write('Masukkan id buku: ');
		readln(idhilang);
		arrLaporanHilang[lenLaporanHilang + 1].ID_Buku_Hilang := idhilang;
		
		for i := 1 to lenBuku do
		begin
			if arrBuku[i].ID_Buku = idhilang then
			begin
				indexlost := i;
			end;
		end;
		
		
		write('Masukkan judul buku: ');
		readln(judulbukuhilang);
		//arrLaporanHilang[indexlost].Judul_Buku := judulbukuhilang;
		//arrBuku[indexlost].Jumlah_Buku := arrBuku[indexlost].Jumlah_Buku - 1; tidak perlu karena sudah ditangani saat meminjam buku
		
		write('Masukkan tanggal pelaporan: ');
		readln(tanggallaporstring);
		arrLaporanHilang[lenLaporanHilang + 1].Tanggal_Laporan := ParseDate(tanggallaporstring);
		//Day := LaporanBukuHilang.Tanggal_Laporan.DD;
		//Month := LaporanBukuHilang.Tanggal_Laporan.MM;
		//Year := LaporanBukuHilang.Tanggal_Laporan.YYYY;
		// belum dibutuhkan
		
		arrLaporanHilang[lenLaporanHilang + 1].Username := UserIn.username;
		
		lenLaporanHilang := lenLaporanHilang + 1;
		
		writeln('Laporan Berhasil Diterima');
		
		
	end;
end.




