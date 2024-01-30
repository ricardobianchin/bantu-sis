unit App.UI.Form.Bas.Modulo_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas_u, Vcl.ExtCtrls,
  Sis.ModuloSistema.Types,
  Sis.ModuloSistema, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, System.Actions,
  Vcl.ActnList, App.Sessao.Eventos;

type
  TModuloBasForm = class(TBasForm)
    TitleBarPanel: TPanel;
    TitleBarTextCaptionLabel: TLabel;
    ToolBar1: TToolBar;
    FecharToolButton: TToolButton;
    TitleBarActionList_ModuloBasForm: TActionList;
    FecharAction_ModuloBasForm: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FecharAction_ModuloBasFormExecute(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FModuloSistema: IModuloSistema;
    FSessaoEventos: ISessaoEventos;


    function GetTitleBarText: string;
    procedure SetTitleBarText(Value: string);

  protected
    function PergFechar: boolean;
    function Voltou: boolean; virtual;
    procedure DoFechar; virtual;
    function Fechou: boolean; virtual;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pModuloSistema: IModuloSistema; pSessaoEventos: ISessaoEventos);
      reintroduce;
    property TitleBarText: string read GetTitleBarText write SetTitleBarText;
  end;

  TModuloBasFormClass = class of TModuloBasForm;

var
  ModuloBasForm: TModuloBasForm;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM, Sis.UI.Constants;

{ TModuloBasForm }

// constructor TModuloBasForm.Create(AOwner: TComponent);
// begin
// inherited Create(AOwner);
// FTipoModuloSistema := moduloNaoIndicado;;
// end;

constructor TModuloBasForm.Create(AOwner: TComponent;
  pModuloSistema: IModuloSistema; pSessaoEventos: ISessaoEventos);
begin
  inherited Create(AOwner);
  TitleBarPanel.Color := COR_PRETO_TITLEBAR;
  FModuloSistema := pModuloSistema;
  TitleBarText := FModuloSistema.TipoModuloSistemaDescr;
  FSessaoEventos := pSessaoEventos;
end;

procedure TModuloBasForm.DoFechar;
begin
  Close;
  FSessaoEventos.DoClose;
end;

procedure TModuloBasForm.FecharAction_ModuloBasFormExecute(Sender: TObject);
begin
  inherited;
  Fechou;
end;

function TModuloBasForm.Fechou: boolean;
begin
  Result := PergFechar;
  if not Result then
    exit;
  DoFechar;
end;

procedure TModuloBasForm.FormCreate(Sender: TObject);
begin
  inherited;
  TitleBarActionList_ModuloBasForm.Images := SisImgDataModule.ImageList_40_24;
end;

procedure TModuloBasForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #27 then
  begin
    Key := #0;
    Voltou;
  end;
end;

function TModuloBasForm.GetTitleBarText: string;
begin
  Result := TitleBarTextCaptionLabel.Caption;
end;

function TModuloBasForm.PergFechar: boolean;
var
  sMens: string;
  Resultado: TModalResult;
begin
  inherited;
  sMens := 'Deseja finalizar o módulo ' +
    FModuloSistema.TipoModuloSistemaDescr + '?';
  Resultado := MessageDlg(sMens, TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0);
  Result := IsPositiveResult(Resultado);
end;

procedure TModuloBasForm.SetTitleBarText(Value: string);
begin
  TitleBarTextCaptionLabel.Caption := Value;
end;

function TModuloBasForm.Voltou: boolean;
begin
  Result := Fechou;
end;

end.
