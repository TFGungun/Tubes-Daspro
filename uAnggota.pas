///////////////////////////////////////////////////////////////
//							uAnggota	                     //
///////////////////////////////////////////////////////////////
//Unit yang menangani hal-hal yang berhubungan dengan anggota//
///////////////////////////////////////////////////////////////
unit uAnggota;

interface
	uses uFileLoader, uDate, parsertuanyon;

	procedure CariAnggota(var arrUser : UArr);
	{Mencari anggota dengan username tertentu dan mencetak datanya ke layar}
	{I.S. : arrUser sudah berisi, username didapat dari input}
	{F.S. : Data user tercetak ke layar, jika username tidak ditemukan akan
			dicetak pesan kesalahan}


implementation
	
	procedure CariAnggota(var arrUser : UArr);
	{Mencari anggota dengan username tertentu dan mencetak datanya ke layar}
	{I.S. : arrUser sudah berisi, username didapat dari input}
	{F.S. : Data user tercetak ke layar, jika username tidak ditemukan akan
			dicetak pesan kesalahan}

	{KAMUS LOKAL}
	var
		username : string;
		i : integer;
		found : boolean;

	{ALGORITMA}
	begin

		write('Masukkan username: ');
		readln(username);
		i := 1;
		found := false;
		
		while ((not found) and (i <= lenUser)) do
		begin
			if(arrUser[i].Username = username) then
			begin
				found := true;
			end else
			begin
				inc(i);
			end;
		end;

		if (found) then
		begin
			writeln('Nama Anggota: ', arrUser[i].Nama);
			writeln('Alamat Anggota: ', arrUser[i].Alamat);
		end else
		begin
			writeln('Anggota tidak ditemukan');
		end;

	end;

end.