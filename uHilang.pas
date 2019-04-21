unit uHilang;

interface
	uses uFileLoader, uDate;

	procedure PrintLaporanWithJudul(var arrLaporanHilang : HilangArr ; arrBuku : BArr);
	{Menulis laporan hilang dengan format
	 ID_Buku_Hilang | Judul_Buku | Tanggal_Laporan}
	{I.S. : arrLaporanHilang dan arrBuku sudah berisi data dari file laporan hilang serta buku 
	dan/atau modifikasi di main program}
	{F.S. : laporan hilang tercetak ke layar sesuai format
	ID_Buku_Hilang | Judul_Buku | Tanggal_Laporan}

	function CariJudulBuku(var arrBuku : Barr ; ID_Buku : string) : string;
	{Menghasilkan string Judul_Buku dari buku dengan id ID_Buku}


implementation
	
	procedure PrintLaporanWithJudul(var arrLaporanHilang : HilangArr ; arrBuku : BArr);
	{Menulis laporan hilang dengan format
	 ID_Buku_Hilang | Judul_Buku | Tanggal_Laporan}
	{I.S. : arrLaporanHilang dan arrBuku sudah berisi data dari file laporan hilang serta buku 
	dan/atau modifikasi di main program}
	{F.S. : laporan hilang tercetak ke layar sesuai format
	ID_Buku_Hilang | Judul_Buku | Tanggal_Laporan}

	{KAMUS LOKAL}
	var
		i : integer;

	{ALGORITMA}
	begin
		writeln('Buku yang hilang');
		
		for i := 1 to lenLaporanHilang do
		begin
			write(arrLaporanHilang[i].ID_Buku_Hilang);
			write(' | ');
			write(CariJudulBuku(arrBuku, arrLaporanHilang[i].ID_Buku_Hilang));
			write(' | ');
			WritelnDate(arrLaporanHilang[i].Tanggal_Laporan);
		end;
	end;

	function CariJudulBuku(var arrBuku : Barr ; ID_Buku : string) : string;
	{Menghasilkan string Judul_Buku dari buku dengan id ID_Buku}
	
	{KAMUS LOKAL}
	var
		i : integer;
		isfound : boolean;

	{ALGORITMA}
	begin
		i := 1;
		isfound := false;
		while ((not isfound) and (i <= lenBuku)) do
		begin
			if(arrBuku[i].ID_Buku = ID_Buku) then
			begin
				CariJudulBuku := arrBuku[i].Judul_Buku;
				isfound := true;
			end else
			begin
				inc(i);
			end;
		end;
	end;

end.
