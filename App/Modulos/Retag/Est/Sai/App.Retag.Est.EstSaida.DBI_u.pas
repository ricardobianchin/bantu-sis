unit App.Retag.Est.EstSaida.DBI_u;

interface

uses App.Est.EstMovDBI_u, App.Retag.Est.EstSaida.DBI,
  App.Retag.Est.EstSaida.Ent,
  Data.DB, System.Classes, Sis.DB.DBTypes, Sis.Types.Dates;

type
  TEstSaidaDBI = class(TEstMovDBI, IEstSaidaDBI)
  private
    FEstSaidaEnt: IEstSaidaEnt;
  protected
    function GetSqlForEach(pValues: variant): string; override;

    procedure SetVarArrayToId(pNovaId: variant); override;
    function GetSqlInserirDoERetornaId: string; override;
  public

    procedure SaidaMotivoPrepareLista(pSL: TStrings);

    constructor Create(pDBConnection: IDBConnection;
      pEstSaidaEnt: IEstSaidaEnt);
  end;

implementation

uses Sis.DB.DataSet.Utils, Sis.DB.Factory, System.SysUtils, Sis.Entities.Types,
  Sis.Types, Sis.Types.Floats;

{ TEstSaidaDBI }

constructor TEstSaidaDBI.Create(pDBConnection: IDBConnection;
  pEstSaidaEnt: IEstSaidaEnt);
begin
  inherited Create(pDBConnection, pEstSaidaEnt);
  FEstSaidaEnt := pEstSaidaEnt;
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
    + 'EST_SAIDA_NOME,'#13#10 //

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
    + DataSQLFirebird(dthIni) //
    + ', ' + DataSQLFirebird(dthFin) //
    + ');'#13#10 //
    ;
end;

function TEstSaidaDBI.GetSqlInserirDoERetornaId: string;
var
  i: integer;
  iItemProdId: TId;
  uItemQtd: Currency;

begin
  i := FEstSaidaEnt.ItemIndex;
  iItemProdId := FEstSaidaEnt.Items[i].Prod.Id;
  uItemQtd := FEstSaidaEnt.Items[i].Qtd;

  Result := 'SELECT EST_MOV_ID_RET, DTH_DOC_RET, EST_MOV_CRIADO_EM_RET,' +
    ' EST_MOV_ITEM_CRIADO_EM_RET, EST_SAIDA_ID_RET, ORDEM_RET, LOG_STR_RET' +
    ' FROM EST_SAIDA_PA.EST_SAIDA_ITEM_INS(' + //
    FEstSaidaEnt.Loja.id.ToString + ',' + //
    FEstSaidaEnt.TerminalId.ToString + ',' + //
    FEstSaidaEnt.EstMovId.ToString + ',' + //
    FEstSaidaEnt.EstSaidaId.ToString + ',' + //
    FEstSaidaEnt.SaidaMotivoId.ToString + ',' + //
    iItemProdId.ToString + ',' + //
    CurrencyToStrPonto(uItemQtd) + ',' + //
    QuotedStr(FEstSaidaEnt.LogStr) + ');' //
    ;
end;

procedure TEstSaidaDBI.SaidaMotivoPrepareLista(pSL: TStrings);
var
  oDBQuery: IDBQuery;
  sSql: string;
  Q: TDataSet;
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
      Q := oDBQuery.DataSet;
      while not Q.Eof do
      begin
        iId := Q.Fields[0].AsInteger;
        sDescr := //
          Trim(Q.Fields[1].AsString) //
          ;

        if iId < 1 then
        begin
          pSL.Add(sDescr);
          Q.Next;
          continue;
        end;

        sDescr2 := ' - ' + AnsiLowerCase(Trim(Q.Fields[2].AsString));

        sDescr := sDescr + sDescr2;

        p := Pointer(iId);
        pSL.AddObject(sDescr, p);

        Q.Next;
      end;
    finally
      oDBQuery.Fechar;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

procedure TEstSaidaDBI.SetVarArrayToId(pNovaId: variant);
begin
  inherited;
  FEstSaidaEnt.EstMovId := pNovaId[0];
  FEstSaidaEnt.DtHDoc := pNovaId[1];
  FEstSaidaEnt.CriadoEm := pNovaId[2];
  FEstSaidaEnt.Items[FEstSaidaEnt.ItemIndex].CriadoEm := pNovaId[3];
  FEstSaidaEnt.EstSaidaId := pNovaId[4];
  //FEstSaidaEnt.Items[FEstSaidaEnt.ItemIndex].Ordem := pNovaId[5];
  FEstSaidaEnt.LogStr := pNovaId[6];
end;

end.
