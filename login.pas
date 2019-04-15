unit login;

interface
uses
	uFileLoader;

procedure log_in(arrUser: UArr);

implementation
procedure log_in(arrUser: UArr);
var
    i : integer;
    found : boolean;
    usnm,pwd: string;
begin
//masukkan username and password
writeln('Masukkan username: ');
readln(usnm);
writeln('Masukkan password: ');
readln(pwd);

//cek username ada / ga
i := 1;
found := false;
repeat
    if (arrUser[i].username = usnm) then
        found := true
    else
        i := i+1;
until (found) or (i = lenUser);
if not found then
    writeln('Usename salah! Silakan coba lagi.')
//kalo username nemu cek password
else
    if (arrUser[i].password = pwd) then
    begin
        writeln('Selamat datang ', arrUser[i].nama, '.');
        arrUser[i].Status := true;
    end else
    begin
        writeln('Password salah! Silakan coba lagi.');
    end;
end;
end.