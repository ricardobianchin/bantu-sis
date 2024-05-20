unit App.UI.Form.Bas.Princ.Sessoes_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Princ_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.Imaging.pngimage, App.UI.Sessoes.Frame, App.Sessao.Eventos,
  Sis.UI.Form.Login.Config, App.Constants, App.Sessao;

type
  TSessoesPrincBasForm = class(TPrincBasForm, ISessaoEventos)
    BasePanel: TPanel;
    DtHCompilePanel: TPanel;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
//    FSessaoCriadorList: ISessaoCriadorList;
    FSessoesFrame: TSessoesFrame;

    FLoginConfig: ILoginConfig;
    procedure ControlesAjustar;
    procedure SessoesFrameCriar;
    procedure DoAbrirSessao(pSessaoIndex: TSessaoIndex);
  protected
    function SessoesFrameCreate: TSessoesFrame; virtual; abstract;
    property LoginConfig: ILoginConfig read FLoginConfig;

    procedure DoCancel;
    procedure DoOk;
    procedure DoAposModuloOcultar;
    procedure DoFecharSessao(pSessaoIndex: TSessaoIndex);
    procedure DoTrocarDaSessao(pSessaoIndex: TSessaoIndex);

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

var
  SessoesPrincBasForm: TSessoesPrincBasForm;

implementation

{$R *.dfm}

uses App.Sessao.Factory, Sis.Usuario.Factory;

constructor TSessoesPrincBasForm.Create(AOwner: TComponent);
begin
  inherited;
  ProcessLog.PegueLocal('TSessoesPrincBasForm.FormCreate');
  try
    FLoginConfig := LoginConfigCreate(ProcessLog, ProcessOutput);
    FLoginConfig.Ler;

    SessoesFrameCriar;
//    FSessaoCriadorList := SessaoCriadorListCreate;
  finally
    ProcessLog.RetorneLocal;
  end;
end;

procedure TSessoesPrincBasForm.DoAbrirSessao(pSessaoIndex: TSessaoIndex);
var
  iSessaoVisivelIndex: TSessaoIndex;
  oSessao: ISessao;
  oModuloBasForm: TForm;
begin
  iSessaoVisivelIndex := FSessoesFrame.GetSessaoVisivelIndex;

  if iSessaoVisivelIndex <> SESSAO_INDEX_INVALIDO then
  begin
    FSessoesFrame.Sessao[iSessaoVisivelIndex].EscondaModuloForm;
  end;
  oSessao := FSessoesFrame[pSessaoIndex];
  oModuloBasForm := oSessao.ModuloBasForm;
  oModuloBasForm.Show;
  DoOk;
end;

procedure TSessoesPrincBasForm.DoCancel;
begin

end;

procedure TSessoesPrincBasForm.DoFecharSessao(pSessaoIndex: TSessaoIndex);
begin
  FSessoesFrame.DeleteByIndex(pSessaoIndex);
  Show;
end;

procedure TSessoesPrincBasForm.DoAposModuloOcultar;
begin
  Show;
end;

procedure TSessoesPrincBasForm.DoOk;
begin
  Hide;
end;

procedure TSessoesPrincBasForm.DoTrocarDaSessao(pSessaoIndex: TSessaoIndex);
begin
  FSessoesFrame.DoTrocarDaSessao(pSessaoIndex);
end;

procedure TSessoesPrincBasForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  FSessoesFrame.ExecutouPeloShortCut(Key, Shift);
end;

procedure TSessoesPrincBasForm.ControlesAjustar;
begin
  DtHCompileLabel.Parent := DtHCompilePanel;
  DtHCompileLabel.Left := 3;
  DtHCompileLabel.Top := 10;
  // StatusLabel.left := 30;
  ProcessOutput.Ativo := false;
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
