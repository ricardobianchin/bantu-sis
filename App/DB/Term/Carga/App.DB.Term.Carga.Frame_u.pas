unit App.DB.Term.Carga.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Sis.Entities.TerminalList, Sis.Config.SisConfig,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u, Vcl.StdCtrls,
  Vcl.Buttons, App.AppInfo, Sis.DB.DBTypes, System.Actions, Vcl.ActnList,
  Vcl.CheckLst;

type
  TTermCargaFrameFrame = class(TBasFrame)
    AtualizarListaBitBtn: TBitBtn;
    ActionList1: TActionList;
    AtualizarListaAction: TAction;
    TermCheckListBox: TCheckListBox;
    TermCargaAction: TAction;
    TermCargaBitBtn: TBitBtn;
    procedure AtualizarListaActionExecute(Sender: TObject);
  private
    { Private declarations }
    FAppInfo: IAppInfo;
    FSisConfig: ISisConfig;
    FServerDBConnection: IDBConnection;
    FTerminalList: ITerminalList;
    procedure PreencherTermListBox;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppInfo: IAppInfo; pSisConfig: ISisConfig);
      reintroduce; virtual;
//    procedure MarcarPelosTerminalIds(pStr: string);

  end;

var
  TermCargaFrameFrame: TTermCargaFrameFrame;

implementation

{$R *.dfm}

uses App.DB.Utils, Sis.Sis.Constants, Sis.DB.Factory, Sis.Entities.Terminal,
  Sis.Entities.Factory;

procedure TTermCargaFrameFrame.AtualizarListaActionExecute(Sender: TObject);
begin
  inherited;
  PreencherTermListBox;
end;

constructor TTermCargaFrameFrame.Create(AOwner: TComponent; pAppInfo: IAppInfo; pSisConfig: ISisConfig);
begin
  inherited Create(AOwner);
  FAppInfo := pAppInfo;
  FSisConfig := pSisConfig;
  FTerminalList := TerminalListCreate;
end;

procedure TTermCargaFrameFrame.PreencherTermListBox;
var
  oDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
  I: Integer;
  oTerminal: ITerminal;
  sText: string;
begin
  oDBConnectionParams := TerminalIdToDBConnectionParams(TERMINAL_ID_RETAGUARDA,
    FAppInfo, FSisConfig);

  oDBConnection := DBConnectionCreate('CargaFrame.PreencherList.Conn',
    FSisConfig, oDBConnectionParams, nil, nil);

  PreencherTerminalList(oDBConnection, FAppInfo, FTerminalList);

  TermCheckListBox.Items.Clear;
  for I := 0 to FTerminalList.Count - 1 do
  begin
    oTerminal := FTerminalList[I];
    sText := oTerminal.AsText;
    TermCheckListBox.Items.Add(sText);
  end;
end;

end.
