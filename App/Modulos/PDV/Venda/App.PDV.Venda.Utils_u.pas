unit App.PDV.Venda.Utils_u;

interface

type
  TPDVBuscaResultado = (pdvbrNaoDefinido, pdvbrStringNula, pdvbrErro,
    pdvbrValida, pdvbrBuscarDescricao);

const
  /// <summary>
  /// A set of TPDVBuscaResultado values used to define the results for PDV search operations.
  /// NaoDefinido, StringNula, Erro, BuscarDescricao]
  /// </summary>
  PDVBuscaResultadosAbreSelect: set of TPDVBuscaResultado = [pdvbrNaoDefinido,
    pdvbrStringNula, pdvbrErro, pdvbrBuscarDescricao];

function BuscaNumericaStatus(const pStrBusca: string): TPDVBuscaResultado;
procedure SepareBuscaStr(pStr: string; out pBuscaStr: string; out pQtd: Currency);

implementation

uses System.SysUtils, System.Character, Sis.Types.Floats;

function BuscaNumericaStatus(const pStrBusca: string): TPDVBuscaResultado;
var
  c: Char;
  i, iPosAsterisco, iposSepDecimal: integer;
  iQtdSepDecimal: integer;
  iQtdAsterisco: integer;
  bTemVirgulaOuPonto, bTemAlfa: Boolean;
begin
  Result := TPDVBuscaResultado.pdvbrStringNula;
  // Inicializa com o status padr�o para string vazia

  if pStrBusca = '' then
    Exit;

  iQtdSepDecimal := 0;
  bTemVirgulaOuPonto := False;
  bTemAlfa := False;
  iPosAsterisco := 0;
  iQtdAsterisco := 0;

  for i := 1 to Length(pStrBusca) do
  begin
    c := pStrBusca[i];

    bTemAlfa := not CharInSet(c, ['0' .. '9', '*', ',', '.']);
    if bTemAlfa then
    begin
      Result := TPDVBuscaResultado.pdvbrBuscarDescricao;
      Exit;
    end;

    if Result = pdvbrErro then
      Continue;

    if c = '*' then
    begin
      inc(iQtdAsterisco);
      if iQtdAsterisco > 1 then
      begin
        Result := pdvbrErro;
        // Exit;
      end;

      iPosAsterisco := i;
      if (iposSepDecimal > 0) and (iposSepDecimal < iPosAsterisco) then
      begin
        Result := pdvbrErro;
        // Exit;
      end;
    end;

    if CharInSet(c, [',', '.']) then
    begin
      inc(iQtdSepDecimal);
      if iQtdSepDecimal > 1 then
      begin
        Result := pdvbrErro;
        // Exit;
      end;
      iposSepDecimal := i;
      bTemVirgulaOuPonto := True;
      if (iPosAsterisco = 0) or (iposSepDecimal < iPosAsterisco) then
      begin
        Result := pdvbrErro;
        // Exit;
      end;
    end;
  end;

  if Result = pdvbrErro then
    Exit;

  c := pStrBusca[1];
  if CharInSet(c, [',', '.', '*']) then
  begin
    Result := pdvbrErro;
    Exit;
  end;

  c := pStrBusca[Length(pStrBusca)];
  if CharInSet(c, [',', '.', '*']) then
  begin
    Result := pdvbrErro;
    Exit;
  end;
  Result := TPDVBuscaResultado.pdvbrValida;
end;

procedure SepareBuscaStr(pStr: string; out pBuscaStr: string; out pQtd: Currency);
var
  iQtdElementos: integer;
  aElementos: TArray<string>;
begin
  aElementos := pStr.Split(['*']);
  iQtdElementos := Length(aElementos);

  if iQtdElementos > 1 then
  begin
    pBuscaStr := aElementos[0];
    pQtd := StrToCurrency(aElementos[1]);
  end
  else
  begin
    pBuscaStr := aElementos[0];
    pQtd := 1;
  end;
end;

end.
