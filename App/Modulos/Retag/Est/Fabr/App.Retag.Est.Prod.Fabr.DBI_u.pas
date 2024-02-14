unit App.Retag.Est.Prod.Fabr.DBI_u;

interface

uses Sis.DBI, Sis.DBI_u, App.Retag.Est.Prod.Fabr, Sis.DB.DBTypes, Data.DB,
  App.Retag.Est.Prod.Fabr.DBI, System.Variants, Sis.Types.Integers;

type
  TProdFabrDBI = class(TDBI, IProdFabrDBI)
  private
    FProdFabr: IProdFabr;
  public
    procedure PreencherDataSet(pStrBusca: string; pLeReg: TProcDataSetRef);
    function ByNome(pNome: string): integer;
    constructor Create(pDBConnection: IDBConnection; pProdFabr: IProdFabr);
    function Garantir: boolean;
  end;

implementation

uses System.SysUtils;

{ TProdFabrDBI }

function TProdFabrDBI.ByNome(pNome: string): integer;
var
  sFormat: string;
  sSql: string;
  q: TDataSet;
  Resultado: Variant;
  sResultado: string;
begin
  Result := 0;
  sFormat := 'SELECT FABRICANTE_ID FROM FABRICANTE_PA.BYNOME_GET(''%s'');';
  sSql := Format(sFormat, [pNome]);
  DBConnection.Abrir;
  try
    Resultado := DBConnection.GetValue(sSql);
    sResultado := System.Variants.VarToStrDef(Resultado, '0');
    Result := StrToInteger(sResultado);

  finally
    DBConnection.Fechar;
  end;
end;

constructor TProdFabrDBI.Create(pDBConnection: IDBConnection;
  pProdFabr: IProdFabr);
begin
  inherited Create(pDBConnection);
  FProdFabr := pProdFabr;
end;

function TProdFabrDBI.Garantir: boolean;
var
  sFormat: string;
  sSql: string;
  q: TDataSet;
  Resultado: Variant;
  sResultado: string;
  iResultado: smallint;
  iId: smallint;
  sNome: string;
begin
  Result := False;
  iId := FProdFabr.Id;
  sNome := FProdFabr.Descr;

  sFormat := 'SELECT FABRICANTE_ID_GRAVADO FROM FABRICANTE_PA.FABRICANTE_GARANTIR(%d,''%s'');';
  sSql := Format(sFormat, [iId, sNome]);
  DBConnection.Abrir;
  try
    Resultado := DBConnection.GetValue(sSql);
    Result := True;
    sResultado := VarToStrDef(Resultado, '0');
    iResultado := StrToInteger(sResultado);
    FProdFabr.Id := iResultado;
  finally
    DBConnection.Fechar;
  end;
end;

procedure TProdFabrDBI.PreencherDataSet(pStrBusca: string; pLeReg: TProcDataSetRef);
var
  sSql: string;
  q: TDataSet;
begin
  DBConnection.Abrir;
  try
    sSql := 'select FABRICANTE_ID, NOME from FABRICANTE_PA.LISTA_GET('
      + QuotedStr(pStrBusca)
      + ');';
    DBConnection.QueryDataSet(sSql, q);
    try
      while not q.Eof do
      begin
        pLeReg(q);
        q.Next;
      end;
    finally
      q.Free;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

end.
