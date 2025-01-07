unit App.PDV.DBI_u;

interface

uses Sis.DBI_u, App.PDV.DBI, App.AppObj, Sis.DB.DBTypes, Sis.Entities.Terminal,
  App.PDV.Venda;

type
  TAppPDVDBI = class(TDBI, IAppPDVDBI)
  private
    FAppObj: IAppObj;
    FTerminal: ITerminal;
    FPdvVenda: IPDVVenda;
  protected
    property AppObj: IAppObj read FAppObj;
    property Terminal: ITerminal read FTerminal;
    property PDVVenda: IPDVVenda read FPdvVenda;
  public
    procedure PagSomenteDinheiro;

    constructor Create(pDBConnection: IDBConnection; pAppObj: IAppObj;
      pTerminal: ITerminal; pPdvVenda: IPDVVenda);
  end;

implementation

uses Data.DB, System.SysUtils, Sis.Entities.Types;

{ TAppPDVDBI }

constructor TAppPDVDBI.Create(pDBConnection: IDBConnection; pAppObj: IAppObj;
  pTerminal: ITerminal; pPdvVenda: IPDVVenda);
begin
  inherited Create(pDBConnection);
  FAppObj := pAppObj;
  FTerminal := pTerminal;
  FPdvVenda := pPdvVenda;
end;

procedure TAppPDVDBI.PagSomenteDinheiro;
var
  sSql: string;
  V: IPDVVenda;
  q: TDataSet;
begin
  V := FPdvVenda;

  sSql := //
    'SELECT'#13#10 //

    + 'FINALIZADO_EM_RET'#13#10 //
    + ', DESCONTO_TOTAL_RET'#13#10 //
    + ', CUSTO_TOTAL_RET'#13#10 //
    + ', TOTAL_LIQUIDO_RET'#13#10 //

    + 'FROM VENDA_PAG_INS_PA.FINALIZE_SO_DIN'#13#10 //

    + '('#13#10 //
    + '  ' + V.Loja.Id.ToString + ' -- LOJA_ID'#13#10 //
    + '  , ' + V.TerminalId.ToString + ' -- TERMINAL_ID'#13#10 //
    + '  , ' + V.EstMovId.ToString + ' -- EST_MOV_ID'#13#10 //
    + ');';

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}

  DBConnection.Abrir;
  try
    DBConnection.QueryDataSet(sSql, q);
  finally
    DBConnection.Fechar;
  end;
end;

end.
