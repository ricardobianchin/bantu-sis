unit App.Retag.Est.Entrada.DBI_u;

interface

uses App.Est.EstMovDBI_u, App.Retag.Est.Entrada.DBI,
  App.Retag.Est.Entrada.Ent, Sis.Entities.Types, Sis.Types,
  Data.DB, System.Classes, Sis.DB.DBTypes, Sis.Types.Dates, App.AppObj,
  Sis.Usuario;

type
  TEntradaDBI = class(TEstMovDBI, IEntradaDBI)
  private
    FEntradaEnt: IEntradaEnt;
  protected
    function GetSqlForEach(pValues: variant): string; override;

    procedure SetVarArrayToId(pNovaId: variant); override;
    function GetSqlInserirDoERetornaId: string; override;
  public
    procedure FornecedorPrepareLista(pSL: TStrings);

    constructor Create(pDBConnection: IDBConnection; pAppObj: IAppObj;
      pEntradaEnt: IEntradaEnt; pUsuarioId: TId);
  end;

implementation

uses Sis.DB.DataSet.Utils, Sis.DB.Factory, System.SysUtils, Sis.Types.Floats,
  Sis.Win.Utils_u;

{ TEntradaDBI }

constructor TEntradaDBI.Create(pDBConnection: IDBConnection; pAppObj: IAppObj;
  pEntradaEnt: IEntradaEnt; pUsuarioId: TId);
begin
  inherited Create(pDBConnection, pEntradaEnt, pAppObj, pUsuarioId);
  FEntradaEnt := pEntradaEnt;
end;

procedure TEntradaDBI.FornecedorPrepareLista(pSL: TStrings);
var
  oDBQuery: IDBQuery;
  sSql: string;
  q: TDataSet;
  p: Pointer;
  iId: integer;
  sDescr: string;
begin
  pSL.Clear;
  // pSL.Add('<TODAS AS FORMAS>');
  DBConnection.Abrir;

  try
    sSql := //
      'SELECT'#13#10 //
      + 'PE.PESSOA_ID'#13#10 //
      + ', PE.APELIDO'#13#10 //
      + 'FROM PESSOA PE'#13#10 //
      + 'JOIN FORNECEDOR F ON'#13#10 //
      + 'PE.LOJA_ID = F.LOJA_ID'#13#10 //
      + 'AND PE.TERMINAL_ID = F.TERMINAL_ID'#13#10 //
      + 'AND PE.PESSOA_ID = F.PESSOA_ID'#13#10 //
      + 'WHERE PE.LOJA_ID = '+AppObj.Loja.Id.ToString+#13#10 //
      + 'ORDER BY PE.APELIDO'#13#10 //
      ;

    oDBQuery := DBQueryCreate('TEstEntradaDBI.FornecedorPrepareLista.q',
      DBConnection, sSql, nil, nil);

    oDBQuery.Abrir;
    try
      q := oDBQuery.DataSet;
      while not q.Eof do
      begin
        iId := q.Fields[0].AsInteger;
        sDescr := //
          Trim(q.Fields[1].AsString) //
          ;

        if iId < 1 then
        begin
          pSL.Add(sDescr);
          q.Next;
          continue;
        end;

        p := Pointer(iId);
        pSL.AddObject(sDescr, p);

        q.Next;
      end;
    finally
      oDBQuery.Fechar;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

function TEntradaDBI.GetSqlForEach(pValues: variant): string;
var
  dthIni, dthFin: TDateTime;
begin
  dthIni := pValues[0];
  dthFin := pValues[1];

  Result := 'SELECT'#13#10 //
    + 'LOJA_ID,'#13#10 //
    + 'TERMINAL_ID,'#13#10 //
    + 'EST_MOV_ID,'#13#10 //

    + 'ENTRADA_ID,'#13#10 //

    + 'COD,'#13#10 //
    + 'NDOC,'#13#10 //
    + 'SERIE,'#13#10 //
  // +'DTH_DOC,'#13#10 //

    + 'FORNECEDOR_ID,'#13#10 //
    + 'FORNECEDOR_APELIDO,'#13#10 //

    + 'CRIADO_EM,'#13#10 //

    + 'FINALIZADO,'#13#10 //
    + 'FINALIZADO_EM,'#13#10 //

    + 'CANCELADO,'#13#10 //
  // +'ALTERADO_EM,'#13#10 //
    + 'CANCELADO_EM,'#13#10 //

    + 'CRIADO_POR_ID,'#13#10 //
    + 'CRIADO_POR_APELIDO,'#13#10 //

    + 'CANCELADO_POR_ID,'#13#10 //
    + 'CANCELADO_POR_APELIDO,'#13#10 //

    + 'FINALIZADO_POR_ID,'#13#10 //
    + 'FINALIZADO_POR_APELIDO'#13#10 //

    + 'FROM ENTRADA_PA.LISTA_GET(' //
    + DataHoraSQLFirebird(dthIni) //
    + ', ' + DataHoraSQLFirebird(dthFin) //
    + ');'#13#10 //
    ;
end;

function TEntradaDBI.GetSqlInserirDoERetornaId: string;
var
  i: integer;
  iItemProdId: TId;
  uItemQtd: Currency;
  uCusto: Currency;
  e: IEntradaEnt;
begin
  e := FEntradaEnt;
  i := e.Items.Count - 1;
  iItemProdId := e.Items[i].Prod.Id;
  uItemQtd := e.Items[i].Qtd;
  uCusto := e.Items[i].Custo;

  Result := 'SELECT EST_MOV_ID_RET, DTH_DOC_RET, EST_MOV_CRIADO_EM_RET,' +
    ' EST_MOV_ITEM_CRIADO_EM_RET, ENTRADA_ID_RET, ORDEM_RET, LOG_STR_RET' +
    ' FROM ENTRADA_PA.ENTRADA_ITEM_INS(' + //
    e.Loja.Id.ToString + ',' + //
  // e.TerminalId.ToString + ',' + //
    e.EstMovId.ToString + ',' + //

    e.EntradaId.ToString + ',' + //

    e.ndoc.ToString + ',' + //
    e.serie.ToString + ',' + //
    e.FornecedorId.ToString + ',' + //

    iItemProdId.ToString + ',' + //
    CurrencyToStrPonto(uItemQtd) + ',' + //
    CurrencyToStrPonto(uCusto) + ',' + //

    QuotedStr(e.LogStr) + ',' + //
    
    UsuarioId.ToString + ',' + //
    sMachId //
    + ');' //
    ;
end;

procedure TEntradaDBI.SetVarArrayToId(pNovaId: variant);
var
  i: integer;
  e: IEntradaEnt;
begin
  inherited;
  e := FEntradaEnt;
  i := e.Items.Count - 1;
  e.Items[i].CriadoEm := pNovaId[3];
  // e.Items[i].Ordem := pNovaId[5];
  e.LogStr := pNovaId[6];
  if not e.EditandoItem then
  begin
    e.EstMovId := pNovaId[0];
    e.EntradaId := pNovaId[4];
    e.DtHDoc := pNovaId[1];
    e.CriadoEm := pNovaId[2];
  end;
end;

end.
