unit uHilang;

interface
	uses uFileLoader, uDate;

	procedure PrintLaporanWithJudul(var arrLaporanHilang : HilangArr ; arrBuku : BArr);

	function CariJudulBuku(var arrBuku : Barr ; ID_Buku : string) : string;


implementation
	
	procedure PrintLaporanWithJudul(var arrLaporanHilang : HilangArr ; arrBuku : BArr);
	var
		i : integer;

	begin
		writeln('Buku yang hilang');

		for i := 1 to lenLaporanHilang do
		begin
			write(arrLaporanHilang[i].ID_Buku);
			write(' | ');
			write(CariJudulBuku(arrBuku, arrLaporanHilang[i].ID_Buku));
			write(' | ');
			WritelnDate(arrLaporanHilang[i].Tanggal_Laporan);
		end;
	end;

	function CariJudulBuku(var arrBuku : Barr ; ID_Buku : string) : string;
	var
		i : integer;
		isfound : boolean;

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
