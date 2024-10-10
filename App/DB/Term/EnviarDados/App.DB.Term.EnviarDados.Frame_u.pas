unit App.DB.Term.EnviarDados.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Sis.Entities.TerminalList,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u, Vcl.StdCtrls,
  Vcl.Buttons, App.AppObj, Sis.DB.DBTypes, System.Actions, Vcl.ActnList,
  Vcl.CheckLst, Generics.Collections, Sis.Entities.Types, Sis.Types.Integers;

type
  TTermEnviarDadosFrame = class(TBasFrame)
    AtualizarListaBitBtn: TBitBtn;
    ActionList1: TActionList;
    AtualizarListaAction: TAction;
    TermCheckListBox: TCheckListBox;
    TermEnviarDadosAction: TAction;
    TermCargaBitBtn: TBitBtn;
    procedure AtualizarListaActionExecute(Sender: TObject);
  private
    { Private declarations }
    FAppObj: IAppObj;
    FServerDBConnection: IDBConnection;
    FTerminalList: ITerminalList;
    procedure PreencherTermListBox;
    procedure SelecionePorTerminalIds(pIds: string);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj);
      reintroduce; virtual;
    // procedure MarcarPelosTerminalIds(pStr: string);

  end;

var
  TermEnviarDadosFrame: TTermEnviarDadosFrame;

implementation

{$R *.dfm}

uses App.DB.Utils, Sis.Sis.Constants, Sis.DB.Factory, Sis.Entities.Terminal,
  Sis.Entities.Factory;

procedure TTermEnviarDadosFrame.AtualizarListaActionExecute(Sender: TObject);
begin
  inherited;
  PreencherTermListBox;
end;

constructor TTermEnviarDadosFrame.Create(AOwner: TComponent; pAppObj: IAppObj);
var
  bExec: Boolean;
  sIds: string;
begin
  inherited Create(AOwner);
  FAppObj := pAppObj;
  FTerminalList := TerminalListCreate;

  bExec := FAppObj.AppTestesConfig.ModuRetag.Ajuda.BemVindo.Terminais.AutoExec;

  if not bExec then
    exit;

  sIds := FAppObj.AppTestesConfig.ModuRetag.Ajuda.BemVindo.Terminais.SelectTerminalIds;

  if sIds = '' then
    exit;

  AtualizarListaAction.Execute;
  SelecionePorTerminalIds(sIds);
  TermEnviarDadosAction.Execute;
end;

procedure TTermEnviarDadosFrame.PreencherTermListBox;
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

procedure TTermEnviarDadosFrame.SelecionePorTerminalIds(pIds: string);
var
  a: TArray<string>;
  l: integer;
  i: integer;
  s: string;
  iTerminalId: TTerminalId;
  iIndice: integer;
begin
  a := pIds.Split([',',';']);

  l := Length(a);
  if l = 0 then
    exit;

  for i := 0 to l-1 do
  begin
    s := a[i];
    iTerminalId := StrToInteger(s);
    iIndice := FTerminalList.TerminalIdToIndex(iTerminalId);
    if iIndice < 0 then
      continue;

    TermCheckListBox.Checked[i] := True;
  end;
end;

end.
