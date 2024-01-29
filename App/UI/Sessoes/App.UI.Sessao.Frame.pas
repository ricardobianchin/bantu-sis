unit App.UI.Sessao.Frame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, App.UI.Form.Bas.Modulo_u,
  Sis.ModuloSistema.Types, Sis.Usuario;

type
  TSessaoFrame = class(TFrame)
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
  protected
    property ModuloBasForm: TModuloBasForm read FModuloBasForm;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent;
      pTipoModuloSistema: TTipoModuloSistema; pUsuario: IUsuario;
      pModuloBasForm: TModuloBasForm); reintroduce;
  end;

implementation

{$R *.dfm}

{ TSessaoFrame }

constructor TSessaoFrame.Create(AOwner: TComponent;
  pTipoModuloSistema: TTipoModuloSistema; pUsuario: IUsuario;
  pModuloBasForm: TModuloBasForm);
var
  s: string;
begin
  inherited Create(AOwner);
  FModuloBasForm := pModuloBasForm;
  FTipoModuloSistema := pTipoModuloSistema;
  FUsuario := pUsuario;

  s := FUsuario.NomeExib;
  ApelidoLabel.Caption := s;

  s := TipoModuloSistemaToStr(FTipoModuloSistema);
  ModuloLabel.Caption := s;
end;

end.
