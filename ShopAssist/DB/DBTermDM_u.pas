unit DBTermDM_u;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, Sis.Entities.Types;

type
  TTerminal = record
    TerminalId: TTerminalId;
    NomeNaRede: string;
    LocalArqDados: string;
  end;

  TDBTermDM = class(TDataModule)
    Connection: TFDConnection;
    procedure ConnectionBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Terminal: TTerminal;
  end;

  TProcTermOfObject = procedure(pTermDM: TDBTermDM;
    var pPrecisaTerminar: Boolean) { of object };

  // var
  // DBTermDM: TDBTermDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Sis_u, Sis.Types.Bool_u, Configs_u, Sis.Log;
{$R *.dfm}

procedure TDBTermDM.ConnectionBeforeConnect(Sender: TObject);
var
  sDriver: string;
  sServer: string;
  sArq: string;
begin
  Connection.LoginPrompt := false;
  sDriver := 'FB';
//  Iif(pNome = '', pIP, pNome)

  //sServer := iif(Terminal.NomeNaRede = '', Config.Local.IP, Config.Local.Nome);
  sServer := Terminal.NomeNaRede;
  sArq := Terminal.LocalArqDados;

  Connection.Params.Text := //
    'DriverID=' + sDriver + #13#10 //
    + 'Server=' + sServer + #13#10 //
    + 'Database=' + sArq + #13#10 //
    + 'Password=masterkey'#13#10 //
    + 'User_Name=sysdba'#13#10 //
    + 'Protocol=TCPIP' //
    ;
  Log.Escreva('TDBTermDM.ConnectionBeforeConnect('#13#10+Connection.Params.Text+#13#10);

end;

end.
