unit App.PDV.DBI_u;

interface

uses Sis.DBI_u, App.AppObj, Sis.DB.DBTypes, Sis.Entities.Terminal,
  App.PDV.Venda;

type
  TAppPDVDBI = class(TDBI)
  private
    FAppObj: IAppObj;
    FTerminal: ITerminal;
    FPdvVenda: IPDVVenda;
  protected
    property AppObj: IAppObj read FAppObj;
    property Terminal: ITerminal read FTerminal;
    property PDVVenda: IPDVVenda read FPDVVenda;
  public
    constructor Create(pDBConnection: IDBConnection; pAppObj: IAppObj;
      pTerminal: ITerminal; pPdvVenda: IPDVVenda);
  end;

implementation

{ TAppPDVDBI }

constructor TAppPDVDBI.Create(pDBConnection: IDBConnection; pAppObj: IAppObj;
  pTerminal: ITerminal; pPdvVenda: IPDVVenda);
begin
  inherited Create(pDBConnection);
  FAppObj := pAppObj;
  FTerminal := pTerminal;
  FPDVVenda := pPdvVenda;
end;

end.
