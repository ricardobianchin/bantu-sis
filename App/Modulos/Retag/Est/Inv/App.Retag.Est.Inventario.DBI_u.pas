unit App.Retag.Est.Inventario.DBI_u;

interface

uses App.Est.EstMovDBI_u, App.Retag.Est.Inventario.DBI,
  App.Retag.Est.Inventario.Ent, Sis.Entities.Types, Sis.Types,
  Data.DB, System.Classes, Sis.DB.DBTypes, Sis.Types.Dates, App.AppObj,
  Sis.Usuario;

type
  TInventarioDBI = class(TEstMovDBI, IInventarioDBI)
  private
    FInventarioEnt: IInventarioEnt;
  protected
    function GetSqlForEach(pValues: variant): string; override;

    procedure SetVarArrayToId(pNovaId: variant); override;
    function GetSqlInserirDoERetornaId: string; override;
  public
    constructor Create(pDBConnection: IDBConnection; pAppObj: IAppObj;
      pInventarioEnt: IInventarioEnt; pUsuarioId: TId);
  end;

implementation

uses Sis.DB.DataSet.Utils, Sis.DB.Factory, System.SysUtils, Sis.Types.Floats,
  Sis.Win.Utils_u;

{ TInventarioDBI }

constructor TInventarioDBI.Create(pDBConnection: IDBConnection;
  pAppObj: IAppObj; pInventarioEnt: IInventarioEnt; pUsuarioId: TId);
begin
  inherited Create(pDBConnection, pInventarioEnt, pAppObj, pUsuarioId);
  FInventarioEnt := pInventarioEnt;
end;

function TInventarioDBI.GetSqlForEach(pValues: variant): string;
var
  dthIni, dthFin: TDateTime;
begin
  dthIni := pValues[0];
  dthFin := pValues[1];

  Result := 'SELECT'#13#10 //
    + 'LOJA_ID,'#13#10 //
    + 'TERMINAL_ID,'#13#10 //
    + 'EST_MOV_ID,'#13#10 //
    + 'INVENTARIO_ID,'#13#10 //
    + 'COD,'#13#10 //

  // +'DTH_DOC,'#13#10 //

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

    + 'FROM INVENTARIO_PA.LISTA_GET(' //
    + DataHoraSQLFirebird(dthIni) //
    + ', ' + DataHoraSQLFirebird(dthFin) //
    + ');'#13#10 //
    ;
//{$IFDEF DEBUG}
//  CopyTextToClipboard(Result);
//{$ENDIF}
end;

function TInventarioDBI.GetSqlInserirDoERetornaId: string;
var
  i: integer;
  iItemProdId: TId;
  uItemQtd: Currency;
  e: IInventarioEnt;
begin
  e := FInventarioEnt;
  i := e.Items.Count - 1;
  iItemProdId := e.Items[i].Prod.Id;
  uItemQtd := e.Items[i].Qtd;

  Result := 'SELECT EST_MOV_ID_RET, DTH_DOC_RET, EST_MOV_CRIADO_EM_RET,' +
    ' EST_MOV_ITEM_CRIADO_EM_RET, INVENTARIO_ID_RET, ORDEM_RET, LOG_STR_RET' +
    ' FROM INVENTARIO_PA.INVENTARIO_ITEM_INS(' + //
    e.Loja.Id.ToString + ',' + //
  // FInventarioEnt.TerminalId.ToString + ',' + //
    e.EstMovId.ToString + ',' + //
    e.InventarioId.ToString + ',' + //
    iItemProdId.ToString + ',' + //
    CurrencyToStrPonto(uItemQtd) + ',' + //
    QuotedStr(FInventarioEnt.LogStr) + ',' + //
    UsuarioId.ToString + ',' + //
    sMachId //
    + ');' //
    ;
end;

procedure TInventarioDBI.SetVarArrayToId(pNovaId: variant);
var
  i: integer;
begin
  inherited;
  i := FInventarioEnt.Items.Count - 1;
  FInventarioEnt.Items[i].CriadoEm := pNovaId[3];
  // FInventarioEnt.Items[i].Ordem := pNovaId[5];
  FInventarioEnt.LogStr := pNovaId[6];
  if not FInventarioEnt.EditandoItem then
  begin
    FInventarioEnt.EstMovId := pNovaId[0];
    FInventarioEnt.InventarioId := pNovaId[4];
    FInventarioEnt.DtHDoc := pNovaId[1];
    FInventarioEnt.CriadoEm := pNovaId[2];
  end;
end;

end.
