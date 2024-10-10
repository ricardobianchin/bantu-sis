unit App.DB.Term.Carga.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Sis.Entities.TerminalList,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u, Vcl.StdCtrls,
  Vcl.Buttons, App.AppObj, Sis.DB.DBTypes, System.Actions, Vcl.ActnList,
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
    FAppObj: IAppObj;
    FServerDBConnection: IDBConnection;
    FTerminalList: ITerminalList;
    procedure PreencherTermListBox;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj);
      reintroduce; virtual;
    // procedure MarcarPelosTerminalIds(pStr: string);

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

constructor TTermCargaFrameFrame.Create(AOwner: TComponent; pAppObj: IAppObj);
begin
  inherited Create(AOwner);
  FAppObj := pAppObj;
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
    FAppObj.AppInfo, FAppObj.SisConfig);

  oDBConnection := DBConnectionCreate('CargaFrame.PreencherList.Conn',
    FAppObj.SisConfig, oDBConnectionParams, nil, nil);

  PreencherTerminalList(oDBConnection, FAppObj.AppInfo, FTerminalList);

  TermCheckListBox.Items.Clear;
  for I := 0 to FTerminalList.Count - 1 do
  begin
    oTerminal := FTerminalList[I];
    sText := oTerminal.AsText;
    TermCheckListBox.Items.Add(sText);
  end;
end;

end.
