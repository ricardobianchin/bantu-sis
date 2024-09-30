unit Sis.DB.Updater.Diretivas_u;

interface

uses System.Classes;

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

procedure ProcessarVariavel(pLinhasSL: TStrings; pVar, pValor: string);
var
  sBuscaSE: string;
  iPosSE: integer;
  iPosFechaSE: integer;
  iPosSENAO: integer;
  iPosFIMSE: integer;
  bTemSenao: boolean;
  sOrigem: string;
  sDestino: string;
  iQtdEncontrada: integer;
  iPosIgual: integer;
  sValorArquivo: string;
  bExpressaoVerdadeira: boolean;
  sTextoVai: string;
  i, c: integer;
begin
  iQtdEncontrada := 0;
  sBuscaSE := sAbreSE + pVar + '=';
  sOrigem := pLinhasSL.Text;
  sDestino := '';
  repeat
    iPosSE := Pos(sBuscaSE, sOrigem);
    if iPosSE < 1 then
      break;
    inc(iQtdEncontrada);

    if iPosSE > 1 then
    begin
      sDestino := sDestino + Copy(sOrigem, 1, iPosSE - 1);
      Delete(sOrigem, 1, iPosSE - 1);
    end;

    iPosIgual := Pos('=', sOrigem);
    iPosFechaSE := Pos(sDiretivaFecha, sOrigem);
    iPosSENAO := Pos(sSENAO, sOrigem);
    iPosFIMSE := Pos(sFIMSE, sOrigem);

    i := iPosIgual + 1;
    c := iPosFechaSE - (iPosIgual + 1);
    sValorArquivo := Trim(Copy(sOrigem, i, c));
    bExpressaoVerdadeira := sValorArquivo = pValor;

    bTemSenao := (iPosSENAO > 0) and (iPosSENAO < iPosFIMSE);

    if bTemSenao then
    begin // tem senao
      if bExpressaoVerdadeira then
      begin
        i := iPosFechaSE + 1;
        c := iPosSENAO - (iPosFechaSE + 1);
        sTextoVai := Copy(sOrigem, i, c);

        if Copy(sTextoVai, 1, 2) = #13#10 then
          Delete(sTextoVai, 1, 2);
        sDestino := sDestino + sTextoVai;
      end
      else
      begin
        i := iPosSENAO + iLenSENAO;
        c := iPosFIMSE -(iPosSENAO + iLenSENAO);
        sTextoVai := Copy(sOrigem, i, c);

        if Copy(sTextoVai, 1, 2) = #13#10 then
          Delete(sTextoVai, 1, 2);
        sDestino := sDestino + sTextoVai;
      end;
    end
    else
    begin // nao tem senao
      if bExpressaoVerdadeira then
      begin
        i := iPosFechaSE + 1;
        c := iPosFIMSE - (iPosFechaSE + 1);
        sTextoVai := Copy(sOrigem, i, c);

        if Copy(sTextoVai, 1, 2) = #13#10 then
          Delete(sTextoVai, 1, 2);
        sDestino := sDestino + sTextoVai;
      end;
    end;
    // {$IFDEF DEBUG}
    CopyTextToClipboard(sOrigem);
    // {$ENDIF}
    Delete(sOrigem, 1, iPosFIMSE + (iLenFIMSE - 1));
    if Copy(sTextoVai, 1, 2) = #13#10 then
      Delete(sTextoVai, 1, 2);

  until False;
  sDestino := sDestino + sOrigem;
  if iQtdEncontrada > 0 then
    pLinhasSL.Text := sDestino;
end;

procedure ProcessarDiretivas(pLinhasSL: TStrings;
  pVariaveis, pDiretivaAbre, pDiretivaFecha: string);
var
  VariaveisSL: TStringList;
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

  VariaveisSL := TStringList.Create;
  try
    VariaveisSL.Text := pVariaveis;
    for iVar := 0 to VariaveisSL.Count - 1 do
    begin
      sVar := VariaveisSL.KeyNames[iVar];
      sValor := VariaveisSL.Values[sVar];
      ProcessarVariavel(pLinhasSL, sVar, sValor);
    end;
  finally
    VariaveisSL.Free;
  end;

end;

end.
