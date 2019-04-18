unit registrasi;

interface
uses
	uFileLoader;

procedure regis(var arrUser: UArr);


implementation
procedure regis(var arrUser: UArr);
var
    nm,almt,usnm,pwd : string;

begin
//prosedur input masukan
    writeln('masukkan nama pengunjung');
    readln(nm);
    writeln('masukkan alamat pengunjung');
    readln(almt);
    writeln('masukkan username pengunjung');
    readln(usnm);
    writeln('masukkan password pengunjung');
    readln(pwd);
//simpen ke array
    arrUser[lenUser+1].Nama := nm;
    arrUser[lenUser+1].Alamat := almt;
    arrUser[lenUser+1].Username := usnm;
    arrUser[lenUser+1].Password := pwd;
    arrUser[lenUser+1].Role := 'Pengunjung';
    lenUser := lenUser + 1;
//msg telah berhasil regis
    writeln('Pengunjung ', nm, ' berhasil terdaftar sebagai user');
end;
end.