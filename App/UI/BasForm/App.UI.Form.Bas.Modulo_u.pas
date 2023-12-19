unit App.UI.Form.Bas.Modulo_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas_u, Vcl.ExtCtrls, Sis.Sessao.Types,
  Sis.Modulo;

type
  TModuloBasForm = class(TBasForm, IModulo)
  private
    { Private declarations }
    FTipoModuloSistema: TTipoModuloSistema;

    function GetTipoModuloSistema: TTipoModuloSistema;
    function GetTipoModuloSistemaDescr: string;
  public
    { Public declarations }
    property TipoModuloSistema: TTipoModuloSistema read GetTipoModuloSistema;
    property TipoModuloSistemaDescr: string read GetTipoModuloSistemaDescr;

    constructor Create(AOwner: TComponent; pTipoModuloSistema: TTipoModuloSistema); reintroduce; overload;
//    constructor Create(AOwner: TComponent);  overload; override;
  end;

  TModuloBasFormClass = class of TModuloBasForm;

var
  ModuloBasForm: TModuloBasForm;

implementation

{$R *.dfm}

{ TModuloBasForm }

constructor TModuloBasForm.Create(AOwner: TComponent;
  pTipoModuloSistema: TTipoModuloSistema);
begin
  inherited Create(AOwner);
  FTipoModuloSistema := pTipoModuloSistema;
end;

//constructor TModuloBasForm.Create(AOwner: TComponent);
//begin
//  inherited Create(AOwner);
//  FTipoModuloSistema := moduloNaoIndicado;;
//end;

function TModuloBasForm.GetTipoModuloSistema: TTipoModuloSistema;
begin
  Result := FTipoModuloSistema;
end;

function TModuloBasForm.GetTipoModuloSistemaDescr: string;
begin
  Result := TipoModuloSistemaToStr(FTipoModuloSistema);
end;

end.
