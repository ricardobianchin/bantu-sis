unit App.Retag.Est.EstSaida.DBI_u;

interface

uses App.Est.EstMovDBI_u, App.Retag.Est.EstSaida.DBI,
  App.Retag.Est.EstSaida.Ent, Sis.Entities.Types, Sis.Types,
  Data.DB, System.Classes, Sis.DB.DBTypes, Sis.Types.Dates, App.AppObj,
  Sis.Usuario;

type
  TEstSaidaDBI = class(TEstMovDBI, IEstSaidaDBI)
  private
    FEstSaidaEnt: IEstSaidaEnt;
  protected
    function GetSqlForEach(pValues: variant): string; override;

    procedure SetVarArrayToId(pNovaId: variant); override;
    function GetSqlInserirDoERetornaId: string; override;
    function GetSqlAlterarDo: string; override;
  public

    procedure SaidaMotivoPrepareLista(pSL: TStrings);

    constructor Create(pDBConnection: IDBConnection; pAppObj: IAppObj;
      pEstSaidaEnt: IEstSaidaEnt; pUsuarioId: TId);
  end;

implementation

uses Sis.DB.DataSet.Utils, Sis.DB.Factory, System.SysUtils, Sis.Types.Floats;

{ TEstSaidaDBI }

constructor TEstSaidaDBI.Create(pDBConnection: IDBConnection; pAppObj: IAppObj;
  pEstSaidaEnt: IEstSaidaEnt; pUsuarioId: TId);
begin
  inherited Create(pDBConnection, pEstSaidaEnt, pAppObj, pUsuarioId);
  FEstSaidaEnt := pEstSaidaEnt;
end;

function TEstSaidaDBI.GetSqlAlterarDo: string;
var
  sSql: string;
  q: TDataSet;
  e: IEstSaidaEnt;
begin
  e := FEstSaidaEnt;

  Result := //
    'EXECUTE PROCEDURE EST_SAIDA_PA.ALTERAR_DO'#13#10 //

    + '('#13#10 //
    + '  ' + e.Loja.Id.ToString + ' -- LOJA_ID'#13#10 //
  // + '  , ' + e.TerminalId.ToString + ' -- TERMINAL_ID'#13#10 //
    + '  , ' + e.EstMovId.ToString + ' -- EST_MOV_ID'#13#10 //
    + '  , ' + e.SaidaMotivoId.ToString + ' -- EST_SAIDA_MOTIVO_ID'#13#10 //

    + '  , ' + UsuarioId.ToString + ' -- LOG_PESSOA_ID'#13#10 //
    + '  , ' + sMachId + ' -- MACHINE_ID'#13#10 //
  // + '  , ' + QuotedStr(pModuloSisId) + ' -- MODULO_SIS_ID'#13#10 //

    + ');';

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}

end;

function TEstSaidaDBI.GetSqlForEach(pValues: variant): string;
var
  dthIni, dthFin: TDateTime;
begin
  dthIni := pValues[0];
  dthFin := pValues[1];

  Result := 'SELECT'#13#10 //
    + 'LOJA_ID,'#13#10 //
    + 'TERMINAL_ID,'#13#10 //
    + 'EST_MOV_ID,'#13#10 //
    + 'EST_SAIDA_ID,'#13#10 //
    + 'COD,'#13#10 //

  // +'DTH_DOC,'#13#10 //

    + 'CRIADO_EM,'#13#10 //

    + 'EST_SAIDA_MOTIVO_ID,'#13#10 //
    + 'EST_SAIDA_MOTIVO_NOME,'#13#10 //

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

    + 'FROM EST_SAIDA_PA.LISTA_GET(' //
    + DataHoraSQLFirebird(dthIni) //
    + ', ' + DataHoraSQLFirebird(dthFin) //
    + ');'#13#10 //
    ;
end;

function TEstSaidaDBI.GetSqlInserirDoERetornaId: string;
var
  i: integer;
  iItemProdId: TId;
  uItemQtd: Currency;
  e: IEstSaidaEnt;
begin
  e := FEstSaidaEnt;
  i := e.Items.Count - 1;
  iItemProdId := e.Items[i].Prod.Id;
  uItemQtd := e.Items[i].Qtd;

  Result := 'SELECT EST_MOV_ID_RET, DTH_DOC_RET, EST_MOV_CRIADO_EM_RET,' +
    ' EST_MOV_ITEM_CRIADO_EM_RET, EST_SAIDA_ID_RET, ORDEM_RET, LOG_STR_RET' +
    ' FROM EST_SAIDA_PA.EST_SAIDA_ITEM_INS(' + //
    e.Loja.Id.ToString + ',' + //
  // FEstSaidaEnt.TerminalId.ToString + ',' + //
    e.EstMovId.ToString + ',' + //
    e.EstSaidaId.ToString + ',' + //
    e.SaidaMotivoId.ToString + ',' + //
    iItemProdId.ToString + ',' + //
    CurrencyToStrPonto(uItemQtd) + ',' + //
    QuotedStr(FEstSaidaEnt.LogStr) + ',' + //
    UsuarioId.ToString + ',' + //
    sMachId //
    + ');' //
    ;
end;

procedure TEstSaidaDBI.SaidaMotivoPrepareLista(pSL: TStrings);
var
  oDBQuery: IDBQuery;
  sSql: string;
  q: TDataSet;
  p: Pointer;
  iId: integer;
  sDescr: string;
  sDescr2: string;
begin
  pSL.Clear;
  // pSL.Add('<TODAS AS FORMAS>');
  DBConnection.Abrir;
  try
    sSql := //
      'SELECT EST_SAIDA_MOTIVO_ID, NOME, DESCR'#13#10 //
      + 'FROM EST_SAIDA_MOTIVO'#13#10 //
      + 'ORDER BY EST_SAIDA_MOTIVO_ID'#13#10 //
      ;

    oDBQuery := DBQueryCreate('TEstSaidaDBI.SaidaMotivoPrepareLista.q',
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

        sDescr2 := ' - ' + AnsiLowerCase(Trim(q.Fields[2].AsString));

        sDescr := sDescr + sDescr2;

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

procedure TEstSaidaDBI.SetVarArrayToId(pNovaId: variant);
var
  i: integer;
begin
  inherited;
  i := FEstSaidaEnt.Items.Count - 1;
  FEstSaidaEnt.Items[i].CriadoEm := pNovaId[3];
  // FEstSaidaEnt.Items[i].Ordem := pNovaId[5];
  FEstSaidaEnt.LogStr := pNovaId[6];
  if not FEstSaidaEnt.EditandoItem then
  begin
    FEstSaidaEnt.EstMovId := pNovaId[0];
    FEstSaidaEnt.EstSaidaId := pNovaId[4];
    FEstSaidaEnt.DtHDoc := pNovaId[1];
    FEstSaidaEnt.CriadoEm := pNovaId[2];
  end;
end;

end.
