unit App.DB.Term.EnviarDados.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Sis.Entities.TerminalList,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u, Vcl.StdCtrls,
  Vcl.Buttons, App.AppObj, Sis.DB.DBTypes, System.Actions, Vcl.ActnList,
  Vcl.CheckLst, Generics.Collections, Sis.Entities.Types, Sis.Types.Integers,
  Vcl.ComCtrls, Sis.UI.IO.Output;

type
  TTermEnviarDadosFrame = class(TBasFrame)
    AtualizarListaBitBtn: TBitBtn;
    ActionList1: TActionList;
    AtualizarListaAction: TAction;
    TermCheckListBox: TCheckListBox;
    TermEnviarDadosAction: TAction;
    TermEnviarDadosBitBtn: TBitBtn;
    ProgressBar1: TProgressBar;
    StatusLabel: TLabel;
    procedure AtualizarListaActionExecute(Sender: TObject);
    procedure TermEnviarDadosActionExecute(Sender: TObject);
  private
    { Private declarations }
    FAppObj: IAppObj;
    FServerDBConnection: IDBConnection;
    FTerminalList: ITerminalList;
    FStatusOutput: IOutput;
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
  Sis.Entities.Factory, App.DB.Term.EnviarDados,
  App.DB.Term.EnviarDados.Factory_u,
  Sis.UI.IO.Factory;

procedure TTermEnviarDadosFrame.AtualizarListaActionExecute(Sender: TObject);
begin
  inherited;
  AtualizarListaAction.Enabled := False;
  try
    PreencherTermListBox;
  finally
    AtualizarListaAction.Enabled := True;
  end;
end;

constructor TTermEnviarDadosFrame.Create(AOwner: TComponent; pAppObj: IAppObj);
var
  bExec: Boolean;
  sIds: string;
begin
  inherited Create(AOwner);
  FStatusOutput := LabelOutputCreate(StatusLabel);
  FAppObj := pAppObj;
  FTerminalList := TerminalListCreate;

  bExec := FAppObj.AppTestesConfig.ModuRetag.Ajuda.BemVindo.Terminais.AutoExec;

  if not bExec then
    exit;

  sIds := FAppObj.AppTestesConfig.ModuRetag.Ajuda.BemVindo.Terminais.
    SelectTerminalIds;

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
  FStatusOutput.Exibir('Consultando Terminais');
  try
    oDBConnectionParams := TerminalIdToDBConnectionParams
      (TERMINAL_ID_RETAGUARDA, FAppObj);

    oDBConnection := DBConnectionCreate
      ('TermEnviarDadosFrame.PreencherList.Conn', FAppObj.SisConfig,
      oDBConnectionParams, nil, nil);

    PreencherTerminalList(oDBConnection, FAppObj, FTerminalList);

    TermCheckListBox.Items.Clear;
    for I := 0 to FTerminalList.Count - 1 do
    begin
      oTerminal := FTerminalList[I];
      sText := oTerminal.AsText;
      TermCheckListBox.Items.Add(sText);
    end;
  finally
    FStatusOutput.Exibir('Lista atualizada');
  end;
end;

procedure TTermEnviarDadosFrame.SelecionePorTerminalIds(pIds: string);
var
  a: TArray<string>;
  l: Integer;
  I: Integer;
  s: string;
  iTerminalId: TTerminalId;
  iIndice: Integer;
begin
  a := pIds.Split([',', ';']);

  l := Length(a);
  if l = 0 then
    exit;

  for I := 0 to l - 1 do
  begin
    s := a[I];
    iTerminalId := StrToInteger(s);
    iIndice := FTerminalList.TerminalIdToIndex(iTerminalId);
    if iIndice < 0 then
      continue;

    TermCheckListBox.Checked[I] := True;
  end;
end;

procedure TTermEnviarDadosFrame.TermEnviarDadosActionExecute(Sender: TObject);
var
  oDBConnectionParams: TDBConnectionParams;
  oServDBConnection: IDBConnection;
  oTermDBConnection: IDBConnection;

  I: Integer;
  oTerminal: ITerminal;
  oTermEnviarDados: ITermEnviarDados;
begin
  inherited;
  TermEnviarDadosAction.Enabled := False;
  FStatusOutput.Exibir('Iniciou o envio');
  try
    oDBConnectionParams := TerminalIdToDBConnectionParams
      (TERMINAL_ID_RETAGUARDA, FAppObj);

    oServDBConnection := DBConnectionCreate
      ('CargaFrame.TermEnviarDados.Serv.Conn', FAppObj.SisConfig,
      oDBConnectionParams, nil, nil);

    for I := 0 to FTerminalList.Count - 1 do
    begin
      if not TermCheckListBox.Checked[I] then
        continue;

      oTerminal := FTerminalList.Terminal[I];

      oDBConnectionParams.Server := oTerminal.NomeNaRede;
      oDBConnectionParams.Arq := oTerminal.LocalArqDados;
      oDBConnectionParams.Database := oTerminal.Database;

      oTermDBConnection := DBConnectionCreate
        ('CargaFrame.TermEnviarDados.Term.Conn', FAppObj.SisConfig,
        oDBConnectionParams, nil, nil);

      oTermEnviarDados := TermEnviarDadosCreate(oServDBConnection,
        oTermDBConnection, oTerminal.TerminalId);
      oTermEnviarDados.Execute;
    end;
  finally
    TermEnviarDadosAction.Enabled := True;
    FStatusOutput.Exibir('Envio Terminado');
  end;
end;

end.
