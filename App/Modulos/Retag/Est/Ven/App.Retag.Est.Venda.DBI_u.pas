unit App.Retag.Est.Venda.DBI_u;

interface

uses App.Est.EstMovDBI_u, App.Retag.Est.Venda.DBI,
  App.Retag.Est.Venda.Ent, Sis.Entities.Types, Sis.Types,
  Data.DB, System.Classes, Sis.DB.DBTypes, Sis.Types.Dates, App.AppObj,
  Sis.Usuario;

type
  TRetagVendaDBI = class(TEstMovDBI, IRetagVendaDBI)
  private
    FRetagVendaEnt: IRetagVendaEnt;
  protected
    function GetSqlForEach(pValues: variant): string; override;

  public
    constructor Create(pDBConnection: IDBConnection; pAppObj: IAppObj;
      pRetagVendaEnt: IRetagVendaEnt; pUsuarioId: TId);
  end;

implementation

uses Sis.DB.DataSet.Utils, Sis.DB.Factory, System.SysUtils, Sis.Types.Floats, Sis.Win.Utils_u;

{ TRetagVendaDBI }

constructor TRetagVendaDBI.Create(pDBConnection: IDBConnection;
  pAppObj: IAppObj; pRetagVendaEnt: IRetagVendaEnt; pUsuarioId: TId);
begin
  inherited Create(pDBConnection, pRetagVendaEnt, pAppObj, pUsuarioId);
  FRetagVendaEnt := pRetagVendaEnt;
end;

function TRetagVendaDBI.GetSqlForEach(pValues: variant): string;
var
  dthIni, dthFin: TDateTime;
begin
  dthIni := pValues[0];
  dthFin := pValues[1];

  Result := 'SELECT'#13#10 //

    + 'LOJA_ID,'#13#10 //
    + 'TERMINAL_ID,'#13#10 //
    + 'EST_MOV_ID,'#13#10 //

    + 'VENDA_ID,'#13#10 //

    + ''''' COD,'#13#10 //

    + 'CRIADO_EM,'#13#10 //

    + 'DESCONTO_TOTAL,'#13#10 //
    + 'TOTAL_LIQUIDO,'#13#10 //

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

    + 'FROM RETAG_VENDA_PA.LISTA_GET(' //
    + DataHoraSQLFirebird(dthIni) //
    + ', ' + DataHoraSQLFirebird(dthFin) //
    + ');'#13#10 //
    ;

//{$IFDEF DEBUG}
//  CopyTextToClipboard(Result);
//{$ENDIF}

end;

end.
