unit login;

interface
uses
    uFileLoader;

procedure log_in(var arrUser: UArr; var UserIn : User);
//Procedure untuk melakukan login

implementation
procedure log_in(var arrUser: UArr; var UserIn : User);
//Kamus Lokal
var
    i : integer;
    found, login : boolean;
    usnm,pwd : string;

begin
    //sebelum login, dibuat suatu variable 'login' yang bernilai boolean. Selama user tidak login, boolean akan bernilai false
    login := false;
    
    //selama user belum login, procedure input akan selalu dicek
    while not login do
        begin
        //input username and password
        write('Masukkan username: ');
        readln(usnm);
        write('Masukkan password: ');
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
            writeln('Usename/Password salah! Silakan coba lagi.')
        
        //kalo username ditemukan, cek password
        else
            //jika password cocok, data user yang aktif disimpan dalam UserIn, kemuadian kirim msg
            if (arrUser[i].password = pwd) then
            begin
                writeln('Selamat datang ', arrUser[i].nama, '.');
                login := true;
                arrUser[i].Status := true;
                UserIn := arrUser[i];
                writeln(UserIn.Status);
            end else
    
            //jika password salah, kirim msg.
            begin
                writeln('Username/Password salah! Silakan coba lagi.');
            end;
        end;
    end;
end.