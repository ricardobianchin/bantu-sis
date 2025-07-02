unit App.UI.Form.Bas.Princ.Sessoes_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Princ_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.Imaging.pngimage, App.UI.Sessoes.Frame_u, App.Sessao.EventosDeSessao,
  Sis.UI.Form.Login.Config, App.Constants, App.Sessao;

type
  TSessoesPrincBasForm = class(TPrincBasForm)
    BasePanel: TPanel;
    DtHCompilePanel: TPanel;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    // FSessaoCriadorList: ISessaoCriadorList;
    FSessoesFrame: TSessoesFrame;
    FEventosDeSessao: IEventosDeSessao;

    FLoginConfig: ILoginConfig;
    procedure SessoesFrameCriar;
  protected
    function SessoesFrameCreate: TSessoesFrame; virtual; abstract;
    property LoginConfig: ILoginConfig read FLoginConfig;

    {    procedure DoCancel;
    procedure DoOk;
    procedure DoAposModuloOcultar;
    procedure DoTrocarDaSessao(pSessaoIndex: TSessaoIndex);
    procedure DoFecharSessao(pSessaoIndex: TSessaoIndex);
    procedure DoAbrirSessao(pSessaoIndex: TSessaoIndex);
}

    procedure AjusteControles; override;
  public
    { Public declarations }
    property EventosDeSessao: IEventosDeSessao read FEventosDeSessao;
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
  if PrecisaFechar then
    exit;

  ProcessLog.PegueLocal('TSessoesPrincBasForm.FormCreate');
  try
    FLoginConfig := LoginConfigCreate(ProcessLog, ProcessOutput);
    FLoginConfig.Ler;

    SessoesFrameCriar;

    FEventosDeSessao := EventosDeSessaoCreate;
    FEventosDeSessao.Pegar(Self, FSessoesFrame);
    FSessoesFrame.PegarEventoSessao(FEventosDeSessao);

    // FSessaoCriadorList := SessaoCriadorListCreate;
  finally
    ProcessLog.RetorneLocal;
  end;
end;


procedure TSessoesPrincBasForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  FSessoesFrame.ExecutouPeloShortCut(Key, Shift);
end;

procedure TSessoesPrincBasForm.AjusteControles;
begin
  inherited;
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
