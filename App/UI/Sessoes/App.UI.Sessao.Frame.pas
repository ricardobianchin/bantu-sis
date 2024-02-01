unit App.UI.Sessao.Frame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, App.UI.Form.Bas.Modulo_u,
  Sis.ModuloSistema.Types, Sis.Usuario, App.Sessao, App.Sessao.Eventos,
  Sis.UI.Form.Login_u, Sis.UI.Form.Login.Config, App.Constants;

type
  TSessaoFrame = class(TFrame, ISessao)
    FundoPanel: TPanel;
    ApelidoLabel: TLabel;
    ModuloLabel: TLabel;
    AbrirButton: TButton;
    ActionList1: TActionList;
    AbrirAction: TAction;
    ApelidoTitLabel: TLabel;
    ModuloTitLabel: TLabel;
    procedure AbrirActionExecute(Sender: TObject);
  private
    { Private declarations }
    FModuloBasForm: TModuloBasForm;
    FTipoModuloSistema: TTipoModuloSistema;
    FUsuario: IUsuario;
    FIndex: TSessaoIndex;
    FSessaoEventos: ISessaoEventos;
//    FLoginConfig: ILoginConfig;

    function GetModuloBasForm: TModuloBasForm;
    function GetUsuario: IUsuario;
    function GetIndex: TSessaoIndex;

  protected
  public
    { Public declarations }

    property ModuloBasForm: TModuloBasForm read GetModuloBasForm;
    property Index: TSessaoIndex read GetIndex;
    property Usuario: IUsuario read GetUsuario;
    procedure EscondaModuloForm;

    constructor Create(AOwner: TComponent;
      pTipoModuloSistema: TTipoModuloSistema; pUsuario: IUsuario;
      pModuloBasForm: TModuloBasForm; pIndex: TSessaoIndex;
      pSessaoEventos: ISessaoEventos
      //; pLoginConfig: ILoginConfig
      ); reintroduce;
  end;

implementation

{$R *.dfm}

uses Sis.DB.DBTypes, App.DB.Utils, Sis.DB.Factory;

{ TSessaoFrame }

procedure TSessaoFrame.AbrirActionExecute(Sender: TObject);
begin
  FSessaoEventos.DoAbrirSessao(Index)
end;

constructor TSessaoFrame.Create(AOwner: TComponent;
  pTipoModuloSistema: TTipoModuloSistema; pUsuario: IUsuario;
  pModuloBasForm: TModuloBasForm; pIndex: TSessaoIndex;
  pSessaoEventos: ISessaoEventos{; pLoginConfig: ILoginConfig});
var
  s: string;
begin
  inherited Create(AOwner);
  FModuloBasForm := pModuloBasForm;
  FTipoModuloSistema := pTipoModuloSistema;
  FUsuario := pUsuario;
  FIndex := pIndex;
  FSessaoEventos := pSessaoEventos;
//  FLoginConfig := pLoginConfig;

  s := FUsuario.NomeExib;
  ApelidoLabel.Caption := s;

  s := TipoModuloSistemaToStr(FTipoModuloSistema);
  ModuloLabel.Caption := s;
end;

procedure TSessaoFrame.EscondaModuloForm;
begin
  if not ModuloBasForm.Visible then
    exit;

  ModuloBasForm.Hide;
end;

function TSessaoFrame.GetIndex: TSessaoIndex;
begin
  Result := FIndex;
end;

function TSessaoFrame.GetModuloBasForm: TModuloBasForm;
begin
  Result := FModuloBasForm;
end;

function TSessaoFrame.GetUsuario: IUsuario;
begin
  Result := FUsuario;
end;

end.
