unit App.UI.Form.Bas.Princ.Sessoes_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Princ_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.Imaging.pngimage, App.Sessao.Criador.List, App.UI.Sessoes.Frame,
  App.Sessao.Eventos, Sis.UI.Form.Login.Config;

type
  TSessoesPrincBasForm = class(TPrincBasForm, ISessaoEventos)
    BasePanel: TPanel;
    DtHCompilePanel: TPanel;
    StatusPanel: TPanel;

    procedure FormCreate(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FSessaoCriadorList: ISessaoCriadorList;
    FSessoesFrame: TSessoesFrame;

    FLoginConfig: ILoginConfig;
    procedure ControlesAjustar;
    procedure LoginConfigInicialize;
    procedure SessoesFrameCriar;
  protected
    function SessoesFrameCreate: TSessoesFrame; virtual; abstract;
    property LoginConfig: ILoginConfig read fLoginConfig;

    procedure DoCancel;
    procedure DoOk;
    procedure DoClose;

  public
    { Public declarations }
  end;

var
  SessoesPrincBasForm: TSessoesPrincBasForm;

implementation

{$R *.dfm}

uses App.Sessao.Factory, Sis.Usuario.Factory;

procedure TSessoesPrincBasForm.DoCancel;
begin

end;

procedure TSessoesPrincBasForm.DoClose;
begin
  Show;
end;

procedure TSessoesPrincBasForm.DoOk;
begin
  Hide;
end;

procedure TSessoesPrincBasForm.FormCreate(Sender: TObject);
begin
  inherited;
  ProcessLog.PegueLocal('TSessoesPrincBasForm.FormCreate');
  try
    LoginConfigInicialize;
    FSessaoCriadorList := SessaoCriadorListCreate;

    SessoesFrameCriar;

  finally
    ProcessLog.RetorneLocal;
  end;
end;

procedure TSessoesPrincBasForm.LoginConfigInicialize;
begin
  FLoginConfig := LoginConfigCreate(ProcessLog, ProcessOutput);
//  FLoginConfig
end;

procedure TSessoesPrincBasForm.ControlesAjustar;
begin
  DtHCompileLabel.Parent := DtHCompilePanel;
  DtHCompileLabel.Left := 3;
  DtHCompileLabel.Top := 10;
  StatusLabel.Parent := StatusPanel;
  StatusLabel.Align := alClient;
  // StatusLabel.left := 30;
  AndamentoTitLabel.Visible := false;
  ProcessOutput.Ativo := false;
  StatusMemo.Visible := false;
end;

procedure TSessoesPrincBasForm.SessoesFrameCriar;
var
  iBaseLogo: integer;
begin
  ControlesAjustar;

  FSessoesFrame := SessoesFrameCreate;
  FSessoesFrame.Parent := Self;

  iBaseLogo := Logo1Image.Top + Logo1Image.Height + 1;

  FSessoesFrame.Left := 5;
  FSessoesFrame.Top := iBaseLogo;
  FSessoesFrame.Height := BasePanel.Top - iBaseLogo;
  FSessoesFrame.Anchors := [akLeft, akTop, akBottom];
  // FSessoesFrame.

end;

procedure TSessoesPrincBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  FSessoesFrame.ExecuteAutoLogin;
end;

end.
