unit uAnggota;

interface
	uses uFileLoader, uDate, parsertuanyon;

	procedure CariAnggota(var arrUser : UArr);

implementation
	
	procedure CariAnggota(var arrUser : UArr);
	var
		username : string;
		i : integer;
		found : boolean;
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