unit btn.lib.types.str.TStrings_u;

interface

uses System.Classes;

procedure SLRemoveCommentsSingleLine(pSL:TStrings);
procedure SLRemoveCommentsMultiLine(pSL:TStrings);
procedure SLManterEntre(pSL:TStrings; pStrIni, pStrFin: string);
procedure SLRemoveVazias(pSL:TStrings);
procedure SLUpperCase(pSL:TStrings);

implementation

uses System.SysUtils, btn.lib.types.strings;

procedure SLRemoveCommentsSingleLine(pSL:TStrings);
var
  iLin: Integer;
  iPos: Integer;
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

procedure SLRemoveCommentsMultiLine(pSL:TStrings);
var
  i: Integer;
  s: string;
  inComment: Boolean;
begin
  inComment := False; // flag para indicar se estamos dentro de um comentário
  for i := 0 to pSL.Count - 1 do
  begin
    s := pSL[i]; // obter a linha atual
    if inComment then // se estamos dentro de um comentário
    begin
      if Pos('*/', s) > 0 then // procurar pelo fim do comentário
      begin
        s := Copy(s, Pos('*/', s) + 2, Length(s)); // remover tudo até o fim do comentário
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
        inComment := True; // atualizar a flag
        if Pos('*/', s) > 0 then // procurar pelo fim do comentário na mesma linha
        begin
          s := Copy(s, 1, Pos('/*', s) - 1) + ' ' + Copy(s, Pos('*/', s) + 2, Length(s)); // remover o comentário da linha
          inComment := False; // atualizar a flag novamente
        end
        else // se não há fim do comentário na mesma linha
        begin
          s := Copy(s, 1, Pos('/*', s) - 1); // remover tudo a partir do início do comentário
        end;
      end;
    end;
    pSL[i] := s; // atualizar a linha no TStringList
  end;
end;

procedure SLManterEntre(pSL:TStrings; pStrIni, pStrFin: string);
var
  i, j: Integer;
  flag: Boolean;
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
      flag := True; // ativa o flag
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

procedure SLRemoveVazias(pSL:TStrings);
var
  I: Integer;
  S: string;
begin
  I := 0;
  while I < pSL.Count do
  begin
    S := StrSemEspacoDuplo(pSL[I]);
    if S = '' then
      pSL.Delete(I)
    else
    begin
      pSL[I] := S;
      inc(I);
    end;
  end;
end;

procedure SLUpperCase(pSL:TStrings);
var
  I: Integer;
begin
  for I := 0 to pSL.Count - 1 do
  begin
    pSL[I] := UpperCase(pSL[I]);
  end;
end;

end.
