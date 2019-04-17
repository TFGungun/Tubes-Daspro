unit registrasi;

interface
uses
	uFileLoader;

procedure regis(var lenUser: longint; arrUser: UArr);


implementation
procedure regis(var lenUser: longint; arrUser: UArr);
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
    arrUser[lenUser+1].nama := nm;
    arrUser[lenUser+1].alamat := almt;
    arrUser[lenUser+1].username := usnm;
    arrUser[lenUser+1].password := pwd;
//msg telah berhasil regis
    writeln('Pengunjung ', nm, ' berhasil terdaftar sebagai user');
end;
end.