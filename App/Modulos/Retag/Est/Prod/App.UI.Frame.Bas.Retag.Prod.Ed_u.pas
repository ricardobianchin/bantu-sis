unit App.UI.Frame.Bas.Retag.Prod.Ed_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Frame.Bas.Retag.Ed_u, App.Retag.Est.Prod.Ent, App.Retag.Est.Factory,
  Sis.UI.IO.Output;

type
  TRetagProdEdBasFrame = class(TRetagEdBasFrame)
  private
    { Private declarations }
  protected
    function GetProdEnt: IProdEnt;
    property ProdEnt: IProdEnt read GetProdEnt;

    procedure ControlesToEnt; virtual; abstract;
    procedure EntToControles; virtual; abstract;
    function ControlesOk: boolean; virtual; abstract;
  public
    { Public declarations }
  end;

var
  RetagProdEdBasFrame: TRetagProdEdBasFrame;

implementation

{$R *.dfm}

{ TRetagProdEdBasFrame }

function TRetagProdEdBasFrame.GetProdEnt: IProdEnt;
begin
  Result := EntEdCastToProdEnt(inherited EntEd);
end;

end.
