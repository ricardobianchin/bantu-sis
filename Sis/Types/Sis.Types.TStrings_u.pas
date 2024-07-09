unit Sis.Types.TStrings_u;

interface

uses System.Classes;

procedure SLRemoveCommentsSingleLine(pSL: TStrings);
procedure SLRemoveCommentsMultiLine(pSL: TStrings);
procedure SLManterEntre(pSL: TStrings; pStrIni, pStrFin: string);
procedure SLRemoveVazias(pSL: TStrings);
procedure SLUpperCase(pSL: TStrings);
function SLGetAsString(pSL: TStrings; pSeparador: string): string;

// o uso de tstrings.duplicate so funciona se sort=true
// quando nao posso alterar a ordem dos itens, uso esta funcion
procedure SLAddUnique(pSL: TStrings; pStr: string);

function SLNLinhaQTem(pSL: TStrings; pS: string; pNLinhaInic: integer = 0;
  IgnoraCase: boolean = true): integer;

implementation

uses System.SysUtils, Sis.Types.strings_u;

procedure SLRemoveCommentsSingleLine(pSL: TStrings);
var
  iLin: integer;
  iPos: integer;
  sLinha: string;
begin
  for iLin := 0 to pSL.Count - 1 do
  begin
    sLinha := pSL[iLin];

    iPos := Pos('//', sLinha);

    if iPos > 0 then
    begin
      sLinha := Copy(sLinha, 1, iPos - 1);
      pSL[iLin] := sLinha;
    end;
  end;
end;

procedure SLRemoveCommentsMultiLine(pSL: TStrings);
var
  i: integer;
  s: string;
  inComment: boolean;
begin
  inComment := False; // flag para indicar se estamos dentro de um comentário
  for i := 0 to pSL.Count - 1 do
  begin
    s := pSL[i]; // obter a linha atual
    if inComment then // se estamos dentro de um comentário
    begin
      if Pos('*/', s) > 0 then // procurar pelo fim do comentário
      begin
        s := Copy(s, Pos('*/', s) + 2, Length(s));
        // remover tudo até o fim do comentário
        inComment := False; // atualizar a flag
      end
      else // se não há fim do comentário na linha atual
      begin
        s := ''; // remover toda a linha
      end;
    end;
    if not inComment then // se não estamos dentro de um comentário
    begin
      if Pos('/*', s) > 0 then // procurar pelo início do comentário
      begin
        inComment := true; // atualizar a flag
        if Pos('*/', s) > 0 then
        // procurar pelo fim do comentário na mesma linha
        begin
          s := Copy(s, 1, Pos('/*', s) - 1) + ' ' + Copy(s, Pos('*/', s) + 2,
            Length(s)); // remover o comentário da linha
          inComment := False; // atualizar a flag novamente
        end
        else // se não há fim do comentário na mesma linha
        begin
          s := Copy(s, 1, Pos('/*', s) - 1);
          // remover tudo a partir do início do comentário
        end;
      end;
    end;
    pSL[i] := s; // atualizar a linha no TStringList
  end;
end;

procedure SLManterEntre(pSL: TStrings; pStrIni, pStrFin: string);
var
  i, j: integer;
  flag: boolean;
  sLinha: string;
begin
  pStrIni := UpperCase(pStrIni);
  pStrFin := UpperCase(pStrFin);

  flag := False; // indica se encontrou a linha inicial
  i := 0; // índice da linha atual
  while i < pSL.Count do
  begin
    sLinha := UpperCase(pSL[i]);
    if sLinha = pStrIni then // se encontrou a linha inicial
    begin
      flag := true; // ativa o flag
      for j := 0 to i do // apaga as linhas anteriores e a atual
        pSL.Delete(0);
      i := 0; // reinicia o índice
    end
    else if sLinha = pStrFin then // se encontrou a linha final
    begin
      if flag then // se já tinha encontrado a linha inicial
      begin
        for j := i to pSL.Count - 1 do // apaga a linha atual e as posteriores
          pSL.Delete(i);
        Break; // sai do loop
      end;
    end;
    Inc(i); // incrementa o índice
  end;
end;

procedure SLRemoveVazias(pSL: TStrings);
var
  i: integer;
  s: string;
begin
  i := 0;
  while i < pSL.Count do
  begin
    s := StrSemCharRepetido(pSL[i]);
    if s = '' then
      pSL.Delete(i)
    else
    begin
      pSL[i] := s;
      Inc(i);
    end;
  end;
end;

procedure SLUpperCase(pSL: TStrings);
var
  i: integer;
begin
  for i := 0 to pSL.Count - 1 do
  begin
    pSL[i] := UpperCase(pSL[i]);
  end;
end;

procedure SLAddUnique(pSL: TStrings; pStr: string);
var
  i: integer;
begin
  i := pSL.IndexOf(pStr);
  if i > -1 then
    exit;
  pSL.Add(pStr);
end;

function SLGetAsString(pSL: TStrings; pSeparador: string): string;
var
  i: integer;
begin
  Result := '';

  for i := 0 to pSL.Count - 1 do
  begin
    if Result <> '' then
      Result := Result + ', ';
    Result := Result + pSL[i];
  end;
end;

function SLNLinhaQTem(pSL: TStrings; pS: string; pNLinhaInic: integer = 0;
  IgnoraCase: boolean = true): integer;
var
  t: integer;
begin
  Result := -1;
  if IgnoraCase then
  begin
    for t := pNLinhaInic to pSL.Count - 1 do
      if Pos(ansiuppercase(pS), ansiuppercase(pSL[t])) <> 0 then
      begin
        Result := t;
        Break;
      end
  end
  else
  begin
    for t := pNLinhaInic to pSL.Count - 1 do
      if Pos(pS, pSL[t]) <> 0 then
      begin
        Result := t;
        Break;
      end;
  end;
end;

end.
