unit App.Retag.Est.Entrada.DBI_u;

interface

uses App.Est.EstMovDBI_u, App.Retag.Est.Entrada.DBI,
  App.Retag.Est.Entrada.Ent, Sis.Entities.Types, Sis.Types,
  Data.DB, System.Classes, Sis.DB.DBTypes, Sis.Types.Dates, App.AppObj,
  Sis.Usuario, App.Types;

type
  TEntradaDBI = class(TEstMovDBI, IEntradaDBI)
  private
    FEntradaEnt: IEntradaEnt;
  protected
    function GetSqlForEach(pValues: variant): string; override;

    procedure SetVarArrayToId(pNovaId: variant); override;
    function GetSqlInserirDoERetornaId: string; override;
    function GetSqlAlterarDo: string; override;
  public
    procedure FornecedorPrepareLista(pSL: TStrings);

    procedure EstMovFinalize(out pFinalizadoEm: TDateTime;
      out pErroDeu: Boolean; out pErroMens: string; pLojaId: TLojaId;
      pEstMovId: Int64; pTerminalId: TTerminalId = 0; pModuloSisId: Char = '#'); override;

    procedure UpdateItem;

    constructor Create(pDBConnection: IDBConnection; pAppObj: IAppObj;
      pEntradaEnt: IEntradaEnt; pUsuarioId: TId);
  end;

implementation

uses Sis.DB.DataSet.Utils, Sis.DB.Factory, System.SysUtils, Sis.Types.Floats,
  Sis.Win.Utils_u, Data.FmtBcd;

{ TEntradaDBI }

constructor TEntradaDBI.Create(pDBConnection: IDBConnection; pAppObj: IAppObj;
  pEntradaEnt: IEntradaEnt; pUsuarioId: TId);
begin
  inherited Create(pDBConnection, pEntradaEnt, pAppObj, pUsuarioId);
  FEntradaEnt := pEntradaEnt;
end;

procedure TEntradaDBI.EstMovFinalize(out pFinalizadoEm: TDateTime;
  out pErroDeu: Boolean; out pErroMens: string; pLojaId: TLojaId;
  pEstMovId: Int64; pTerminalId: TTerminalId; pModuloSisId: Char);
var
  sSql: string;
  q: TDataSet;
begin
//  inherited;
  sSql := //
    'SELECT'#13#10 //

    + 'FINALIZADO_EM_RET'#13#10 //

    + 'FROM ENTRADA_PA.ENTRADA_FINALIZE'#13#10 //

    + '('#13#10 //
    + '  ' + pLojaId.ToString + ' -- LOJA_ID'#13#10 //
//    + '  , ' + pTerminalId.ToString + ' -- TERMINAL_ID'#13#10 //
    + '  , ' + pEstMovId.ToString + ' -- EST_MOV_ID'#13#10 //

    + '  , ' + UsuarioId.ToString + ' -- LOG_PESSOA_ID'#13#10 //
    + '  , ' + sMachId + ' -- MACHINE_ID'#13#10 //
    + '  , ' + QuotedStr(pModuloSisId) + ' -- MODULO_SIS_ID'#13#10 //

    + ');';

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}

  pErroDeu := not DBConnection.Abrir;
  if pErroDeu then
  begin
    pErroMens := 'Erro ao tentar Finalizar Nota. ' + DBConnection.UltimoErro;
    exit;
  end;

  try
    DBConnection.QueryDataSet(sSql, q);
    pFinalizadoEm := q.Fields[0].AsDateTime;
  finally
    DBConnection.Fechar;
  end;

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

function TEntradaDBI.GetSqlAlterarDo: string;
var
  sSql: string;
  q: TDataSet;
  e: IEntradaEnt;
begin
  e := FEntradaEnt;

  Result := //
    'EXECUTE PROCEDURE ENTRADA_PA.ALTERAR_DO'#13#10 //

    + '('#13#10 //
    + '  ' + e.Loja.Id.ToString + ' -- LOJA_ID'#13#10 //
  // + '  , ' + e.TerminalId.ToString + ' -- TERMINAL_ID'#13#10 //
    + '  , ' + e.EstMovId.ToString + ' -- EST_MOV_ID'#13#10 //
    + '  , ' + e.FornecedorId.ToString + ' -- '#13#10 //
    + '  , ' + e.ndoc.ToString + ' -- '#13#10 //
    + '  , ' + e.serie.ToString + ' -- '#13#10 //

    + '  , ' + UsuarioId.ToString + ' -- LOG_PESSOA_ID'#13#10 //
    + '  , ' + sMachId + ' -- MACHINE_ID'#13#10 //
  // + '  , ' + QuotedStr(pModuloSisId) + ' -- MODULO_SIS_ID'#13#10 //

    + ');';


  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}

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

    + 'CRIADO_EM,'#13#10 //

    + 'FORNECEDOR_ID,'#13#10 //
    + 'FORNECEDOR_APELIDO,'#13#10 //

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
  iNItem: SmallInt;
  iOrdem: SmallInt;
  sProdIdDeles: string;
  iProdId: TId;
  uQtd: Currency;
  uCusto: Currency;
  uMargem: Currency;
  uPreco: Currency;
  e: IEntradaEnt;
begin
  e := FEntradaEnt;
  if e.EditandoItem and (e.State = dsEdit) then
  begin
    i := e.ItemIndex;
  end
  else
  begin
    i := e.Items.Count - 1;
  end;

  iOrdem := e.Items[i].Ordem;
  iNItem := e.Items[i].NItem;
  sProdIdDeles := e.Items[i].ProdIdDeles;
  iProdId := e.Items[i].Prod.Id;
  uQtd := e.Items[i].Qtd;
  Bcdtocurr(e.Items[i].Custo, uCusto);
  uMargem := e.Items[i].Margem;
  Bcdtocurr(e.Items[i].Preco, uPreco);

  Result := //
    'SELECT'#13#10
    + 'EST_MOV_ID_RET'#13#10 //
    + ', DTH_DOC_RET'#13#10 //
    + ', EST_MOV_CRIADO_EM_RET'#13#10 //
    + ', EST_MOV_ITEM_CRIADO_EM_RET'#13#10 //
    + ', ENTRADA_ID_RET'#13#10 //
    + ', ORDEM_RET'#13#10 //
    + ', LOG_STR_RET'#13#10 //
    + ' FROM ENTRADA_PA.ENTRADA_ITEM_INS(' + //
    e.Loja.Id.ToString + ',' + //
  // e.TerminalId.ToString + ',' + //
    e.EstMovId.ToString + ',' + //

    e.EntradaId.ToString + ',' + //

    iNItem.ToString + ',' + //
    e.ndoc.ToString + ',' + //
    e.serie.ToString + ',' + //
    e.FornecedorId.ToString + ',' + //

    QuotedStr(sProdIdDeles) + ',' + //

    iProdId.ToString + ',' + //
    CurrencyToStrPonto(uQtd) + ',' + //
    CurrencyToStrPonto(uCusto) + ',' + //
    CurrencyToStrPonto(uMargem) + ',' + //
    CurrencyToStrPonto(uPreco) + ',' + //

    QuotedStr(e.LogStr) + ',' + //

    UsuarioId.ToString + ',' + //
    sMachId //
    + ');' //
    ;
//{$IFDEF DEBUG}
//  CopyTextToClipboard(Result);
//{$ENDIF}
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

procedure TEntradaDBI.UpdateItem;
var
  sSqlInserirDoERetornaId: string;
  sMens: string;
  q: TDataSet;
  bDataSetWasEmpty: Boolean;
  Result: Boolean;
begin
  sSqlInserirDoERetornaId := GetSqlInserirDoERetornaId;

  Result := DBConnection.Abrir;
  if not Result then
  begin
    sMens := DBConnection.UltimoErro;
    exit;
  end;

  try
    DBConnection.QueryDataSet(sSqlInserirDoERetornaId, q);
  finally
    FreeAndNil(q);
    DBConnection.Fechar;
    Result := True;
  end;
end;

end.
