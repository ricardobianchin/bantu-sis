unit sta.exec.testes.crypt_u;

interface

procedure TestarCript;

implementation

uses sis.types.strings.crypt, dialogs;
//procedure Encriptar(pStr: string; out pEncriptado: string);
//procedure Desencriptar(pEncriptado: string; out pStr: string);

procedure TestarCript;
var
  str, encriptado: string;
begin
  str := 'J';
  Encriptar(str, encriptado);

  Desencriptar(encriptado, str);
  //Sho wMe ssage(s);

  str := 'JOAO';
  Encriptar(str, encriptado);

  Desencriptar(encriptado, str);
  //Sho wMe ssage(s);


  str := 'JOAO DA SILVA';
  Encriptar(str, encriptado);

  Desencriptar(encriptado, str);
  //Sho wMe ssage(s);


end;

end.
