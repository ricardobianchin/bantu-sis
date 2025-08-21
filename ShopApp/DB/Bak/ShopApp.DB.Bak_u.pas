unit ShopApp.DB.Bak_u;

interface

uses Sis.Sis.Executavel_u, App.DB.Bak_u,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, System.Classes,
  App.AppObj;

type
  TShopAppBak = class(TAppBak)
  private
  protected
    procedure PreenchaBancosSL(pBancosSL: TStrings); override;
  public
  end;

implementation

{ TShopAppBak }

uses Sis.Terminal, Sis.DB.DBTypes, App.DB.Utils, Sis.Sis.Constants;

procedure TShopAppBak.PreenchaBancosSL(pBancosSL: TStrings);
var
  oTerminal: ITerminal;
  oDBConnectionParams: TDBConnectionParams;
begin
  // inherited;
  pBancosSL.Clear;

  AppObj.TerminalList.ExecuteForAll(
    procedure(pTerminal: ITerminal)
    begin
      pBancosSL.Add(pTerminal.LocalArqDados);
    end, AppObj.SisConfig.LocalMachineId.Name);

  if AppObj.SisConfig.LocalMachineIsServer then
  begin
    oDBConnectionParams := TerminalIdToDBConnectionParams
      (TERMINAL_ID_RETAGUARDA, AppObj);

    pBancosSL.Add(oDBConnectionParams.Arq);
  end;

end;

end.
