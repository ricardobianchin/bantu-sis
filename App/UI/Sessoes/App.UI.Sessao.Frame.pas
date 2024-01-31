unit App.UI.Sessao.Frame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, App.UI.Form.Bas.Modulo_u,
  Sis.ModuloSistema.Types, Sis.Usuario, App.Sessao;

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
  private
    { Private declarations }
    FModuloBasForm: TModuloBasForm;
    FTipoModuloSistema: TTipoModuloSistema;
    FUsuario: IUsuario;
    FIndex: Cardinal;

    function GetModuloBasForm: TModuloBasForm;
    function GetUsuario: IUsuario;
    function GetIndex: Cardinal;

  protected
  public
    { Public declarations }

    property ModuloBasForm: TModuloBasForm read GetModuloBasForm;
    property Index: Cardinal read GetIndex;
    property Usuario: IUsuario read GetUsuario;

    constructor Create(AOwner: TComponent;
      pTipoModuloSistema: TTipoModuloSistema; pUsuario: IUsuario;
      pModuloBasForm: TModuloBasForm; pIndex: Cardinal); reintroduce;
  end;

implementation

{$R *.dfm}

{ TSessaoFrame }

constructor TSessaoFrame.Create(AOwner: TComponent;
  pTipoModuloSistema: TTipoModuloSistema; pUsuario: IUsuario;
  pModuloBasForm: TModuloBasForm; pIndex: Cardinal);
var
  s: string;
begin
  inherited Create(AOwner);
  FModuloBasForm := pModuloBasForm;
  FTipoModuloSistema := pTipoModuloSistema;
  FUsuario := pUsuario;
  FIndex := pIndex;

  s := FUsuario.NomeExib;
  ApelidoLabel.Caption := s;

  s := TipoModuloSistemaToStr(FTipoModuloSistema);
  ModuloLabel.Caption := s;
end;

function TSessaoFrame.GetIndex: Cardinal;
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
