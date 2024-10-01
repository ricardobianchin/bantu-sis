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

  oVariaveisSL: TStringList;

procedure ProcessarValor(pLinhasSL: TStrings; pVar, pValor: string);
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
