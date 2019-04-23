///////////////////////////////////////////////////////////////////
//                            uAnggota                           //
///////////////////////////////////////////////////////////////////
//  Unit yang menangani hal-hal yang berhubungan dengan anggota  //
///////////////////////////////////////////////////////////////////
unit uAnggota;

interface
	uses uFileLoader, uDate, parsertuanyon;

	procedure CariAnggota(var arrUser : UArr);
	{Mencari anggota dengan username tertentu dan mencetak datanya ke layar}
	{I.S. : arrUser sudah berisi, username didapat dari input}
	{F.S. : Data user tercetak ke layar, jika username tidak ditemukan akan
			dicetak pesan kesalahan}

	function leftrotate(x : Cardinal ; c : Cardinal) : Cardinal;
	//Fungsi untuk menghasilkan suatu nilai dari hasil shl atau shr 2 nilai

	function hashpw(password : string) : string;
	//Fungsi untuk menjalankan hash pada password
	{Sumber Ide : https://en.wikipedia.org/wiki/MD5#Algorithm
				  https://tr.opensuse.org/MD5
				  https://rosettacode.org/wiki/MD5/Implementation
				  https://stackoverflow.com/questions/27360260/md5-in-delphi-pascal-freepascal-for-short-strings}

	procedure log_in(var arrUser: UArr; var UserIn : User);
	//Procedure untuk melakukan login

	procedure regis(var arrUser: UArr);
	//procedure untuk menerima input user baru. Procedure akan meminta user untuk memasukkan nama, alamat, username, dan password.

	procedure PrintUser (var arrUser : UArr);
	{Menulis elemen-elemen dari arrUser ke layar dengan format sesuai data user}
	{I.S. : arrUser sudah berisi data dari file user dan/atau modifikasi di main program}
	{F.S. :	arrUser tercetak ke layar sesuai format data user}

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

//======================================

function leftrotate(x, c: Cardinal): Cardinal;
    begin
        leftrotate := (x shl c) or (x shr (32-c));
    end;

//======================================

function hashpw(password: string): string;
    //Kamus Lokal
    const 
    s: array[0..63] of Cardinal = (
        7, 12, 17, 22,  7, 12, 17, 22,  7, 12, 17, 22,  7, 12, 17, 22,
        5,  9, 14, 20,  5,  9, 14, 20,  5,  9, 14, 20,  5,  9, 14, 20,
        4, 11, 16, 23,  4, 11, 16, 23,  4, 11, 16, 23,  4, 11, 16, 23,
        6, 10, 15, 21,  6, 10, 15, 21,  6, 10, 15, 21,  6, 10, 15, 21 );

    K: array[0..63] of Cardinal = (
        $d76aa478, $e8c7b756, $242070db, $c1bdceee,
        $f57c0faf, $4787c62a, $a8304613, $fd469501,
        $698098d8, $8b44f7af, $ffff5bb1, $895cd7be,
        $6b901122, $fd987193, $a679438e, $49b40821,
        $f61e2562, $c040b340, $265e5a51, $e9b6c7aa,
        $d62f105d, $02441453, $d8a1e681, $e7d3fbc8,
        $21e1cde6, $c33707d6, $f4d50d87, $455a14ed,
        $a9e3e905, $fcefa3f8, $676f02d9, $8d2a4c8a,
        $fffa3942, $8771f681, $6d9d6122, $fde5380c,
        $a4beea44, $4bdecfa9, $f6bb4b60, $bebfbc70,
        $289b7ec6, $eaa127fa, $d4ef3085, $04881d05,
        $d9d4d039, $e6db99e5, $1fa27cf8, $c4ac5665,
        $f4292244, $432aff97, $ab9423a7, $fc93a039,
        $655b59c3, $8f0ccc92, $ffeff47d, $85845dd1,
        $6fa87e4f, $fe2ce6e0, $a3014314, $4e0811a1,
        $f7537e82, $bd3af235, $2ad7d2bb, $eb86d391 );

    var a0, b0, c0, d0, a,b,c,d, f, g, dTemp: Cardinal;
    Len: Integer;
    Arrpw : array[0..63] of Char;
    M: array[0..15] of Cardinal absolute Arrpw; //memecah Arrpw menjadi 16 potongan kata 32-bit
    i: Integer;
    
    //Algorithm
    begin
        //set variable initiator
        a0 := $67452301;
        b0 := $efcdab89;
        c0 := $98badcfe;
        d0 := $10325476;

        //mendapatkan panjang password
        Len := Length(password);

        //masukkan string password ke dalam array msg
        FillChar(Arrpw, 64, 0);

        for i:=1 to Len do Arrpw[i-1] := password[i];

            //tambahkan 1 bit ke Arrpw
            Arrpw[Len] := chr(128);

            //tambahkan panjang string password ke msg
            Arrpw[63-7] := chr(8*Len);

            //variable initiator diset menjadi acuan awal perhitungan
            A := a0;
            B := b0;
            C := c0;
            D := d0;

        //Main loop:
        for i := 0 to 63 do begin
        //dalam setiap character password dibuat suatu fungsi yang mengakses array K, M, dan s
        //tujuannya untuk membuat tiap character pada password akan membuat perubahan pada variable initiator
        //dibuat 4 fungsi berbeda sehingga proses hashing dapat lebih rumit
            if (i>=0) and (i<=15) then begin
                F := (B and C) or ((not B) and D);
                g := i;
            end
            else if (i>=16) and (i<=31) then begin
                F := (D and B) or ((not D) and C);
                g := (5*i + 1) mod 16;
            end
            else if (i>=32) and (i<=47) then begin
                F := B xor C xor D;
                g := (3*i + 5) mod 16;
            end
            else if (i>=48) and (i<=63) then begin
                F := C xor (B or (not D));
                g := (7*i) mod 16;
            end;

            dTemp := D;
            D := C;
            C := B;
            B := B + leftrotate((A + F + K[i] + M[g]), s[i]);
            A := dTemp;
        end;

        //hasil modifikasi variable
        a0 := a0 + A;
        b0 := b0 + B;
        c0 := c0 + C;
        d0 := d0 + D;
        
        //hex password    
        hashpw := ( IntToHex(a0,8) + IntToHex(b0,8) + IntToHex(c0,8)  +IntToHex(d0,8) );
    end;

//======================================

procedure regis(var arrUser: UArr);
    //Kamus lokal
    var
        nm,almt,usnm,pwd : string;

    begin
        //prosedur input masukan
        write('masukkan nama pengunjung: ');
        readln(nm);
        write('masukkan alamat pengunjung: ');
        readln(almt);
        write('masukkan username pengunjung: ');
        readln(usnm);
        write('masukkan password pengunjung: ');
        readln(pwd);
        
        //Password hasil hash adalah gabungan string username dan password yang dimasukkan dalam fungsi hash
        pwd := usnm + pwd;
        pwd := hashpw(pwd);
        
        //simpen ke array
        arrUser[lenUser+1].nama := nm;
        arrUser[lenUser+1].alamat := almt;
        arrUser[lenUser+1].username := usnm;
        arrUser[lenUser+1].password := pwd;
        arrUser[lenUser+1].Role := 'Pengunjung';
        lenUser := lenUser + 1;

        //msg telah berhasil regis
        writeln('Pengunjung ', nm, ' berhasil terdaftar sebagai user');
    end;

//=====================================

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
            
            //Password hasil hash adalah gabungan string username dan password yang dimasukkan dalam fungsi hash
            pwd := usnm + pwd;
            pwd := hashpw(pwd);
            
            //cek username ada / ga
            i := 1;
            found := false;
            repeat
                if (arrUser[i].username = usnm) then
                begin
                    found := true;
                end else
                begin
                    i := i+1;
                end;
            until (found) or (i > lenUser);
            if not found then
            begin
                writeln('Usename/Password salah! Silakan coba lagi.');
            end
            //kalo username ditemukan, cek password
            else
                //jika password cocok, data user yang aktif disimpan dalam UserIn, kemuadian kirim msg
                //writeln(pwd);
                //writeln(arrUser[i].password);
                if (arrUser[i].password = pwd) then
                begin
                    UserIn := arrUser[i];
                    writeln('Selamat datang ', arrUser[i].nama, '.');
                    UserIn.Status := true;
                    login := true;
                end else
        
                //jika password salah, kirim msg.
                begin
                    writeln('Username/Password salah! Silakan coba lagi.');
                end;
            end;
    end;

    procedure PrintUser (var arrUser : UArr);
	{Menulis elemen-elemen dari arrUser ke layar dengan format sesuai data user}
	{I.S. : arrUser sudah berisi data dari file user dan/atau modifikasi di main program}
	{F.S. :	arrUser tercetak ke layar sesuai format data user}
	{' | ' digunakan untuk pemisah antar kolom}
	var
		k : integer;
	begin
		writeln(lenUser);
		for k := 1 to (lenUser) do
		begin
			write(k);
			write(' | ');
			write(arrUser[k].Nama);
			write(' | ');
			write(arrUser[k].Alamat);
			write(' | ');
			write(arrUser[k].Username);
			write(' | ');
			write(arrUser[k].Password);
			write(' | ');
			write(arrUser[k].Role);
			writeln();
		end;
	end;
end.