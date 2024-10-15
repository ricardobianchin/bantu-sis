unit Sis.DB.Updater.Diretivas_u;

interface

uses System.Classes, System.Generics.Collections;

procedure ProcessarDiretivas(pLinhasSL: TStrings;
  pVariaveis, pDiretivaAbre, pDiretivaFecha: string);

implementation

uses System.SysUtils, System.StrUtils, Sis.Win.Utils_u;

var
  sDiretivaAbre: string;
  sDiretivaFecha: string;

  sAbreSE: string;
  sSENAO: string;
  sFIMSE: string;

  iLenABRESE: integer;
  iLenSENAO: integer;
  iLenFIMSE: integer;

  oVariaveisSL: TStringList;

procedure ProcessarValor(pLinhasSL: TStrings; pVar, pValor: string);
//semelhante do #define do C
//por exemplo {ALVO} substitui por SERVIDOR
var
  sBusca: string;
  sOrigem: string;
  sDestino: string;
  bEncontrouVar: boolean;
begin
  sOrigem := pLinhasSL.Text;
  sBusca := sDiretivaAbre + pVar + sDiretivaFecha;
  bEncontrouVar := Pos(sBusca, sOrigem) > 0;
  if not bEncontrouVar then
    exit;

  sDestino := ReplaceStr(sOrigem, sBusca, pValor);
  pLinhasSL.Text := sDestino;
end;

procedure ProcessarSE(pLinhasSL: TStrings; pVar, pValor: string);
var
  sBuscaSE: string;
  iPosSE, iPosFechaSE, iPosSENAO, iPosFIMSE, iPosIgual: Integer;
  bTemSenao, bExpressaoVerdadeira: Boolean;
  sOrigem, sDestino, sValorArquivo, sTextoVai: string;
  i, c: Integer;
  Pilha: TStack<Integer>;
begin
  sBuscaSE := '{SE ' + pVar + '=';
  sOrigem := pLinhasSL.Text;
  sDestino := '';
  Pilha := TStack<Integer>.Create;
  try
    repeat
      iPosSE := Pos(sBuscaSE, sOrigem);
      if iPosSE < 1 then
        Break;

      if iPosSE > 1 then
      begin
        sDestino := sDestino + Copy(sOrigem, 1, iPosSE - 1);
        Delete(sOrigem, 1, iPosSE - 1);
      end;

      iPosIgual := Pos('=', sOrigem);
      iPosFechaSE := Pos('}', sOrigem);
      i := iPosIgual + 1;
      c := iPosFechaSE - (iPosIgual + 1);
      sValorArquivo := Trim(Copy(sOrigem, i, c));
      bExpressaoVerdadeira := sValorArquivo = pValor;

      Pilha.Push(iPosSE);
      iPosFIMSE := 0;
      repeat
        iPosSE := PosEx('{SE ', sOrigem, iPosFechaSE + 1);
        iPosFIMSE := PosEx('{FIMSE}', sOrigem, iPosFechaSE + 1);
        if (iPosSE > 0) and (iPosSE < iPosFIMSE) then
        begin
          Pilha.Push(iPosSE);
          iPosFechaSE := PosEx('}', sOrigem, iPosSE + 1);
        end
        else
        begin
          Pilha.Pop;
          if Pilha.Count > 0 then
            iPosFechaSE := PosEx('}', sOrigem, iPosFIMSE + 1);
        end;
      until Pilha.Count = 0;

      iPosSENAO := PosEx('{SENAO}', sOrigem, iPosFechaSE + 1);
      bTemSenao := (iPosSENAO > 0) and (iPosSENAO < iPosFIMSE);

      if bTemSenao then
      begin
        if bExpressaoVerdadeira then
        begin
          i := iPosFechaSE + 1;
          c := iPosSENAO - (iPosFechaSE + 1);
          sTextoVai := Copy(sOrigem, i, c);
        end
        else
        begin
          i := iPosSENAO + 8;
          c := iPosFIMSE - (iPosSENAO + 8);
          sTextoVai := Copy(sOrigem, i, c);
        end;
      end
      else
      begin
        if bExpressaoVerdadeira then
        begin
          i := iPosFechaSE + 1;
          c := iPosFIMSE - (iPosFechaSE + 1);
          sTextoVai := Copy(sOrigem, i, c);
        end
        else
          sTextoVai := '';
      end;

      sDestino := sDestino + sTextoVai;
      Delete(sOrigem, 1, iPosFIMSE + 6);
    until False;

    sDestino := sDestino + sOrigem;
    pLinhasSL.Text := sDestino;
  finally
    Pilha.Free;
  end;
end;

procedure ProcessarDiretivas(pLinhasSL: TStrings;
  pVariaveis, pDiretivaAbre, pDiretivaFecha: string);
var
  iVar: integer;
  sVar: string;
  sValor: string;
begin
  sDiretivaAbre := pDiretivaAbre;
  sDiretivaFecha := pDiretivaFecha;

  sAbreSE := sDiretivaAbre + 'SE ';
  sSENAO := sDiretivaAbre + 'SENAO' + sDiretivaFecha;
  sFIMSE := sDiretivaAbre + 'FIMSE' + sDiretivaFecha;

  iLenABRESE := Length(sAbreSE);
  iLenSENAO := Length(sSENAO);
  iLenFIMSE := Length(sFIMSE);

  oVariaveisSL := TStringList.Create;
  try
    oVariaveisSL.Text := pVariaveis;

    for iVar := 0 to oVariaveisSL.Count - 1 do
    begin
      sVar := oVariaveisSL.KeyNames[iVar];
      sValor := oVariaveisSL.Values[sVar];
      ProcessarSE(pLinhasSL, sVar, sValor);
    end;

    for iVar := 0 to oVariaveisSL.Count - 1 do
    begin
      sVar := oVariaveisSL.KeyNames[iVar];
      sValor := oVariaveisSL.Values[sVar];
      ProcessarValor(pLinhasSL, sVar, sValor);
    end;
  finally
    oVariaveisSL.Free;
  end;
end;

end.
