unit Sis.Types.Codigos.Utils;

interface

function CNPJValido(pCNPJ: string; AceitaNulo: boolean = true): boolean;
function CPFValido(pCPF: string): boolean;
function CPFComMasc(S: string): string;
function CEPComMasc(S: string): string;
function NomeCod(S: string): string;
function CNPJComMasc(S: string): string;
function CodComMasc(S: string): string;
function FoneComMasc(S: string): string;
function BarCodValido(pCod: string): boolean;

function EAN8Valido(pCod: string): boolean;
function EAN8Dig(pCod: string): char;

function EAN13Valido(pCod: string): boolean;
function EAN13Dig(pCod: string): char;

function EAN14Valido(pCod: string): boolean;
function EAN14Dig(pCod: string): char;

function UPCAValido(pCod: string): boolean;

function IdToEan13(pId: integer): string;

implementation

uses System.SysUtils, System.Classes, System.StrUtils, VCL.Dialogs,
  Sis.Types.strings_u, Sis.Types.TStrings_u;

function SoDig(pStr: string): string;
begin
  Result := StrToOnlyDigit(pStr);
end;

function FoneComMasc(S:string):string;
begin
  s:=trim(s);
  if Length(s)<5 then
  begin
    result:=s;
    exit;
  end;

  if s[1]='0' then
  begin
    result:=
      LeftStr(s,4)
      +'-'
      +RightStr(s,length(s)-4)
      ;
  end
  else
  begin
    result:=
      LeftStr(s,length(s)-4)
      +'-'
      +RightStr(s,4)
      ;
  end;
end;

function CPFComMasc(S:string):string;
begin
  s:=trim(s);
  if Length(s)<>11 then
    result:=s
  else
    result:=s[1]+s[2]+s[3]+'.'+s[4]+s[5]
      +s[6]+'.'+s[7]+s[8]+s[9]+'-'+s[10]+s[11];
end;

function CodComMasc(S:string):string;
var
  l:integer;
begin
  s:=trim(s);
  l:=Length(s);
  case l of
    11:result:=CPFComMasc(s);
    14:Result:=CNPJComMasc(s);
    else
      result:=s;
  end;
end;

  function CEPComMasc(S:string):string;
  begin
    s:=trim(s);
    if Length(s)<8 then
      result:=s
    else
      result:=
        s[1]+s[2]+s[3]+s[4]+s[5]+'-'
        +s[6]+s[7]+s[8]
  end;

  function CNPJComMasc(S:string):string;
  begin
    s:=trim(s);
    if length(s)<14 then
      result:=s
    else
      result:=
        s[1]+s[2]+'.'
        +s[3]+s[4]+s[5]+'.'
        +s[6]+s[7]+s[8]+'/'
        +s[9]+s[10]+s[11]+s[12]+'-'
        +s[13]+s[14];
  end;



function NomeCod(S:string):string;
var
  l:integer;
begin
  s:=trim(s);
  l:=Length(s);
  case l of
    11:result:='CPF';
    14:Result:='CNPJ';
    else
      result:='CODIGO';
  end;
end;



function CNPJValido(pCNPJ:string; AceitaNulo:boolean=true):boolean;
var
  soma,ind,i,resto,dv:integer;
begin
  result:=false;
  pCNPJ:=SoDig(pCNPJ);
  if (not AceitaNulo) and (pCNPJ='') then
    exit
  else if Length(pCNPJ)<14 then
    exit;

  soma:=0;
  ind:=5;
  for i := 1 to 12 do
  begin
    inc(soma, strtoint(pCNPJ[i])*ind);
    dec(ind);
    if ind=1 then
      ind:=9;
  end;
  resto := soma mod 11;
  if (resto=0) or (resto=1) then
    dv:=0
  else
    dv:=11-resto;
  if strtoint(pCNPJ[13])<>dv then
  begin
    result:=false;
    exit;
  end;
  soma := 0;
  ind:=6;

  for i := 1 to 13 do
  begin
    inc(soma, strtoint(pCNPJ[i])*ind);
    dec(ind);
    if ind=1 then
      ind:=9;
  end;
  resto := soma mod 11;
  if (resto=0) or (resto=1) then
    dv:=0
  else
    dv:=11-resto;
  if strtoint(pCNPJ[14])<>dv then
  begin
    result:=false;
    exit;
  end;

  result:=true;
end;

function CPFValido(pCPF:string):boolean;
var
  soma,p,resto, dv:integer;
begin
  result:=false;

  pCPF:=sodig(pCPF);

  if pCPF='' then
    exit;

  if StrToInt64(pCPF)=0 then
    Exit;

  if Length(pCPF)<11 then
    Exit;

  soma:=0;
  for p := 1 to 9 do
    inc(soma,strtoint(pCPF[p])*(11-p));

  resto:= soma mod 11;

  if (resto=0) or (resto=1) then
    dv:=0
  else
    dv:=11-resto;

  if StrToInt(pCPF[10])<>dv then
    exit;

  soma:=0;
  for p := 1 to 10 do
    inc(soma,strtoint(pCPF[p])*(12-p));

  resto:= soma mod 11;

  if (resto=0) or (resto=1) then
    dv:=0
  else
    dv:=11-resto;

  if StrToInt(pCPF[11])<>dv then
    exit;
  result:=true;

end;

function BarCodValido(pCod:string):boolean;
var
  l :integer;
begin
  pcod:=trim(sodig(pcod));
  l:=Length(pCod);
  case l of
    12:result:=UPCAValido(pCod);
    13:result:=EAN13Valido(pCod);
    14:result:=EAN14Valido(pCod);
    8:result:=EAN8Valido(pCod);
    else
      result:=false;
  end;
end;

function EAN13Dig(pCod:string):char;
var
  dv, soma:integer;
//  c:char;
begin
//  result:=false;
  soma:=
    StrToInt(pCod[2])
    +StrToInt(pCod[4])
    +StrToInt(pCod[6])
    +StrToInt(pCod[8])
    +StrToInt(pCod[10])
    +StrToInt(pCod[12])
    ;
  soma:=soma*3;

  soma:=soma
    +StrToInt(pCod[1])
    +StrToInt(pCod[3])
    +StrToInt(pCod[5])
    +StrToInt(pCod[7])
    +StrToInt(pCod[9])
    +StrToInt(pCod[11])
    ;

  if (soma mod 10)=0 then
    dv:=0
  else
    dv:=10-(soma mod 10);

  result:=inttostr(dv)[1];
end;

function EAN13Valido(pCod:string):boolean;
const
  LEN_DESEJADO = 13;
var
  dv, soma:integer;
//  c:char;
  iLen: integer;
begin
  iLen := Length(pCod);
  Result := iLen = LEN_DESEJADO;
  if not Result then
    exit;

//  result:=false;
  soma:=
    StrToInt(pCod[2])
    +StrToInt(pCod[4])
    +StrToInt(pCod[6])
    +StrToInt(pCod[8])
    +StrToInt(pCod[10])
    +StrToInt(pCod[12])
    ;
  soma:=soma*3;

  soma:=soma
    +StrToInt(pCod[1])
    +StrToInt(pCod[3])
    +StrToInt(pCod[5])
    +StrToInt(pCod[7])
    +StrToInt(pCod[9])
    +StrToInt(pCod[11])
    ;

  if (soma mod 10)=0 then
    dv:=0
  else
    dv:=10-(soma mod 10);

  result:=pCod[length(pcod)]=inttostr(dv);

{  pcod:=trim(pcod);
  l:=Length(pCod);
  if l<5 then
    exit;
  t:=Length(pCod)-1;
  SOMA := 0;
  repeat
    c:=pCod[t];
    inc(soma,StrToInt(c)*3);
    dec(t,2);
  until t<2;

  t:=Length(pCod)-2;
  repeat
    c:=pCod[t];
    inc(soma,StrToInt(c));
    dec(t,2);
  until t<1;

  if (soma mod 10)=0 then
    dv:=0
  else
    dv:=(((soma div 10)+1)*10)-soma;

  result:= pCod[length(pcod)]=inttostr(dv);}
end;

function UPCAValido(pCod:string):boolean;
const
  LEN_DESEJADO = 12;
var
  dv, soma:integer;
//  c:char;
  iLen: integer;
begin
  iLen := Length(pCod);
  Result := iLen = LEN_DESEJADO;
  if not Result then
    exit;


//  result:=false;
  soma:=
    +StrToInt(pCod[1])
    +StrToInt(pCod[3])
    +StrToInt(pCod[5])
    +StrToInt(pCod[7])
    +StrToInt(pCod[9])
    +StrToInt(pCod[11])
    ;
  soma:=soma*3;

  soma:=soma
    +StrToInt(pCod[2])
    +StrToInt(pCod[4])
    +StrToInt(pCod[6])
    +StrToInt(pCod[8])
    +StrToInt(pCod[10])
    ;

  if (soma mod 10)=0 then
    dv:=0
  else
    dv:=10-(soma mod 10);

  result:=pCod[length(pcod)]=inttostr(dv);

end;

function EAN8Dig(pCod:string):char;
var
  dv, soma:integer;
//  c:char;
begin
//  result:=false;
  soma:=
    StrToInt(pCod[1])
    +StrToInt(pCod[3])
    +StrToInt(pCod[5])
    +StrToInt(pCod[7])
    ;
  soma:=soma*3;

  soma:=soma
    +StrToInt(pCod[2])
    +StrToInt(pCod[4])
    +StrToInt(pCod[6])
    ;

  if (soma mod 10)=0 then
    dv:=0
  else
    dv:=10-(soma mod 10);

  result:=inttostr(dv)[1];
end;


function EAN8Valido(pCod:string):boolean;
const
  LEN_DESEJADO = 13;
var
  dv, soma:integer;
//  c:char;
  iLen: integer;
begin
  iLen := Length(pCod);
  Result := iLen = LEN_DESEJADO;
  if not Result then
    exit;

//  result:=false;
  soma:=
    StrToInt(pCod[1])
    +StrToInt(pCod[3])
    +StrToInt(pCod[5])
    +StrToInt(pCod[7])
    ;
  soma:=soma*3;

  soma:=soma
    +StrToInt(pCod[2])
    +StrToInt(pCod[4])
    +StrToInt(pCod[6])
    ;

  if (soma mod 10)=0 then
    dv:=0
  else
    dv:=10-(soma mod 10);

  result:=pCod[length(pcod)]=inttostr(dv);
end;


///////////////

function EAN14Dig(pCod:string):char;
var
  dv, soma:integer;
//  c:char;
begin
//  result:=false;
  soma:=
    StrToInt(pCod[1])
    +StrToInt(pCod[3])
    +StrToInt(pCod[5])
    +StrToInt(pCod[7])
    +StrToInt(pCod[9])
    +StrToInt(pCod[11])
    +StrToInt(pCod[13])
    ;
  soma:=soma*3;

  soma:=soma
    +StrToInt(pCod[2])
    +StrToInt(pCod[4])
    +StrToInt(pCod[6])
    +StrToInt(pCod[8])
    +StrToInt(pCod[10])
    +StrToInt(pCod[12])
    ;

  if (soma mod 10)=0 then
    dv:=0
  else
    dv:=10-(soma mod 10);

  result:=inttostr(dv)[1];

end;


{

  789 633 600 591 7
17896336005914

  789 633 600 591 7
1 789 633 600 591 4

  789 633 600 591 7
1 7 8 9 6 3 3 6 0 0 5 9 1 4
1   8   6   3   0   5   1
  7   9   3   6   0   9

1+8+6+3+0+5+1=24 24*3=72
7+9+3+6+0+9=34
72+34=106

/*
Função		U_EAN14()
Descrição	Calcula Digito verificador para EAN14
Parâmetro	String com 13 digitos
Retorno		String contendo dígito verificador
*/

User function EAN14(cCod13)
Local nOdd := 0
Local nEven := 0
Local nI
Local nDig
Local nMul := 10
For nI := 1 to 13
	If (nI%2) == 0
		nEven += val(substr(cCod13,nI,1))
	Else
		nOdd += val(substr(cCod13,nI,1))
	Endif
Next
nDig := nEven + (nOdd*3)
While nMul<nDig
	nMul += 10
Enddo
Return strzero(nMul-nDig,1)

}


function EAN14Valido(pCod:string):boolean;
const
  LEN_DESEJADO = 14;
var
  udc:char;
  dv, soma, somapar, udi:integer;
//  c:char;
  iLen: integer;
begin
  iLen := Length(pCod);
  Result := iLen = LEN_DESEJADO;
  if not Result then
    exit;

//  result:=false;
{

5 passos para o cálculo algoritmo do dígito verificador:

Vamos supor que estamos usando o código fictício de: 05432122345.
Adicione todos os dígitos das posições ímpares (dígitos na posição 1, 3, 5, 7, 9 e 11)
0 + 4 + 2 + 2 + 3 + 5 = 16
Multiplique por 3.
16 * 3 = 48
Adicione todos os dígitos das posições pares (dígitos na posição 2, 4, 6, 8 e 10).
5 + 3 + 1 + 2 + 4 = 15
Some os resultados das etapas 3 e 2.
48 + 15 = 63
Determine o número que deve ser adicionado ao resultado do passo 4
para criar um múltiplo de 10.
63 + 7 = 70
Portanto, o dígito verificador é 7.
}
//17896336005914
//showmessage(pcod);
  soma:=
    StrToInt(pCod[1])
    +StrToInt(pCod[3])
    +StrToInt(pCod[5])
    +StrToInt(pCod[7])
    +StrToInt(pCod[9])
    +StrToInt(pCod[11])
    +StrToInt(pCod[13])
    ;
//showmessage('soma '+inttostr(soma));
  soma:=soma*3;
//showmessage('soma *3 '+inttostr(soma));

somapar:=
    +StrToInt(pCod[2])
    +StrToInt(pCod[4])
    +StrToInt(pCod[6])
    +StrToInt(pCod[8])
    +StrToInt(pCod[10])
    +StrToInt(pCod[12])
    ;
//showmessage('somapar '+inttostr(somapar));
  soma:=soma+somapar;

//showmessage('soma '+inttostr(soma));
  if (soma mod 10)=0 then
    dv:=0
  else
    dv:=10-(soma mod 10);
//showmessage('dv'+inttostr(dv));
udc:=pcod[14];
udi:=strtoint(udc);
//showmessage(inttostr(udi)+'='+inttostr(dv));
udi:=udi-dv;
  result:=udi=0;
  if not result then
    //showmessage(inttostr(udi))
  else
    //showmessage('ok');
end;

function IdToEan13(pId: integer): string;
const
  LEN_CODIGO = 13;
  LEN_DESEJADO = LEN_CODIGO - 1;
var
  sId: string;
  iFalta: integer;
  iLen: integer;
  sZeros: string;
  cDigVer: char;
begin
  sId := pId.ToString;

  iLen := Length(sId);
  iFalta := LEN_DESEJADO - iLen;

  sZeros := StringOfChar('0', iFalta);

  Result := sId + sZeros;
  cDigVer := EAN13Dig(Result);

  Result := Result + cDigVer;
end;

end.
